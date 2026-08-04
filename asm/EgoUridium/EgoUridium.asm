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

	icl "..\System-Equates.asm"
	icl "..\EgoRAM-Equates.asm"
	icl "EgoUridium-Constants.asm"

playerScore = $20
indexCurrentEnemyFormation = $24
enemyMovementStrategyLoPtr = $70
enemyMovementStrategyHiPtr = $71
a9C = $9C
aA4 = $A4
aC0 = $C0
aC1 = $C1
aC2 = $C2
aC3 = $C3
aC4 = $C4
aC5 = $C5
aC6 = $C6
aC7 = $C7
aC8 = $C8
aC9 = $C9
aCA = $CA
aCB = $CB
aCC = $CC
aCD = $CD
aCE = $CE
aF3 = $F3
aF6 = $F6
aF9 = $F9
;
; **** ZP ABSOLUTE ADRESSES ****
;
RAM_ACCESS_MODE = $01
currentSpriteMSB = $02
spriteMixerValue = $03
spriteIndex = $04
currentSpriteXPos = $05
currentSpriteMSBXPosOffset = $06
currentSpriteYPos = $07
currentSpriteDisplayEnable = $08
currentSpriteExpandVertical = $09
currentSpriteBackgroundDisplayPriority = $0A
currentSpriteMultiColorMode = $0B
currentSpriteExpandHorizontal = $0C
currentSpriteColor = $0D
currentSpriteValue = $0E
secondHalfOfMap = a0F
pixelYPositionOfPlayerBullet = a0F
a0F = $0F
dataIndex = $10
stashedYValue = $11
dreadnoughtDataLoPtr = $12
colorRamLoPtr = $12
dreadnoughtDataHiPtr = $13
colorRamHiPtr = $13
someDataLoPtr = $14
someDataHiPtr = $15
currentLevelSurfaceDataHiPtr = someDataHiPtr
currentLevelSurfaceDataLoPtr = someDataLoPtr
upPressed = $16
rightPressed = $17
firePressed = $18
bitMapForPlayerVolumeAndColor = $19
srcLoPtr = $1A
srcHiPtr = $1B
spriteVariablesLoPtr = srcLoPtr
spriteVariablesHiPtr = srcHiPtr
ramLoPtr = $1C
ramHiPtr = $1D
a1F = $1F
currentPlayerLivesLeft = $25
indexToCurrentLevelTextureData = $26
currentLevel = $27
selectForBulletsOrMines = $28
positionInsideScrollSegment = $29
currentScrollSegment = $2A
frameRateBeforePause = $2B
pixelsToScroll = $2C
a2D = $2D
mantaDirectionAndSpeed = $2E
shouldWaitUntilReady = $2F
scrollPositionHiPtr = $30
scrollPositionLoPtr = $31
hasShipBeenHit = $32
mantaCurrentYPos = $33
a34 = $34
a35 = $35
a36 = $36
a37 = $37
a38 = $38
a39 = $39
a3A = $3A
a3B = $3B
a3C = $3C
mantaShadowOffset = $3D
a3E = $3E
a3F = $3F
newSpriteValue = $40
mantaShadowSpriteValue = $41
mantaAnimationLoPtr = $42
mantaAnimationHiPtr = $43
framesInAnimation = $44
a45 = $45
a46 = $46
a47 = $47
fireButtonDebounce = $48
buttonPressDebounce = $49
currentBackgroundColor = $4A
backgroundColor2 = $4B
backgroundColor1 = $4C
loadedCharacterColor = $4D
multiColor0 = $4E
spriteColorForLevel = $4F
mantaBottomCannonLoPtr = $50
mantaBottomCannonHiPtr = $51
mantaTopCannonLoPtr = $52
mantaTopCannonHiPtr = $53
someKindOfTextureColorVariable = $54
currentColorValue = $55
a56 = $56
a57 = $57
monochromeCharacterColor = $58
loopCounter = $59
pausedOrNotPaused = $5A
a5B = $5B
playerAndJoystickMode = $5C
currentPlayer = $5D
fakeupPressed = $5E
fakeRightPressed = $5F
pausePressed = $60
monochromEnabled = $61
someKindOfFrameRate = $62
enemyXPosBackwardVelocity = $63
enemyXPosBackwardIncrement = $64
enemyBulletXPosAnimationRate = $65
enemyXPosForwardVelocity = $66
enemyXPosForwardIncrement = $67
whetherScoreAwardedForHittingEnemy = $68
whetherToFireEnemyBulletOrMine = $69
bulletSpriteCurrentLevel = $6A
enemyBulletXPosIncrement = $6B
usedToCheckIfWeShouldLaunchMine = $6C
loPtrToEnemyFormationOrder = $6D
hiPtrToEnemyFormationOrder = $6E
currentEnemyMovementStrategy = $6F
durationOfStrategyForFormation = $7C
durationOfStrategyForNextEnemyInFormation = $7D
currentEnemySpriteValue = $7E
scoreToAddForHittingEnemy = $7F
enemyYPosUpwardVelocity = $80
enemyYPosUpwardIncrement = $81
enemyYPosDownwardVelocity = $82
enemyYPosDownwardIncrement = $83
initialEnemyXPos = $84
landNowActivated = $85
a86 = $86
formationAnnihilationBonus = $87
numberOfEnemiesSpawned = $88
destroyedEdgeLoPtr = $89
destroyedEdgeHiPtr = $8A
indexToTextureSegment = $8D
fakeFirePressed = $8E
initialValueOfY = $8F
soundOrTitleSelector = $90
soundVariable1 = $91
soundVariable2 = $92
soundVariable3 = $93
a94 = $94
a95 = $95
a96 = $96
a97 = $97
a98 = $98
a99 = $99
a9D = $9D
a9F = $9F
aA0 = $A0
soundPtr = $A1
aA2 = $A2
aA3 = $A3
aA7 = $A7
aA8 = $A8
aA9 = $A9
aAA = $AA
MANTA_HORIZONTAL_POSITION = $AA
anotherRandomNumberBetween0and1 = $AB
randomNumberBetween0and1 = $AC
shipDestructBonus = $AD
miniGameUpdateRate = $AE
tempLoPtrCopyTo = $B0
tempHiPtrCopyTo = $B1
tempLoPtrCopyFrom = $B2
tempHiPtrCopyFrom = $B3
currentCharYPos = $B4
currentCharXPos = $B5
charToWrite = $B6
aB7 = $B7
aB8 = $B8
aBA = $BA
aBB = $BB
temp = aBA
cnt = aBB
aBC = $BC
dataLoPtr = $BE
dataHiPtr = $BF
aEF = $EF
aF0 = $F0
aF1 = $F1
aF2 = $F2
aFB = $FB
aFC = $FC

ptr			= ramLoPtr
;
;tileDataPtr		= $82
;screenPtr		= $84
;dreadPtr		= $86
;dreadXPos		= $86
;destPtr			= $88
;charSetPtr		= $8a
;temp			= $8c
;currentScoreCharToWrite = temp
;colorbk			= $8d
;colorpf0		= $8e
;colorpf1		= $8f
;colorpf2		= $90
;dataIndex			= $91
;cnt			= $92
;bulletFlag		= $94
;bulletCnt		= $95
;bulletYPos		= $96
;bulletSlotX		= $97
;leftbound		= $98
;rightbound		= $99
;tempX			= $9a
;decalState		= $a4
;currentDigitInScore	= $a7
;minePos0		= $a8
;minePos1		= $a9
;hspeed			= $aa
;
;p0Ypos			= $c0
;p1Ypos			= $c1
;p2Ypos			= $c2
;p3Ypos			= $c3
;colorp0			= $c4
;colorp1			= $c5
;colorp2			= $c6
;colorp3			= $c7

WIDTH			= 40
WIDTHPIX		= 160
HEIGHT			= 192
MAXSPRITES		= 16

EOL			= $9b
LEFT			= $06
RIGHT			= $07
UP			= $0e
DOWN			= $0f

;------------------------------------------------------------
; $8010 - $954f		17x8   surface gfx lines, 40 bytes each
; $9860 - $9cff		 4x8   title gfx lines, 40 bytes each
; $9d60 - $9dff		 4x40  bytes title char data
; $9e00 - $afff		17x512 bytes surface char data
;------------------------------------------------------------
SCREEN_RAM_HIBANK = $4800
sprite0Ptr = SCREEN_RAM_HIBANK + $03F8


surfaceStructureDataLoPtrArray = $c000
surfaceStructureDataHiPtrArray = $c100

dreadnaught		= $C000-$2200				;= $9E00
surfaceDataForCurrentLevel = dreadnaught
startOfSurfaceDataForCurrentLevel = dreadnaught + $2040

surfaceTextureCharacterSet = $CAFE				;to do!!!

mathpack		= $d800
intCharset		= $cc00
normCharset		= $e000
player0data		= intCharset
player1data		= player0data+$100
player2data		= player1data+$100
player3data		= player2data+$100


titlechars		= dreadnaught-4*40
titlegfx		= titlechars-4*8*40

gfxmem			= $8010

mantax			= 84
mantay			= 68

debugScreen		= $0600
randomDataStorage 	= $0700
buffer			= $0600
nmivkt			= $fffa

explosion_major46	= 46

;------------------------------------------------------------
;
;------------------------------------------------------------

		org $0800

;------------------------------------------------------------
;
;------------------------------------------------------------
	
		.proc main
		
		jsr initGame		

restart		jsr initLevel
		;jsr UpdateLivesLeft
		jmp MaybeStartNewLevel


;--------------------------------------------------------------------
; EnterNewLevel
;--------------------------------------------------------------------
EnterNewLevel
        ;JSR SetInterruptToIRQInterrupt1
        LDX #<spaces
        LDY #>spaces
        JSR WriteToScreen
        JSR UpdateLivesLeft
        ;JSR UpdatePlayerDecalColors
;       LDA #$00
;       STA $D015    ;Sprite display Enable
;        LDA #$30
;        JSR Write21LinesOfAccumulatorValToScreen

        ;LDX #<newLevelColors
        ;LDY #>newLevelColors
        ;STX srcLoPtr
        ;STY srcHiPtr
        ;LDX #<COLOR_RAM + $00A0
        ;LDY #>COLOR_RAM + $00A0
        ;STX ramLoPtr
        ;STY ramHiPtr
        ;LDY #$0D
        ;JSR WriteSourceValueToRam

        LDX #<gameOn
        LDY #>gameOn
        JSR WriteToScreen
        LDA currentPlayer
        CMP #$01
        BEQ b0C5F

        ; Player 2
        LDX #<player2
        LDY #>player2
        JSR WriteToScreen
        JMP j0C66

        ; Player 1
b0C5F   LDX #<player1
        LDY #>player1
        JSR WriteToScreen

j0C66   LDA currentPlayerLivesLeft
        LDX #$30
        LSR
        LSR
        LSR
        LSR
        BEQ b0C71
        TAX
b0C71   STX tensLivesLeftDisplayed
        LDA currentPlayerLivesLeft
        AND #$0F
        STA livesLeftDisplayed
        LDX #<livesLeftText
        LDY #>livesLeftText
        JSR WriteToScreen
        LDX #<uridiumDecal
        LDY #>uridiumDecal
        JSR WriteToScreen
;       LDA #M_WHITE
;       STA $D026    ;Sprite Multi-Color Register 1
;       LDA #$FE
;       STA $D025    ;Sprite Multi-Color Register 0
        LDX #<spriteVariablesManta
        LDY #>spriteVariablesManta
        STX spriteVariablesLoPtr
        STY spriteVariablesHiPtr
        JSR LoadSpriteVariablesAndDisplay
        JSR SpinWaitingForJoystickInput
        JSR GenerateRandomDataFromRNG

        LDA #$03
        STA soundVariable1
        LDA #$04
        STA soundVariable2
        LDA #$05
        STA soundVariable3
        LDA #$BF
        STA someKindOfFrameRate
	
	jsr char2title

SpinningShipAnimationLoop
	;lda #0
	;sta dbgpos
	;lda someKindOfFrameRate
	;jsr puthex
	;lda currentSpriteValue
	;jsr puthex
	;lda spriteIndex
	;jsr puthex
	;lda currentSpriteDisplayEnable
	;jsr puthex
	;lda currentSpriteXPos
	;jsr puthex
	;lda currentSpriteYPos
	;jsr puthex
	
        JSR CheckInputMaybeUpdateDecal
        LDA firePressed
        BEQ SpinningShipAnimationOver
        LDA someKindOfFrameRate
        BEQ SpinningShipAnimationOver
        JSR MaybeShowPauseScreen
        JSR GetCurrentSprite
        INC currentSpriteValue
        LDA currentSpriteValue
        CMP #MANTA_LEFT_0
        BCC b0CD1
        LDA #MANTA
        STA currentSpriteValue
b0CD1   JSR DisplayCurrentSprite
	jsr char2gfx
	jsr renderSprites
        JMP SpinningShipAnimationLoop

        ; The spinning ship sequence is over, or the user has pressed
        ; fire so start the ship deployment sequence.
SpinningShipAnimationOver
        LDA #$12
        STA soundOrTitleSelector
	;SEI
	;JSR PlayTitleTune
	;CLI
        JSR SetUpScreenForScrolling
        JSR UpdatePointersAndFetchSurfaceData
	;JSR PlayShipDeploymentSequence

;        LDA backgroundColor2
;        STA $D02E    ;Sprite 7 Color
        LDY #$07
b0CF0   LDA someKindOfSettingArray,Y
        STA a35,Y
        DEY
        BPL b0CF0

	dec mantaDirectionAndSpeed
;--------------------------------------------------------------------
; MainGameLoop
;--------------------------------------------------------------------
MainGameLoop
        ;LDA shouldWaitUntilReady
        ;BNE MainGameLoop
	
	lda #112
	jsr waitvcnt
	
	lda #0
	sta dbgpos
	lda scrollPositionHiPtr
	jsr puthex
	lda scrollPositionLoPtr
	jsr puthex
	lda mantaDirectionAndSpeed
	jsr puthex
	lda pixelsToScroll
	jsr puthex

        ;JSR AnimatePlayerBullet
        JSR UpdateScrollPositionUsingDirectionAndSpeed
        JSR ScrollShipSurface
	jsr char2gfx
;        JSR AddStarsBehindDreadnought
;        JSR UpdateColorsOnScreen
;        JSR UpdateEnemies
        INC someKindOfFrameRate
        JSR GetJoystickInput

        ; Perform one of seven functions at each loop.
;        LDA someKindOfFrameRate
;        AND #$07
;        TAY
;        LDA mainLoopJumpTableHiPtr,Y
;        STA mymainGameLoopHiPtr
;        LDA mainLoopJumpTableLoPtr,Y
;        STA mymainGameLoopLoPtr
;mymainGameLoopLoPtr   =*+$01
;mymainGameLoopHiPtr   =*+$02
;        JSR MaybeChangeTitleDecal

        ;JSR MaybeFirePlayerBullets
        JSR MaybeMoveLeft
        JSR MaybeMoveRight
        JSR UpdateABunchOfGameVariables
        JSR AnimateMantaShip
	jsr renderSprites
	
        ;JSR CheckLandNowWarning
        LDA landNowActivated
        BPL b0D41
        ;JMP StartLandingSequence

b0D41   LDA hasShipBeenHit
        BEQ MainGameLoop
	
	bne MainGameLoop
;--------------------------------------------------------------------
; DoNothing
;--------------------------------------------------------------------
DoNothing
        RTS
	
	
;-------------------------------------------------------------------
; AnimateMantaShip
;-------------------------------------------------------------------
AnimateMantaShip
        LDA a46
        BPL DrawTheAnimation

        LDA a45
        AND #$04
        BEQ RightFacingAnimation

LeftFacingAnimation
        LDA a45
        ASL
        ASL
        ASL
        AND #$18
        STA a0F
        LDA a46
        AND #$07
        ORA a0F
        TAX
        LDA mantaleftFacingAnimationLoPtrArray,X
        STA mantaAnimationLoPtr
        LDA mantaleftFacingAnimationHiPtrArray,X
        STA mantaAnimationHiPtr

j2737   LDY #$00
        LDA (mantaAnimationLoPtr),Y
        STA framesInAnimation
        TAY
        INY
        LDA (mantaAnimationLoPtr),Y
        STA a47
        BNE b2749
        LDA a3F
        BNE b274E
b2749   INY
        LDA (mantaAnimationLoPtr),Y
        STA a3F
b274E   LDA a46
        STA a45
        LDA #$00
        STA a46
        RTS

RightFacingAnimation   
        LDA a45
        ASL
        ASL
        ASL
        AND #$18
        STA a0F
        LDA a46
        AND #$07
        ORA a0F
        TAX
        LDA mantaRightFacingAnimationLoPtrArray,X
        STA mantaAnimationLoPtr
        LDA mantaRightFacingAnimationHiPtrArray,X
        STA mantaAnimationHiPtr
        JMP j2737

DrawTheAnimation   
        LDA a45
        BMI b277B
        JMP DrawMantaAnimationFrame

b277B   LDA someKindOfFrameRate
        AND #$01
        BNE DrawMantaAnimationFrame
        LDY framesInAnimation
        LDA (mantaAnimationLoPtr),Y
        STA newSpriteValue
        LDA a47
        BEQ b2793
        LDA mantaShadowOffsets,Y
        CLC
        ADC mantaShadowOffset
        STA mantaShadowOffset
b2793   DEC framesInAnimation
        BNE DrawMantaAnimationFrame
        LDA a45
        AND #$7F
        STA a45
        LDA #$00
        STA a3F
        STA a47

        ; Draw the animation frame.
DrawMantaAnimationFrame   
        LDA #$06
        STA spriteIndex
        JSR GetCurrentSprite
        LDA newSpriteValue
        STA currentSpriteValue
        CLC
        ADC #$30
        STA mantaShadowSpriteValue
        LDA mantaCurrentYPos
        STA currentSpriteYPos
        JSR DisplayCurrentSprite

        ; Draw the Manta's shadow.
        INC spriteIndex
        JSR GetCurrentSprite
        LDA mantaShadowSpriteValue
        STA currentSpriteValue
        LDA mantaShadowOffset
        LSR
        CLC
        ADC mantaCurrentYPos
        STA currentSpriteYPos
        LDA #MANTA_HORIZONTAL_POSITION
        CLC
        ADC mantaShadowOffset
        STA currentSpriteXPos
        JSR DisplayCurrentSprite
        ; Falls through
	
;-------------------------------------------------------------------
; UpdateABunchOfGameVariables
;-------------------------------------------------------------------
UpdateABunchOfGameVariables
        LDA a34
        CLC
        ADC mantaCurrentYPos
;        CMP #$62
        CMP #$15
        BCS b2697
;        LDA #$62
        LDA #$15
b2697   ;CMP #$D7
	cmp #$89
        BCC b269D
;        LDA #$D7
        LDA #$89
b269D   STA mantaCurrentYPos
        LDA mantaDirectionAndSpeed
        BMI b26D1
        CMP a38
        BCC b26AB
        LDA a38
        STA mantaDirectionAndSpeed
b26AB   LDA a45
        BMI b26EB
        LDA currentScrollSegment
        BNE b26BA
        LDA #$C8
        STA a3F
        JMP b26EB

b26BA   CMP #$0E
        BCC b26EB
        LDA positionInsideScrollSegment
        BPL b26EB
b26C2   LDA a45
        ORA #$80
        STA a46
        JMP b26EB

b26CB   LDA positionInsideScrollSegment
        BMI b26EB
        BPL b26C2
b26D1   CMP a37
        BCS b26D9
        LDA a37
        STA mantaDirectionAndSpeed
b26D9   LDA a45
        BMI b26EB
        LDA currentScrollSegment
        BMI b26EB
        BEQ b26CB
        CMP #$0E
        BCC b26EB
        LDA #$38
        STA a3F
b26EB   LDA a3E
        CMP #$03
        BCS b26FF
        CMP #$02
        BCS b2700
        LDA a45
        BMI b26FF
        EOR #$04
        ORA #$80
        STA a46
b26FF   RTS

b2700   LDA a45
        BMI b26FF
        AND #$03
        CMP #$01
        BEQ b26FF
        LDA a45
        AND #$FC
        ORA #$81
        STA a46
        RTS

;-------------------------------------------------------------------
; CheckInputMaybeUpdateDecal
;-------------------------------------------------------------------
CheckInputMaybeUpdateDecal
        JSR GetJoystickInput
        JSR MaybeChangeTitleDecal
        LDY #$18
        JSR WasteCyclesUsingXAndY
        INC someKindOfFrameRate
        RTS

;-------------------------------------------------------------------
; GetCurrentSprite
;-------------------------------------------------------------------
GetCurrentSprite
        LDY spriteIndex
        LDA msbForSpriteArray,Y
        STA currentSpriteMSB
	
	lda spriteShape,y
	sta currentSpriteValue
	
	lda spriteXpos,y
	asl
	sta currentSpriteXPos
	lda #0
	rol
	beq GetCurrentSprite1
	lda #$ff
GetCurrentSprite1	
	sta currentSpriteMSBXPosOffset
	
	lda spriteYpos,y
	sta currentSpriteYPos

	lda spriteEna,y
	sta currentSpriteDisplayEnable
	rts
	
	
	
	
        EOR #$FF
        STA spriteMixerValue
        LDA $D027,Y  ;Sprite 0 Color
        STA currentSpriteColor
        LDA sprite0Ptr,Y
        STA currentSpriteValue
        TYA
        ASL
        TAY
        LDA $D000,Y  ;Sprite 0 X Pos
        STA currentSpriteXPos
        LDA $D001,Y  ;Sprite 0 Y Pos
        STA currentSpriteYPos
        LDA $D010    ;Sprites 0-7 MSB of X coordinate
        AND currentSpriteMSB
        BEQ bB088
        LDA #$FF
bB088   STA currentSpriteMSBXPosOffset
        LDA $D015    ;Sprite display Enable
        AND currentSpriteMSB
        STA currentSpriteDisplayEnable
        RTS

;-------------------------------------------------------------------
; SetUpScreenForScrolling
;-------------------------------------------------------------------
SetUpScreenForScrolling
        JSR LoadSurfaceStructureData
        LDA #$40
        STA positionInsideScrollSegment
        LDA #M_WHITE
        STA currentBackgroundColor
        LDA #$00
        STA currentScrollSegment
        JSR CreateDreadnoughtForCurrentLevel	
        JSR ClearSurfaceStructureDataPtrArray
        JSR UpdateScreenColors
        ;JSR AddStarsToBackgroundBehindDreadnought
        JSR ScrollShipSurface
        JSR AddStarsBehindDreadnought
        ;JSR GenerateStarfield
;        LDA #$FB
;        STA $D025    ;Sprite Multi-Color Register 0
        LDA #$00
        STA a34
        STA mantaDirectionAndSpeed
        STA a3F
        STA a47
        STA a46
        STA a3E
        STA hasShipBeenHit
        LDA #$FF
        STA a2D
        LDA #$10
        STA mantaShadowOffset
        LDA #$05
        STA a45
        LDA #$59
        STA newSpriteValue
        LDA #$98
        STA mantaCurrentYPos
        LDA #$01
        STA fireButtonDebounce
        LDA BUTTON_DEBOUNCE
        STA buttonPressDebounce
;        LDA backgroundColor2
;        STA $D02E    ;Sprite 7 Color
;        LDA #$2F
;        STA charsetSwitcher
;        JSR SetInterrupToIRQInterrupt2
        RTS

;-------------------------------------------------------------------
; UpdatePointersAndFetchSurfaceData
;-------------------------------------------------------------------
UpdatePointersAndFetchSurfaceData
        LDY indexToCurrentLevelTextureData
        LDA scoringStrategyForLevelLoPtrArray,Y
        STA loPtrToEnemyFormationOrder
        LDA scoringStrategyForLevelHiPtrArray,Y
        STA hiPtrToEnemyFormationOrder

        LDA #$00
        STA formationAnnihilationBonus
        STA landNowActivated
        LDA #$80
        STA usedToCheckIfWeShouldLaunchMine
        STA whetherScoreAwardedForHittingEnemy
        JSR FetchCurrentSurfaceData
        RTS

;-------------------------------------------------------------------
; LoadSurfaceStructureData
; Reads in the surface structure data
; In fact it generates the pointers to the tile data
;-------------------------------------------------------------------
LoadSurfaceStructureData
        LDX #<surfaceStructureData
        LDY #>surfaceStructureData
        STX srcLoPtr
        STY srcHiPtr

        LDX #$01
UpdateTextureDataLoop   
        LDY #$00
        STY stashedYValue
        LDA srcLoPtr
        STA surfaceStructureDataLoPtrArray,X
        LDA srcHiPtr
        STA surfaceStructureDataHiPtrArray,X
        INX
        BEQ ReturnFromUpdatingPosition
        LDA (srcLoPtr),Y
        BEQ ReturnFromUpdatingPosition

        STA initialValueOfY
        INC stashedYValue
b2C89   LDY stashedYValue
        LDA (srcLoPtr),Y
        SEC
        ADC stashedYValue
        STA stashedYValue
        DEC initialValueOfY
        BNE b2C89

        LDA srcLoPtr
        CLC
        ADC stashedYValue
        STA srcLoPtr
        BCC UpdateTextureDataLoop
        INC srcHiPtr
        JMP UpdateTextureDataLoop

ReturnFromUpdatingPosition
	RTS

;-------------------------------------------------------------------
; ClearSurfaceStructureDataPtrArray
;-------------------------------------------------------------------
ClearSurfaceStructureDataPtrArray
        LDA #$00
        TAY
b2CA8   STA surfaceStructureDataLoPtrArray,Y
        STA surfaceStructureDataHiPtrArray,Y
        INY
        BNE b2CA8
        RTS

;-------------------------------------------------------------------
; CreateDreadnoughtForCurrentLevel
;-------------------------------------------------------------------
CreateDreadnoughtForCurrentLevel
	lda #0
	sta dbgpos
	lda indexToCurrentLevelTextureData
	jsr puthex

        LDA #$FF
        STA someKindOfTextureColorVariable
        LDA indexToCurrentLevelTextureData
        AND #$0F
        TAY
        LDA dreadnoughtDataForLevelLoPtrArray,Y
        STA dreadnoughtDataLoPtr
        LDA dreadnoughtDataForLevelHiPtrArray,Y
        STA dreadnoughtDataHiPtr

        ; Fill the beginning and end of the dreadnought map
        ; with spaces.
        LDA #>(surfaceDataForCurrentLevel + $2000)
        STA currentLevelSurfaceDataHiPtr
        LDA #<(surfaceDataForCurrentLevel + $2000)
        STA currentLevelSurfaceDataLoPtr
b2CCD   LDY #$3F
        LDA #$20
b2CD1   STA (currentLevelSurfaceDataLoPtr),Y
        DEY
        BPL b2CD1
        DEC currentLevelSurfaceDataHiPtr
        DEC currentLevelSurfaceDataHiPtr
        LDA currentLevelSurfaceDataHiPtr
        CMP #>surfaceDataForCurrentLevel
        BCS b2CCD

        ; dreadnoughtData gives us an index into surfaceStructureDataLoPtrArray. 
        ; We use this textureData to write the structure of an object
        ; built from charsets into currentLevelSurfaceData. 

        LDX #<startOfSurfaceDataForCurrentLevel
        LDY #>startOfSurfaceDataForCurrentLevel
        STX currentLevelSurfaceDataLoPtr
        STY currentLevelSurfaceDataHiPtr

        ; Each objec
DrawSurfaceSectionsLoop   
        ; Get the next structure in the dreadnought data.
        LDY #$00
        LDA (dreadnoughtDataLoPtr),Y
        ; If we've hit a '00' do a special read of the '01' structure before
        ; moving on to the next section of the dreadnought data in DrawPlacedStructures.
        BEQ ReachedEndOfSurfaceSections
        TAX                           ; Make it an index into surfaceStructureDataLoPtrArray
        ; Get the object structure from textureData.
        LDA surfaceStructureDataHiPtrArray,X
        STA srcHiPtr
        LDA surfaceStructureDataLoPtrArray,X
        STA srcLoPtr
        CLC
        ; Move to the next structure in dreadnought data, for the next time around..
        LDA dreadnoughtDataLoPtr
        ADC #$01
        STA dreadnoughtDataLoPtr
        BCC ReadSurfaceSection
        INC dreadnoughtDataHiPtr

numberOfStrips = initialValueOfY
        ; Read in and interpret the object structure.
ReadSurfaceSection   
        LDA (srcLoPtr),Y                ; Get the first value, the length of the object.
        INY                             ; Move to the next value.
        STA numberOfStrips

        ; Point ramLo/HiPtr to currentLevelSurfaceData for writing out the surface data.
DrawSectionStrip   
        LDA currentLevelSurfaceDataLoPtr
        STA ramLoPtr
        LDA currentLevelSurfaceDataHiPtr
        STA ramHiPtr

        LDA (srcLoPtr),Y   ; Read in the run-length of the data.
        INY                ; Move index to next position.
        AND #$1F           ; Cap length to 31.
        TAX                ; Store the run-length in X.
ReadSectionBytes   
        LDA (srcLoPtr),Y   ; Get a charset value from the object.
        INY                ; Increment Y.
        STY stashedYValue  ; Stash Y.
        LDY #$00           ; 
        STA (ramLoPtr),Y   ; Store the charset value in currentLevelSurfaceData.

        LDY stashedYValue  ; Restore Y.
        DEC ramHiPtr       ; Move up to the next position in the strip (i.e. 512 bytes) ..
        DEC ramHiPtr       ; .. by decrementing the high pointer twice.
        DEX
        BNE ReadSectionBytes ; Loop until all data read.

        ; Fill any remaining space with blank spaces.
BlankSpacesLoop   
        LDA ramHiPtr
        CMP #>surfaceDataForCurrentLevel
        BCC GoToNextSection
        STY stashedYValue
        LDY #$00
        LDA #SPACE
        STA (ramLoPtr),Y
        LDY stashedYValue
        DEC ramHiPtr ; Move up to the next position in the strip (i.e. 512 bytes) ..
        DEC ramHiPtr ; .. by decrementing the high pointer twice.
        JMP BlankSpacesLoop

        ; Do the next strip.
GoToNextSection
        CLC
        LDA currentLevelSurfaceDataLoPtr
        ADC #$01
        STA currentLevelSurfaceDataLoPtr
        BCC b2D4B
        INC currentLevelSurfaceDataHiPtr
b2D4B   LDA currentLevelSurfaceDataHiPtr
        CMP #>surfaceStructureDataLoPtrArray
        BCS DrawPlacedStructures
        DEC numberOfStrips
        BNE DrawSectionStrip
        BEQ DrawSurfaceSectionsLoop

ReachedEndOfSurfaceSections   
        LDA surfaceStructureDataLoPtrArray + $01
        STA srcLoPtr
        LDA surfaceStructureDataHiPtrArray + $01
        STA srcHiPtr
        LDY #$00
        JMP ReadSurfaceSection

        ; Read in the structures that have a defined position.
DrawPlacedStructures   
        LDY #$00
        CLC
        LDA dreadnoughtDataLoPtr
        ADC #$01
        STA dreadnoughtDataLoPtr
        BCC ReadPlacedStructure
        INC dreadnoughtDataHiPtr

ReadPlacedStructure   
        ; Read in the High Pointer Byte
        LDA (dreadnoughtDataLoPtr),Y
	clc
	adc #$1C
;        ORA #$80
;        AND #$BF
        STA currentLevelSurfaceDataHiPtr
        CMP #>surfaceStructureDataLoPtrArray ; If we a high pointer not pointing to an area within the array, bail.
        BCS FinishSurfaceAndReturn

        ; Read in the Low Pointer Byte
        INY
        LDA (dreadnoughtDataLoPtr),Y
        STA currentLevelSurfaceDataLoPtr

        ; Read in the index to a surface structure.
        INY
        LDA (dreadnoughtDataLoPtr),Y
        BEQ FinishSurfaceAndReturn
        TAX
        LDA surfaceStructureDataHiPtrArray,X
        STA srcHiPtr
        LDA surfaceStructureDataLoPtrArray,X
        STA srcLoPtr

        ; Move index forward 3 bytes to the next substructure.
        CLC
        LDA dreadnoughtDataLoPtr
        ADC #$03
        STA dreadnoughtDataLoPtr
        BCC b2D9F
        INC dreadnoughtDataHiPtr

       ; Read the structure data pointed to by the index.
b2D9F   
        LDY #$00
        LDA (srcLoPtr),Y
        INY
        STA numberOfStrips

        ; Process each strip in the structure.
ProcessStrip   
        LDA currentLevelSurfaceDataLoPtr
        STA ramLoPtr
        LDA currentLevelSurfaceDataHiPtr
        STA ramHiPtr
        LDA (srcLoPtr),Y
        INY

        ; Process each character in the strip. 
        AND #$1F
        TAX
ProcessCharacterInStrip   
        LDA (srcLoPtr),Y
        INY
        STY stashedYValue
        LDY #$00
        CMP #SPACE
        BEQ b2DC1
        STA (ramLoPtr),Y
b2DC1   JSR SomeKindOfFixUpToTheSurfaceData
        LDY stashedYValue
        DEC ramHiPtr ; Move up to the next position in the strip (i.e. 512 bytes) ..
        DEC ramHiPtr ; .. by decrementing the high pointer twice.
        BPL FinishSurfaceAndReturn
        DEX
        BNE ProcessCharacterInStrip

        ; Go to the next strip
        CLC
        LDA currentLevelSurfaceDataLoPtr
        ADC #$01
        STA currentLevelSurfaceDataLoPtr
        BCC b2DDA
        INC currentLevelSurfaceDataHiPtr
b2DDA   DEC numberOfStrips
        BNE ProcessStrip

        ; Go to the next substructure.
        LDY #$00
        JMP ReadPlacedStructure

FinishSurfaceAndReturn   
        RTS


;-------------------------------------------------------------------
; FetchCurrentSurfaceData
;-------------------------------------------------------------------
FetchCurrentSurfaceData
;       SEI
        LDA #$24
        STA RAM_ACCESS_MODE
        LDY indexToCurrentLevelTextureData
        LDA levelSurfaceDataHiPtrArray,Y
        STA tempHiPtrCopyFrom
        LDA #$00
        STA tempLoPtrCopyFrom
        STA tempLoPtrCopyTo
        LDA #>initialPositionOfMiniGameScreenData
        STA tempHiPtrCopyTo
        LDX #$04
        JSR CopyDataUntilXIsZero
        LDA #$25
        STA RAM_ACCESS_MODE
;       CLI
        RTS
	
;-------------------------------------------------------------------
; UpdateScreenColors
;-------------------------------------------------------------------
UpdateScreenColors
	rts

;-------------------------------------------------------------------
; SomeKindOfFixUpToTheSurfaceData
;-------------------------------------------------------------------
SomeKindOfFixUpToTheSurfaceData
        CMP #$59
        BCC b2E16
        CMP #$5C
        BCS b2E16
        LDY someKindOfTextureColorVariable
        INY
        CPY #$10
        BCS b2E16
        STY someKindOfTextureColorVariable
        LDA ramHiPtr
        AND #$01
        STA $0230,Y
        LDA ramHiPtr
        SEC
        SBC #$82
        CLC
        ADC #$0C
        LSR
        STA $0220,Y
        LDA ramLoPtr
        STA $0210,Y
        ROR
        STA $0200,Y
        LDA #$FF
        STA $0240,Y
b2E16   RTS


;-------------------------------------------------------------------
; FirePlayerBullets
;-------------------------------------------------------------------
FirePlayerBullets
        LDA fireButtonDebounce
        ORA #$80
        STA fireButtonDebounce

        ; Fire the top bullet.
        LDX newSpriteValue
        LDA levelColorScheme + $01,X
        BEQ b2993
        CLC
        ADC mantaCurrentYPos
        SEC
        SBC #$62
        STA pixelYPositionOfPlayerBullet
        LDX #$00
        JSR GetFreeSlotForBullets
        BCS b2993
        STX dataIndex
        JSR UpdateBulletArrays

        ; Fire the bottom bullet.
        LDX newSpriteValue
        LDA levelColorScheme + 47,X
        BEQ b2993
        CLC
        ADC mantaCurrentYPos
        SEC
        SBC #$62
        STA pixelYPositionOfPlayerBullet
        LDX dataIndex
        JSR GetFreeSlotForBullets
        BCS b2993
        JSR UpdateBulletArrays
b2993   RTS

;-------------------------------------------------------------------
; GetFreeSlotForBullets
;-------------------------------------------------------------------
GetFreeSlotForBullets
        LDA playerBulletSlotArray,X
        BEQ b299F
        INX
        CPX #$06
        BCC GetFreeSlotForBullets
        RTS

b299F   CLC
        RTS
;-------------------------------------------------------------------
; UpdateBulletArrays
;-------------------------------------------------------------------
UpdateBulletArrays
        LDA #$09
        STA soundVariable1
        LDA #$02
        LDY mantaDirectionAndSpeed
        BEQ b29DF
        BMI b29DF

        ; Create a right-firing bullet.
        LDA #$FE
        STA playerBulletSlotArray,X
        LDA mantaTopCannonLoPtr
        STA playerBulletRamLoPtrArray,X
        STA colorRamLoPtr

        LDA pixelYPositionOfPlayerBullet
        AND #$07
        CMP #$07
        BNE b29C3
        LDA #$06
b29C3   STA bulletOffsetsInCharsetDef,X
        LDA pixelYPositionOfPlayerBullet
        LSR
        LSR
        AND #$FE
        STA pixelYPositionOfPlayerBullet
        LDA mantaTopCannonHiPtr
        AND #$01
        CLC
        ADC pixelYPositionOfPlayerBullet
        ADC #$82
        STA playerBulletRamHiPtrArray,X
        STA colorRamHiPtr
        JMP FinishedUpdatingBullets

        ; Create a left-firing bullet.
b29DF   STA playerBulletSlotArray,X
        CLC
        ADC mantaTopCannonLoPtr
        STA playerBulletRamLoPtrArray,X
        STA colorRamLoPtr
        PHP
        LDA pixelYPositionOfPlayerBullet
        AND #$07
        CMP #$07
        BNE b29F5
        LDA #$06
b29F5   STA bulletOffsetsInCharsetDef,X
        LDA pixelYPositionOfPlayerBullet
        LSR
        LSR
        AND #$FE
        STA pixelYPositionOfPlayerBullet
        LDA mantaTopCannonHiPtr
        AND #$01
        CLC
        ADC pixelYPositionOfPlayerBullet
        PLP
        ADC #$82
        STA playerBulletRamHiPtrArray,X
        STA colorRamHiPtr

FinishedUpdatingBullets
        LDY #$00
        LDA (colorRamLoPtr),Y
        STA charBehindPlayerBulletArray,X
        RTS
	
;-------------------------------------------------------------------
; CopyDataUntilXIsZero
;-------------------------------------------------------------------
CopyDataUntilXIsZero
        LDY #$00
        JSR CopyDataUntilYIsZero
        INC tempHiPtrCopyFrom
        INC tempHiPtrCopyTo
        DEX
        BNE CopyDataUntilXIsZero
        RTS
	
;-------------------------------------------------------------------
; CopyDataUntilYIsZero
;-------------------------------------------------------------------
CopyDataUntilYIsZero
        LDA (tempLoPtrCopyFrom),Y
        STA (tempLoPtrCopyTo),Y
        DEY
        BNE CopyDataUntilYIsZero
        LDA (tempLoPtrCopyFrom),Y
        STA (tempLoPtrCopyTo),Y
        RTS
	
;-------------------------------------------------------------------
; WasteCyclesUsingXAndY
;-------------------------------------------------------------------
WasteCyclesUsingXAndY
        DEX
        BNE WasteCyclesUsingXAndY
        DEY
        BNE WasteCyclesUsingXAndY
        RTS

;-------------------------------------------------------------------
; GetJoystickInput
;-------------------------------------------------------------------
GetJoystickInput
        LDA #$00
        STA upPressed
        STA rightPressed
;        LDA #$FF
;        STA $DC00    ;CIA1: Data Port Register A
joystick1LoPtr   =*+$01
joystick1HiPtr   =*+$02
	lda porta
;        LDA $DC00    ;CIA1: Data Port Register A
joystick2LoPtr   =*+$01
joystick2HiPtr   =*+$02
;        AND $DC01    ;CIA1: Data Port Register B
        BIT msbForSpriteArray + $02
        BEQ bB037
        BIT msbForSpriteArray + $03
        BEQ bB03B
        JMP jB03D

bB037   DEC rightPressed
        BNE jB03D
bB03B   INC rightPressed
jB03D   BIT msbForSpriteArray
        BEQ bB04A
        BIT msbForSpriteArray + $01
        BEQ bB04E
        JMP jB050

bB04A   DEC upPressed
        BNE jB050
bB04E   INC upPressed
jB050   lda trig0
;	AND #$10
	AND #$01
        STA firePressed
        RTS

;-------------------------------------------------------------------
; Write21LinesOfAccumulatorValToScreen
;-------------------------------------------------------------------
Write21LinesOfAccumulatorValToScreen
        LDX #<SCREEN_RAM_HIBANK + $00A0
        LDY #>SCREEN_RAM_HIBANK + $00A0
        STX ramLoPtr
        STY ramHiPtr
        LDX #$15
        JSR WriteToRam
        RTS
	
;-------------------------------------------------------------------
; WriteToRam
;-------------------------------------------------------------------
WriteToRam
        STA currentSpriteColor
jB18B   LDY #$00
bB18D   STA (ramLoPtr),Y
        INY
        CPY #$28
        BCC bB18D
        DEX
        BEQ bB1A7
        CLC
        LDA ramLoPtr
        ADC #$28
        STA ramLoPtr
        BCC bB1A2
        INC ramHiPtr
bB1A2   LDA currentSpriteColor
        JMP jB18B

bB1A7   CLC
        CLC
        LDA ramLoPtr
        ADC #$28
        STA ramLoPtr
        BCC bB1B3
        INC ramHiPtr
bB1B3   RTS

;-------------------------------------------------------------------
; WriteSourceValueToRam
;-------------------------------------------------------------------
WriteSourceValueToRam
        STY initialValueOfY
b23A7   LDY initialValueOfY
        LDA (srcLoPtr),Y
        LDX #$01
        JSR WriteToRam
        DEC initialValueOfY
        BPL b23A7
        RTS
	
;

;-------------------------------------------------------------------
; AnimatePlayerBullet
;-------------------------------------------------------------------
AnimatePlayerBullet
        LDY #$00
        LDX #$05
EraseBulletsLoop  
        LDA playerBulletSlotArray,X
        BEQ SkipB
        LDA playerBulletRamLoPtrArray,X
        STA ramLoPtr
        LDA playerBulletRamHiPtrArray,X
        STA ramHiPtr
        LDA charBehindPlayerBulletArray,X
        STA (ramLoPtr),Y
SkipB   DEX
        BPL EraseBulletsLoop

        INX  ; Make X = 1.
DrawPlayerBulletsLoop
        LDA playerBulletSlotArray,X
        BEQ GoToNextPlayerBullet

        JSR UpdatePlayerBulletPosition
        STA playerBulletRamHiPtrArray,X
        STA ramHiPtr
        ROR

        ; Check whether the bullet has hit something.
        LDA ramLoPtr
        ROR
        CMP mantaBottomCannonLoPtr
        BCC SkipToNextBullet
        CMP mantaBottomCannonHiPtr
        BCS SkipToNextBullet
        LDA (ramLoPtr),Y
        BPL DrawPlayerBullet
        CMP #$90
        BCC PlayerBulletBlockedByStructure
        CMP #$A0
        BCS DrawPlayerBullet
        JSR PlayerBulletDestroysStructure
        JMP SkipToNextBullet

bulletCharDefLoPtr = someDataLoPtr
bulletCharDefHiPtr = someDataHiPtr
DrawPlayerBullet
        STA charBehindPlayerBulletArray,X
        STY bulletBackgroundCharSetDefHiPtr
        ASL
        ROL bulletBackgroundCharSetDefHiPtr
        ASL
        ROL bulletBackgroundCharSetDefHiPtr
        ASL
        ROL bulletBackgroundCharSetDefHiPtr
        STA bulletBackgroundCharSetDefLoPtr

        LDA bulletBackgroundCharSetDefHiPtr
        ADC #>surfaceTextureCharacterSet
        STA bulletBackgroundCharSetDefHiPtr

        LDA offsetsForPlayerBullet,X
maskForPlayerBullet   =*+$01
        ORA #$80
        STA bulletCharDefLoPtr
        LDA #>surfaceTextureCharacterSet
        STA bulletCharDefHiPtr

        ; Copy the character set definition for the character underneath
        ; the bullet to our character set definition for the bullet.
        LDY #$07
bulletBackgroundCharSetDefLoPtr   =*+$01
bulletBackgroundCharSetDefHiPtr   =*+$02
CharacterDefCopyLoop
        LDA surfaceTextureCharacterSet,Y
        STA (bulletCharDefLoPtr),Y
        DEY
        BPL CharacterDefCopyLoop

        ; Draw the bullet by updating the character set definition we
        ; copied above by drawing a line (AA) across it.
        LDY bulletOffsetsInCharsetDef,X
        LDA #$00   ; The upper white line of the bullet.
        STA (bulletCharDefLoPtr),Y
        INY
        LDA #$AA   ; The lower black line of the bullet.
        STA (bulletCharDefLoPtr),Y


        ; Write the updated charset to the appropriate
        ; position on screen.
        LDY #$00
        TXA
bulletSurfaceMask   =*+$01
        ORA #$10
        STA (ramLoPtr),Y

GoToNextPlayerBullet
        INX
        CPX #$06
        BCC DrawPlayerBulletsLoop

        ; Reset the masks.
        LDA maskForPlayerBullet
        EOR #$80
        STA maskForPlayerBullet
        LDA bulletSurfaceMask
        EOR #$10
        STA bulletSurfaceMask
        RTS

PlayerBulletBlockedByStructure
        LDA #$21
        STA soundVariable1
SkipToNextBullet
        LDA playerBulletSlotArray,X
        BEQ GoToNextPlayerBullet
        LDA #$00
        STA playerBulletSlotArray,X
        BEQ GoToNextPlayerBullet
        ; Falls through

;-------------------------------------------------------------------
; UpdatePlayerBulletPosition
;-------------------------------------------------------------------
UpdatePlayerBulletPosition
        BMI b2ADA
        CLC
        ADC playerBulletRamLoPtrArray,X
        STA playerBulletRamLoPtrArray,X
        STA ramLoPtr
        LDA playerBulletRamHiPtrArray,X
        ADC #$00
        RTS

b2ADA
        CLC
        ADC playerBulletRamLoPtrArray,X
        STA playerBulletRamLoPtrArray,X
        STA ramLoPtr
        LDA playerBulletRamHiPtrArray,X
        ADC #-1
        RTS

;-------------------------------------------------------------------
; PlayerBulletDestroysStructure
;-------------------------------------------------------------------
PlayerBulletDestroysStructure
        TAY
        LDA playerBulletRamLoPtrArray,X
        SEC
        SBC f33C6,Y
        STA srcLoPtr
        LDA playerBulletRamHiPtrArray,X
        SBC f33D6,Y
        STA srcHiPtr
        LDA f33E6,Y
        STA stashedYValue
        STA initialValueOfY

        LDA scoresForHittingStructuresArray,Y
        TAY
        STX dataIndex
        JSR AddScoresFromHittingStuff

        LDX dataIndex
        LDA #$1B
        STA soundVariable2
UpdateDestroyedSurfaceLoop
        LDY stashedYValue
DestroyStructure
        LDA (srcLoPtr),Y
        CMP #$20
        BCC SkipSpace
        CMP #$F0
        BCS GoToNextCharacter
        SEC
        SBC #$20
        STA (srcLoPtr),Y
GoToNextCharacter
        DEY
        BPL DestroyStructure

        DEC initialValueOfY
        BMI ExitDestroyLoopAndReturn
        INC srcHiPtr
        INC srcHiPtr
        JMP UpdateDestroyedSurfaceLoop

ExitDestroyLoopAndReturn
        LDY #$00
        RTS

SkipSpace
        STX dataIndex
        TAX
        LDA #$00
        STA playerBulletSlotArray,X
        LDX dataIndex
        JMP GoToNextCharacter
	
;-------------------------------------------------------------------
; UpdateScrollPositionUsingDirectionAndSpeed
;-------------------------------------------------------------------
UpdateScrollPositionUsingDirectionAndSpeed
        LDA mantaDirectionAndSpeed
        BEQ UpdatePixelsToScroll
        BPL ScrollLeft

        ; Set the scroll position with a precision at the character level.
        LDA positionInsideScrollSegment
        SEC
        SBC mantaDirectionAndSpeed
        STA positionInsideScrollSegment

        ; Update the current scroll segment.
        ; Will increment currentScrollSegment and move to next segment if carry bit is set.
        ; Will stay on current segment if carry bit is not set.
        LDA currentScrollSegment
        SBC #$FF
        STA currentScrollSegment

        ; Set the scroll position with a precision of 8 bits within the character.
UpdatePixelsToScroll
        LDA #$08
        SEC
        SBC positionInsideScrollSegment
        AND #$07
        STA pixelsToScroll
        RTS

ScrollLeft
        ; Set the scroll position with a precision at the character level.
        LDA positionInsideScrollSegment
        SEC
        SBC mantaDirectionAndSpeed
        STA positionInsideScrollSegment

        ; Update the current scroll segment.
        ; Will decrement currentScrollSegment and move to previous segment if carry bit is not set.
        ; Will stay on current segment if carry bit is set.
        LDA currentScrollSegment
        SBC #$00
        STA currentScrollSegment
        JMP UpdatePixelsToScroll
	
;-------------------------------------------------------------------
; ScrollShipSurface
;-------------------------------------------------------------------
ScrollShipSurface
        LDA positionInsideScrollSegment
        CLC
        ADC #$07
        STA scrollPositionLoPtr

        ; Figure out which section of the dreadnought we're on.
        ; currentScrollSegment tracks our position on the dreanought
        ; in terms of 16 frames of 32 bytes each (the dreadnought is 512
        ; bytes wide). The routine below performs the following mapping
        ; for each value of currentScrollSegment:
        ;
        ; $X0 -> 8200, $X1 -> 8220, $X2 -> 8240, $X3 -> 8260
        ; $X4 -> 8280, $X5 -> 82A0, $X6 -> 82C0, $X7 -> 82F0
        ; $X8 -> 8300, $X9 -> 8320, $XA -> 8340, $XB -> 8360
        ; $XC -> 8380, $XD -> 83A0, $XE -> 83C0, $XF -> 83F0
        ;
        ; Note that only the last 4 bits are actually used for the mapping,
        ; the other 4 are ignored.
        ; Remember that 8200 is the address of surfaceDataForCurrentLevel, 
        ; so is the top left of the dreadnought map. 
        LDA currentScrollSegment
        ADC #$00
        LSR
        ROR scrollPositionLoPtr
        LSR
        ROR scrollPositionLoPtr
        LSR
        ROR scrollPositionLoPtr
        AND #$01
        STA secondHalfOfMap

        LDA #>surfaceDataForCurrentLevel
        ORA secondHalfOfMap
        STA scrollPositionHiPtr
;        STA surfaceDataForCurrentLevelHiPtr
        LDA scrollPositionLoPtr
;        STA surfaceDataForCurrentLevelLoPtr

;        LDA #>(SCREEN_RAM_HIBANK + $00F0)
;        STA screenRAMToDrawHiPtr
;        LDA #<(SCREEN_RAM_HIBANK + $00F0)
;        STA screenRAMToDrawLoPtr
;
;        LDX #$11
;DrawScrollingSurfaceRows   
;        LDY #$26
;DrawRowOfScrollingSurface   
;
;surfaceDataForCurrentLevelLoPtr   =*+$01
;surfaceDataForCurrentLevelHiPtr   =*+$02
;        LDA surfaceDataForCurrentLevel,Y
;screenRAMToDrawLoPtr   =*+$01
;screenRAMToDrawHiPtr   =*+$02
;        STA SCREEN_RAM_HIBANK + $00F0,Y
;
;        DEY
;        BPL DrawRowOfScrollingSurface
;
;        DEX
;        BEQ FinishScrollingAndCleanUp
;        INC surfaceDataForCurrentLevelHiPtr
;        INC surfaceDataForCurrentLevelHiPtr
;        LDA screenRAMToDrawLoPtr
;        CLC
;        ADC #$28
;        STA screenRAMToDrawLoPtr
;        BCC DrawScrollingSurfaceRows
;        INC screenRAMToDrawHiPtr
;
;        JMP DrawScrollingSurfaceRows

FinishScrollingAndCleanUp
        ; Update the stored positions of the player's cannon.
        LDA scrollPositionLoPtr
        CLC
        ADC #$12
        STA mantaTopCannonLoPtr

        PHP
        LDA mantaCurrentYPos
        SEC
        SBC #$58
        AND #$F8
        LSR
        LSR
        PLP
        ADC scrollPositionHiPtr
        STA mantaTopCannonHiPtr

        LDA scrollPositionHiPtr
        ROR
        LDA scrollPositionLoPtr
        ROR
        STA mantaBottomCannonLoPtr

        CLC
        ADC #$14
        STA mantaBottomCannonHiPtr
        RTS

;-------------------------------------------------------------------
; AddStarsBehindDreadnought
;-------------------------------------------------------------------
AddStarsBehindDreadnought
	rts


;-------------------------------------------------------------------
; AddScoresFromHittingStuff
;-------------------------------------------------------------------
AddScoresFromHittingStuff
        SED
        LDA scoresToAddArray1,Y
        CLC
        ADC playerScore + $03
        STA playerScore + $03
        LDA scoresToAddArray2,Y
        ADC playerScore + $02
        STA playerScore + $02
        PHP
        LDA playerScore + $01
        ADC #$00
        STA playerScore + $01
        LDA playerScore
        ADC #$00
        STA playerScore
        BCC AwardExtraLife
        LDA #$99
        STA playerScore
        STA playerScore + $01
        STA playerScore + $02
        STA playerScore + $03
        PLP
        CLD
        RTS

AwardExtraLife
        PLP
        BCC b1A36
        CLC
        LDA currentPlayerLivesLeft
        ADC #$01
        BCS b1A36
        STA currentPlayerLivesLeft
        CLD
        JSR UpdateLivesLeft
        LDA #$81
        STA soundVariable1
        RTS

b1A36   CLD
        RTS
	
enemyFormationDataLoPtr = srcLoPtr
enemyFormationDataHiPtr = srcHiPtr
enemiesToUpdate = stashedYValue
;-------------------------------------------------------------------
; MaybeCreateNewEnemyFormation
;-------------------------------------------------------------------
MaybeCreateNewEnemyFormation
        LDA someKindOfFrameRate
        AND #$3F
        CMP #$21
        BNE DontCreateNewFormation

        LDA usedToCheckIfWeShouldLaunchMine
        BEQ SelectAFormation

        CMP #$80
        BNE DontCreateNewFormation

        LDA #$00
        STA usedToCheckIfWeShouldLaunchMine
        LDA numberOfEnemiesSpawned
        BNE b1A93

        LDA whetherScoreAwardedForHittingEnemy
        BNE b1A93

        INC formationAnnihilationBonus
b1A93
        LDA #$00
        STA numberOfEnemiesSpawned
DontCreateNewFormation
        RTS

        ; Select a formation from enemyFormationData using
        ; the *EnemyFormationOrder arrays, e.g. level1EnemyFormationOrder. 
        ; If we've used up the array, select a random formation.
SelectAFormation   
        LDA #$00
        STA enemyFormationDataHiPtr
        LDA #$80
        STA usedToCheckIfWeShouldLaunchMine
        LDA #$AE
        STA soundVariable2

        LDY indexCurrentEnemyFormation
        LDA (loPtrToEnemyFormationOrder),Y
        CMP #$FF
        BNE b1AB9

        ; If we've used up the array, select a random formation.
        LDA $D41B    ; Random Number Generator
        AND #$03
        CLC
        ADC #$12
        STA whetherScoreAwardedForHittingEnemy
        JMP j1ABF

b1AB9   INC indexCurrentEnemyFormation
        LDX #$00
        STX whetherScoreAwardedForHittingEnemy

j1ABF   ASL
        ROL enemyFormationDataHiPtr
        ASL
        ROL enemyFormationDataHiPtr
        ASL
        ROL enemyFormationDataHiPtr
        ASL
        ROL enemyFormationDataHiPtr
        STA enemyFormationDataLoPtr

        LDA enemyFormationDataHiPtr
        ADC #>enemyFormationData
        STA enemyFormationDataHiPtr

        LDA #$FF
        STA currentSpriteDisplayEnable
        STA currentSpriteMultiColorMode
        STA currentSpriteMSBXPosOffset
        LDA spriteColorForLevel
        STA currentSpriteColor

        ; Get the sprite for this formation.
        LDY #$0E
        LDA (enemyFormationDataLoPtr),Y
        STA currentEnemySpriteValue

        TAX
        LDA enemyHorizontalVelocityArray,X
        STA enemyXPosForwardVelocity
        EOR #$FF
        CLC
        ADC #$01
        STA enemyXPosBackwardVelocity

        LDA #$00
        STA enemyBulletXPosIncrement
        STA enemyXPosForwardIncrement
        STA enemyYPosDownwardIncrement

        LDA #-1
        STA enemyXPosBackwardIncrement
        STA enemyYPosUpwardIncrement

        LDA enemyVerticalVelocityArray,X
        STA enemyYPosDownwardVelocity
        EOR #$FF
        CLC
        ADC #$01
        STA enemyYPosUpwardVelocity

        LDA currentPlayerLivesLeft
        LSR
        CLC
        ADC indexToCurrentLevelTextureData
        ADC selectForBulletsOrMines
        ADC fireBulletOrMineArray,X
        STA whetherToFireEnemyBulletOrMine

        LDA bulletSpriteArray,X
        STA bulletSpriteCurrentLevel

        LDA indexToScoresToAddArray,X
        STA scoreToAddForHittingEnemy

        LDA enemeyBulletSpeedForLevel,X
        STA enemyBulletXPosAnimationRate

        ; Get initial X Position of formation.
        ; 00 - means enter from the right
        ; FF - means enter from the left
        ; 80 - means ?
        DEY                              ; Point to 14th byte in enemyFormationData.
        LDA (enemyFormationDataLoPtr),Y
        BEQ b1B45
        CMP #$FF
        BEQ b1B36
        LDA $D41B    ; Random Number Generator
        BPL b1B45

        ; Entering from the left.
b1B36   LDA mantaDirectionAndSpeed
        EOR #$FF
        CLC
        ADC #$01
        STA initialEnemyXPos

        LDA mantaDirectionAndSpeed
        BMI b1B4D
        BPL b1B5B

        ; Entering from the right.
b1B45   LDA #$00
        STA initialEnemyXPos

        ; Choose the direction of the enemy sprite based on the
        ; the direction the manta is travelling.
        LDA mantaDirectionAndSpeed
        BMI b1B5B

        ; Manta is travelling to the left, so choose right-facing sprite
b1B4D   LDA #$A4
        STA currentSpriteXPos
        LDA currentEnemySpriteValue
        CLC
        ADC #$A0               ; Add A0 to point to the right-facing sprite.
        STA currentSpriteValue
        JMP GetMovementStrategyDuration

        ; Manta is travelling to the right, so choose left-facing sprite.
b1B5B   LDA #$A2
        STA currentSpriteXPos
        LDA currentEnemySpriteValue
        CLC
        ADC #$B0               ; Add B0 to point to the right-facing sprite.
        STA currentSpriteValue

        ; Reverse the increment values for left-facing sprites.
        LDA enemyXPosBackwardVelocity
        LDX enemyXPosForwardVelocity
        STX enemyXPosBackwardVelocity
        STA enemyXPosForwardVelocity

        LDA enemyXPosBackwardIncrement
        LDX enemyXPosForwardIncrement
        STX enemyXPosBackwardIncrement
        STA enemyXPosForwardIncrement

        ; Reverse the bullet animation direction for left facing sprites.
        LDA enemyBulletXPosAnimationRate
        EOR #$FF
        CLC
        ADC #$01
        STA enemyBulletXPosAnimationRate
        LDA #-1
        STA enemyBulletXPosIncrement

        ; Get the rate at which we tick through the items in the movement
        ; strategy.
GetMovementStrategyDuration
        LDY #$0C
        LDA (enemyFormationDataLoPtr),Y
        STA durationOfStrategyForFormation
        LDA #$00
        STA durationOfStrategyForNextEnemyInFormation

        ; Get the movement strategy and initial Y position for all enemies
        ; in the formation.
        LDY #$05
        STY enemiesToUpdate
        LDX #$0A
        STX dataIndex
InitializeEnemyLoop   
        LDY enemiesToUpdate
        STY spriteIndex

        ; Get the movement strategy to be used by the
        ; formation.
        LDA (enemyFormationDataLoPtr),Y
        BEQ SetYPositionsOfEnemies

        ; Select the movement strategy in enemyMovementStrategyLoPtrArray.
        LDX dataIndex
        TAY
        LDA enemyMovementStrategyLoPtrArray,Y
        STA enemyMovementStrategyLoPtr,X
        INX
        LDA enemyMovementStrategyHiPtrArray,Y
        STA enemyMovementStrategyLoPtr,X

        ; Make sure the next thing the enemy does is update its position.
        LDY enemiesToUpdate
        LDA #$02 ; UpdateEnemyPositions
        STA indexToEnemyUpdatePtrArray,Y

        INC usedToCheckIfWeShouldLaunchMine
        INC numberOfEnemiesSpawned

        LDA durationOfStrategyForNextEnemyInFormation
        STA durationOfMovementStrategyForEnemy,Y
        CLC
        ADC durationOfStrategyForFormation
        STA durationOfStrategyForNextEnemyInFormation

        ; Get the Y positions to be used for each of the enemy
        ; ships in the formation.
SetYPositionsOfEnemies
        TYA
        CLC
        ADC #$06
        TAY
        LDA (enemyFormationDataLoPtr),Y
        BNE b1BCB
        ; If no Y pos set, use the player's Y pos.
        LDA mantaCurrentYPos
b1BCB   STA currentSpriteYPos
        JSR ApplySpriteVariablesAndDisplay

        LDY enemiesToUpdate
        LDA enemyBulletXPosIncrement
        STA enemyFiringStrategy,Y

        LDA #$00
        STA enemyMovementStrategies,Y
        STA enemyXPosCurrentVelocityMSBOffsetArray,Y
        STA enemyXPosVelocityLimitArray,Y
        STA enemyYPosCurrentVelocityArray,Y
        STA enemyYPosVelocityLimitArray,Y

        LDA initialEnemyXPos
        STA enemyXPosCurrentVelocityArray,Y
        BPL b1BF4

        LDA #$FF
        STA enemyXPosCurrentVelocityMSBOffsetArray,Y

b1BF4   DEC dataIndex
        DEC dataIndex
        DEC enemiesToUpdate
        BPL InitializeEnemyLoop
        RTS
	
;-------------------------------------------------------------------
; ApplySpriteVariablesAndDisplay
;-------------------------------------------------------------------
ApplySpriteVariablesAndDisplay
	jmp DisplayCurrentSprite
	
        LDY spriteIndex
        LDA msbForSpriteArray,Y
        STA currentSpriteMSB
        EOR #$FF
        STA spriteMixerValue
        LDA currentSpriteColor
        STA $D027,Y  ;Sprite 0 Color
        LDA currentSpriteMultiColorMode
        BEQ bB0FE
        LDA currentSpriteMSB
        ORA $D01C    ;Sprites Multi-Color Mode Select
        BNE bB103
bB0FE   LDA $D01C    ;Sprites Multi-Color Mode Select
        AND spriteMixerValue
bB103   STA $D01C    ;Sprites Multi-Color Mode Select
        LDA currentSpriteExpandVertical
        BEQ bB111
        LDA currentSpriteMSB
        ORA $D017    ;Sprites Expand 2x Vertical (Y)
        BNE bB116
bB111   LDA $D017    ;Sprites Expand 2x Vertical (Y)
        AND spriteMixerValue
bB116   STA $D017    ;Sprites Expand 2x Vertical (Y)
        LDA currentSpriteExpandHorizontal
        BEQ bB124
        LDA currentSpriteMSB
        ORA $D01D    ;Sprites Expand 2x Horizontal (X)
        BNE bB129
bB124   LDA $D01D    ;Sprites Expand 2x Horizontal (X)
        AND spriteMixerValue
bB129   STA $D01D    ;Sprites Expand 2x Horizontal (X)
        LDA currentSpriteBackgroundDisplayPriority
        BEQ bB137
        LDA currentSpriteMSB
        ORA $D01B    ;Sprite to Background Display Priority
        BNE bB13C
bB137   LDA $D01B    ;Sprite to Background Display Priority
        AND spriteMixerValue
bB13C   STA $D01B    ;Sprite to Background Display Priority

;-------------------------------------------------------------------
; DisplayCurrentSprite
;-------------------------------------------------------------------
DisplayCurrentSprite
        LDY spriteIndex
	
	lda currentSpriteDisplayEnable
	sta spriteEna,y
	lda currentSpriteValue
	sta spriteShape,y
	lda #1
	sta spriteModus,y
	lda currentSpriteMSBXPosOffset
	lsr
	lda currentSpriteXPos
	ror
	sta spriteXpos,y
	lda currentSpriteYPos
	sta spriteYpos,y
	rts
	
        LDA msbForSpriteArray,Y
        STA currentSpriteMSB
        EOR #$FF
        STA spriteMixerValue
        LDA currentSpriteValue
        STA sprite0Ptr,Y
        TYA
        ASL
        TAY
        LDA currentSpriteXPos
        STA $D000,Y  ;Sprite 0 X Pos
        LDA currentSpriteYPos
        STA $D001,Y  ;Sprite 0 Y Pos
        LDA currentSpriteMSBXPosOffset
        AND #$01
        STA currentSpriteMSBXPosOffset
        LDA currentSpriteMSBXPosOffset
        BEQ bB16D
        LDA currentSpriteMSB
        ORA $D010    ;Sprites 0-7 MSB of X coordinate
        BNE bB172
bB16D   LDA $D010    ;Sprites 0-7 MSB of X coordinate
        AND spriteMixerValue
bB172   STA $D010    ;Sprites 0-7 MSB of X coordinate
        LDA currentSpriteDisplayEnable
        BEQ bB180
        LDA currentSpriteMSB
        ORA $D015    ;Sprite display Enable
        BNE bB185
bB180   LDA $D015    ;Sprite display Enable
        AND spriteMixerValue
bB185   STA $D015    ;Sprite display Enable
        RTS	
	
;--------------------------------------------------------------------
; MaybeStartNewLevel
;--------------------------------------------------------------------
MaybeStartNewLevel
        LDA currentLevel
        CMP indexToCurrentLevelTextureData
        BEQ CheckIfGameIsOver
        STA indexToCurrentLevelTextureData
        CMP #$10
        BCC b0D62
        LDA #$01
        STA currentLevel
        STA indexToCurrentLevelTextureData

        LDA selectForBulletsOrMines
        CLC
        ADC #$10
        CMP #$40
        BCS b0D62
        STA selectForBulletsOrMines

b0D62   LDA #$00
        STA indexCurrentEnemyFormation
        JMP EnterNewLevel
        ; Doesn't return here, enters main game loop.
	
	
CheckIfGameIsOver
	jmp CheckIfGameIsOver
		
;-------------------------------------------------------------------
; SpinWaitingForJoystickInput
;-------------------------------------------------------------------
SpinWaitingForJoystickInput
        LDA #$08
        STA initialValueOfY
bB276   JSR GetJoystickInput
        LDY #$08
        JSR WasteCyclesUsingXAndY
        LDA firePressed
        BEQ SpinWaitingForJoystickInput
        DEC initialValueOfY
        BNE bB276
        RTS
	
;-------------------------------------------------------------------
; LoadSpriteVariablesAndDisplay
;-------------------------------------------------------------------
LoadSpriteVariablesAndDisplay
        ; Load the variables from spriteIndex to currentSpriteColor
        ; with the values from spriteVariablesLoPtr
        LDY #$0A
bB289   LDA (spriteVariablesLoPtr),Y
        STA spriteIndex,Y
        DEY
        BPL bB289

        JSR ApplySpriteVariablesAndDisplay
        RTS

;-------------------------------------------------------------------
; MaybeFirePlayerBullets
;-------------------------------------------------------------------
MaybeFirePlayerBullets
        LDA fireButtonDebounce
        BMI b2954
        BEQ b2943
BUTTON_DEBOUNCE   =*+$01
        LDA #$07
        STA buttonPressDebounce
        LDA firePressed
        BNE b2942
        STA fireButtonDebounce
        JSR FirePlayerBullets
b2942   RTS

b2943   LDA firePressed
        BEQ b294D
        INC fireButtonDebounce
        JSR FirePlayerBullets
        RTS

b294D   LDA buttonPressDebounce
        BMI b2942
        DEC buttonPressDebounce
        RTS

b2954   AND #$7F
        STA fireButtonDebounce
        RTS

;--------------------------------------------------------------------
; b2617
;--------------------------------------------------------------------
b2617
        BMI b2627
        CLC
        ADC a2D
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$00
        BMI b2650
        JMP j2679

b2627   CLC
        ADC a2D
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$FF
        BMI b2650
        JMP j2679

;-------------------------------------------------------------------
; MaybeMoveRight
;-------------------------------------------------------------------
MaybeMoveRight
        LDA a3F
        BNE b2617
        LDA a45
        AND #$04
        BNE b2668
        LDA rightPressed
        BEQ b2659
        BMI b265A
        LDA a2D
        CLC
        ADC a39
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$FF
b2650   STA mantaDirectionAndSpeed
        EOR #$FF
        CLC
        ADC #$01
        STA a3E
b2659   RTS

b265A   LDA a2D
        CLC
        ADC a3A
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$00
        JMP b2650

b2668   LDA rightPressed
        BEQ b2659
        BPL b267E
        LDA a2D
        CLC
        ADC a3B
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$00
j2679
        STA mantaDirectionAndSpeed
        STA a3E
        RTS

b267E   LDA a2D
        CLC
        ADC a3C
        STA a2D
        LDA mantaDirectionAndSpeed
        ADC #$FF
        JMP j2679

;-------------------------------------------------------------------
; MaybeMoveLeft
;-------------------------------------------------------------------
MaybeMoveLeft
        LDA buttonPressDebounce
        BEQ b25B0
b257A   LDA upPressed
        BEQ b259E
        BMI b258F
        INC a34
        LDA a34
        BMI b258E
        CMP a36
        BCC b258E
        LDA a36
        STA a34
b258E   RTS

b258F   DEC a34
        LDA a34
        BPL b258E
        CMP a35
        BCS b258E
        LDA a35
        STA a34
        RTS

b259E   LDA a34
        CMP #$FF
        BEQ b25AB
        ROL
        LDA a34
        ROR
        STA a34
        RTS

b25AB   LDA #$00
        STA a34
        RTS

b25B0   LDA upPressed
        BNE b25B9
        INC buttonPressDebounce
        JMP b259E

b25B9   LDA a3F
        BNE b257A
        LDA a45
        BMI b257A
        AND #$03
        CMP #$01
        BNE b25DF
        CLC
        ADC upPressed
        AND #$03
        ORA #$80
        STA a0F
        LDA a3E
        CMP #$03
        BCC b257A
b25D6   LDA a45
        AND #$FC
        ORA a0F
        STA a46
        RTS

b25DF   LDA #$81
        STA a0F
        BNE b25D6
        ; Never Falls through
	
;------------------------------------------------------------
; main loop
;------------------------------------------------------------
;mainloop	lda #112
;		jsr waitvcnt
;
;		inc rtclok
;
;;		lda #10
;;		sta colbk
;		
;		lda #0
;		sta dbgpos
;;		lda dreadXpos+1
;;		jsr puthex
;;		lda dreadXpos
;;		jsr puthex
;		
;		jsr keyboard
;
;		lda dead
;		beq mainloop1
;		jsr explosion
;		jmp mainloop2
;		
;mainloop1	lda rtclok
;		and #$07
;		tay
;		lda screenWriteJumpTableHiPtr,Y
;		sta mainGameLoopHiPtr
;		lda screenWriteJumpTableLoPtr,Y
;		sta mainGameLoopLoPtr
;mainGameLoopLoPtr   =*+$01
;mainGameLoopHiPtr   =*+$02
;		jsr MaybeChangeTitleDecal
;		
;mainloop2	jsr char2title
;		jsr char2gfx
;		jsr stars2gfx
;		jsr renderSprites		
;		jsr moveBullets
;		
;		jsr checkstick
;		jsr checkfire
;		jsr moveShaft
;		jsr scrollSurface
;
;		jsr collision
;		jsr updateManta		
;		
;		jsr getstart
;		jsr getselect
;		jsr getoption
;
;;		lda #$00
;;		sta colbk
;		jmp mainloop

;-------------------------------------------------------------------
; MaybeChangeTitleDecal
;-------------------------------------------------------------------
MaybeChangeTitleDecal
		;rts
		ldx #1
ChangeDecal1	clc
		lda colorp2,x
		adc #16
		sta colorp2,x
		sta colpm2,x
		dex
		bpl ChangeDecal1
		
		lda rtclok
		and #$7F
		bne b231C
		lda a5B
		sta a0F
		clc
		adc #$01
		and #$03
		sta a5B
		beq b231D					;uridium
		lda pause
		cmp #$03
		beq b231D
		lda a5B
		cmp #$01
		beq b2325
		cmp #$02
		beq b232D
		lda pause
		;cmp #$02
		beq b2335
b22FC   	;lda playerAndJoystickMode
		;tay
		;lda scrollingTitleScreenDataHiPtrArray,Y
		;ldx scrollingTitleScreenDataLoPtrArray,Y
		;tay
		;jsr WriteToScreen
		;lda monochromEnabled
		;beq b2315
		;
		;ldx #<globeSymbol
		;ldy #>globeSymbol
		;jsr WriteToScreen
		rts
	
b2315   	ldx #<arrowKeysSymbol
		ldy #>arrowKeysSymbol
		jsr WriteToScreen
b231C   	rts
	
b231D   	ldx #<uridiumDecal
		ldy #>uridiumDecal
p2322   =*+$01
		jsr WriteToScreen
		rts
	
b2325   	ldx #<hiScoreLabel
		ldy #>hiScoreLabel
		jsr WriteToScreen
		rts
	
b232D   	ldx #<inGameBanner
		ldy #>inGameBanner
		jsr WriteToScreen
		rts

b2335   	LDY indexToCurrentLevelTextureData
		;ldy currentLevel
		ldx levelNameLoPtrArray,Y
		lda levelNameHiPtrArray,Y
		tay
		jsr WriteToScreen
		rts

UpdateAndDisplaySomeSprites
		rts
		
currentScoreCharToWrite = a0F
currentDigitInScore = dataIndex
;-------------------------------------------------------------------
; UpdatePlayerScore
;-------------------------------------------------------------------
UpdatePlayerScore
		lda #$02
		sta currentCharYPos
xPosForPlayerScoreDisplay =*+$01
		lda #$01
		sta currentCharXPos
		ldx #$00
		stx currentDigitInScore
		lda #$30
		sta currentScoreCharToWrite

bB1C4		lda playerScore,X
		lsr
		lsr
		lsr
		lsr
		bne bB1EF
		lda currentScoreCharToWrite
jB1CE		sta charToWrite
		jsr WriteCharacterToScreen
		ldx currentDigitInScore
		lda playerScore,X
		and #$0F
		bne bB1F6
		cpx #$03
		beq bB1F6
		lda currentScoreCharToWrite
jB1E1		sta charToWrite
		jsr WriteCharacterToScreen
		inc currentDigitInScore
		ldx currentDigitInScore
		cpx #$04
		bne bB1C4
		rts

bB1EF		ldy #$00
		sty currentScoreCharToWrite
		jmp jB1CE
		
bB1F6		ldy #$00
		sty currentScoreCharToWrite
		jmp jB1E1
		
		
;-------------------------------------------------------------------
; MaybeShowPauseScreen
;-------------------------------------------------------------------
MaybeShowPauseScreen
		lda pause
		and #1
		beq ReturnEarly
		
		ldx #<pauseText
		ldy #>pauseText
		jsr WriteToScreen

		jsr char2title
		
		jsr getoption
		lda pause
		and #1
		bne MaybeShowPauseScreen
		
		ldx #<spaces
		ldy #>spaces
		jsr WriteToScreen

		;rts
		
;--------------------------------------------------------------------
; ReturnEarly
;--------------------------------------------------------------------
ReturnEarly
		rts
		
;--------------------------------------------------------------------
; MaybeLaunchMine
;--------------------------------------------------------------------
MaybeLaunchMine
		rts
;--------------------------------------------------------------------
; UpdateCurrentColorValue
;--------------------------------------------------------------------
UpdateCurrentColorValue
		rts

;--------------------------------------------------------------------
;
;--------------------------------------------------------------------
;moveShaft	ldx #1
;moveShaft3	lda minePos0,x
;		sta hposp2,x
;		beq moveShaft4
;		
;		clc
;		ldy hspeed
;		bmi movecheckShaft
;
;moveShaftRight	adc hspeed
;		cmp #204
;		bcs moveShaft1
;		bcc moveShaft2
;
;movecheckShaft	adc hspeed
;		cmp #44
;		bcs moveShaft2
;		
;moveShaft1	lda #0
;moveShaft2	sta minePos0,x
;moveShaft4	dex
;		bpl moveShaft3
;
;moveShaftEx	rts

;--------------------------------------------------------------------
;
;--------------------------------------------------------------------
;shaftRight	lda #0
;                sta checkShaft2+1
;                lda #48
;                sta checkShaft9+1
;		bne checkShaft
;
;;--------------------------------------------------------------------
;;
;;--------------------------------------------------------------------
;shaftLeft	lda #39
;		sta checkShaft2+1
;		lda #204
;		sta checkShaft9+1
;
;;--------------------------------------------------------------------
;;
;;--------------------------------------------------------------------
;checkShaft	lda dreadXPos
;		sta ptr
;		lda dreadXPos+1
;		sta ptr+1
;	
;		ldx #0
;checkShaft2	ldy #39
;		lda (ptr),y
;;		cmp #$d7
;;		beq checkShaft4
;		cmp #$59					;mine shaft $58-5A
;		bcc checkShaft1
;		cmp #$5b+1
;		bcs checkShaft1
;		
;checkShaft4	ldy #1
;checkShaft6	lda minePos0,y
;		beq checkShaft5
;		dey
;		bpl checkShaft6
;		bmi checkShaft1
;		
;checkShaft5	lda hscrol
;		lsr
;checkShaft9	adc #204
;		sta minePos0,y
;		
;		stx temp
;		txa
;		asl
;		asl
;		asl
;		adc #72
;		tax
;
;		tya
;		adc #$ce
;		sta checkShaft7+2
;		sta checkShaft8+2
;		
;		lda #7
;		sta cnt
;		
;		lda p2Ypos,y
;		stx p2Ypos,y
;		tay
;
;checkShaft3	lda #0
;checkShaft7	sta $ce00,y
;		lda #$ff
;checkShaft8	sta $ce00,x
;		inx
;		iny
;		dec cnt
;		bpl checkShaft3
;		ldx temp
;		
;checkShaft1	inc ptr+1
;		inc ptr+1
;		inx
;		cpx #17
;		bne checkShaft2
;		
;checkShaftEx	rts
;-------------------------------------------------------------------
; 
;-------------------------------------------------------------------
;myMaybeFirePlayerBullets
;checkFire	lda bulletFlag
;		bmi checkFire1
;		beq checkFire3
;		
;		lda #$07
;		sta bulletCnt
;		lda firePressed
;		bne checkFire2
;		sta bulletFlag
;		jsr FireBullets
;checkFire2	rts
;		
;checkFire3	lda firePressed
;		beq checkFire4
;		inc bulletFlag
;		jsr FireBullets
;		rts
;		
;checkFire4	lda bulletCnt
;		bmi checkFire2
;		dec bulletCnt
;		rts
;
;checkFire1	and #$7F
;		sta bulletFlag
;		rts
	
;-------------------------------------------------------------------
; FireBullets
;-------------------------------------------------------------------
;FireBullets
;		lda bulletFlag
;		ora #$80
;		sta bulletFlag
;		;ldx newSpriteValue
;		;lda levelColorScheme + $01,X
;		;beq FireBulletsEx
;
;		lda mantaYpos					;a33
;		sec
;		sbc #19						;subtract offset so starts at 0
;		sta bulletYPos					;zp0F
;		ldx #$00
;		jsr GetFreeSlotForBullets
;		bcs FireBulletsEx
;		stx bulletSlotX
;		jsr UpdateBulletArrays
;
;		;ldx newSpriteValue
;		;lda bulletColorScheme,X
;		;beq FireBulletsEx
;
;		lda mantaYpos
;		sec
;		sbc #19
;		adc #15
;		sta bulletYPos
;		ldx bulletSlotX
;		jsr GetFreeSlotForBullets
;		bcs FireBulletsEx
;		jsr UpdateBulletArrays
;FireBulletsEx	rts
;
;;-------------------------------------------------------------------
;; GetFreeSlotForBullets
;;-------------------------------------------------------------------
;GetFreeSlotForBullets
;		lda bulletSlot,X
;		beq GetFreeSlotForBulletsEx
;		inx
;		cpx #$06
;		bcc GetFreeSlotForBullets
;		rts
;
;GetFreeSlotForBulletsEx	
;		clc
;		rts
;
;;-------------------------------------------------------------------
;; UpdateBulletArrays
;;-------------------------------------------------------------------
;UpdateBulletArrays
;		
;		lda dreadXPos
;		sta ptr
;		lda bulletYpos
;		lsr
;		lsr
;		and #$fe
;		clc
;		adc dreadXPos+1
;		sta ptr+1		
;	
;		lda #16
;		ldy spriteShape
;		cpy #$19
;		beq UpdateBulletArrays1
;		cpy #$01
;		bne UpdateBulletArraysEx
;		lda #19
;UpdateBulletArrays1
;		adc ptr
;		sta ptr
;		sta bulletPosLo,x
;		lda ptr+1
;		adc #0
;		sta ptr+1
;		sta bulletPosHi,x
;
;		lda bulletYPos
;		and #$07
;		cmp #$07
;		bne UpdateBulletArrays2
;		lda #$06
;UpdateBulletArrays2	
;		sta bulletCharY,x
;		
;		lda #2
;		ldy hspeed
;		bmi UpdateBulletArrays3
;		lda #$fe
;UpdateBulletArrays3		
;		sta bulletSlot,X
;
;		ldy #0
;		lda (ptr),y
;		sta bulletOldChar,x
;
;UpdateBulletArraysEx		
;		rts


;------------------------------------------------------------
;
;------------------------------------------------------------
;moveBullets
;		ldx #5
;		ldy #0
;		sty moveBullets3+1
;moveBullets2	lda bulletSlot,x
;		beq moveBullets1
;		bpl moveBullets4
;		lda #$ff
;		sta moveBullets3+1
;
;moveBullets4	lda bulletPosLo,x
;		sta ptr
;		lda bulletPosHi,x
;		sta ptr+1
;		lda bulletOldChar,x
;		sta (ptr),y
;
;		clc
;		lda bulletSlot,x
;		adc ptr
;		sta ptr
;		sta bulletPosLo,x
;		lda ptr+1
;moveBullets3	adc #0
;		sta ptr+1
;		sta bulletPosHi,x
;		
;		ror
;		lda ptr
;		ror
;		cmp leftbound
;		bcc moveBullets5
;		cmp rightbound
;		bcs moveBullets5
;
;		lda (ptr),y
;		bpl moveBullets6
;		cmp #$90
;		bcc moveBullets5
;		cmp #$A0
;		bcs moveBullets6
;		jsr checkHit
;		jmp moveBullets5
;		
;moveBullets6	sta bulletOldChar,x
;		
;		sty charSetPtr+1
;		asl
;		rol charSetPtr+1
;		asl
;		rol charSetPtr+1
;		asl
;		rol charSetPtr+1
;		clc
;		adc #<surfaceCharset
;		sta charSetPtr
;		lda charSetPtr+1
;		adc #>surfaceCharset
;		sta charSetPtr+1
;		tay
;		bpl moveBullets8
;		ldy currentLevel
;		adc charsetArray,y
;		sta charSetPtr+1
;		
;moveBullets8	jsr uploadChar
;		txa
;		sta (ptr),y
;
;moveBullets1	dex
;		bpl moveBullets2
;		rts
;		
;moveBullets5	lda #0
;		sta bulletSlot,x
;		beq moveBullets1

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
uploadChar2	lda (ptr),y
uploadChar3	sta EGO_REG_DATA
		iny
		cpy #8
		bcc uploadChar1
		ldy #0
		rts
		
;------------------------------------------------------------
;
;------------------------------------------------------------
;checkHit	sec
;		sbc #$90
;		tay
;		lda bulletPosLo,x
;		sbc hitPtrLo,y
;		sta ptr
;		lda bulletPosHi,x
;		sbc hitPtrHi,y
;		sta ptr+1
;
;		lda hitYlen,y
;		sta cnt
;		sta temp
;		
;		lda hitScore,Y
;		tay
;		jsr addScore
;		
;checkHit3	ldy temp
;checkHit1	lda (ptr),y
;		cmp #$20
;		bcc killBullet
;		cmp #$f0
;		bcs checkHit2
;		sec
;		sbc #$20
;		sta (ptr),y	
;checkHit2	dey
;		bpl checkHit1
;		dec cnt
;		bmi checkHitEx
;		inc ptr+1
;		inc ptr+1
;		jmp checkHit3
;
;checkHitEx	ldy #$00
;		rts
;
;killBullet	STX tempX
;		TAX
;		LDA #$00
;		STA bulletSlot,X
;		LDX tempX
;		JMP checkHit2
		
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
		clc
		lda currentPlayerLivesLeft
		adc #$01
		bcs addScore2
		sta currentPlayerLivesLeft
		cld
		jsr UpdateLivesLeft
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
;explosion	lda dead
;		bmi explosion1
;
;		ldx #1
;		stx spriteModus+1
;		dex
;		stx mantajfy
;		stx spriteEna+1
;		stx turncnt
;		dex
;		stx dead
;		
;		ldx #7
;explosion3	jsr random3bit
;		adc mantaXPos
;		sta spriteXpos,x
;		jsr random4bit
;		adc mantaYpos
;		sta spriteYpos,x
;		lda #explosion_major46
;		sta spriteShape,x
;		lda #0
;		sta spriteEna,x
;		dex
;		bpl explosion3
;		rts
;
;explosion1	dec mantajfy
;		bpl explosionEx
;		lda #1
;		sta mantajfy
;		
;		ldx turncnt
;		cpx #8
;		bcs explosion9
;		inc spriteEna,x
;explosion9	cpx #19
;		bcc explosion5
;	
;		pla
;		pla
;		jmp restart
;		
;		
;explosion5	ldx #7
;explosion4	lda spriteEna,x
;		beq explosion6
;		lda spriteShape,x
;		cmp #explosion_major46+10
;		bcc explosion7
;		lda #0
;		sta spriteEna,x
;		beq explosion6
;explosion7	inc spriteShape,x
;explosion6	dex
;		bpl explosion4
;
;		inc turncnt		
;explosionEx	rts

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
;collision	lda nocollision
;		bne collisionEx
;		
;		jsr getMantaScreen
;
;		ldx #3
;collision2	ldy #18
;collision1	lda (ptr),y
;		and #$F0
;		cmp #$80
;		bne collision4
;		inc dead
;collision4	iny
;		cpy #21
;		bne collision1
;
;		inc ptr+1
;		inc ptr+1
;collision3	dex
;		bne collision2
;
;		lda dead
;		beq collisionEx
;
;;		lda #$3f
;;		sta colbk
;		
;collisionEx	rts
;
;
;getMantaScreen
;		lda dreadXPos
;		sta ptr
;		sec
;		lda mantaYpos
;		sbc #20
;		lsr
;		lsr
;		and #$fe
;		clc
;		adc dreadXPos+1
;		sta ptr+1
;		rts
;------------------------------------------------------------
; scrollSurface
;------------------------------------------------------------
;scrollSurface	lda hspeed
;		asl
;		sta temp
;		bmi incxpos					;scroll left
;		
;		clc
;		lda hscrol
;		adc temp
;		cmp #8
;		bcs decxpos2
;		sta hscrol
;		rts	
;		
;decxpos2	and #6
;		sta hscrol
;		lda turnactive
;		bne decxpos
;		
;		lda dreadXPos					;check if zero
;		cmp #<(dreadnaught+4)
;		lda dreadXpos+1
;		sbc #>(dreadnaught+4)
;		bcs decxpos
;
;		dec turnactive
;		lda #15
;		sta turncnt
;
;decxpos		lda dreadXPos
;		bne decxpos1
;		dec dreadXPos+1
;decxpos1	dec dreadXPos
;		jsr shaftRight
;		jmp incxpos2
;
;;
;;
;;
;incxpos		clc
;		lda hscrol
;		adc temp
;		bmi incxpos3
;		sta hscrol
;		rts
;		
;incxpos3	and #6
;		sta hscrol
;		lda turnactive
;		bne incxpos1
;		
;		lda dreadXPos
;		cmp #<(dreadnaught+$1ac)
;		lda dreadXPos+1
;		sbc #>(dreadnaught+$1ac)
;		bcc incxpos1
;		
;		inc turnactive
;		lda #15
;		sta turncnt
;		
;incxpos1	inc dreadXPos
;		bne incxpos4
;		inc dreadXPos+1
;incxpos4	jsr shaftLeft
;
;incxpos2	lda dreadXPos+1					;compute playfield bounds for bullets
;		ror
;		lda dreadXpos
;		ror
;		sta leftbound
;		clc
;		adc #20
;		sta rightbound		
;		rts
		

;------------------------------------------------------------
;
;------------------------------------------------------------
;updateManta	lda turnactive
;		beq updateManta1
;
;		dec mantajfy
;		bmi updateManta2
;		rts
;		
;updateManta2	lda #1
;		sta mantajfy
;
;		ldx turncnt
;		lda turnactive
;		bpl flipMantaLeft
;
;flipMantaRight	jsr shapeRightSeq	
;		jmp flipManta
;
;flipMantaLeft	jsr shapeLeftSeq
;		
;flipManta	lda #1
;		cpx #7
;		bcs flipmanta3
;		dec xshadow
;		jmp flipmanta1
;flipmanta3	lda #0
;		cpx #9
;		bcc flipmanta1
;		lda #-1
;		inc xshadow
;		
;		clc
;flipmanta1	ldy turnactive
;		bpl flipmanta2
;		eor #$ff
;		adc #1
;flipmanta2	sta hspeed
;		dex
;		stx turncnt
;		bpl updateManta1		
;		stx mantajfy
;		inx
;		stx turnactive
;		asl hspeed
;		
;updateManta1	lda #mantax
;		sta spriteXpos
;		lda mantaYpos
;		sta spriteYpos
;
;		clc						;x-pos lo
;		lda #mantax
;		adc xshadow
;		sta spriteXpos+1
;		lda mantaYpos					;y-pos lo
;		adc xshadow
;		sta spriteYpos+1
;		rts
;		
;
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;shapeRightSeq	
;		lda flipRightSeq,x
;		sta spriteShape
;		sta spriteShape+1		
;		rts
;		
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;shapeLeftSeq	
;		lda flipLeftSeq,x
;		sta spriteShape
;		sta spriteShape+1		
;		rts
		
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
;checkstick	lda trig0
;		eor #$01
;		sta firePressed
;		
;		lda porta
;		lsr
;		bcc stickup
;		lsr
;		bcc stickdown
;
;checkstickleft	lda turnactive					;if ship is turning
;		bne checkstickex				;no stick updates
;
;		dec stickjiffy
;		bpl checkstickex
;		lda #5
;		sta stickjiffy
;
;;		lda stick0
;		lda porta
;		lsr
;		lsr
;		lsr
;		bcc stickleft
;		lsr
;		bcc stickright
;checkstickex	rts
;		
;;------------------------------------------------------------
;stickleft	lda hspeed
;		bmi stickleft1
;		cmp #4
;		bcs stickleft2
;stickleft1	inc hspeed
;		bne stickleft2
;		inc turnactive
;stickleft3	lda #15
;		sta turncnt
;stickleft2	rts
;
;;------------------------------------------------------------
;stickright	lda hspeed
;		bpl stickright1
;		cmp #$fd
;		bcc stickleft2
;stickright1	dec hspeed
;		bne stickleft2
;		dec turnactive
;		bmi stickleft3
;
;;------------------------------------------------------------
;stickdown	lda mantaYpos
;		adc #3
;		cmp #137
;		bcc stickdown1
;		lda #137
;stickdown1	sta mantaYpos
;stickdown2	bne checkstickleft
;
;;------------------------------------------------------------
;stickup		lda mantaYpos
;		sbc #2						;=3 (carry clear)
;		cmp #21
;		bcs stickup1
;		lda #21
;stickup1	jmp stickdown1
;
;------------------------------------------------------------
; initialize a level
;------------------------------------------------------------
initLevel	ldx currentLevel	
		lda levelColorBak,x
		lda #0
		sta colorbk
		lda levelColorPf0,x
		sta colorpf0
		lda #$04
		sta backgroundColor1
		lda #$0f
		sta backgroundColor2

;		jsr genStars	
;		jsr uploadSurfaceCharset
;		jsr drawdread

		ldx #5*8-1					;initialize all sprite data
		lda #0
initLevel1	sta spriteEna,x
		dex
		bpl initLevel1

;		stx hspeed					;X=$ff
		inx
;		stx hscrol					;X=$00
;		stx turnactive
;		stx dead
		stx playerScore
		stx playerScore+1
		stx playerScore+2
		stx playerScore+3	
		stx minePos0
		stx minePos1
		stx indexToCurrentLevelTextureData
		
		inx
;		stx spriteEna					;X=$01
;		stx spriteEna+1
;		stx spriteShape
;		stx spriteShape+1
;		stx spriteModus
		stx currentPlayer
		inx
;		stx spriteModus+1				;X=$02
		
;		lda #mantax
;		sta spriteXpos
;		sta mantaXpos
;		lda #mantax+8
;		sta spriteXpos+1
;		lda #mantay
;		sta spriteYpos
;		sta mantaYpos
;		lda #mantay+8
;		sta spriteYpos+1
;
;		lda #<(dreadnaught+0)
;		sta dreadXPos
;		lda #>(dreadnaught+0)
;		sta dreadXPos+1	
;
		lda #8
;		sta xshadow
		sta currentPlayerLivesLeft
;		
		lda #10
		sta colorp2
		sta colorp3
		
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
dli2		jmp dliproc0
		

;
; turn off yellow(gold) player coloring
; set dreadnaught colors
;
dli1		lda backgroundColor1
		sta wsync
		sta colpf1
		lda colorbk
		sta colbk
		lda colorpf0
		sta colpf0
		lda backgroundColor2
		sta colpf2
		jmp dliproc0

dli0		lda #$02
		sta dlino
		lda #$0f
		sta wsync
		sta colpf1
		lda #$00
		sta colpf2
		sta colbk
		beq dliproc1


;------------------------------------------------------------
; main game initialization
;------------------------------------------------------------
initGame
		jsr copyRomRam					;OS is not required, but the RAM underneath
;		jsr GenerateRandomDataFromRNG
		jsr initdlist					;initialise Atari Hardware
;		jsr LoadSurfaceStructureData			;generate tile pointers
		jsr setScreenLines				;upload addresses of gfx lines

		ldx #0
initPdata	lda #$ff
		sta player0data,x
		sta player1data,x
		lda #$00
		sta player2data,x
		sta player3data,x
		inx
		bne initPdata

filltitle:	lda #$30					;clear title screen and debug lines
		sta titlechars,x
		lda #0
		sta debugScreen,x
		inx
		cpx #160
		bne filltitle

		rts
		
; =================================================================
; ATARI 800XL: Ultra-optimierte ROM-to-RAM Routine (SMC-Methode)
; =================================================================
copyRomRam   	sei          
		ldy #$00     
		sty nmien    					;disable IRQ & NMI
		
		; --- startadresse für smc setzen ---
		lda #$c0      
		sta sm_rd+2					; high-byte in die lade-anweisung schreiben
		sta sm_wr+2					; high-byte in die schreib-anweisung schreiben
	
page_lp 	
		; --- schritt 1: rom einblenden & lesen ---
		lda #$ff
		sta portb    
	
sm_rd   	lda $c000,y					; das high-byte ($c0) wird dynamisch modifiziert
		sta buffer,y 
		iny
		bne sm_rd  
	
		; --- schritt 2: ram einblenden & schreiben ---
		lda #$fe
		sta portb    

sm_wr1		lda buffer,y 
sm_wr		sta $c000,y 					; das high-byte ($c0) wird dynamisch modifiziert
		iny
		bne sm_wr1 
	
		; --- schritt 3: smc-adressen hochzählen ---
		inc sm_rd+2					; modifiziert direkt das high-byte im befehl oben
		inc sm_wr+2					; modifiziert direkt das high-byte im befehl oben
	
		; --- i/o-bereich überspringen ---
		lda sm_rd+2
		cmp #$d0     
		bne chk_end
	
		lda #$d8     
		sta sm_rd+2   
		sta sm_wr+2   
	
chk_end 	cmp #$00					; fertig bei überlauf von $ff nach $00
		bne page_lp  

;		cli						;keep IRQ turned off
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
initdlist	lda #>(player0data-4)				;player data at $cc00
		sta pmbase
		
		ldx #$ff
		stx sizep0
		stx sizep1
		
		inx						; x=0
		stx dmactl
copydlist	lda dl,x
		sta mathpack,x
		lda dl+$100,x
		sta mathpack+$100,x
		dex
		bne copydlist

		stx colpm0
		stx colpm1

		ldx #$02
		stx dlino
		stx prior
		stx gractl
		
		lda #<dliproc 
		sta nmivkt
		lda #>dliproc 
		sta nmivkt+1

		lda #<mathpack
		sta dlistl
		lda #>mathpack
		sta dlistl+1
		
		lda #20						;first column equals player pos
		sta hposp0
		lda #204
		sta hposp1
	
		lda #140
		jsr waitvcnt
		
		lda #32+16+8+2					;DLIST DMA + single + Player + normal playfield
		sta dmactl

		lda #139
		jsr waitvcnt

		lda #128					;allow only DLI
		sta nmien
		rts
;------------------------------------------------------------
;
;------------------------------------------------------------
waitvcnt	cmp vcount
		bne waitvcnt
		rts

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

;-------------------------------------------------------------------
; UpdateLivesLeft
;-------------------------------------------------------------------
UpdateLivesLeft
		ldx #$30
		lda currentPlayer
		cmp #$01
		bne b19DA
		lda currentPlayerLivesLeft
		lsr
		lsr
		lsr
		lsr
		beq b19C8
		tax
b19C8   	stx livesLeftPlayerOneText
		lda currentPlayerLivesLeft
		and #$0F
		sta livesLeftPlayerOneText + $01
		ldx #<oneUpText
		ldy #>oneUpText
		jsr WriteToScreen
		rts
	
b19DA   	lda currentPlayerLivesLeft
		lsr
		lsr
		lsr
		lsr
		beq b19E3
		tax
b19E3   	stx livesLeftPlayerTwoText
		lda currentPlayerLivesLeft
		and #$0F
		sta livesLeftPlayerTwoText + $01
		ldx #<twoUpText
		ldy #>twoUpText
		jsr WriteToScreen
		rts
	
;-------------------------------------------------------------------
; WriteToScreen
;-------------------------------------------------------------------
WriteToScreen
		stx dataLoPtr
		sty dataHiPtr
								;Get the Y Pos from the first byte
		ldy #$00
		lda (dataLoPtr),Y
		sta currentCharYPos
bB2A0   =*+$01
		cmp #$18
		bcs WriteToScreenEx				; Return early if the Y Pos is invalid				
		iny						; Get the X pos from the second byte
		lda (dataLoPtr),Y
		sta currentCharXPos
								
		iny						; Get the character to write. Only use the lowest 7 bits for
		lda (dataLoPtr),Y					; some reason.
		and #$7F
								; Skip to the entry point of the loop for reading in the
								; characters to write.
		jmp WriteToScreen1

WriteCharsLoop
		ldy temp
		lda (dataLoPtr),Y
WriteToScreen1	iny
		sty temp					; Stop writing if the leftmost bit is set on temp. This mean
								; the most bytes we'll write is 128.
		bmi WriteToScreenEx				; Stop writing if the leftmost bit is set on the char to write.
		cmp #$00
		bmi WriteToScreenEx				; the character to screen.
		sta charToWrite
		jsr WriteCharacterToScreen
		jmp WriteCharsLoop

WriteToScreenEx	RTS

;-------------------------------------------------------------------
; WriteCharacterToScreen
;-------------------------------------------------------------------
WriteCharacterToScreen
		; Move the ptr to the x/y position.
		ldy currentCharYPos
		lda titleLineHi,Y
		sta tempHiPtrCopyTo
		lda titleLineLo,Y
		clc
		adc currentCharXPos
		sta tempLoPtrCopyTo
		lda #$00
		adc tempHiPtrCopyTo
		sta tempHiPtrCopyTo
		
		; Write the top half of the character
		lda charToWrite
		ldy #$00
		sta (tempLoPtrCopyTo),Y
		
		; Write the bottom half of the character
		ora #$80
		ldy #$28
		sta (tempLoPtrCopyTo),Y
		
		; Check if the byte encodes a second half.
		inc currentCharXPos
		and #$7F
		cmp #$3A
		bcc WriteCharacterToScreenEx
		
		cmp #$5A
		bcs WriteCharacterToScreenEx
		
		; The byte encodes a second half. Write the top half of it.
		ldy #$01
		adc #$20
		sta (tempLoPtrCopyTo),Y
		
		; Write the bottom half of it.
		ora #$80
		ldy #$29
		sta (tempLoPtrCopyTo),Y
		
		inc currentCharXPos
WriteCharacterToScreenEx		
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
char2title	lda #EGO_CMD_CHAR_TO_VIDEO
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
		sty EGO_REG_DATA				;no col38
		
		jmp waitstatus
		
;------------------------------------------------------------
;
;------------------------------------------------------------
char2gfx	lda #EGO_CMD_CHAR_TO_VIDEO
		sta EGO_REG_CMD
		
		clc
		;lda dreadXPos
		lda scrollPositionLoPtr
		sta EGO_REG_DATA
		;lda dreadXPos+1
		lda scrollPositionHiPtr
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
		;lda hscrol
		lda pixelsToScroll
		and #$7e
		sta EGO_REG_DATA				;scroll
		lda #0
		sta EGO_REG_DATA				;col38 = false
		;rts
		
waitstatus	lda EGO_REG_STATUS
		bmi waitstatus
		rts

;------------------------------------------------------------
; draw dreadnaught
;------------------------------------------------------------
;drawdread	lda #40
;		sta dreadcolumn
;		lda #0
;		sta dreadcolumn+1
;
;		lda #<dreadnaught
;		sta screenPtr		
;		lda #>dreadnaught
;		sta screenPtr+1
;
;		lda #32
;		ldx #2*17
;		ldy #0
;drawdread1	sta (screenPtr),y
;		iny
;		bne drawdread1
;		inc screenPtr+1
;		dex
;		bne drawdread1
;		
;		ldx currentLevel
;		lda textureDataForLevelLoPtrArray,x
;		sta dreadPtr
;		lda textureDataForLevelHiPtrArray,x
;		sta dreadPtr+1
;		
;drawdread2	ldy #0
;		lda (dreadPtr),y				;load tile number
;		beq drawdetail
;		jsr incDreadPtr
;		
;		tax
;		lda surfaceStructureDataLoPtrArray,x
;		sta tileDataPtr
;		lda surfaceStructureDataHiPtrArray,x
;		sta tileDataPtr+1
;		jsr drawTile
;		beq drawdread2					;process next tile	
;		
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;drawdetail	jsr incDreadPtr
;		lda (dreadPtr),y
;		beq drawdetail5
;		tax
;
;		jsr incDreadPtr
;		clc
;		lda (dreadPtr),y
;		adc #<(dreadnaught - $8418)
;		sta screenPtr
;		txa
;		adc #>(dreadnaught - $8218)
;		sta screenPtr+1
;		
;		jsr incDreadPtr
;		lda (dreadPtr),y				;load tile
;		tax
;		lda surfaceStructureDataLoPtrArray,x
;		sta tileDataPtr
;		lda surfaceStructureDataHiPtrArray,x
;		sta tileDataPtr+1
;		
;		lda (tileDataPtr),y				;get num of columns
;		sta tileColumnCnt
;		jsr incTileDataPtr
;
;drawdetail4	lda screenPtr+1
;		pha
;		lda screenPtr
;		pha
;
;		lda (tileDataPtr),y				;get num of rows
;		sta tileRowCnt
;		jsr incTileDataPtr
;
;drawdetail1	lda (tileDataPtr),y				;row data
;		cmp #32
;		beq drawdetail2
;		sta (screenPtr),y
;drawdetail2	jsr sub513
;		iny
;		cpy tileRowCnt
;		bne drawdetail1
;
;		tya
;		clc
;		adc tileDataPtr
;		sta tileDataPtr
;		bcc drawdetail3
;		inc tileDataPtr+1
;
;drawdetail3	clc
;		pla
;		adc #1
;		sta screenPtr
;		pla
;		adc #0
;		sta screenPtr+1
;
;		ldy #0	
;		dec tileColumnCnt
;		bne drawdetail4		
;		beq drawdetail		
;drawdetail5	rts
;		
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;incDreadPtr	inc dreadPtr
;		bne incDreadPtr1
;		inc dreadPtr+1
;incDreadPtr1	rts	
;
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;incTileDataPtr	inc tileDataPtr
;		bne incTileDataPtr1
;		inc tileDataPtr+1
;incTileDataPtr1	rts
;		
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;drawTile	lda (tileDataPtr),y				;get num of columns
;		sta tileColumnCnt
;		;jsr puthex
;		jsr incTileDataPtr
;
;		
;drawTile1	lda (tileDataPtr),y				;get num of rows
;		jsr drawcolumn
;		
;		inc dreadcolumn
;		bne drawTile2
;		inc dreadcolumn+1
;		
;drawTile2	;lda dreadcolumn
;		;cmp #<512
;		;lda dreadcolumn+1
;		;sbc #>512
;		;bcs drawTile3
;		
;		dec tileColumnCnt
;		bne drawTile1
;drawTile3	rts
;
;
;
;;------------------------------------------------------------
;; generate drawcolumn
;;------------------------------------------------------------
;drawcolumn	sta tileRowCnt					;row cnt
;		;jsr puthex
;		
;		inc tileDataPtr
;		bne drawcolumn1
;		inc tileDataPtr+1
;
;drawcolumn1	clc
;		lda firstlineLo
;		adc dreadcolumn
;		sta screenPtr
;		lda firstlineHi
;		adc dreadcolumn+1
;		sta screenPtr+1
;		
;drawcolumn2	lda (tileDataPtr),y				;row data
;		sta (screenPtr),y
;		jsr sub513
;		iny
;		cpy tileRowCnt
;		bne drawcolumn2
;
;		tya
;		clc
;		adc tileDataPtr
;		sta tileDataPtr
;		bcc drawcolumn3
;		inc tileDataPtr+1
;		
;drawcolumn3:	cpy #17
;		bcs drawcolumn4
;		lda #32
;		sta (screenPtr),y
;		jsr sub513	
;		iny
;		bne drawcolumn3
;		
;drawcolumn4	ldy #0
;		rts
;	
;;------------------------------------------------------------
;;
;;------------------------------------------------------------
;sub513		sec
;		lda screenPtr
;		sbc #<513
;		sta screenPtr
;		lda screenPtr+1
;		sbc #>513
;		sta screenPtr+1
;		rts

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
genStars1	ldx dataIndex
		inc dataIndex
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
genstars8	ldx dataIndex					;compute random line
		inc dataIndex
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

		ldx dataIndex					;compute random xpos
		inc dataIndex
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
		
		ldx dataIndex					;compute thickness
		inc dataIndex
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
		
;------------------------------------------------------------
;
;------------------------------------------------------------
getstart	lda #1
		bit consol
		bne getstart1
		
getstart2	bit consol
		beq getstart2
		lda currentLevel
		cmp #14
		bcs getstart1
		inc currentLevel
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
		lda currentLevel
		beq getselect1
		dec currentLevel
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
showcolors	ldx #0
colors		lda vcount
		cmp #2
		bne colors

colors1		stx wsync 
		nop
		stx colbk
		stx colpf2
		inx
		bne colors1
		
		stx colbk
		stx colpf2
		beq colors
		
;------------------------------------------------------------
;
;------------------------------------------------------------
prtspace	lda #0
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
dlino		.byte 0
hscrol		.byte 0
currentLevel	.byte 1
dbgpos		.byte 0
turnactive	.byte 0
turncnt		.byte 0
pause		.byte 0
xshadow		.byte 0
dead		.byte 0
nocollision	.byte 1
hspeed		.byte 0
p2Ypos		.byte 0
colorp2		.byte 0
colorp3		.byte 0
colorpf0	.byte 0
colorpf1	.byte 0
colorpf2	.byte 0
colorbk		.byte 0
minePos0	.byte 0
minePos1	.byte 0
		
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

msbForSpriteArray
		.BYTE $01,$02,$04,$08,$10,$20,$40,$80
enemyXPosCurrentVelocityArray
:8		.byte 0
enemyYPosCurrentVelocityArray
:8		.byte 0
enemyXPosCurrentVelocityMSBOffsetArray
:8		.byte 0
enemyXPosVelocityLimitArray
:8		.byte 0
enemyYPosVelocityLimitArray
:8		.byte 0
enemyMovementStrategies
:8		.byte 0
enemyFiringStrategy
:8		.byte 0
indexToEnemyUpdatePtrArray
:8		.byte 0
durationOfMovementStrategyForEnemy
:8		.byte 0
playerBulletRamLoPtrArray
:16		.byte 0
playerBulletRamHiPtrArray
:16		.byte 0
charBehindPlayerBulletArray
:16		.byte 0
playerBulletSlotArray
:16		.byte 0
bulletOffsetsInCharsetDef
:16		.byte 0
offsetsForPlayerBullet
		.byte $00,$08,$10,$18,$20,$28,$30,$38
		.byte $40,$48,$50,$58,$60,$68,$70,$78

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

;firstline	.word dreadnaught+16*512

lineAdrLo	.byte <(gfxmem+4*40+00*320), <(gfxmem+4*40+01*320), <(gfxmem+4*40+02*320), <(gfxmem+4*40+03*320)
		.byte <(gfxmem+4*40+04*320), <(gfxmem+4*40+05*320), <(gfxmem+4*40+06*320), <(gfxmem+4*40+07*320)
		.byte <(gfxmem+4*40+08*320), <(gfxmem+4*40+09*320), <(gfxmem+4*40+10*320), <(gfxmem+4*40+11*320)
		.byte <(gfxmem+4*40+12*320), <(gfxmem+4*40+13*320), <(gfxmem+4*40+14*320), <(gfxmem+4*40+15*320)
		.byte <(gfxmem+4*40+16*320)
lineAdrHi	.byte >(gfxmem+4*40+00*320), >(gfxmem+4*40+01*320), >(gfxmem+4*40+02*320), >(gfxmem+4*40+03*320)
		.byte >(gfxmem+4*40+04*320), >(gfxmem+4*40+05*320), >(gfxmem+4*40+06*320), >(gfxmem+4*40+07*320)
		.byte >(gfxmem+4*40+08*320), >(gfxmem+4*40+09*320), >(gfxmem+4*40+10*320), >(gfxmem+4*40+11*320)
		.byte >(gfxmem+4*40+12*320), >(gfxmem+4*40+13*320), >(gfxmem+4*40+14*320), >(gfxmem+4*40+15*320)
firstlineLo	.byte >(gfxmem+4*40+16*320)
		
titleLineLo	.byte <(titlechars+0*40),<(titlechars+1*40),<(titlechars+2*40),<(titlechars+3*40)
		.byte <(dreadnaught+00*512),<(dreadnaught+01*512),<(dreadnaught+02*512),<(dreadnaught+03*512)
		.byte <(dreadnaught+04*512),<(dreadnaught+05*512),<(dreadnaught+06*512),<(dreadnaught+07*512)
		.byte <(dreadnaught+08*512),<(dreadnaught+09*512),<(dreadnaught+10*512),<(dreadnaught+11*512)
		.byte <(dreadnaught+12*512),<(dreadnaught+13*512),<(dreadnaught+14*512),<(dreadnaught+15*512)
firstlineHi	.byte <(dreadnaught+16*512)
		
titleLineHi	.byte >(titlechars+0*40),>(titlechars+1*40),>(titlechars+2*40),>(titlechars+3*40)
		.byte >(dreadnaught+00*512),>(dreadnaught+01*512),>(dreadnaught+02*512),>(dreadnaught+03*512)
		.byte >(dreadnaught+04*512),>(dreadnaught+05*512),>(dreadnaught+06*512),>(dreadnaught+07*512)
		.byte >(dreadnaught+08*512),>(dreadnaught+09*512),>(dreadnaught+10*512),>(dreadnaught+11*512)
		.byte >(dreadnaught+12*512),>(dreadnaught+13*512),>(dreadnaught+14*512),>(dreadnaught+15*512)
		.byte >(dreadnaught+16*512)
;lineOffsetLo
;		.byte <(-04*40), <(-03*40), <(-02*40), <(-01*40), <(00*40), <(01*40), <(02*40), <(03*40)
;lineOffsetHi
;		.byte >(-04*40), >(-03*40), >(-02*40), >(-01*40), >(00*40), >(01*40), >(02*40), >(03*40)
	


;		;icl "EgoUridium-Manta.asm"	
;		;icl "explosion_sprites.asm"
		;
titleCharset	;ins "main-charset.bin"
surfaceCharset	;ins "surface-common-charset.bin"
		;icl "surface-charset.asm"
		
		icl "EgoUridium-GameData.asm"
		icl "EgoUridium-LevelData.asm"

dc		= $0e

dl		.byte $70,$70
		.byte $40+$0f
		.word titlegfx
:22		.byte $0f
		.byte $0f+$80
:7		.byte $0f
		.byte $0f+$80

		.byte $40+dc
		.word gfxtop
:15		.byte dc

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
		.byte $41
		.word mathpack

gfxtop		= $da00
gfxbottom	= gfxtop + $280

;		org $349F
;f349F   .BYTE $4E,$1B,$12,$0D,$12,$1E,$42,$30
;        .BYTE $0B,$22,$30,$3A,$17,$0D,$1B,$0E
;        .BYTE $54,$30,$3B,$1B,$0A,$22,$0B,$1B
;        .BYTE $18,$18,$14,$28,$30,$41,$12,$10
;        .BYTE $11,$30,$2E
;
;;hiScoreForScrollingBanner
;        .BYTE " 12000 AEB", $FF, $FF, $FF, $FF
;;player1Symbol
;        .BYTE $00,$0F
;        .BYTE "  ", $55, $55, " ", $56, "  ", $FF
;;player2Symbol
;        .BYTE $00,$0F
;        .BYTE " ", $55, $55, " ", $56, $56, " ", $FF
;;playerAndJoystickSymbol
;        .BYTE $00,$0F
;        .BYTE "   ", $55, " ", $56, "   ", $FF
;;arrowKeysSymbol
;        .BYTE $02,$0A,$57,$FF
;;globeSymbol
;        .BYTE $02,$0A,$58,$FF
;;uridiumDecal
;        .BYTE $02,$0A
;        .BYTE $30,$30,$30,$30,$30,$31,$32,$33
;        .BYTE $34,$35,$36,$37,$38,$39,$7D,$30
;        .BYTE $30,$30,$30,$30,$FF
;;hiScoreLabel
;        .BYTE $02,$0A
;        .BYTE "     Hi-score      ", $FF
;
;;inGameHiScoreDisplay =*+$04
;;inGameBanner ; $3526
;        .BYTE $02,$0A
;        .BYTE "     12000 AEB   ", $FF, "2c    "
;        .BYTE " ", $55, $55, "     ", $56, $56, $FF, "2c     ", $55, " "
;        .BYTE "        ", $56, $FF, "2c     ", $55, $55, " "
;        .BYTE "      ", $56, $FF
;;scrollingTitleScreenDataLoPtrArray   .BYTE $3A,$4B,$5E
;;scrollingTitleScreenDataHiPtrArray   .BYTE $35,$35,$35


		.endp

		run main