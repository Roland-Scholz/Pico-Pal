
	icl "System-Equates.asm"
	icl "EgoRAM-Equates.asm"
	
ptr			= $80
tileDataPtr		= $82
screenPtr		= $84
dreadPtr		= $86
destPtr			= $88
charSetPtr		= $8a

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

		org $1000
	
		.proc main
	
		jsr initoutch
		jsr initdlist
		
		jsr cpylevelcharset
		jsr convert
		jsr genTilePtrs
		jsr fillhortab
		
		jsr uploadMainCharset
		jsr uploadSurfaceCharset
		
		ldx #0
filltitle:	lda titlescr,x
		sta titlechars,x
		inx
		cpx #160
		bne filltitle
		
		jsr drawdread
;		jsr char2gfx
;		jsr cleartitle
;		jsr char2title



		jsr char3title
;		jsr char3gfx

;loop		jmp loop

;------------------------------------------------------------
; main loop
;------------------------------------------------------------
		lda #0
		sta dreadXPos
		lda #0
		sta dreadXPos+1

mainloop	

waitvcnt	lda VCOUNT
		cmp #108
		bne waitvcnt
		
		lda #14
		sta colbk
		jsr char3gfx
		lda #0
		sta colbk
		
		lda direction
		and #1
		beq incxpos					;scroll left
		
		lda dreadXPos					;check if zero
		ora dreadXpos+1
		bne decxpos	
		inc direction
		jmp mainloop

decxpos		lda dreadXPos
		bne decxpos1
		dec dreadXPos+1
decxpos1	dec dreadXPos
		jmp mainloop
		
incxpos		lda dreadXPos
		cmp #172
		lda dreadXPos+1
		sbc #1
		bcc incxpos1
		inc direction
		jmp mainloop
		
incxpos1	inc dreadXPos
		bne mainloop1
		inc dreadXPos+1
		
mainloop1	jmp mainloop
		
;------------------------------------------------------------
;
;------------------------------------------------------------
initoutch	ldx	$E406				;CHAR PUT routine
		ldy	$E407
		inx
		stx	OUTCH+1
		bne	geoutch1
		iny
geoutch1:	sty	OUTCH+2
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadMainCharset		
		lda #<mainCharacterSet
		ldx #>mainCharacterSet
		ldy #0
		beq uploadCharset
		
uploadSurfaceCharset
		lda #<surCommCharset
		ldx #>surCommCharset
		ldy #1					;fall through
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadCharset	sta ptr
		stx ptr+1

		lda #EGO_CMD_CHARSET		
		sta EGO_REG_CMD				;upload charset
		sty EGO_REG_DATA			;charset no 0 of 1

		ldx #8
		ldy #0
uploadCharset1	lda (ptr),y
		sta EGO_REG_DATA
		iny
		bne uploadCharset1
		inc ptr+1
		dex
		bne uploadCharset1
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
dliproc		pha
		
		lda dlino
		bmi dliproc1
		beq dli0
		cmp #1
		beq dli1
		cmp #4
		beq dli4
		
dli		lda #0
		sta grafp1	
		lda #$6f
		sta colpm1
		lda #$00
		sta colpm0
		
		;jmp dliproc0

		txa
		pha
		ldx dlino
		lda hor1tab,x
		sta wsync
		sta hposp1
		lda #1
		sta grafp1
		sta wsync
		lda #0
		sta grafp1		
		pla
		tax
		jmp dliproc0

dli4		lda #$10
		sta colpm0
		sta colpm1
		lda #$ff
		sta grafp1
		bne dliproc0

dli1		lda #4
		sta prior
		lda #$02
		sta wsync
		sta colpf1
		lda #$0f
		sta colpf2
		bne dliproc0

dli0		lda #$0f
		sta wsync
		sta colpf1
		lda #$02
		sta colpf2
		lda #140
		sta hposp1
		lda #$04
		sta dlino
		bne dliproc1
		
dliproc0	dec dlino
dliproc1	pla
		rti

;------------------------------------------------------------
;
;------------------------------------------------------------
;cleartitle	ldx #5
;		ldy #0
;		
;		lda #<titledata
;		sta destPtr
;		lda #>titledata
;		sta destPtr+1
;		
;		tya
;cleartitle1:	sta (destPtr),y
;		iny
;		bne cleartitle1
;
;		dex
;		bne cleartitle1
;		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
initdlist	lda #64
		sta nmien

		lda #32+2
		sta sdmctl
		
		lda savmsc+1
		sta text+1
		lda savmsc
		sta text
		        
		lda #0
		sta lmargn
		lda #$7d
		jsr print
		
		lda #4
		sta dlino
		
		mwa #dliproc vdslst
		mwa #dl sdlstl
		
		mva #$00 color4	;00	backgound
		mva #$16 color0	;01
		mva #$0f color1	;10
		mva #$00 color2	;11
		mva #$18 color3

		lda #$00
		sta pcolor0
		sta pcolor1
		
		lda #3						;enable players and missiles
		;sta gractl
		sta sizep0
		;sta sizep1
		
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

		ldx rtclok+2
		inx
		inx
waitvbi		cpx rtclok+2
		bne waitvbi
		
waitvbi1	lda vcount
		bne waitvbi1

;		sei
		lda #192
		sta nmien
		rts
	
;------------------------------------------------------------
; table for Player stars horizontal tab
;------------------------------------------------------------
fillhortab	ldx #99
fillhartab1	lda random
		and #$7f
;		clc
		adc #40
		sta hor1tab,x
		dex
		bpl fillhartab1
		
;		ldx #3
;		lda #40
;		sta hor1tab,x
;		dex
;		lda #140
;		sta hor1tab,x
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
; copy charsetdata for level
;------------------------------------------------------------
cpylevelcharset	ldx #0
		lda levelCharsetData,x
		clc
		adc #>surfaceCharset
		sta ptr+1
;		jsr puthex

		lda #<surfaceCharset
		sta ptr		
;		jsr puthex
		
		lda #<levelCharset
		sta destPtr
		lda #>levelCharset
		sta destPtr+1
		
		ldx #4
		ldy #0
cpylevelc1	lda (ptr),y
		sta (destPtr),y
		iny
		bne cpylevelc1
		inc ptr+1
		inc destPtr+1
		dex
		bne cpylevelc1
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
		
		jmp waitstatus
		
;------------------------------------------------------------
;
;------------------------------------------------------------
char3gfx	lda #EGO_CMD_CHAR_TO_VIDEO
		sta EGO_REG_CMD
		
		clc
		lda #<dreadnaught
		adc dreadXPos
		sta EGO_REG_DATA
		lda #>dreadnaught
		adc dreadXPos+1
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

waitstatus	lda EGO_REG_STATUS
		bmi waitstatus
		rts
;------------------------------------------------------------
;
;------------------------------------------------------------
char2title
		lda #0
		sta scry
		
		lda #<titlescr
		sta dreadPtr
		lda #>titlescr
		sta dreadPtr+1
		
char2title3	ldx #0

char2title2	ldy scry
		clc
		txa
		adc titleYTabLo,y
		sta destPtr
		lda titleYTabHi,y
		adc #0
		sta destPtr+1
		
		txa
		tay
		lda (dreadPtr),y
		asl
		rol charsetPtr+1
		asl
		rol charsetPtr+1
		asl
		rol charsetPtr+1
		clc
		adc #<mainCharacterSet
		sta charSetPtr
		lda charsetPtr+1
		and #7
		adc #>mainCharacterSet
		sta charsetPtr+1

		ldy #0
copychar3	lda (charsetPtr),y
		sta (destPtr),y
		lda destPtr
		adc #39
		sta destPtr
		bcc copychar2
		inc destPtr+1
copychar2	iny
		cpy #8
		bcc copychar3

char2title1	inx
		cpx #40
		bcc char2title2
		
		lda dreadPtr
		adc #39
		sta dreadPtr
		bcc char2title4
		inc dreadPtr+1
		
char2title4	inc scry
		lda scry
		cmp #4
		bne char2title3
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
char2gfx	
		lda #0
		sta scry
		
		clc
		lda #<dreadnaught
		adc dreadXPos
		sta dreadPtr
		lda #>dreadnaught
		adc dreadXpos+1
		sta dreadPtr+1

char2gfx3	ldx #0

char2gfx2	ldy scry
		;clc
		txa
		adc gfxYTabLo,y
		sta destPtr
		lda gfxYTabHi,y
		adc #0
		sta destPtr+1
			
		txa
		tay
		lda (dreadPtr),y
		asl
		rol charsetPtr+1
		asl
		rol charsetPtr+1
		asl
		rol charsetPtr+1
		clc
		adc #<surCommCharset
		sta charSetPtr
		lda charsetPtr+1
		and #7
		adc #>surCommCharset
		sta charsetPtr+1

		ldy #0
;		clc
copychar	lda (charsetPtr),y
		sta (destPtr),y
		lda destPtr
		adc #39
		sta destPtr
		bcc copychar1
		inc destPtr+1
copychar1	iny
		cpy #8
		bcc copychar

char2gfx1	inx
		cpx #40
		bcc char2gfx2
		
		inc dreadPtr+1
		inc dreadPtr+1
		
		inc scry
		lda scry
		cmp #17
		bne char2gfx3
		rts
					
;------------------------------------------------------------
;
;------------------------------------------------------------
convert		ldx #8						;8 pages
		ldy #0
		lda #<surCommCharset
		sta ptr
		lda #>surCommCharset
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
		
		lda #<levelOneDreadnoughtData
		sta dreadPtr
		lda #>levelOneDreadnoughtData
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

;linePtrLo:	.byte <(SCREEN+16*40-00), <(SCREEN+15*40-01), <(SCREEN+14*40-02), <(SCREEN+13*40-03)
;		.byte <(SCREEN+12*40-04), <(SCREEN+11*40-05), <(SCREEN+10*40-06), <(SCREEN+09*40-07)
;		.byte <(SCREEN+08*40-08), <(SCREEN+07*40-09), <(SCREEN+06*40-10), <(SCREEN+05*40-11)
;		.byte <(SCREEN+04*40-12), <(SCREEN+03*40-13), <(SCREEN+02*40-14), <(SCREEN+01*40-15)
;		.byte <(SCREEN+00*40-16)
;
;linePtrHi:	.byte >(SCREEN+16*40-00), >(SCREEN+15*40-01), >(SCREEN+14*40-02), >(SCREEN+13*40-03)
;		.byte >(SCREEN+12*40-04), >(SCREEN+11*40-05), >(SCREEN+10*40-06), >(SCREEN+09*40-07)
;		.byte >(SCREEN+08*40-08), >(SCREEN+07*40-09), >(SCREEN+06*40-10), >(SCREEN+05*40-11)
;		.byte >(SCREEN+04*40-12), >(SCREEN+03*40-13), >(SCREEN+02*40-14), >(SCREEN+01*40-15)
;		.byte >(SCREEN+00*40-16)

gfxYTabLo:	.byte <(gfxmem + 00 * 320), <(gfxmem + 01 * 320), <(gfxmem + 02 * 320), <(gfxmem + 03 * 320)
		.byte <(gfxmem + 04 * 320), <(gfxmem + 05 * 320), <(gfxmem + 06 * 320), <(gfxmem + 07 * 320)
		.byte <(gfxmem + 08 * 320), <(gfxmem + 09 * 320), <(gfxmem + 10 * 320), <(gfxmem + 11 * 320)
		.byte <(gfxmem + 12 * 320), <(gfxmem + 13 * 320), <(gfxmem + 14 * 320), <(gfxmem + 15 * 320)
		.byte <(gfxmem + 16 * 320), <(gfxmem + 17 * 320), <(gfxmem + 18 * 320), <(gfxmem + 19 * 320)
		.byte <(gfxmem + 20 * 320), <(gfxmem + 21 * 320), <(gfxmem + 22 * 320), <(gfxmem + 23 * 320)
		
gfxYTabHi:	.byte >(gfxmem + 00 * 320), >(gfxmem + 01 * 320), >(gfxmem + 02 * 320), >(gfxmem + 03 * 320)
		.byte >(gfxmem + 04 * 320), >(gfxmem + 05 * 320), >(gfxmem + 06 * 320), >(gfxmem + 07 * 320)
		.byte >(gfxmem + 08 * 320), >(gfxmem + 09 * 320), >(gfxmem + 10 * 320), >(gfxmem + 11 * 320)
		.byte >(gfxmem + 12 * 320), >(gfxmem + 13 * 320), >(gfxmem + 14 * 320), >(gfxmem + 15 * 320)
		.byte >(gfxmem + 16 * 320), >(gfxmem + 17 * 320), >(gfxmem + 18 * 320), >(gfxmem + 19 * 320)
		.byte >(gfxmem + 20 * 320), >(gfxmem + 21 * 320), >(gfxmem + 22 * 320), >(gfxmem + 23 * 320)
		
titleYTabLo	.byte <(titlegfx + 0 * 320), <(titlegfx + 1 * 320), <(titlegfx + 2 * 320), <(titlegfx + 3 * 320)
titleYTabHi	.byte >(titlegfx + 0 * 320), >(titlegfx + 1 * 320), >(titlegfx + 2 * 320), >(titlegfx + 3 * 320)

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
;		txa
;		jsr puthex
		
;		ldx #0
;genTilePtrs5	lda tileDataPtrHi,x
;		jsr puthex
;		lda tileDataPtrLo,x
;		jsr puthex
;		jsr space
;		inx
;		cpx #6
;		bne genTilePtrs5
		
		rts


;------------------------------------------------------------
;
;------------------------------------------------------------
getstart	pha
getstart1	lda consol
		and #1
		bne getstart1
getstart2	lda consol
		and #1
		beq getstart2
		pla
		rts	
		
;------------------------------------------------------------
;
;------------------------------------------------------------
space:		lda #' '
		bne PRINT
		
;------------------------------------------------------------
;
;------------------------------------------------------------
NEWLINE:	lda	#EOL

;------------------------------------------------------------
;
;------------------------------------------------------------
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


;============================================================
; jump to E:-handler put routine
;============================================================
OUTCH:		jmp 0

mantacnt	.byte 0
mantajfy	.byte 8
tileColumnCnt	.byte 0
tileRowCnt	.byte 0
numberOfTiles	.byte 0
dreadcolumn	.word 0
mask		.byte 0
cnt		.byte 0
dreadXPos	.word 0
scrx		.byte 0
scry		.byte 0
data		.byte 0
dlino		.byte 0
direction	.byte 0

		icl "EgoDemo-Manta.asm"
		
		;.align $100
surCommCharset
		ins "surface-common-charset.bin"
levelCharset
:1024		.byte 0
		icl "surface-charset.asm"
		icl "EgoDemo-GameData.asm"
		icl "EgoDemo-LevelData.asm"
		
;		.align $100		

	
;
; $95 
;	
tileDataPtrLo
:160		.byte 0
tileDataPtrHi
:160		.byte 0
	
		.align $400
mainCharacterSet
		ins "main-charset.bin"

;		.local dl
		dc = $0e+$00
	
dl		.byte $70,$70
		.byte $40+$0f
		.word titlegfx
:22		.byte $0f
		.byte $0f+$80
:7		.byte $0f
		.byte $0f+$80

		.byte $70+$80,$70+$80
		
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

		.byte $70+$80
		
		.byte $40+$02
text:		.word 0
		.byte 2, 2	
		.byte $41,a(dl)
;		.endl


titlescr
		.byte $30,$01,$1e,$19,$30,$7a,$7b,$30,$03,$30,$30,$30,$30,$30,$30,$30
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
	
	run main

