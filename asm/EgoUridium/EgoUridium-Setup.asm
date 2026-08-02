;------------------------------------------------------------
; C64 memory layout
;
; $4000 - $47ff sprites $00-$1f (dropship $00-$0b, $0c-$1f explosions)
; $4800 - $4be8 screen data
; $4bf8 - $4bff sprite pointer
; $4c00 - $5000 sprites $30-$3f explosions-major
; $5000 - $5c00 sprites $40-$6f Manta
; $5c00 - $67ff sprites $70-$9f Manta shadow
; $6800 - $6fff sprites $a0-$bf meanies
;------------------------------------------------------------
; we only upload sprites $00-$1f, $30-6f, $a0-$bf
; manta shadow is created and handled in EgoRam
; sprites $20-$2f are non existend as there is the screen ram of VIC-II
;
; totals 	6kb charset data
;		8kb sprite data		
;------------------------------------------------------------
ptr		= $80
cnt		= $82

eol		= $9b

		icl "..\System-Equates.asm"
		icl "..\EgoRAM-Equates.asm"
		icl "EgoUridium-Constants.asm"

;------------------------------------------------------------
; upload all static data to EgoRam,
; in order to keep EgoUridium shorter
;------------------------------------------------------------

		org $0800
		
		.proc main

		jsr getOutch
		jsr uploadAllSprites
		jsr uploadCharsets
		
		lda #<message
		ldx #>message
		jsr printstr
		
endless		jmp endless
		
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadCharsets		
		lda #<mainCharset			;charset for title etc.
		ldx #>mainCharset
		ldy #0					;charsetno 0
		jsr uploadCharset
		jsr uploadCharset1
		
		lda #1
		sta cnt

uploadSurfaceCharset
		lda #<surfaceCharset
		ldx #>surfaceCharset
		ldy cnt					;charsetno 1-3
		jsr uploadCharset

		lda cnt
		asl
		asl
		adc #>surfaceCharset
		sta ptr+1
		jsr uploadCharset1
		
		inc cnt
		lda cnt
		cmp #4
		bne uploadSurfaceCharset

		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
uploadCharset	sta ptr
		stx ptr+1
		
		lda #EGO_CMD_CHARSET		
		sta EGO_REG_CMD				;upload charset
		sty EGO_REG_DATA			;charset no 0 of 1

uploadCharset1	lda ptr+1
		jsr puthex
		lda ptr
		jsr puthex
		jsr newline
		
		ldx #4					;upload 1k;
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
uploadAllSprites
		lda #<spriteData				;upload sprites $00-$1f
		ldy #>spriteData
		ldx #$20
		stx cnt
		ldx #0
		jsr uploadSprites

		ldx #$70					;upload sprites $30-$6f
		stx cnt
		ldx #$30
		jsr uploadSprites1

		ldx #$c0					;upload sprites $a0-$bf
		stx cnt
		ldx #$a0
		jsr uploadSprites1

		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
uploadSprites	sta ptr
		sty ptr+1

uploadSprites1	txa
		jsr puthex
		jsr space
		
		jsr uploadSprite
		jsr addPtr64
		inx
		cpx cnt
		bne uploadSprites1
		
		jsr newline
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

printstr	sta ptr
		stx ptr+1
		ldx #0
printstr1	lda (ptr,x)
		jsr print
		cmp #eol
		beq printstrEx
		inc ptr
		bcc printstr1
		inc ptr+1
		bne printstr1

printstrEx	rts		
;------------------------------------------------------------
;
;------------------------------------------------------------
space		lda #' '
		bne print
newline		lda #eol
print		pha
		txa
		pha
		tya
		pha
		tsx
		lda $103,X
		jsr outch
		pla
		tay
		pla
		tax
		pla
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
puthex		pha
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
		jsr putnib
		pla
		and #$0f
		jsr putnib
	
		pla
		tya
		pla
		tax
		pla
		rts
	
;------------------------------------------------------------

;------------------------------------------------------------	
putnib:		clc
		adc #'0'
		cmp #'9'+1
		bcc putnib1
		adc #6
putnib1
		
;------------------------------------------------------------
; jump to E:-handler put routine
;------------------------------------------------------------
outch:		jmp 0

;------------------------------------------------------------
;
;------------------------------------------------------------
getOutch	ldx $E406					;CHAR PUT routine
		ldy $E407
		inx 
		stx outch+1
		bne geoutch1
		iny 
geoutch1:	sty outch+2
		rts

;------------------------------------------------------------
;
;------------------------------------------------------------
message		.byte 'press Reset to continue...', eol

;------------------------------------------------------------
; sprite and charset data
;------------------------------------------------------------		
spriteData	icl "dropship_sprites.asm"
		icl "explosion_sprites.asm"
		icl "ship_sprites.asm"		
		icl "enemy_sprites.asm"
mainCharset	ins "main_charset.bin"
surfaceCharset	ins "surface_common_charset.bin"
		icl "surface_charset.asm"
		.endp

		run main