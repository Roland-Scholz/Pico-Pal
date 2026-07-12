
	icl "System-Equates.asm"
	icl "EgoRAM-Equates.asm"
	
ptr			= $80
tileDataPtr		= $82
screenPtr		= $84
dreadPtr		= $86
ptr1			= $88

WIDTH			= 40
WIDTHPIX		= 160
HEIGHT			= 192
MAXSPRITES		= 16

EOL			= $9b
LEFT			= $06
RIGHT			= $07
UP			= $0e
DOWN			= $0f

SCREEN			= $b800


		org $2000

;sm	= $a010
sm	= $8010
sm_width = 40
screen_lines = 192
lines_4k=102
size_4k=sm_width*lines_4k
	
		.proc main
	
		ldx	$E406				;CHAR PUT routine
		ldy	$E407
		inx
		stx	OUTCH+1
		bne	geoutch1
		iny
geoutch1:	sty	OUTCH+2

		lda	savmsc+1
		sta	text+1
		;jsr	puthex
		lda	savmsc
		sta	text
		;jsr	puthex
		
		mwa #dl sdlstl
		
		mva #$24 color4	;00	backgound
		mva #$86 color0	;01
		mva #$00 color1	;10
		mva #$0f color2	;11
		
		mva #$18 color3
		
;keyloop	lda KBCODE
;		jsr puthex
;		jmp keyloop
		
		ldx rtclok+2
		inx
		inx
	
waitvbi		cpx rtclok+2
		bne waitvbi 
	
		lda #<sm
		sta ptr
		lda #>sm
		sta ptr+1
		
		lda #EGO_CMD_ABORT
		sta EGO_REG_CMD
		
		lda #EGO_CMD_LINE_PTR
		sta EGO_REG_CMD
		ldx #200
		stx EGO_REG_DATA
		
lineptr		lda ptr
		sta EGO_REG_DATA
		lda ptr+1
		sta EGO_REG_DATA
		
		clc
		lda ptr
		adc #40
		sta ptr
		lda ptr+1
		adc #0
		sta ptr+1
		
		dex
		bne lineptr
		
		mva #EGO_CMD_SET_BLIT_WIDTH	EGO_REG_CMD
		mva #WIDTH			EGO_REG_DATA
		mva #EGO_CMD_SET_BLIT_HEIGHT	EGO_REG_CMD
		mva #HEIGHT			EGO_REG_DATA

;
; prepare shape
;	
		mva #EGO_CMD_SHAPE_DATA		EGO_REG_CMD
		mva #$00			EGO_REG_DATA		;shape no
		mva #3				EGO_REG_DATA		;shape x bytes
		mva #21				EGO_REG_DATA		;shape y lines
		mva #2				EGO_REG_DATA		;shape bpp
		
		ldx #64
shape0		lda mantaShipSprites,x
		sta EGO_REG_DATA
shwait:		lda EGO_REG_STATUS
		bmi shwait
		inx
		cpx #128
		bne shape0
		
;
; upload charset
;
		mva #EGO_CMD_CHARSET		EGO_REG_CMD		;upload charset
		mva #0				EGO_REG_DATA		;charset no 0 of 1
		
		clc
		lda #<surCommCharset
		adc #<(64 * 8)
		sta ptr
		lda #>surCommCharset
		adc #>(64 * 8)
		sta ptr+1
		
		clc
		lda #<surfaceCharset
		adc #<(3 * 96 * 8)
		sta ptr1
		lda #>surfaceCharset
		adc #>(3 * 96 * 8)
		sta ptr1+1

		ldy #0
		ldx #4
copy1		lda (ptr1),y
		sta (ptr),y
		iny
		bne copy1
		inc ptr+1
		inc ptr1+1
		dex
		bne copy1

		ldx #2						;2 pages
		ldy #0
		;mva #<surfaceCharset		ptr
		;mva #>surfaceCharset		ptr+1
		mva #<surCommCharset		ptr
		mva #>surCommCharset		ptr+1
		
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



		ldx #8							;8 pages
		ldy #0
		;mva #<surfaceCharset		ptr
		;mva #>surfaceCharset		ptr+1
		mva #<surCommCharset		ptr
		mva #>surCommCharset		ptr+1
				
charset_loop	lda (ptr),y
		sta EGO_REG_DATA
		iny
		bne charset_loop
		inc ptr+1
		dex
		bne charset_loop

;
; init X/Y pos and increments
;
		ldx #0
		ldy #0
		
randx:		lda RANDOM
		cmp #8
		bcc randx
		cmp #140
		bcs randx
		sta xpos,x
		lda #0
		sta xpos+1,x
		
		lda RANDOM
		and #1
		bne randxhi
		lda #$ff
		sta xinc,x
		sta xinc+1,x
		bne randy
		
randxhi		sta xinc,x
		lda #0
		sta xinc+1,x
		
randy:		lda RANDOM
		cmp #height
		bcs randy
		sta ypos,x
		lda #0
		sta ypos+1,x
		lda RANDOM
		and #1
		bne randyhi
		lda #$ff
		sta yinc,x
		sta yinc+1,x
		bne spriteshape
randyhi		sta yinc,x
		lda #0
		sta yinc+1,x

;
; associate sprite with shape
; enable sprite
;
spriteshape
		lda #EGO_CMD_SPRITE_DATA
		sta EGO_REG_CMD
		sty EGO_REG_DATA				; sprite no
		lda #$00					; shape number			
		sta EGO_REG_DATA	
	
		lda #EGO_CMD_SET_SPRITE_XY
		sta EGO_REG_CMD
		sty EGO_REG_DATA				;sprite no	
		lda xpos,x
		sta EGO_REG_DATA
		lda xpos+1,x
		sta EGO_REG_DATA
		lda ypos,x
		sta EGO_REG_DATA
		lda ypos+1,x
		sta EGO_REG_DATA

		lda #EGO_CMD_ENA_SPRITE
		sta EGO_REG_CMD
		sty EGO_REG_DATA				;sprite number			
	
spriteshape1	lda #EGO_CMD_SPRITE_MODE
		sta EGO_REG_CMD
		sty EGO_REG_DATA				;sprite number
		lda #1						;mask mode
		sta EGO_REG_DATA
	
		clc
		txa
		adc #8
		tax
		
		iny
		cpy #MAXSPRITES
		beq render
		jmp randx

;
;
;
render		mva #EGO_CMD_SET_WRITEABLE EGO_REG_CMD
		
		mva #EGO_CMD_FILL_MEM EGO_REG_CMD
		lda #0
		sta EGO_REG_DATA
		sta EGO_REG_DATA
		sta EGO_REG_DATA
		lda #$1f
		sta EGO_REG_DATA
		lda #$55
		sta EGO_REG_DATA
waitfill1	lda EGO_REG_STATUS
		bmi waitfill1	
		
;		ldx #0
;fillscr		txa
;		sta SCREEN,x
;		inx
;		bne fillscr
	
		lda #EGO_CMD_RENDER_SPRITES
		jsr sendcmd
	

		sei
		lda #0
		sta NMIEN
		sta mantacnt
		
		jsr genTilePtrs
		jsr drawdread

		lda #EGO_CMD_CHAR_TO_VIDEO
		jsr sendcmd
		
;forever		jmp forever
		jsr getstart
		
	
		lda #<mantaShipSprites
		sta ptr
		lda #>mantaShipSprites
		sta ptr+1
;------------------------------------------------------------
; main loop
;------------------------------------------------------------
mainloop
waitvcnt	lda VCOUNT
		cmp #108
		bne waitvcnt
		
;		ldx #0
;		ldy #0
;waitx		dex
;		bne waitx
;		dey
;		bne waitx

;		mva #EGO_CMD_FILL_MEM EGO_REG_CMD
;		lda #0
;		sta EGO_REG_DATA
; 		sta EGO_REG_DATA
;		sta EGO_REG_DATA
;		lda #$1f
;		sta EGO_REG_DATA
;		lda #$00
;		sta EGO_REG_DATA	
;waitfill	lda EGO_REG_STATUS
;		bmi waitfill

;		lda #14
;		sta colbk
		lda #EGO_CMD_CHAR_TO_VIDEO
		jsr sendcmd
;		lda #$34
;		sta colbk
		
;		lda KBCODE
;		cmp #UP
;		bne maindown
;		dec ypos
;maindown	cmp #DOWN
;		bne mainleft
;		inc ypos
;mainleft	cmp #LEFT
;		bne mainright
;		dec xpos
;mainright	cmp #RIGHT
;		bne mainrender
;		inc xpos
;
;mainrender:	jsr setxy
;		lda #EGO_CMD_RENDER_SPRITES
;		jsr sendcmd
;		
;		jmp mainloop

		dec mantajfy
		bne moveit
		
		lda #4
		sta mantajfy
	
		ldy #0
		mva #EGO_CMD_SHAPE_DATA		EGO_REG_CMD
		mva #$00			EGO_REG_DATA		;shape no
		mva #3				EGO_REG_DATA		;shape x bytes
		mva #21				EGO_REG_DATA		;shape y lines
		mva #2				EGO_REG_DATA		;shape bpp
shapeloop	lda (ptr),y
		sta EGO_REG_DATA
		iny
		cpy #63
		bne shapeloop
		
		clc
		lda ptr
		adc #64
		sta ptr
		lda ptr+1
		adc #0
		sta ptr+1
	
		inc mantacnt
		lda mantacnt
		cmp #32
		bne moveit
	
		lda #0
		sta mantacnt
		
		lda #<mantaShipSprites
		sta ptr
		lda #>mantaShipSprites
		sta ptr+1
	
	
	
;		lda #$04
;		sta COLBK
moveit		jsr domove
		
;		lda #$06
;		sta COLBK	
		jsr checkmove
	
;		lda #$08
;		sta COLBK	
		jsr setxy
	
;		lda #$14
;		sta COLBK
		lda #EGO_CMD_RENDER_SPRITES
		jsr sendcmd
;		lda #$0
;		sta COLBK
	
;		lda #$00	
;		sta COLBK

waitvcnt1
;		lda VCOUNT
;		cmp #2
;		bmi waitvcnt1
	
		jmp mainloop

;
;
;
setxy		ldx #0
		ldy #0
		
setxy1		lda #EGO_CMD_SET_SPRITE_XY
		sta EGO_REG_CMD
		sty EGO_REG_DATA
		lda xpos,x
		sta EGO_REG_DATA
		lda xpos+1,x
		sta EGO_REG_DATA
		lda ypos,x
		sta EGO_REG_DATA
		lda ypos+1,x
		sta EGO_REG_DATA
	
		clc
		txa
		adc #8
		tax
		
		iny
		cpy #MAXSPRITES
		bne setxy1
		
		rts
	
;
;
;
checkmove
		ldx #0
		ldy #0
	
checkmove1
		lda xpos,x
		cmp #<widthpix
		lda xpos+1,x
		sbc #>widthpix
		bcc checkmovey
		
		lda #0
		sbc xinc,x
		sta xinc,x
		lda #0
		sbc xinc+1,x
		sta xinc+1,x
		
		jsr addinc

checkmovey
	
		lda ypos,x
		cmp #<height
		lda ypos+1,x
		sbc #>height
		bcc checkmove2
		
		lda #0
		sbc yinc,x
		sta yinc,x
		lda #0
		sbc yinc+1,x
		sta yinc+1,x
	
		jsr addinc	

checkmove2	
		clc
		txa
		adc #8
		tax
		
		iny
		cpy #MAXSPRITES
		bne checkmove1
	
checkmoveex
		rts
	

;
;
;	
domove		ldx #0
		ldy #MAXSPRITES

domove1		jsr addinc
		inx
		inx
		inx
		inx
		jsr addinc
		inx
		inx
		inx
		inx
		
		dey
		bne domove1
		rts	
	
;	
;	
;	
addinc		clc
		lda xpos,x
		adc xinc,x
		sta xpos,x	
		lda xpos+1,x
		adc xinc+1,x
		sta xpos+1,x
		rts
		
	
	.proc sendcmd	; IN: <A>=command
	sta EGO_REG_CMD
sendcw	lda EGO_REG_STATUS
	bmi sendcw
	rts
	.endp
	
	.proc senddata	; IN: <A>=data
	sta EGO_REG_DATA
senddw	bit EGO_REG_STATUS
	bmi senddw
	rts
	.endp

space:		lda #' '
		bne PRINT
		
NEWLINE:	lda	#EOL
PRINT:		pha
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
		adc	#'0'
		cmp	#'9'+1
		bcc	PUTNIB1
		adc	#6
PUTNIB1:	jmp	OUTCH

;------------------------------------------------------------
; draw dreadnaught
;------------------------------------------------------------
drawdread	ldx #0
		stx dreadcolumn

		lda #<levelOneDreadnoughtData
		sta dreadPtr
		lda #>levelOneDreadnoughtData
		sta dreadPtr+1
		
drawdread2	ldy #0
		lda (dreadPtr),y				;load tile number
		jsr puthex
		inc dreadPtr
		bne drawdread3
		inc dreadPtr+1
		
drawdread3:	tax
		dex
		lda tileDataPtrLo,x
		sta tileDataPtr
		lda tileDataPtrHi,x
		sta tileDataPtr+1
		
		;jsr puthex
		;lda tileDataPtr
		;jsr puthex
		
		lda (tileDataPtr),y				;get num of columns
		sta tileColumnCnt
		;jsr puthex

		inc tileDataPtr
		bne drawdread1
		inc tileDataPtr+1
drawdread1	lda (tileDataPtr),y				;get num of rows
		jsr drawcolumn
		
		inc dreadcolumn
		lda dreadcolumn
		cmp #40
		bcs drawdread4
		
		dec tileColumnCnt
		bne drawdread1

		;jsr space
		;jsr getstart

		jmp drawdread2					;process next tile

drawdread4	rts
		
;------------------------------------------------------------
; generate drawcolumn
;------------------------------------------------------------
drawcolumn	sta tileRowCnt					;row cnt
		;jsr puthex
		
		inc tileDataPtr
		bne drawcolumn1
		inc tileDataPtr+1
		
drawcolumn1	clc
		lda linePtrLo,y
		adc dreadcolumn
		sta screenPtr
		lda linePtrHi,y
		adc #0
		sta screenPtr+1

		lda (tileDataPtr),y				;row data
		sta (screenPtr),y
		iny
		dec tileRowCnt
		bne drawcolumn1

		tya
		clc
		adc tileDataPtr
		sta tileDataPtr
		bcc drawcolumn3
		inc tileDataPtr+1
		
drawcolumn3:	cpy #17
		bcs drawcolumn2
		lda linePtrLo,y
		adc dreadcolumn
		sta screenPtr
		lda linePtrHi,y
		adc #0
		sta screenPtr+1
		lda #32
		sta (screenPtr),y
		iny
		bne drawcolumn3
		
drawcolumn2	ldy #0
		rts
		
linePtrLo:	.byte <(SCREEN+16*40-00), <(SCREEN+15*40-01), <(SCREEN+14*40-02), <(SCREEN+13*40-03)
		.byte <(SCREEN+12*40-04), <(SCREEN+11*40-05), <(SCREEN+10*40-06), <(SCREEN+09*40-07)
		.byte <(SCREEN+08*40-08), <(SCREEN+07*40-09), <(SCREEN+06*40-10), <(SCREEN+05*40-11)
		.byte <(SCREEN+04*40-12), <(SCREEN+03*40-13), <(SCREEN+02*40-14), <(SCREEN+01*40-15)
		.byte <(SCREEN+00*40-16)

linePtrHi:	.byte >(SCREEN+16*40-00), >(SCREEN+15*40-01), >(SCREEN+14*40-02), >(SCREEN+13*40-03)
		.byte >(SCREEN+12*40-04), >(SCREEN+11*40-05), >(SCREEN+10*40-06), >(SCREEN+09*40-07)
		.byte >(SCREEN+08*40-08), >(SCREEN+07*40-09), >(SCREEN+06*40-10), >(SCREEN+05*40-11)
		.byte >(SCREEN+04*40-12), >(SCREEN+03*40-13), >(SCREEN+02*40-14), >(SCREEN+01*40-15)
		.byte >(SCREEN+00*40-16)

;------------------------------------------------------------
; generate tileDataPtrs
;------------------------------------------------------------
genTilePtrs	ldy #0
		ldx #1
		
		lda #<tileData
		sta tileDataPtr
		sta tileDataPtrLo
		lda #>tileData
		sta tileDataPtr+1
		sta tileDataPtrHi

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
		
		lda tileDataPtr
		sta tileDataPtrLo,x
		lda tileDataPtr+1
		sta tileDataPtrHi,x

		inx
		jmp genTilePtrs4
		
genTilePtrs3	stx numberOfTiles
		txa
		jsr puthex
		
		
		ldx #0
genTilePtrs5	lda tileDataPtrHi,x
		jsr puthex
		lda tileDataPtrLo,x
		jsr puthex
		jsr space
		inx
		cpx #6
		bne genTilePtrs5
		
		rts


getstart	pha
getstart1	lda consol
		and #1
		bne getstart1
getstart2	lda consol
		and #1
		beq getstart2
		pla
		rts
;============================================================
; jump to E:-handler put routine
;============================================================
OUTCH:		jmp 0

mantacnt	.byte 0
mantajfy	.byte 8
tileColumnCnt	.byte 0
tileRowCnt	.byte 0
numberOfTiles	.byte 0
dreadcolumn	.byte 0
mask		.byte 0
cnt		.byte 0


		icl "EgoDemo-Manta.asm"
;		icl "charset.asm"
surCommCharset
		ins "surface-common-charset.bin"
		icl "surface-charset.asm"
		icl "EgoDemo-GameData.asm"
		icl "EgoDemo-LevelData.asm"
		
tileDataPtrLo
:256		.byte 0
tileDataPtrHi
:256		.byte 0
	
		.endp
	
		.align $400
;		.local dl
		dc =$0e
	
dl		.byte $70,$70
		.byte $40+dc,a(sm)
:101		.byte dc
		.byte $40+dc,a(sm+size_4k)
:89		.byte dc
		.byte $40+$02
text:		.word 0
		.byte 2, 2	
		.byte $41,a(dl)
;		.endl

;
; one page!!
;	
xpos		.word 0
xinc		.word 0
ypos		.word 0
yinc		.word 0
	
	run main

