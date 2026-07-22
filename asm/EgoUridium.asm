
	icl "System-Equates.asm"
	icl "EgoRAM-Equates.asm"
	
ptr			= $80
ramLoPtr		= ptr
ramHiPtr		= ptr+1

tileDataPtr		= $82
screenPtr		= $84
dreadPtr		= $86
dreadXPos		= $86
destPtr			= $88
charSetPtr		= $8a
temp			= $8c
colorbk			= $8d
colorpf0		= $8e
colorpf1		= $8f
colorpf2		= $90
rndidx			= $91
cnt			= $92
firePressed		= $93
bulletFlag		= $94
bulletCnt		= $95
bulletYPos		= $96
bulletSlotX		= $97
leftbound		= $98
rightbound		= $99
tempX			= $9a
playerScore		= $9b					;4-byte
dummy			= $9f

WIDTH			= 40
WIDTHPIX		= 160
HEIGHT			= 192
MAXSPRITES		= 16

EOL			= $9b
LEFT			= $06
RIGHT			= $07
UP			= $0e
DOWN			= $0f

dreadnaught		= $C000-$2200
titlechars		= dreadnaught-4*40
titlegfx		= titlechars-4*8*40

gfxmem			= $8010
SCREEN_RAM_HIBANK	= gfxmem

mantax			= 84
mantay			= 68

debugScreen		= $0600
randomDataStorage 	= $0700

explosion_major1	= 46

;------------------------------------------------------------
;
;------------------------------------------------------------

		org $0800

;------------------------------------------------------------
;
;------------------------------------------------------------
	
		.proc main
	
		jsr GenerateRandomDataFromRNG
		jsr initdlist
		jsr convert
		jsr genTilePtrs
		jsr setScreenLines
		jsr uploadSprites
		jsr uploadMainCharset
		
		ldx #0
filltitle:	lda titlescr,x
		sta titlechars,x
		inx
		cpx #160
		bne filltitle
		jsr char3title

restart		jsr initLevel

;------------------------------------------------------------
; main loop
;------------------------------------------------------------
mainloop	

waitvcnt	lda VCOUNT
		cmp #104
		bne waitvcnt
		
		sta atract

;		lda #10
;		sta colbk
		
		lda #0
		sta dbgpos
	
;		lda leftbound
;		jsr puthex
;		lda rightbound
;		jsr puthex
;		lda mantaYpos
;		jsr puthex
;		lda bulletYpos
;		jsr puthex
		
		jsr keyboard
		
		lda pause
		and #1
		bne mainpause

		lda dead
		beq mainloop1
		jsr explosion
		jmp mainloop2
		
mainloop1	jsr checkfire
		jsr collision
		jsr checkstick
		jsr updateManta
		
mainloop2	;lda #6
		;sta colbk
		jsr char2gfx
		jsr stars2gfx
		jsr renderSprites		
		jsr moveBullets
		jsr scrollSurface

mainpause	jsr getstart
		jsr getselect
		jsr getoption

;		lda #$00
;		sta colbk
		jmp mainloop

;-------------------------------------------------------------------
; 
;-------------------------------------------------------------------
checkFire	lda bulletFlag
		bmi checkFire1
		beq checkFire3
		
		lda #$07
		sta bulletCnt
		lda firePressed
		bne checkFire2
		sta bulletFlag
		jsr FireBullets
checkFire2	rts
		
checkFire3	lda firePressed
		beq checkFire4
		inc bulletFlag
		jsr FireBullets
		rts
		
checkFire4	lda bulletCnt
		bmi checkFire2
		dec bulletCnt
		rts

checkFire1	and #$7F
		sta bulletFlag
		rts
	
;-------------------------------------------------------------------
; FireBullets
;-------------------------------------------------------------------
FireBullets
		lda bulletFlag
		ora #$80
		sta bulletFlag
		;ldx newSpriteValue
		;lda levelColorScheme + $01,X
		;beq FireBulletsEx

		lda mantaYpos					;a33
		sec
		sbc #19						;subtract offset so starts at 0
		sta bulletYPos					;zp0F
		ldx #$00
		jsr GetFreeSlotForBullets
		bcs FireBulletsEx
		stx bulletSlotX
		jsr UpdateBulletArrays

		;ldx newSpriteValue
		;lda bulletColorScheme,X
		;beq FireBulletsEx

		lda mantaYpos
		sec
		sbc #19
		adc #15
		sta bulletYPos
		ldx bulletSlotX
		jsr GetFreeSlotForBullets
		bcs FireBulletsEx
		jsr UpdateBulletArrays
FireBulletsEx	rts

;-------------------------------------------------------------------
; GetFreeSlotForBullets
;-------------------------------------------------------------------
GetFreeSlotForBullets
		lda bulletSlot,X
		beq GetFreeSlotForBulletsEx
		inx
		cpx #$06
		bcc GetFreeSlotForBullets
		rts

GetFreeSlotForBulletsEx	
		clc
		rts

;-------------------------------------------------------------------
; UpdateBulletArrays
;-------------------------------------------------------------------
UpdateBulletArrays
		
		lda dreadXPos
		sta ptr
		lda bulletYpos
		lsr
		lsr
		and #$fe
		clc
		adc dreadXPos+1
		sta ptr+1		
	
		lda #16
		ldy spriteShape
		cpy #$19
		beq UpdateBulletArrays1
		cpy #$01
		bne UpdateBulletArraysEx
		lda #19
UpdateBulletArrays1
		adc ptr
		sta ptr
		sta bulletPosLo,x
		lda ptr+1
		adc #0
		sta ptr+1
		sta bulletPosHi,x

		lda bulletYPos
		and #$07
		cmp #$07
		bne UpdateBulletArrays2
		lda #$06
UpdateBulletArrays2	
		sta bulletCharY,x
		
		lda #2
		ldy hspeed
		bmi UpdateBulletArrays3
		lda #$fe
UpdateBulletArrays3		
		sta bulletSlot,X

		ldy #0
		lda (ptr),y
		sta bulletOldChar,x

UpdateBulletArraysEx		
		rts


;------------------------------------------------------------
;
;------------------------------------------------------------
moveBullets
		ldx #5
		ldy #0
		sty moveBullets3+1
moveBullets2	lda bulletSlot,x
		beq moveBullets1
		bpl moveBullets4
		lda #$ff
		sta moveBullets3+1

moveBullets4	lda bulletPosLo,x
		sta ptr
		lda bulletPosHi,x
		sta ptr+1
		lda bulletOldChar,x
		sta (ptr),y

		clc
		lda bulletSlot,x
		adc ptr
		sta ptr
		sta bulletPosLo,x
		lda ptr+1
moveBullets3	adc #0
		sta ptr+1
		sta bulletPosHi,x
		
		ror
		lda ptr
		ror
		cmp leftbound
		bcc moveBullets5
		cmp rightbound
		bcs moveBullets5

		lda (ptr),y
		bpl moveBullets6
		cmp #$90
		bcc moveBullets5
		cmp #$A0
		bcs moveBullets6
		jsr checkHit
		jmp moveBullets5
		
moveBullets6	sta bulletOldChar,x
		
		sty charSetPtr+1
		asl
		rol charSetPtr+1
		asl
		rol charSetPtr+1
		asl
		rol charSetPtr+1
		clc
		adc #<surfaceCharset
		sta charSetPtr
		lda charSetPtr+1
		adc #>surfaceCharset
		sta charSetPtr+1
		tay
		bpl moveBullets8
		ldy level
		adc charsetArray,y
		sta charSetPtr+1
		
moveBullets8	jsr uploadChar
		txa
		sta (ptr),y

moveBullets1	dex
		bpl moveBullets2
		rts
		
moveBullets5	lda #0
		sta bulletSlot,x
		beq moveBullets1

;------------------------------------------------------------
;
;------------------------------------------------------------
uploadChar	ldy #0
		lda bulletCharY,x
		sta temp

		lda #EGO_CMD_CHAR
		sta EGO_REG_CMD
		lda #1
		sta EGO_REG_DATA
		stx EGO_REG_DATA
uploadChar1	cpy temp
		bne uploadChar2
		lda #$ff
		sta EGO_REG_DATA
		iny
		lda #$aa
		bne uploadChar3
uploadChar2	lda (charSetPtr),y
uploadChar3	sta EGO_REG_DATA
		iny
		cpy #8
		bcc uploadChar1
		ldy #0
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
checkHit	sec
		sbc #$90
		tay
		lda bulletPosLo,x
		sbc hitPtrLo,y
		sta ptr
		lda bulletPosHi,x
		sbc hitPtrHi,y
		sta ptr+1

		lda hitYlen,y
		sta cnt
		sta temp
		
		lda hitScore,Y
		tay
		jsr addScore
		
checkHit3	ldy temp
checkHit1	lda (ptr),y
		cmp #$20
		bcc killBullet
		cmp #$f0
		bcs checkHit2
		sec
		sbc #$20
		sta (ptr),y	
checkHit2	dey
		bpl checkHit1
		dec cnt
		bmi checkHitEx
		inc ptr+1
		inc ptr+1
		jmp checkHit3

checkHitEx	ldy #$00
		rts

killBullet	STX tempX
		TAX
		LDA #$00
		STA bulletSlot,X
		LDX tempX
		JMP checkHit2
		
;-------------------------------------------------------------------
; checkHitsFromHittingStuff
;-------------------------------------------------------------------
addScore	sed
		lda scoresToAddArray1,Y
		clc
		adc playerScore + $03
		sta playerScore + $03
		lda scoresToAddArray2,Y
		adc playerScore + $02
		sta playerScore + $02
		php
		lda playerScore + $01
		adc #$00
		sta playerScore + $01
		lda playerScore
		adc #$00
		sta playerScore
		bcc addScore1
		lda #$99
		sta playerScore
		sta playerScore + $01
		sta playerScore + $02
		sta playerScore + $03
		plp
		cld
		rts

addScore1	plp
		bcc addScore2
;		clc
;		lda currentPlayerLivesLeft
;		adc #$01
;		bcs addScore2
;		sta currentPlayerLivesLeft
		cld
		;jsr UpdateLivesLeft
		;lda #$81
		;sta a91
		rts

addScore2   	cld
		rts
;------------------------------------------------------------
; keyboard
;------------------------------------------------------------
keyboard	lda kbcode
		cmp #$21					;space
		bne keyboardEx
		lda #0
		sta hspeed
		lda #0
		sta hscrol
keyboardEx	rts

;------------------------------------------------------------
; explosion
;------------------------------------------------------------
explosion	lda dead
		bmi explosion1

		ldx #1
		stx spriteModus+1
		dex
		stx mantajfy
		stx spriteEna+1
		stx turncnt
		dex
		stx dead
		
		ldx #7
explosion3	jsr random3bit
		adc mantaXPos
		sta spriteXpos,x
		jsr random4bit
		adc mantaYpos
		sta spriteYpos,x
		lda #explosion_major1
		sta spriteShape,x
		lda #0
		sta spriteEna,x
		dex
		bpl explosion3
		rts

explosion1	dec mantajfy
		bpl explosionEx
		lda #1
		sta mantajfy
		
		ldx turncnt
		cpx #8
		bcs explosion9
		inc spriteEna,x
explosion9	cpx #19
		bcc explosion5
	
		pla
		pla
		jmp restart
		
		
explosion5	ldx #7
explosion4	lda spriteEna,x
		beq explosion6
		lda spriteShape,x
		cmp #explosion_major1+10
		bcc explosion7
		lda #0
		sta spriteEna,x
		beq explosion6
explosion7	inc spriteShape,x
explosion6	dex
		bpl explosion4

		inc turncnt		
explosionEx	rts

;------------------------------------------------------------
; random4bit
;------------------------------------------------------------
random4bit	lda random
		and #$0f
		sec
		sbc #8
		clc
		rts
;------------------------------------------------------------
; random3bit
;------------------------------------------------------------
random3bit	lda random
		and #$07
		sec
		sbc #4
		clc
		rts
;------------------------------------------------------------
; collision
;------------------------------------------------------------
collision	lda nocollision
		bne collisionEx
		
		jsr getMantaScreen

		ldx #3
collision2	ldy #18
collision1	lda (ptr),y
		and #$F0
		cmp #$80
		bne collision4
		inc dead
collision4	iny
		cpy #21
		bne collision1

		inc ptr+1
		inc ptr+1
collision3	dex
		bne collision2

		lda dead
		beq collisionEx

;		lda #$3f
;		sta colbk
		
collisionEx	rts


getMantaScreen
		lda dreadXPos
		sta ptr
		sec
		lda mantaYpos
		sbc #20
		lsr
		lsr
		and #$fe
		clc
		adc dreadXPos+1
		sta ptr+1
		rts
;------------------------------------------------------------
; scrollSurface
;------------------------------------------------------------
scrollSurface	lda hspeed
		asl
		sta temp
		bmi incxpos					;scroll left
		
		clc
		lda hscrol
		adc temp
		cmp #8
		bcs decxpos2
		sta hscrol
		rts	
		
decxpos2	and #6
		sta hscrol
		lda turnactive
		bne decxpos
		
		lda dreadXPos					;check if zero
		cmp #<(dreadnaught+1)
		lda dreadXpos+1
		sbc #>(dreadnaught+1)
		bcs decxpos

		dec turnactive
		lda #15
		sta turncnt

decxpos		lda dreadXPos
		bne decxpos1
		dec dreadXPos+1
decxpos1	dec dreadXPos
		jmp incxpos2

;
;
;
incxpos		clc
		lda hscrol
		adc temp
		bmi incxpos3
		sta hscrol
		rts
		
incxpos3	and #6
		sta hscrol
		lda turnactive
		bne incxpos1
		
		lda dreadXPos
		cmp #<(dreadnaught+$1ac)
		lda dreadXPos+1
		sbc #>(dreadnaught+$1ac)
		bcc incxpos1
		
		inc turnactive
		lda #15
		sta turncnt
		
incxpos1	inc dreadXPos
		bne incxpos2
		inc dreadXPos+1

incxpos2	lda dreadXPos+1
		ror
		lda dreadXpos
		ror
		sta leftbound
		clc
		adc #20
		sta rightbound		
		rts
		

;------------------------------------------------------------
;
;------------------------------------------------------------
updateManta	lda turnactive
		beq updateManta1

		dec mantajfy
		bmi updateManta2
		rts
		
updateManta2	lda #1
		sta mantajfy

		ldx turncnt
		lda turnactive
		bpl flipMantaLeft

flipMantaRight	jsr shapeRightSeq	
		jmp flipManta

flipMantaLeft	jsr shapeLeftSeq
		
flipManta	lda #1
		cpx #7
		bcs flipmanta3
		dec xshadow
		jmp flipmanta1
flipmanta3	lda #0
		cpx #9
		bcc flipmanta1
		lda #-1
		inc xshadow
		
		clc
flipmanta1	ldy turnactive
		bpl flipmanta2
		eor #$ff
		adc #1
flipmanta2	sta hspeed
		dex
		stx turncnt
		bpl updateManta1		
		stx mantajfy
		inx
		stx turnactive
		asl hspeed
		
updateManta1	lda #mantax
		sta spriteXpos
		lda mantaYpos
		sta spriteYpos

		clc						;x-pos lo
		lda #mantax
		adc xshadow
		sta spriteXpos+1
		lda mantaYpos					;y-pos lo
		adc xshadow
		sta spriteYpos+1
		rts
		

;------------------------------------------------------------
;
;------------------------------------------------------------
shapeRightSeq	
		lda flipRightSeq,x
		sta spriteShape
		sta spriteShape+1		
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
shapeLeftSeq	
		lda flipLeftSeq,x
		sta spriteShape
		sta spriteShape+1		
		rts
		
;------------------------------------------------------------
; renderSprites
;------------------------------------------------------------
renderSprites	ldx #7
renderSprites3	lda #EGO_CMD_DIS_SPRITE				;enable or disable sprite
		ldy spriteEna,x
		beq renderSprites1
		lda #EGO_CMD_ENA_SPRITE
renderSprites1	sta EGO_REG_CMD
		stx EGO_REG_DATA
		tya
		beq renderSprites2
		
		lda #EGO_CMD_SPRITE_DATA			;associate sprite with shape
		sta EGO_REG_CMD
		stx EGO_REG_DATA
		lda spriteShape,x
		sta EGO_REG_DATA

		lda #EGO_CMD_SPRITE_MODE
		sta EGO_REG_CMD
		stx EGO_REG_DATA
		lda spriteModus,x
		sta EGO_REG_DATA
		
		ldy #0
		lda #EGO_CMD_SET_SPRITE_XY
		sta EGO_REG_CMD
		stx EGO_REG_DATA
		lda spriteXpos,x
		sta EGO_REG_DATA
		sty EGO_REG_DATA
		lda spriteYpos,x
		sta EGO_REG_DATA
		sty EGO_REG_DATA
		
renderSprites2	dex
		bpl renderSprites3

		lda #EGO_CMD_RENDER_SPRITES
		sta EGO_REG_CMD
		jmp waitstatus

;------------------------------------------------------------
; joystick input routine
;------------------------------------------------------------
checkstick	lda trig0
		eor #$01
		sta firePressed
		
		lda porta
		lsr
		bcc stickup
		lsr
		bcc stickdown

checkstickleft	lda turnactive					;if ship is turning
		bne checkstickex				;no stick updates

		dec stickjiffy
		bpl checkstickex
		lda #5
		sta stickjiffy

;		lda stick0
		lda porta
		lsr
		lsr
		lsr
		bcc stickleft
		lsr
		bcc stickright
checkstickex	rts
		
;------------------------------------------------------------
stickleft	lda hspeed
		bmi stickleft1
		cmp #4
		bcs stickleft2
stickleft1	inc hspeed
		bne stickleft2
		inc turnactive
stickleft3	lda #15
		sta turncnt
stickleft2	rts

;------------------------------------------------------------
stickright	lda hspeed
		bpl stickright1
		cmp #$fd
		bcc stickleft2
stickright1	dec hspeed
		bne stickleft2
		dec turnactive
		bmi stickleft3

;------------------------------------------------------------
stickdown	lda mantaYpos
		adc #3
		cmp #137
		bcc stickdown1
		lda #137
stickdown1	sta mantaYpos
stickdown2	bne checkstickleft

;------------------------------------------------------------
stickup		lda mantaYpos
		sbc #2						;=3 (carry clear)
		cmp #21
		bcs stickup1
		lda #21
stickup1	jmp stickdown1

;------------------------------------------------------------
; initialize a level
;------------------------------------------------------------
initLevel	ldx level	
		lda levelColorBak,x
		sta colorbk
		lda levelColorPf0,x
		sta colorpf0
		lda #$02
		sta colorpf1
		lda #$0f
		sta colorpf2

		jsr genStars	
		jsr uploadSurfaceCharset
		jsr drawdread

		ldx #5*8-1
		lda #0
initLevel1	sta spriteEna,x
		dex
		bpl initLevel1

		stx hspeed					;X=$ff
		inx
		stx hscrol					;X=$00
		stx turnactive
		stx dead
		inx
		stx spriteEna					;X=$01
		stx spriteEna+1
		stx spriteShape
		stx spriteShape+1
		stx spriteModus
		inx
		stx spriteModus+1				;X=$02
		
		lda #mantax
		sta spriteXpos
		sta mantaXpos
		lda #mantax+8
		sta spriteXpos+1
		lda #mantay
		sta spriteYpos
		sta mantaYpos
		lda #mantay+8
		sta spriteYpos+1

		lda #<(dreadnaught+0)
		sta dreadXPos
		lda #>(dreadnaught+0)
		sta dreadXPos+1	

		lda #8
		sta xshadow
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
uploadMainCharset		
		lda #<titleCharset
		ldx #>titleCharset
		ldy #0					;charsetno
		jsr uploadCharset
		jmp uploadCharset1
		
uploadSurfaceCharset
		lda #<surfaceCharset
		ldx #>surfaceCharset
		ldy #1
		jsr uploadCharset
		
		ldx level
		clc
		lda charsetArray,x
		adc ptr+1
		sta ptr+1
		
;		lda ptr+1
;		jsr puthex
;		lda ptr
;		jsr puthex
		
		jmp uploadCharset1
	
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadCharset	sta ptr
		stx ptr+1

		lda #EGO_CMD_CHARSET		
		sta EGO_REG_CMD				;upload charset
		sty EGO_REG_DATA			;charset no 0 of 1

uploadCharset1	ldx #4					;upload 1k;
		ldy #0
uploadCharset2	lda (ptr),y
		sta EGO_REG_DATA
		iny
		bne uploadCharset2
		inc ptr+1
		dex
		bne uploadCharset2
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
dliproc		pha
		
		lda dlino
		
		beq dli0
		cmp #1
		beq dli1
		cmp #2
		beq dli2

dliproc0	dec dlino
dliproc1	pla
		rti

;
; turn on yellow(gold) player coloring
;
dli2		lda #$10
		sta colpm0
		sta colpm1
		lda #$ff
		sta grafp0
		sta grafp1
		bne dliproc0

;
; turn off yellow(gold) player coloring
; set dreadnaught colors
;
dli1		lda #$00
		sta grafp0
		sta grafp1
		lda colorpf1
		sta wsync
		sta colpf1
		lda colorbk
		sta colbk
		lda colorpf0
		sta colpf0
		lda colorpf2
		sta colpf2
		jmp dliproc0

dli0		lda #$02
		sta dlino
		lda #$0f
		sta wsync
		sta colpf1
		lda #$00
		sta colpf2
;		sta colbk
		beq dliproc1

;------------------------------------------------------------
;
;------------------------------------------------------------
initdlist	lda #0
		sta sdmctl
		sta nmien
		
		lda #2
		sta dlino
		sta critic
		
;		mva #$00 color4	;00	backgound
;		mva #$16 color0	;01
		mva #$0f color1	;10
;		mva #$00 color2	;11
		;mva #$18 color3

		lda #$00
		sta pcolor0
		sta pcolor1
		
		lda #3						;enable players and missiles
		sta sizep0
		
		lda #8
		sta gprior
		
		lda #$ff
		sta grafp0
		sta grafp1
		sta grafp2
		sta grafp3
		
		lda #108
		sta hposp0
		lda #140
		sta hposp1
		
waitvbi		lda vcount
		bne waitvbi
		
		lda #<dliproc 
		sta vdslst
		lda #>dliproc 
		sta vdslst+1
		
		lda #<dl
		sta dlistl
		sta sdlstl
		lda #>dl
		sta dlistl+1
		sta sdlstl+1
		
		lda #192
		sta nmien
		
		lda #32+2
		sta sdmctl
		sta dmactl
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
;fillnaught:	ldy #0
;		sty scry
;		sty data
;		lda #<dreadnaught
;		sta dreadPtr
;		lda #>dreadnaught
;		sta dreadPtr+1
;
;filln2		ldy #0
;filln1		lda data
;		inc data
;		sta (dreadPtr),y
;		iny
;		cpy #40
;		bne filln1
;		
;		inc dreadPtr+1
;		inc dreadPtr+1
;
;		inc scry
;		lda scry
;		cmp #17
;		bne filln2
;		rts
		
		
;------------------------------------------------------------
; set line addresses and blitwidth/heigt (40 / 136)
;------------------------------------------------------------
setScreenLines	lda #EGO_CMD_SET_BLIT_WIDTH	
		sta EGO_REG_CMD
		lda #40						;BLITWIDTH
		sta EGO_REG_DATA
		
		lda #EGO_CMD_SET_BLIT_HEIGHT
		sta EGO_REG_CMD
		lda #136			
		sta EGO_REG_DATA


		lda #<gfxmem
		sta ptr
		lda #>gfxmem
		sta ptr+1
		
		lda #EGO_CMD_ABORT
		sta EGO_REG_CMD
		
		lda #EGO_CMD_LINE_PTR
		sta EGO_REG_CMD
		ldx #136
		stx EGO_REG_DATA
		
setScreenLines1	lda ptr
		sta EGO_REG_DATA
		lda ptr+1
		sta EGO_REG_DATA
		
		clc
		lda ptr
		adc #40
		sta ptr
		bcc setScreenLines2
		inc ptr+1
		
setScreenLines2	dex
		bne setScreenLines1
		
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadSprites	lda #<mantaShipSprites
		sta ptr
		lda #>mantaShipSprites
		sta ptr+1
		
		ldx #0
uploadSprites1	jsr uploadSprite
		jsr addPtr64
		inx
		cpx #46
		bne uploadSprites1
		
		lda #<explosion_major
		sta ptr
		lda #>explosion_major
		sta ptr+1
		
uploadSprites2	jsr uploadSprite
		jsr addPtr64
		inx
		cpx #58
		bne uploadSprites2
		
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------		
addPtr64	clc
		lda ptr
		adc #64
		sta ptr
		bcc addPtr64a
		inc ptr+1
addPtr64a	rts

;------------------------------------------------------------
;
;------------------------------------------------------------		
uploadSprite	ldy #0
		lda #EGO_CMD_SHAPE_DATA
		sta EGO_REG_CMD
		stx EGO_REG_DATA				;shape no
		lda #3		
		sta EGO_REG_DATA				;shape x bytes
		lda #21				
		sta EGO_REG_DATA				;shape y lines
		lda #2				
		sta EGO_REG_DATA				;shape bpp
uploadSprite1	lda (ptr),y
		sta EGO_REG_DATA
		iny
		cpy #63
		bne uploadSprite1
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
char3title	lda #EGO_CMD_CHAR_TO_VIDEO
		sta EGO_REG_CMD
		
		lda #<titlechars
		sta EGO_REG_DATA
		lda #>titlechars
		sta EGO_REG_DATA

		ldx #40
		stx EGO_REG_DATA				;src inc
		ldy #0
		sty EGO_REG_DATA
		
		lda #<titlegfx
		sta EGO_REG_DATA
		lda #>titlegfx
		sta EGO_REG_DATA
		
		stx EGO_REG_DATA				;dest inc
		sty EGO_REG_DATA
		
		stx EGO_REG_DATA				;width
		lda #4
		sta EGO_REG_DATA				;height
		
		sty EGO_REG_DATA				;charset 0
		sty EGO_REG_DATA				;scroll 0
		sta EGO_REG_DATA				;no col38
		
		jmp waitstatus
		
;------------------------------------------------------------
;
;------------------------------------------------------------
char2gfx	lda #EGO_CMD_CHAR_TO_VIDEO
		sta EGO_REG_CMD
		
		clc
		;lda #<dreadnaught
		lda dreadXPos
		sta EGO_REG_DATA
		;lda #>dreadnaught
		lda dreadXPos+1
		sta EGO_REG_DATA

		ldx #0
		stx EGO_REG_DATA				;src inc
		ldy #2
		sty EGO_REG_DATA
		
		lda #<gfxmem
		sta EGO_REG_DATA
		lda #>gfxmem
		sta EGO_REG_DATA
		
		
		ldy #40
		sty EGO_REG_DATA				;dest inc (40)
		stx EGO_REG_DATA
		
		sty EGO_REG_DATA				;width
		lda #17
		sta EGO_REG_DATA				;height
		
		lda #1
		sta EGO_REG_DATA				;charset 0
		lda hscrol
		sta EGO_REG_DATA				;scroll
		sty EGO_REG_DATA				;col38 = true
		;rts
		
waitstatus	lda EGO_REG_STATUS
		bmi waitstatus
		rts
					
;------------------------------------------------------------
;
;------------------------------------------------------------
convert		ldx #16						;16 pages = 4kb
		ldy #0
		lda #<surfaceCharset
		sta ptr
		lda #>surfaceCharset
		sta ptr+1
		
convert1	lda #$c0
		sta mask
		
convert2	lda (ptr),y
		and mask
		bne convert3
		lda (ptr),y					;"00" case -> "11"
		ora mask
		sta (ptr),y
		jmp convert4
convert3	cmp mask				
		bne convert4
		eor #$ff					;"11" case -> "00"
		and (ptr),y
		sta (ptr),y
		
convert4	lsr mask
		lsr mask
		bne convert2
		
		iny
		bne convert1		
		inc ptr+1
		dex
		bne convert1
		rts
		
		
;------------------------------------------------------------
; draw dreadnaught
;------------------------------------------------------------
drawdread	lda #40
		sta dreadcolumn
		lda #0
		sta dreadcolumn+1

		lda #<dreadnaught
		sta screenPtr		
		lda #>dreadnaught
		sta screenPtr+1

		lda #32
		ldx #2*17
		ldy #0
drawdread1	sta (screenPtr),y
		iny
		bne drawdread1
		inc screenPtr+1
		dex
		bne drawdread1
		
		ldx level
		lda textureDataForLevelLoPtrArray,x
		sta dreadPtr
		lda textureDataForLevelHiPtrArray,x
		sta dreadPtr+1
		
drawdread2	ldy #0
		lda (dreadPtr),y				;load tile number
		beq drawdetail
		jsr incDreadPtr
		
		tax
		lda tileDataPtrLo,x
		sta tileDataPtr
		lda tileDataPtrHi,x
		sta tileDataPtr+1
		jsr drawTile
		beq drawdread2					;process next tile	
		
;------------------------------------------------------------
;
;------------------------------------------------------------
drawdetail	jsr incDreadPtr
		lda (dreadPtr),y
		beq drawdetail5
		tax

		jsr incDreadPtr
		clc
		lda (dreadPtr),y
		adc #<(dreadnaught - $8418)
		sta screenPtr
		txa
		adc #>(dreadnaught - $8218)
		sta screenPtr+1
		
		jsr incDreadPtr
		lda (dreadPtr),y				;load tile
		tax
		lda tileDataPtrLo,x
		sta tileDataPtr
		lda tileDataPtrHi,x
		sta tileDataPtr+1
		
		lda (tileDataPtr),y				;get num of columns
		sta tileColumnCnt
		jsr incTileDataPtr

drawdetail4	lda screenPtr+1
		pha
		lda screenPtr
		pha

		lda (tileDataPtr),y				;get num of rows
		sta tileRowCnt
		jsr incTileDataPtr

drawdetail1	lda (tileDataPtr),y				;row data
		cmp #32
		beq drawdetail2
		sta (screenPtr),y
drawdetail2	jsr sub513
		iny
		cpy tileRowCnt
		bne drawdetail1

		tya
		clc
		adc tileDataPtr
		sta tileDataPtr
		bcc drawdetail3
		inc tileDataPtr+1

drawdetail3	clc
		pla
		adc #1
		sta screenPtr
		pla
		adc #0
		sta screenPtr+1

		ldy #0	
		dec tileColumnCnt
		bne drawdetail4		
		beq drawdetail		
drawdetail5	rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
incDreadPtr	inc dreadPtr
		bne incDreadPtr1
		inc dreadPtr+1
incDreadPtr1	rts	

;------------------------------------------------------------
;
;------------------------------------------------------------
incTileDataPtr	inc tileDataPtr
		bne incTileDataPtr1
		inc tileDataPtr+1
incTileDataPtr1	rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
drawTile	lda (tileDataPtr),y				;get num of columns
		sta tileColumnCnt
		;jsr puthex
		jsr incTileDataPtr

		
drawTile1	lda (tileDataPtr),y				;get num of rows
		jsr drawcolumn
		
		inc dreadcolumn
		bne drawTile2
		inc dreadcolumn+1
		
drawTile2	;lda dreadcolumn
		;cmp #<512
		;lda dreadcolumn+1
		;sbc #>512
		;bcs drawTile3
		
		dec tileColumnCnt
		bne drawTile1
drawTile3	rts



;------------------------------------------------------------
; generate drawcolumn
;------------------------------------------------------------
drawcolumn	sta tileRowCnt					;row cnt
		;jsr puthex
		
		inc tileDataPtr
		bne drawcolumn1
		inc tileDataPtr+1

drawcolumn1	clc
		lda firstline
		adc dreadcolumn
		sta screenPtr
		lda firstline+1
		adc dreadcolumn+1
		sta screenPtr+1
		
drawcolumn2	lda (tileDataPtr),y				;row data
		sta (screenPtr),y
		jsr sub513
		iny
		cpy tileRowCnt
		bne drawcolumn2

		tya
		clc
		adc tileDataPtr
		sta tileDataPtr
		bcc drawcolumn3
		inc tileDataPtr+1
		
drawcolumn3:	cpy #17
		bcs drawcolumn4
		lda #32
		sta (screenPtr),y
		jsr sub513	
		iny
		bne drawcolumn3
		
drawcolumn4	ldy #0
		rts
	
;------------------------------------------------------------
;
;------------------------------------------------------------
sub513		sec
		lda screenPtr
		sbc #<513
		sta screenPtr
		lda screenPtr+1
		sbc #>513
		sta screenPtr+1
		rts
		
firstline	.word dreadnaught+16*512

;------------------------------------------------------------
; generate tileDataPtrs
;------------------------------------------------------------
genTilePtrs	ldy #0
		ldx #1
		
		lda #<tileData
		sta tileDataPtr
		lda #>tileData
		sta tileDataPtr+1
		bne genTilePtrs6

genTilePtrs4	lda (tileDataPtr),y				;load tile's number of columns 
		beq genTilePtrs3				;if zero exit
		sta tileColumnCnt

		inc tileDataPtr
		bne genTilePtrs2
		inc tileDataPtr+1

genTilePtrs2	lda (tileDataPtr),y				;load number of rows
		sec
		adc tileDataPtr
		sta tileDataPtr
		bcc genTilePtrs1
		inc tileDataPtr+1
genTilePtrs1	dec tileColumnCnt
		bne genTilePtrs2
		
genTilePtrs6	lda tileDataPtr
		sta tileDataPtrLo,x
		lda tileDataPtr+1
		sta tileDataPtrHi,x

		inx
		jmp genTilePtrs4
		
genTilePtrs3	stx numberOfTiles		
		rts

;-------------------------------------------------------------------
; stars2gfx
;-------------------------------------------------------------------
stars2gfx	ldx #16

stars2gfx2	ldy #0
		lda starPosLo,x
		sta ptr
		lda starPosHi,x
		sta ptr+1
		
		lda (ptr),y
		bne stars2gfx3
		ora #$0c
		sta (ptr),y
		
stars2gfx3	lda starThick,x
		beq stars2gfx1

		ldy #40
		lda (ptr),y
		bne stars2gfx1
		ora #$0c
		sta (ptr),y
		
stars2gfx1	dex
		bpl stars2gfx2
		rts

;-------------------------------------------------------------------
; GenerateStarfield
;-------------------------------------------------------------------
genStars	lda #0						;clear 1280 bytes for starfield
		tax
genStars3	sta gfxtop,x
		sta gfxtop+$100,x
		sta gfxtop+$200,x
		sta gfxtop+$300,x
		sta gfxtop+$400,x		
		inx
		bne genStars3

		clc
		lda #<(gfxtop+4*40+1)
		sta ptr
		lda #>(gfxtop+4*40+1)
		sta ptr+1
		
		lda #4
		sta cnt
genStars4	ldy #$26
genStars1	ldx rndidx
		inc rndidx
		lda randomDataStorage,X
		tax
		lda #00
		cpx #$F0
		bcc genStars2
		lda #$30
		cpx #$F8
		bcs genStars2
		sty temp
		tya
		adc #40
		tay
		lda #$30
		sta (ptr),y
		ldy temp
genStars2	sta (ptr),Y
		dey
		bpl genStars1	

		clc
		lda ptr
		adc #<320
		sta ptr
		lda ptr+1
		adc #>320
		sta ptr+1
		dec cnt
		bne genStars4
		
		ldy #16						;do 17 lines
genstars8	ldx rndidx					;compute random line
		inc rndidx
		lda randomDataStorage,X
		and #$1f
		cmp #17
		bcc genstars5					;0-16
		sbc #15						;2-16
genstars5	tax
		lda lineAdrLo,x
		sta starPosLo,y
		lda lineAdrHi,x
		sta starPosHi,y

		ldx rndidx					;compute random xpos
		inc rndidx
		lda randomDataStorage,X
		and #$3f
		cmp #38
		bcc genstars6
		sbc #26
		clc
genstars6	adc #1
genstars7	clc
		adc starPosLo,y
		sta starPosLo,y
		lda starPosHi,y
		adc #0
		sta starPosHi,y
		
		ldx rndidx					;compute thickness
		inc rndidx
		lda randomDataStorage,X
		and #1
		sta starThick,y

		dey
		bpl genstars8
		
;		iny
;genstars9	lda starPosHi,y
;		jsr puthex
;		lda starPosHi,y
;		jsr puthex
;		jsr space
;		iny 
;		cpy #17
;		bne genstars9
		rts

;-------------------------------------------------------------------
; GenerateRandomDataFromRNG
;-------------------------------------------------------------------
GenerateRandomDataFromRNG
		ldx #$00
GenerateRandom1	lda random					; Random Number Generator
		eor randomDataStorage,X
		sta randomDataStorage,X
		inx
		bne GenerateRandom1
		rts
		

;------------------------------------------------------------
;
;------------------------------------------------------------
getstart	lda #1
		bit consol
		bne getstart1
		
getstart2	bit consol
		beq getstart2
		lda level
		cmp #14
		bcs getstart1
		inc level
		jsr initLevel	
getstart1	rts	


;------------------------------------------------------------
;
;------------------------------------------------------------
getselect	lda #2
		bit consol
		bne getselect1
		
getselect2	bit consol
		beq getselect2
		lda level
		beq getselect1
		dec level
		jsr initLevel	
getselect1	rts	

;------------------------------------------------------------
;
;------------------------------------------------------------
getoption	lda #4
		bit consol
		bne getoption1

		inc pause
		
getoption2	bit consol
		beq getoption2
		
getoption1	rts	

;------------------------------------------------------------
;
;------------------------------------------------------------
time		ldy #0
time1		dex
		bne time1
		dey
		bne time1
		rts
;------------------------------------------------------------
;
;------------------------------------------------------------
space		lda #0
		beq print
		
;------------------------------------------------------------
;
;------------------------------------------------------------
newline		lda #EOL

;------------------------------------------------------------
;
;------------------------------------------------------------
print		pha
		txa
		pha
		tya
		pha
		tsx
		lda	$103,X
		jsr	OUTCH
		pla
		tay
		pla
		tax
		pla
		rts

puthex:		pha
		txa
		pha
		tya
		pha
	
		tsx
		lda	$103,X
		pha
		lsr	
		lsr	
		lsr	
		lsr	
		jsr	PUTNIB
		pla
		and	#$0f
		jsr	PUTNIB
	
		pla
		tay
		pla
		tax
		pla
		rts
	
	
PUTNIB:		clc
		adc	#16
;		adc	#'0'
		cmp	#16+10
		bcc	PUTNIB1
		adc	#6
PUTNIB1:	;jmp	OUTCH


;============================================================
; jump to E:-handler put routine
;============================================================
OUTCH:		ldx dbgpos
		sta debugScreen,x
		inc dbgpos
		rts

mantaYpos	.byte mantay
mantaXpos	.byte mantax
mantajfy	.byte 0
stickjiffy	.byte 8
tileColumnCnt	.byte 0
tileRowCnt	.byte 0
numberOfTiles	.byte 0
dreadcolumn	.word 0
mask		.byte 0
dlino		.byte 0
hscrol		.byte 0
hspeed		.byte 0
level		.byte 1
dbgpos		.byte 0
turnactive	.byte 0
turncnt		.byte 0
pause		.byte 0
xshadow		.byte 0
dead		.byte 0
nocollision	.byte 1
		
flipLeftSeq	.byte 25,24,23,22,21,20,19,18,17		;left 1-9
		.byte 38,37,36,35,34,33,32			;flip 0-6
		
flipRightSeq	.byte 1,0,15,14,13,12,11,10,9
		.byte 39,40,41,42,43,44,45

; The score are decimal so: 10,24,50,100 etc.
scoresToAddArray2
		.byte $00,$00,$00,$00,$01,$01,$02,$05
		.byte $07,$10,$20,$50
scoresToAddArray1
		.byte $00,$10,$25,$50,$00,$50,$50,$00
		.byte $50,$00,$00,$00

spriteEna	.byte 0, 0, 0, 0, 0, 0, 0, 0
spriteXpos	.byte 0, 0, 0, 0, 0, 0, 0, 0
spriteYpos	.byte 0, 0, 0, 0, 0, 0, 0, 0
spriteShape	.byte 0, 0, 0, 0, 0, 0, 0, 0
spriteModus	.byte 0, 0, 0, 0, 0, 0, 0, 0
bulletSlot	.byte 0, 0, 0, 0, 0, 0
bulletCharY	.byte 0, 0, 0, 0, 0, 0
bulletPosLo	.byte 0, 0, 0, 0, 0, 0
bulletPosHi	.byte 0, 0, 0, 0, 0, 0
bulletOldChar	.byte 0, 0, 0, 0, 0, 0

hitPtrLo	.byte $00,$01,$00,$01,$00,$01,$02,$00
		.byte $01,$02,$00,$01,$02,$00,$00,$00
hitPtrHi	.byte $00,$00,$02,$02,$00,$00,$00,$02
		.byte $02,$02,$04,$04,$04,$00,$00,$00
hitYlen		.byte $01,$01,$01,$01,$02,$02,$02,$02
		.byte $02,$02,$02,$02,$02,$00,$00,$00
hitScore	.byte $02,$02,$02,$02,$02,$00,$00,$00
		.byte $02,$02,$02,$02,$04,$04,$04,$04

starPosLo
:17		.byte 0
starPosHi
:17		.byte 0
starThick
:17		.byte 0

lineAdrLo	.byte <(gfxmem+4*40+00*320), <(gfxmem+4*40+01*320), <(gfxmem+4*40+02*320), <(gfxmem+4*40+03*320)
		.byte <(gfxmem+4*40+04*320), <(gfxmem+4*40+05*320), <(gfxmem+4*40+06*320), <(gfxmem+4*40+07*320)
		.byte <(gfxmem+4*40+08*320), <(gfxmem+4*40+09*320), <(gfxmem+4*40+10*320), <(gfxmem+4*40+11*320)
		.byte <(gfxmem+4*40+12*320), <(gfxmem+4*40+13*320), <(gfxmem+4*40+14*320), <(gfxmem+4*40+15*320)
		.byte <(gfxmem+4*40+16*320)
lineAdrHi	.byte >(gfxmem+4*40+00*320), >(gfxmem+4*40+01*320), >(gfxmem+4*40+02*320), >(gfxmem+4*40+03*320)
		.byte >(gfxmem+4*40+04*320), >(gfxmem+4*40+05*320), >(gfxmem+4*40+06*320), >(gfxmem+4*40+07*320)
		.byte >(gfxmem+4*40+08*320), >(gfxmem+4*40+09*320), >(gfxmem+4*40+10*320), >(gfxmem+4*40+11*320)
		.byte >(gfxmem+4*40+12*320), >(gfxmem+4*40+13*320), >(gfxmem+4*40+14*320), >(gfxmem+4*40+15*320)
		.byte >(gfxmem+4*40+16*320)

lineOffsetLo
		.byte <(-04*40), <(-03*40), <(-02*40), <(-01*40), <(00*40), <(01*40), <(02*40), <(03*40)
lineOffsetHi
		.byte >(-04*40), >(-03*40), >(-02*40), >(-01*40), >(00*40), >(01*40), >(02*40), >(03*40)
		
tileDataPtrLo
:160		.byte 0
tileDataPtrHi
:160		.byte 0


		icl "EgoUridium-Manta.asm"	
		icl "explosion_sprites.asm"
		
titleCharset	ins "main-charset.bin"
surfaceCharset	ins "surface-common-charset.bin"
		icl "surface-charset.asm"
		
		icl "EgoUridium-GameData.asm"
		icl "EgoUridium-LevelData.asm"

		.align $400

;		.local dl
		dc = $0e+$00
	
dl		.byte $70,$70
		.byte $40+$0f
		.word titlegfx
:22		.byte $0f
		.byte $0f+$80
:7		.byte $0f
		.byte $0f+$80

;		.byte $70,$70
		.byte $40+dc
		.word gfxtop
:15		.byte dc

;.rept 136
;		.byte $40+dc
;		.word gfxmem + (# * 40)
;.endr

		.byte $40+dc
		.word gfxmem
:101		.byte dc
		.byte $40+dc
		.word gfxmem+102*40
:33		.byte dc

		.byte $40+dc
		.word gfxbottom
:14		.byte dc
		
		.byte dc+$80
		
		.byte $40+$02
text:		.word debugScreen
		.byte 2
		.byte $41,a(dl)
;		.endl

gfxtop		
:640		.byte 0
gfxbottom
:640		.byte 0

titlescr
		.byte $01,$01,$1e,$19,$30,$7a,$7b,$30,$03,$30,$30,$30,$30,$30,$30,$30
		.byte $30,$49,$69,$0a,$1e,$1c,$0e,$30,$30,$30,$30,$30,$30,$30,$30,$7a  
		.byte $7b,$30,$03,$30,$02,$1e,$19,$30
		.byte $30,$81,$9e,$99,$b0,$fa,$fb,$b0
		.byte $83,$30,$30,$30,$30,$30,$30,$b0,$b0,$c9,$e9,$8a,$9e,$9c,$8e,$b0
		.byte $b0,$b0,$30,$30,$30,$30,$30,$fa,$fb,$b0,$83,$b0,$82,$9e,$99,$30

		dta c"000000000000000123456789"
		.byte $7d
		dta c"                "
		
		dta c"              "
		.byte $b1,$b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9,$fd
		dta c"                "
		
hor1tab		
:100		.byte 0

		.endp

