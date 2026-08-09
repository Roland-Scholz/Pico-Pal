c64colors
	;	BLACK,	WHITE,	RED,	CYAN,	PURPLE,	GREEN,	BLUE,	YELLOW	
	.byte 	$00, 	$0f, 	$34, 	$c4, 	$54, 	$b4,	$74,	$ec
	;	ORANGE,	BROWN,	LTRED,	GRAY1,	GRAY2,	LTGREEN,LTBLUE,	GRAY3  
	.byte 	$18, 	$e2, 	$2a, 	$04, 	$06, 	$ba,	$7a,	$08


screenWriteJumpTableLoPtr
        .BYTE <MaybeChangeTitleDecal,<UpdateAndDisplaySomeSprites,<UpdatePlayerScore,<MaybeShowPauseScreen
        .BYTE <ReturnEarly,<MaybeLaunchMine,<UpdateCurrentColorValue,<MaybeShowPauseScreen
screenWriteJumpTableHiPtr
        .BYTE >MaybeChangeTitleDecal,>UpdateAndDisplaySomeSprites,>UpdatePlayerScore,>MaybeShowPauseScreen
        .BYTE >ReturnEarly,>MaybeLaunchMine,>UpdateCurrentColorValue,>MaybeShowPauseScreen

mainLoopJumpTableLoPtr
        .BYTE <MaybeChangeTitleDecal,<MaybeCreateNewEnemyFormation,<UpdatePlayerScore,<MaybeShowPauseScreen
        .BYTE <DoNothing,<MaybeLaunchMine,<UpdateCurrentColorValue,<MaybeShowPauseScreen
mainLoopJumpTableHiPtr
        .BYTE >MaybeChangeTitleDecal,>MaybeCreateNewEnemyFormation,>UpdatePlayerScore,>MaybeShowPauseScreen
        .BYTE >DoNothing,>MaybeLaunchMine,>UpdateCurrentColorValue,>MaybeShowPauseScreen
	
enemyHorizontalVelocityArray
        .BYTE $A0,$80,$80,$60,$A0,$A0,$C0,$B0
        .BYTE $A0,$40,$70,$60,$80,$90,$70,$80

enemyVerticalVelocityArray
        .BYTE $61,$61,$81,$71,$81,$91,$81,$91
        .BYTE $B1,$21,$61,$51,$41,$71,$61,$41

fireBulletOrMineArray   
	.BYTE $10,$10,$14,$18,$1C,$0C,$18,$1C
        .BYTE $0C,$0A,$18,$10,$0C,$14,$0E,$18

bulletSpriteArray
        .BYTE BULLET_NARROW,BULLET_5,BULLET_NARROW,BULLET_WIDE,BULLET_5,BULLET_NARROW,BULLET_VERYNARROW,BULLET_NARROW
        .BYTE EXPLOSION_1,BULLET_SINGLE,BULLET_WIDE,BULLET_WIDE,BULLET_VERYNARROW,BULLET_NARROW,BULLET_NARROW,BULLET_WIDE

scoresForHittingStructuresArray
        .byte $00,$0C,$0D,$10,$11,$0F,$0D,$0C
        .byte $00,$0B,$0D,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $00

indexToScoresToAddArray
        .BYTE $06,$05,$06,$07,$07,$05,$09,$08
        .BYTE $04,$04,$08,$06,$04,$06,$05,$07

enemeyBulletSpeedForLevel
        .BYTE $05,$04,$06,$07

bulletAnimationArrayOfSomeSort
        .BYTE $06,$04,$06,$06,$04,$05,$06,$06

enemyBulletSpriteTransformOffset
        .BYTE $05,$06,$06,$07,$00,$02,$05,$09
        .BYTE $09,$09,$02,$00,$14,$12,$0F,$0C
        .BYTE $0C,$0C,$12,$00

scoringStrategyForLevelLoPtrArray ;= $C100
        .BYTE <a0000,<level1EnemyFormationOrder,<level2EnemyFormationOrder,<level3EnemyFormationOrder
        .BYTE <level4EnemyFormationOrder,<level5EnemyFormationOrder,<level6EnemyFormationOrder,<level7EnemyFormationOrder
        .BYTE <level8EnemyFormationOrder,<level9EnemyFormationOrder,<level10EnemyFormationOrder,<level11EnemyFormationOrder
        .BYTE <level12EnemyFormationOrder,<level13EnemyFormationOrder,<level14EnemyFormationOrder,<level15EnemyFormationOrder
scoringStrategyForLevelHiPtrArray ;= $C110
        .BYTE >a0000,>level1EnemyFormationOrder,>level2EnemyFormationOrder,>level3EnemyFormationOrder
        .BYTE >level4EnemyFormationOrder,>level5EnemyFormationOrder,>level6EnemyFormationOrder,>level7EnemyFormationOrder
        .BYTE >level8EnemyFormationOrder,>level9EnemyFormationOrder,>level10EnemyFormationOrder,>level11EnemyFormationOrder
        .BYTE >level12EnemyFormationOrder,>level13EnemyFormationOrder,>level14EnemyFormationOrder,>level15EnemyFormationOrder
	
; Manta manoeuvres. These data structures are used to animate the movement
; of the player's ship when it changes direction, rolls, or flips.

a0000 = $0000
mantaRollRightFrom90Degrees
        .BYTE $04,MANTA_RIGHT_13,MANTA_RIGHT_14,MANTA_RIGHT_15,MANTA,$00,$FF
mantaRollLeftFromUpsideDown
        .BYTE $04,MANTA_RIGHT_5,MANTA_RIGHT_4,MANTA_RIGHT_3,MANTA_2,$00,$FF
mantaRollLeft1
        .BYTE $04,MANTA1,MANTA_2,MANTA_RIGHT_3,MANTA_RIGHT_4,$00,$FF
mantaRollLeft
        .BYTE $04,MANTA1,MANTA_2,MANTA_RIGHT_3,MANTA_RIGHT_4,$00,$FF

mantaFlipFromRightToLeft
        .BYTE $10,MANTA_LEFT_9,MANTA_LEFT_8,MANTA_LEFT_7,MANTA_LEFT_6,MANTA_LEFT_5,MANTA_LEFT_4
        .BYTE MANTA_LEFT_3,MANTA_LEFT_2,MANTA_LEFT_1,MANTA_FLIP_6,MANTA_FLIP_5,MANTA_FLIP_4,MANTA_FLIP_3
        .BYTE MANTA_FLIP_2,MANTA_FLIP_1,MANTA_FLIP_0,$28,$28
mantaRollFacingRight
        .BYTE $10,MANTA1,MANTA,MANTA_RIGHT_15,MANTA_RIGHT_14,MANTA_RIGHT_13,MANTA_RIGHT_12,MANTA_RIGHT_11
        .BYTE MANTA_RIGHT_10,MANTA_RIGHT_9,MANTA_RIGHT_8,MANTA_RIGHT_7,MANTA_RIGHT_6,MANTA_RIGHT_5,MANTA_RIGHT_4,MANTA_RIGHT_3
        .BYTE MANTA_2,$00,$FF

mantaRollLeft90DegreesFacingLeft
        .BYTE $04,MANTA_LEFT_5,MANTA_LEFT_6,MANTA_LEFT_7,MANTA_LEFT_8,$00,$01
mantaRollRight90DegreesFacingLeft
        .BYTE $04,MANTA_LEFT_13,MANTA_LEFT_12,MANTA_LEFT_11,MANTA_LEFT_10,$00,$01
mantaRollRightFrom180DegreesFacingLeft
        .BYTE $04,MANTA_LEFT_9,MANTA_LEFT_8,MANTA_LEFT_7,MANTA_LEFT_6,$00,$01
mantaRollLeftFrom180DegreesFacingLeft
        .BYTE $04,MANTA_LEFT_9,MANTA_LEFT_10,MANTA_LEFT_11,MANTA_LEFT_12,$00,$01
mantaRollAndFlipLeft
        .BYTE $10,MANTA1,MANTA,MANTA_RIGHT_15,MANTA_RIGHT_14
        .BYTE MANTA_RIGHT_13,MANTA_RIGHT_12,MANTA_RIGHT_11
        .BYTE MANTA_RIGHT_10,MANTA_RIGHT_9,MANTA_FLIP_7,MANTA_FLIP_8
        .BYTE MANTA_FLIP_9,MANTA_FLIP_10,MANTA_FLIP_11,MANTA_FLIP_12
        .BYTE MANTA_FLIP_13,$D8,$D8
manta360RollLeft
        .BYTE $10,MANTA_LEFT_9,MANTA_LEFT_8,MANTA_LEFT_7,MANTA_LEFT_6,MANTA_LEFT_5,MANTA_LEFT_4,MANTA_LEFT_3
        .BYTE MANTA_LEFT_2,MANTA_LEFT_1,MANTA_LEFT_0,MANTA_LEFT_15,MANTA_LEFT_14,MANTA_LEFT_13,MANTA_LEFT_12,MANTA_LEFT_11
        .BYTE MANTA_LEFT_10,$00,$01


mantaleftFacingAnimationLoPtrArray
        .BYTE <a0000,<a0000,<a0000,<a0000,<a0000,<mantaRollRightFrom180DegreesFacingLeft,<a0000,<a0000
        .BYTE <a0000,<mantaRollAndFlipLeft,<a0000,<a0000,<mantaRollLeft90DegreesFacingLeft,<manta360RollLeft,<mantaRollRight90DegreesFacingLeft,<a0000
        .BYTE <a0000,<a0000,<a0000,<a0000,<a0000,<mantaRollLeftFrom180DegreesFacingLeft
mantaleftFacingAnimationHiPtrArray
        .BYTE >a0000,>a0000,>a0000,>a0000,>a0000,>mantaRollRightFrom180DegreesFacingLeft,>a0000,>a0000
        .BYTE >a0000,>mantaRollAndFlipLeft,>a0000,>a0000,>mantaRollLeft90DegreesFacingLeft,>manta360RollLeft,>mantaRollRight90DegreesFacingLeft,>a0000
        .BYTE >a0000,>a0000,>a0000,>a0000,>a0000,>mantaRollLeftFrom180DegreesFacingLeft

mantaRightFacingAnimationLoPtrArray
        .BYTE <a0000,<mantaRollLeft1,<a0000,<a0000,<a0000,<a0000,<a0000,<a0000
        .BYTE <mantaRollRightFrom90Degrees,<mantaRollFacingRight,<mantaRollLeftFromUpsideDown,<a0000,<a0000,<mantaFlipFromRightToLeft,<a0000,<a0000
        .BYTE <a0000,<mantaRollLeft
mantaRightFacingAnimationHiPtrArray
        .BYTE >a0000,>mantaRollLeft1,>a0000,>a0000,>a0000,>a0000,>a0000,>a0000
        .BYTE >mantaRollRightFrom90Degrees,>mantaRollFacingRight,>mantaRollLeftFromUpsideDown,>a0000,>a0000,>mantaFlipFromRightToLeft,>a0000,>a0000
        .BYTE >a0000,>mantaRollLeft

; The values in these arrays get loaded by UpdateSpriteVariablesAndThenRedrawSprites to:
; spriteIndex, currentSpriteXPos, currentSpriteMSBXPosOffset, currentSpriteYPos,
; currentSpriteDisplayEnable, currentSpriteExpandVertical,
; currentSpriteBackgroundDisplayPriority, currentSpriteMultiColorMode,
; currentSpriteExpandHorizontal, currentSpriteColor, currentSpriteValue.
mantaAnimationVariables
        .BYTE $06,$70,$00,$98,$FF,$00,$00,$FF
        .BYTE $00,$F0,$59
spriteVariablesDemo
        .BYTE $06,$AA,$00,$98,$FF,$00,$00,$FF
        .BYTE $00,$F0,$59
spriteVariablesManta
;        .BYTE $06,$A0,$00,$AE,$FF,$00,$00,$FF
        .BYTE $06,$A0+8,$00,100,$FF,$00,$00,$FF
        .BYTE $00,$F0,$41
dropshipSpriteVariables10
        .BYTE $07,$BA,$00,$A8,$FF,$00,$FF,$00
        .BYTE $00,$FB,$89
spriteVariablesExplosion
        .BYTE $07,$AA,$00,$00,$FF,$00,$00,$FF
        .BYTE $00,$F7,$30
someKindOfSettingArray
        .BYTE $FD,$03,$F8,$08,$B0,$40,$50,$C0
mantaShadowOffsets   
        .BYTE $00,$00,$FF,$FE,$FD,$FD,$FE,$FE
        .BYTE $FF,$00,$01,$02,$03,$03,$02,$02
        .BYTE $01
loPtrsToShipDeploymentSpriteVariables
        .BYTE <dropshipSpriteVariables1,<dropshipSpriteVariables2,<dropshipSpriteVariables3,<dropshipSpriteVariables4
        .BYTE <dropshipSpriteVariables5,<dropshipSpriteVariables6,<bayDoorSection,<dropshipSpriteVariables8
loPtrToMantaAnimationVariables
        .BYTE <mantaAnimationVariables,<dropshipSpriteVariables10
hiPtrsToShipDeploymentSpriteVariables
        .BYTE >dropshipSpriteVariables1,>dropshipSpriteVariables2,>dropshipSpriteVariables3,>dropshipSpriteVariables4
        .BYTE >dropshipSpriteVariables5,>dropshipSpriteVariables6,>bayDoorSection,>dropshipSpriteVariables8
hiPtrToMantaAnimationVariables
        .BYTE >mantaAnimationVariables,>dropshipSpriteVariables10

; The values in these arrays get loaded by UpdateSpriteVariablesAndThenRedrawSprites to:
; spriteIndex, currentSpriteXPos, currentSpriteMSBXPosOffset, currentSpriteYPos,
; currentSpriteDisplayEnable, currentSpriteExpandVertical,
; currentSpriteBackgroundDisplayPriority, currentSpriteMultiColorMode,
; currentSpriteExpandHorizontal, currentSpriteColor, currentSpriteValue.
dropshipSpriteVariables1
        .BYTE $00,$82,$00,$8D,$FF,$00,$00,$FF
        .BYTE $00,$FC,$00
dropshipSpriteVariables2
        .BYTE $01,$6A,$00,$8D,$FF,$00,$00,$FF
        .BYTE $00,$FC,$01
dropshipSpriteVariables3
        .BYTE $02,$52,$00,$8D,$FF,$00,$00,$FF
        .BYTE $00,$FC,$02
dropshipSpriteVariables4
        .BYTE $03,$82,$00,$A2,$FF,$00,$00,$FF
        .BYTE $00,$FC,$03
dropshipSpriteVariables5
        .BYTE $04,$6A,$00,$A2,$FF,$00,$00,$FF
        .BYTE $00,$FC,$04
dropshipSpriteVariables6
        .BYTE $05,$52,$00,$A2,$FF,$00,$00,$FF
        .BYTE $00,$FC,$05
bayDoorSection
        .BYTE $06,$82,$00,$8E,$FF,$FF,$00,$00
        .BYTE $00,$FB,$07
dropshipSpriteVariables8
        .BYTE $07,$82,$00,$8E,$FF,$FF,$00,$FF
        .BYTE $00,$FE,$06

newLevelColors
        .BYTE M_GRAY3,M_WHITE,M_BLACK,M_WHITE,M_GRAY3,M_BLACK,M_GRAY3,M_GRAY2
        .BYTE M_BLACK,M_BLACK,M_BLACK,M_BLACK,M_BLACK,M_BLACK

        ; Background Color 1, Background Color 1, Character Color, Sprite MultiColor0, Sprite Color
levelColorScheme
        .BYTE M_GRAY1,M_GRAY3,M_ORANGE,M_GRAY2,M_GRAY1
        .BYTE M_BLACK,M_GRAY1,M_LTBLUE,M_LTRED,M_RED      ; Level 2, Level 13
        .BYTE M_BLACK,M_GRAY2,M_LTRED,M_LTBLUE,M_BLUE     ; Level 8
        .BYTE M_GREEN,M_LTGREEN,M_ORANGE,M_LTBLUE,M_BLUE  ; Level 5
        .BYTE M_RED,M_LTRED,M_ORANGE,M_YELLOW,M_ORANGE    ; Level 15
        .BYTE M_GRAY1,M_GRAY2,M_GRAY2,M_LTRED,M_RED       ; Level 10
        .BYTE M_BLUE,M_LTBLUE,M_ORANGE,M_LTGREEN,M_GREEN  ; Level 9 , Level 14
        .BYTE M_ORANGE,M_YELLOW,M_ORANGE,M_GRAY2,M_BLACK  ; Level 6
        .BYTE M_GRAY1,M_CYAN,M_LTGREEN,M_LTRED,M_RED      ; Level 7
        .BYTE M_BROWN,M_ORANGE,M_ORANGE,M_LTGREEN,M_GREEN ; Level 3, Level 11
        .BYTE M_GRAY1,M_GRAY3,M_ORANGE,M_YELLOW,M_ORANGE  ; Level 1
        .BYTE M_BLUE,M_CYAN,M_ORANGE,M_GRAY2,M_GRAY1      ; Level 12
        .BYTE M_GRAY1,M_GRAY3,M_ORANGE,M_LTBLUE,M_BLUE    ; Level 4
        
        .BYTE $04,$02,$03,$06,$07,$08
        .BYTE $08,$06,$05,$02,$03,$06,$08,$0B
        .BYTE $07,$06,$05,$02,$03
	
f33C6   .BYTE $06,$08,$0B,$07,$06,$04,$02,$03
        .BYTE $06,$07,$08,$08,$06,$00,$00,$00
f33D6   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$10,$11,$0F,$0D,$0C
f33E6   .BYTE $00,$0B

player1Text
        .BYTE $00,$01
        .byte "Player1", $FF
player2Text
        .BYTE $00,$1F
        .byte "Player2", $FF
oneUpText
        .BYTE $00,$01
	.byte $01,$1e,$19,$30,$7A,$7B
        ;.byte "1up ", $7A, $7B
livesLeftPlayerOneText
        .BYTE $30,$03,$FF

livesLeftPlayerTwoText = *+$04
twoUpText
        .BYTE $00,$1F
        ;.byte "", $7A, "", $7B, " 3 2up", $FF, ""
        .byte $7A, $7B, " 3 2up", $FF
spaces
        .BYTE $00,$0F
	.byte $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$ff
;        .byte "           ", $FF
landNowText
        .BYTE $00,$0F
        ;.byte "Land now!", $FF
	.byte $45,$0a,$17,$0d,$30,$17,$18,$54,$25,$ff

pauseText
        .BYTE $00,$0F
;        .BYTE "  Pause   ", $FF
	.byte $30,$30,$49,$0a,$1e,$1c,$0e,$30,$30,$30,$ff
	
player1
        .BYTE $0A,$0F
        .byte "Player 1", $FF
player2
        .BYTE $0A,$0F
        .byte "Player 2", $FF
gameOn
        .BYTE $0D,$0E
        .byte 'Game On!', $FF

tensLivesLeftDisplayed = *+$02
livesLeftDisplayed = *+$03
livesLeftText
        .BYTE $10,$0E
        .byte " 3     left.", $FF
gameOver
        .BYTE $0D,$0D
        .byte "Game Over!", $FF

destructSequencePrimed
        .BYTE $07,$07
        .byte "Destruct sequence primed!", $FF
formationAnnihilationBonusText
        .BYTE $0A,$05
        .byte "Formation annihilation bonus:", $FF
shipDestructBonusText
        .BYTE $10,$0A
        .byte "Ship destruct bonus:"
        .byte $FF

scoreBonusMultiplierValue = *+$08
scoreBonusResult = *+$0D
scoreBonusText
        .BYTE $0D,$0D
        .byte "100 X 00 = 0000", $FF
youveAmassedAHighScore
        .BYTE $0D,$04
        .byte "You have amassed a great score!", $FF
pleaseEnterYourInitials
        .BYTE $10,$06
        .byte "Please enter your initials.", $FF

initialOne = *+$02
initial2 = *+$03
initial3 = *+$04
initialsInputField
        .BYTE $13,$11
        .byte "A..   ", $FF
alphabetText
        .byte "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
miniGameColorSequence3   .BYTE M_WHITE,M_GRAY3,M_GRAY2,M_GRAY1,M_BLACK
miniGameColorSequence1   .BYTE M_GRAY3,M_GRAY2,M_GRAY1,M_BLACK,M_BLACK
miniGameColorSequence2   .BYTE M_GRAY1,M_GRAY1,M_BLACK,M_BLACK,M_BLACK


arrowKeysSymbol
        .BYTE $02,$0A,$57,$FF
globeSymbol
        .BYTE $02,$0A,$58,$FF
scrollingTitleScreenDataLoPtrArray   .BYTE $3A,$4B,$5E
scrollingTitleScreenDataHiPtrArray   .BYTE $35,$35,$35

uridiumDecal
        .BYTE $02,$0A
        .BYTE $30,$30,$30,$30,$30,$31,$32,$33
        .BYTE $34,$35,$36,$37,$38,$39,$7D,$30
        .BYTE $30,$30,$30,$30,$FF
hiScoreLabel
        .BYTE $02,$0A
	.byte $30,$30,$30,$30,$30
        ;.BYTE "Hi-score"
	.byte $41,$12,$2e,$1c,$0c,$18,$1b,$0e
	.byte $30,$30,$30,$30,$30,$FF

inGameBanner ; $3526
        .BYTE $02,$0A
        ;.byte "     12000 AEB   ", $FF
	.byte $30,$30,$30,$30,$30
	.byte $01,$02,$00,$00,$00,$30
	.byte $3a,$3e,$3b
	.byte $30,$30,$30,$ff
	
	.byte "2c    "
        .byte " ", $55, $55, "     ", $56, $56, $FF, "2c     ", $55, " "
        .byte "        ", $56, $FF, "2c     ", $55, $55, " "
        .byte "      ", $56, $FF

initialPositionOfMiniGameScreenData
        .BYTE $FF,$C3,$99,$99,$99,$99,$C3,$FF
        .BYTE $FF,$E3,$C3,$F3,$F3,$F3,$C1,$FF
        .BYTE $FF,$C1,$9C,$F9,$C3,$9F,$80,$FF
        .BYTE $FF,$C1,$9C,$F1,$F1,$9C,$C1,$FF
        .BYTE $FF,$E1,$C9,$99,$99,$80,$F9,$FF
        .BYTE $FF,$80,$9F,$81,$FC,$9C,$C1,$FF
        .BYTE $FF,$E0,$CF,$81,$9C,$9C,$C1,$FF
        .BYTE $FF,$80,$FC,$F9,$F3,$F3,$F3,$FF
        .BYTE $FF,$C1,$9C,$C1,$C1,$9C,$C1,$FF
        .BYTE $FF,$C1,$9C,$9C,$C0,$F9,$83,$FF
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $55,$55,$50,$45,$46,$46,$46,$46
        .BYTE $55,$55,$05,$99,$49,$49,$49,$49
        .BYTE $55,$55,$54,$50,$58,$54,$54,$54
        .BYTE $55,$55,$25,$65,$65,$65,$65,$65
        .BYTE $55,$55,$50,$4A,$49,$55,$55,$54
        .BYTE $55,$55,$05,$99,$49,$49,$19,$65
        .BYTE $55,$55,$50,$4A,$65,$54,$56,$55
        .BYTE $55,$55,$05,$59,$19,$65,$45,$19
        .BYTE $55,$55,$40,$46,$46,$46,$46,$45
        .BYTE $55,$55,$55,$55,$55,$55,$55,$01
        .BYTE $55,$55,$40,$4A,$49,$44,$6A,$55
        .BYTE $55,$55,$01,$A9,$55,$15,$45,$19
        .BYTE $55,$55,$50,$4A,$49,$44,$45,$46
        .BYTE $55,$55,$01,$A9,$55,$05,$99,$49
        .BYTE $55,$55,$40,$6A,$55,$55,$54,$51
        .BYTE $55,$55,$01,$99,$49,$19,$65,$95
        .BYTE $55,$55,$50,$46,$49,$54,$51,$46
        .BYTE $55,$55,$05,$99,$49,$25,$95,$49
        .BYTE $55,$55,$50,$4A,$49,$44,$5A,$55
        .BYTE $55,$55,$05,$59,$19,$19,$59,$19
        .BYTE $FF,$C1,$9C,$9C,$90,$99,$C0,$FF
        .BYTE $FF,$9C,$9C,$9C,$9C,$9C,$C1,$FF
        .BYTE $FF,$E1,$F3,$F3,$F3,$F3,$E1,$FF
        .BYTE $FF,$81,$E7,$E7,$E7,$E7,$E7,$FF
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $46,$45,$45,$45,$45,$5A,$55,$55
        .BYTE $49,$19,$59,$59,$59,$A5,$55,$55
        .BYTE $54,$50,$55,$55,$55,$5A,$55,$55
        .BYTE $65,$51,$59,$59,$59,$A9,$55,$55
        .BYTE $51,$45,$45,$45,$45,$6A,$55,$55
        .BYTE $95,$01,$59,$59,$59,$A9,$55,$55
        .BYTE $45,$40,$45,$45,$65,$5A,$55,$55
        .BYTE $19,$59,$59,$59,$65,$95,$55,$55
        .BYTE $45,$45,$45,$6A,$55,$55,$55,$55
        .BYTE $59,$59,$59,$99,$49,$69,$55,$55
        .BYTE $45,$40,$45,$45,$65,$5A,$55,$55
        .BYTE $19,$59,$59,$59,$65,$95,$55,$55
        .BYTE $46,$45,$45,$45,$65,$5A,$55,$55
        .BYTE $49,$19,$59,$59,$59,$A5,$55,$55
        .BYTE $51,$51,$51,$51,$51,$5A,$55,$55
        .BYTE $95,$95,$95,$95,$95,$95,$55,$55
        .BYTE $46,$45,$45,$45,$45,$5A,$55,$55
        .BYTE $49,$19,$59,$59,$59,$A5,$55,$55
        .BYTE $55,$40,$45,$45,$45,$6A,$55,$55
        .BYTE $19,$19,$59,$59,$59,$A5,$55,$55

surfaceStructureData
        .BYTE $01,$01,$20

	.BYTE $01,$11,$21,$22,$22
        .BYTE $22,$22,$22,$22,$22,$22,$22,$22
        .BYTE $22,$22,$22,$22,$22,$23

	.BYTE $01,$11
        .BYTE $24,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $26
	.BYTE $01,$11,$27,$28,$28,$28,$28
        .BYTE $28,$28,$28,$28,$28,$28,$28,$28
        .BYTE $28,$28,$28,$29
	
	.BYTE $04,$10,$20,$30
        .BYTE $22,$22,$22,$22,$22,$22,$22,$22
        .BYTE $22,$22,$22,$22,$22,$2B,$10,$20
        .BYTE $32,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$2C,$11
        .BYTE $30,$31,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$2A
        .BYTE $2B,$11,$32,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$2C
	
	.BYTE $03,$11,$24,$21,$22
        .BYTE $23,$21,$22,$23,$21,$22,$23,$21
        .BYTE $22,$23,$21,$22,$23,$26,$11,$24
        .BYTE $24,$25,$26,$24,$25,$26,$24,$25
        .BYTE $26,$24,$25,$26,$24,$25,$26,$26
        .BYTE $11,$24,$27,$28,$29,$27,$28,$29
        .BYTE $27,$28,$29,$27,$28,$29,$27,$28
        .BYTE $29,$26
	
	.BYTE $04,$11,$35,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$2F,$11,$33,$34
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$2D,$2E,$10
        .BYTE $20,$35,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$2F
        .BYTE $10,$20,$33,$28,$28,$28,$28,$28
        .BYTE $28,$28,$28,$28,$28,$28,$28,$28
        .BYTE $2E
	
	.BYTE $02,$0B,$20,$20,$20,$20,$20
        .BYTE $20,$21,$22,$22,$22,$23,$0B,$20
        .BYTE $20,$20,$20,$20,$20,$27,$28,$28
        .BYTE $28,$29
	
	.BYTE $01,$11,$24,$25,$25,$25
        .BYTE $25,$25,$41,$28,$28,$28,$40,$25
        .BYTE $25,$25,$25,$25,$26
	
	.BYTE $01,$11,$24
        .BYTE $25,$25,$25,$25,$25,$26,$20,$20
        .BYTE $20,$24,$25,$25,$25,$25,$25,$26
	
        .BYTE $04,$11,$35,$25,$25,$25,$25,$25
        .BYTE $2F,$20,$20,$20,$35,$25,$25,$25
        .BYTE $25,$25,$2F,$11,$33,$34,$25,$25
        .BYTE $25,$2D,$2E,$20,$20,$20,$33,$34
        .BYTE $25,$25,$25,$2D,$2E,$10,$20,$35
        .BYTE $25,$25,$25,$2F,$20,$20,$20,$20
        .BYTE $20,$35,$25,$25,$25,$2F,$10,$20
        .BYTE $33,$28,$28,$28,$2E,$20,$20,$20
        .BYTE $20,$20,$33,$28,$28,$28,$2E
	
	.BYTE $02
        .BYTE $0B,$20,$20,$20,$20,$20,$20,$53
        .BYTE $52,$52,$52,$51,$0B,$20,$20,$20
        .BYTE $20,$20,$20,$27,$28,$28,$28,$29
	
        .BYTE $06,$06,$4E,$21,$23,$4A,$21,$23
        .BYTE $06,$4F,$27,$25,$25,$25,$29,$06
        .BYTE $50,$4B,$25,$9D,$25,$48,$06,$4E
        .BYTE $21,$25,$25,$25,$23,$06,$4F,$27
        .BYTE $29,$49,$27,$29,$06,$50,$4D,$4C
        .BYTE $50,$4D,$4C,$02,$0B,$20,$20,$20
        .BYTE $20,$20,$20,$A9,$AB,$AF,$AA,$A8
        .BYTE $0B,$20,$20,$20,$20,$20,$20,$A1
        .BYTE $A3,$BA,$A2,$A0,$02,$0B,$20,$20
        .BYTE $20,$20,$20,$20,$A5,$A7,$B9,$A6
        .BYTE $A4,$0B,$20,$20,$20,$20,$20,$20
        .BYTE $A1,$A3,$BA,$A2,$A0,$06,$03,$B0
        .BYTE $B1,$B2,$03,$B3,$B4,$B5,$03,$B3
        .BYTE $B4,$B5,$03,$B3,$B4,$B5,$03,$B3
        .BYTE $B4,$B5,$03,$B6,$B7,$B8,$05,$03
        .BYTE $58,$55,$54,$03,$58,$55,$54,$03
        .BYTE $58,$55,$54,$03,$58,$55,$54,$03
        .BYTE $58,$56,$54,$06,$01,$AC,$01,$AD
        .BYTE $01,$AD,$01,$AD,$01,$AD,$01,$AE
        .BYTE $03,$03,$C6,$C3,$C0,$03,$C7,$C4
        .BYTE $C1,$03,$C8,$C5,$C2,$03,$03,$41
        .BYTE $28,$40,$03,$26,$5A,$24,$03,$3F
        .BYTE $22,$3E,$04,$04,$CB,$86,$83,$80
        .BYTE $04,$CC,$88,$85,$82,$04,$5C,$5C
        .BYTE $5C,$C9,$04,$CD,$5C,$CE,$CA,$04
        .BYTE $04,$CB,$86,$83,$80,$04,$CC,$88
        .BYTE $85,$82,$04,$5C,$5C,$5C,$5C,$04
        .BYTE $CD,$5C,$CE,$CD,$04,$04,$CF,$86
        .BYTE $83,$80,$04,$D0,$88,$85,$82,$04
        .BYTE $5C,$5C,$5C,$5C,$04,$5C,$5C,$CE
        .BYTE $CD,$02,$02,$92,$90,$02,$93,$91
        .BYTE $03,$03,$9A,$97,$94,$03,$9B,$98
        .BYTE $95,$03,$9C,$99,$96,$01,$01,$9D
        .BYTE $01,$01,$9E,$01,$01,$9F,$04,$04
        .BYTE $CB,$86,$83,$80,$04,$CC,$88,$85
        .BYTE $82,$04,$5C,$5C,$5C,$D1,$04,$CD
        .BYTE $5C,$CE,$D2,$04,$03,$86,$83,$80
        .BYTE $03,$88,$85,$82,$03,$5C,$5C,$C9
        .BYTE $03,$5C,$CE,$CA,$03,$03,$21,$22
        .BYTE $23,$03,$24,$25,$26,$03,$27,$28
        .BYTE $29,$02,$01,$20,$01,$20,$03,$08
        .BYTE $21,$22,$22,$22,$22,$22,$22,$23
        .BYTE $08,$24,$25,$25,$25,$25,$25,$25
        .BYTE $26,$08,$24,$25,$25,$25,$25,$25
        .BYTE $25,$26,$03,$08,$27,$28,$28,$40
        .BYTE $41,$28,$40,$26,$08,$20,$20,$20
        .BYTE $24,$26,$20,$24,$26,$08,$20,$20
        .BYTE $20,$24,$26,$20,$24,$26,$01,$08
        .BYTE $27,$28,$28,$28,$28,$28,$28,$29
        .BYTE $01,$08,$24,$41,$28,$40,$41,$28
        .BYTE $40,$26,$02,$08,$24,$26,$20,$24
        .BYTE $26,$20,$24,$26,$08,$24,$26,$20
        .BYTE $24,$26,$20,$24,$26,$02,$08,$35
        .BYTE $3F,$22,$3E,$3F,$22,$3E,$2F,$08
        .BYTE $33,$28,$28,$29,$27,$28,$28,$2E
        .BYTE $03,$08,$30,$22,$22,$22,$22,$22
        .BYTE $22,$2B,$08,$32,$25,$25,$25,$25
        .BYTE $25,$25,$2C,$08,$24,$25,$25,$25
        .BYTE $25,$25,$25,$26,$01,$08,$24,$41
        .BYTE $28,$28,$28,$28,$40,$26,$02,$08
        .BYTE $24,$26,$20,$20,$20,$20,$24,$26
        .BYTE $08,$27,$29,$20,$20,$20,$20,$27
        .BYTE $29,$02,$08,$35,$3F,$22,$22,$22
        .BYTE $22,$3E,$2F,$08,$33,$28,$28,$28
        .BYTE $28,$28,$28,$2E,$02,$08,$24,$26
        .BYTE $20,$24,$26,$20,$24,$26,$08,$27
        .BYTE $29,$20,$27,$29,$20,$27,$29,$02
        .BYTE $08,$20,$20,$20,$24,$26,$20,$24
        .BYTE $26,$08,$20,$20,$20,$27,$29,$20
        .BYTE $27,$29,$04,$08,$24,$26,$20,$20
        .BYTE $20,$20,$24,$26,$08,$24,$26,$20
        .BYTE $21,$23,$20,$24,$26,$08,$35,$3F
        .BYTE $22,$3E,$26,$20,$24,$2F,$08,$33
        .BYTE $28,$28,$28,$29,$20,$27,$2E,$04
        .BYTE $08,$27,$28,$28,$40,$41,$28,$28
        .BYTE $29,$05,$20,$20,$20,$24,$26,$05
        .BYTE $20,$20,$20,$24,$26,$08,$21,$22
        .BYTE $22,$3E,$3F,$22,$22,$23,$04,$03
        .BYTE $30,$22,$23,$03,$32,$25,$26,$03
        .BYTE $24,$25,$26,$03,$24,$41,$29,$04
        .BYTE $02,$24,$26,$02,$24,$26,$08,$35
        .BYTE $3F,$22,$22,$22,$22,$22,$23,$08
        .BYTE $33,$28,$28,$28,$28,$28,$28,$29
        .BYTE $02,$02,$24,$26,$02,$24,$26,$05
        .BYTE $08,$27,$25,$25,$28,$28,$28,$28
        .BYTE $29,$04,$30,$25,$25,$2B,$04,$32
        .BYTE $25,$25,$2C,$06,$24,$2F,$35,$25
        .BYTE $22,$23,$06,$27,$2E,$33,$28,$28
        .BYTE $29,$01,$08,$24,$41,$28,$28,$28
        .BYTE $28,$28,$29,$02,$02,$24,$26,$02
        .BYTE $27,$29,$01,$08,$27,$28,$28,$28
        .BYTE $28,$28,$40,$26,$04,$08,$20,$20
        .BYTE $20,$20,$20,$20,$24,$26,$08,$20
        .BYTE $20,$20,$20,$20,$20,$24,$26,$08
        .BYTE $21,$22,$22,$22,$22,$22,$3E,$26
        .BYTE $08,$27,$28,$28,$28,$28,$28,$40
        .BYTE $26,$04,$08,$20,$20,$20,$20,$20
        .BYTE $20,$24,$26,$08,$20,$20,$20,$20
        .BYTE $20,$20,$24,$26,$08,$21,$22,$22
        .BYTE $22,$22,$22,$3E,$2F,$08,$27,$28
        .BYTE $28,$28,$28,$28,$28,$2E,$02,$08
        .BYTE $20,$20,$20,$35,$3F,$22,$3E,$2F
        .BYTE $08,$20,$20,$20,$33,$28,$28,$28
        .BYTE $2E,$04,$08,$35,$25,$2B,$20,$20
        .BYTE $20,$24,$26,$08,$33,$25,$2C,$20
        .BYTE $20,$20,$24,$26,$08,$21,$25,$3F
        .BYTE $22,$22,$22,$3E,$2F,$08,$27,$28
        .BYTE $28,$28,$28,$28,$28,$2E,$05,$08
        .BYTE $27,$25,$25,$25,$41,$28,$40,$26
        .BYTE $08,$30,$25,$25,$25,$26,$20,$24
        .BYTE $26,$08,$32,$25,$25,$25,$26,$20
        .BYTE $24,$26,$08,$24,$25,$2F,$35,$3F
        .BYTE $22,$3E,$2F,$08,$27,$28,$2E,$33
        .BYTE $28,$28,$28,$2E,$02,$08,$21,$23
        .BYTE $20,$30,$22,$22,$22,$2B,$08,$24
        .BYTE $26,$20,$32,$25,$25,$25,$2C,$02
        .BYTE $08,$35,$3F,$22,$3E,$2F,$20,$24
        .BYTE $26,$08,$33,$28,$28,$28,$2E,$20
        .BYTE $27,$29,$02,$08,$20,$20,$20,$20
        .BYTE $20,$20,$21,$23,$08,$20,$20,$20
        .BYTE $20,$20,$20,$24,$26,$03,$08,$30
        .BYTE $22,$22,$22,$22,$22,$22,$23,$08
        .BYTE $32,$25,$25,$25,$25,$25,$25,$26
        .BYTE $08,$24,$25,$25,$25,$25,$25,$25
        .BYTE $26,$08,$08,$20,$30,$22,$22,$22
        .BYTE $22,$22,$23,$08,$20,$32,$25,$25
        .BYTE $25,$25,$25,$26,$08,$30,$31,$25
        .BYTE $25,$25,$25,$25,$26,$08,$32,$25
        .BYTE $28,$28,$28,$28,$28,$29,$03,$35
        .BYTE $25,$2B,$03,$33,$34,$2C,$08,$20
        .BYTE $35,$25,$22,$22,$22,$22,$23,$08
        .BYTE $20,$33,$28,$28,$28,$28,$28,$29
        .BYTE $04,$02,$24,$26,$02,$24,$26,$08
        .BYTE $24,$3F,$22,$22,$22,$22,$22,$23
        .BYTE $08,$24,$41,$28,$28,$28,$28,$28
        .BYTE $29,$08,$08,$21,$22,$22,$23,$21
        .BYTE $22,$22,$23,$08,$27,$28,$28,$40
        .BYTE $25,$25,$25,$26,$08,$20,$20,$20
        .BYTE $24,$25,$25,$25,$26,$08,$20,$20
        .BYTE $20,$24,$41,$28,$28,$29,$05,$21
        .BYTE $22,$22,$3E,$26,$05,$24,$25,$25
        .BYTE $25,$26,$08,$24,$25,$25,$25,$3F
        .BYTE $22,$22,$23,$08,$27,$28,$28,$29
        .BYTE $27,$28,$28,$29,$08,$08,$20,$20
        .BYTE $30,$22,$22,$22,$22,$23,$08,$20
        .BYTE $20,$32,$25,$25,$25,$25,$26,$08
        .BYTE $21,$22,$25,$25,$25,$25,$25,$26
        .BYTE $08,$24,$25,$25,$25,$41,$28,$28
        .BYTE $29,$05,$24,$25,$25,$25,$26,$05
        .BYTE $27,$28,$25,$25,$26,$08,$20,$20
        .BYTE $35,$25,$3F,$22,$22,$23,$08,$20
        .BYTE $20,$33,$28,$28,$28,$28,$29,$04
        .BYTE $08,$21,$22,$22,$22,$2B,$20,$21
        .BYTE $23,$08,$24,$25,$25,$25,$2C,$20
        .BYTE $24,$26,$08,$24,$25,$25,$25,$26
        .BYTE $20,$24,$26,$08,$24,$41,$28,$40
        .BYTE $26,$20,$24,$26,$02,$08,$24,$26
        .BYTE $20,$35,$3F,$22,$3E,$26,$08,$27
        .BYTE $29,$20,$33,$28,$28,$28,$29,$03
        .BYTE $08,$21,$22,$22,$22,$22,$22,$22
        .BYTE $2B,$08,$24,$25,$25,$25,$25,$25
        .BYTE $25,$2C,$08,$24,$25,$25,$25,$25
        .BYTE $25,$25,$26,$02,$08,$24,$26,$20
        .BYTE $35,$3F,$22,$3E,$2F,$08,$27,$29
        .BYTE $20,$33,$28,$28,$28,$2E,$02,$08
        .BYTE $21,$23,$20,$21,$23,$20,$21,$23
        .BYTE $08,$24,$26,$20,$24,$26,$20,$24
        .BYTE $26,$08,$08,$20,$20,$20,$21,$22
        .BYTE $22,$22,$2B,$08,$20,$20,$20,$24
        .BYTE $41,$28,$40,$2C,$08,$21,$22,$22
        .BYTE $3E,$26,$20,$24,$26,$08,$24,$25
        .BYTE $25,$25,$26,$20,$24,$26,$08,$24
        .BYTE $25,$25,$25,$3F,$22,$3E,$26,$08
        .BYTE $27,$28,$28,$40,$41,$28,$28,$29
        .BYTE $05,$20,$20,$20,$24,$26,$05,$20
        .BYTE $20,$20,$27,$29,$02,$08,$21,$23
        .BYTE $20,$21,$22,$22,$22,$23,$08,$24
        .BYTE $26,$20,$24,$25,$25,$25,$26,$02
        .BYTE $08,$24,$26,$20,$24,$25,$25,$25
        .BYTE $26,$08,$24,$26,$20,$24,$41,$28
        .BYTE $40,$26,$06,$08,$21,$22,$22,$22
        .BYTE $22,$22,$3E,$26,$08,$24,$25,$25
        .BYTE $25,$25,$25,$25,$26,$08,$24,$25
        .BYTE $25,$25,$25,$25,$25,$26,$08,$27
        .BYTE $28,$28,$28,$28,$28,$40,$26,$08
        .BYTE $20,$20,$20,$20,$20,$20,$24,$26
        .BYTE $08,$20,$20,$20,$20,$20,$20,$27
        .BYTE $29,$06,$08,$21,$22,$22,$22,$2B
        .BYTE $20,$24,$26,$08,$24,$25,$25,$25
        .BYTE $2C,$20,$24,$26,$08,$24,$25,$25
        .BYTE $25,$2A,$2B,$24,$26,$08,$27,$28
        .BYTE $28,$25,$25,$2C,$24,$26,$08,$20
        .BYTE $20,$20,$35,$25,$25,$25,$26,$08
        .BYTE $20,$20,$20,$33,$28,$28,$28,$29
        .BYTE $03,$08,$30,$22,$22,$23,$21,$22
        .BYTE $22,$2B,$08,$32,$25,$25,$25,$25
        .BYTE $25,$25,$2C,$08,$24,$25,$25,$25
        .BYTE $25,$25,$25,$26,$02,$08,$35,$3F
        .BYTE $22,$3E,$3F,$22,$3E,$2F,$08,$33
        .BYTE $28,$28,$28,$28,$28,$28,$2E,$04
        .BYTE $05,$20,$20,$20,$21,$23,$05,$20
        .BYTE $20,$20,$24,$26,$05,$20,$20,$20
        .BYTE $24,$26,$05,$20,$20,$20,$27,$29
        .BYTE $02,$08,$24,$26,$20,$20,$20,$20
        .BYTE $24,$26,$08,$24,$26,$20,$20,$20
        .BYTE $20,$24,$26,$04,$03,$86,$83,$80
        .BYTE $03,$88,$85,$82,$03,$5C,$5C,$5C
        .BYTE $03,$5C,$CE,$CD,$03,$03,$D9,$D6
        .BYTE $D3,$03,$DA,$D7,$D4,$03,$DB,$D8
        .BYTE $D5,$05,$03,$58,$55,$54,$03,$58
        .BYTE $55,$54,$03,$58,$56,$54,$03,$58
        .BYTE $56,$54,$03,$58,$56,$54,$05,$05
        .BYTE $4E,$21,$22,$22,$23,$05,$4F,$24
        .BYTE $25,$25,$26,$05,$4F,$24,$25,$25
        .BYTE $26,$05,$4F,$27,$28,$28,$29,$05
        .BYTE $50,$4D,$4D,$4D,$4C,$05,$03,$BF
        .BYTE $BF,$BF,$03,$BF,$25,$BF,$03,$BF
        .BYTE $59,$BF,$03,$BF,$25,$BF,$03,$BF
        .BYTE $BF,$BF,$08,$01,$BF,$01,$BF,$01
        .BYTE $BF,$01,$BF,$01,$BF,$01,$BF,$01
        .BYTE $BF,$01,$BF,$01,$08,$21,$22,$22
        .BYTE $3E,$3F,$22,$3E,$26,$01,$05,$40
        .BYTE $25,$25,$25,$41,$02,$05,$24,$25
        .BYTE $25,$25,$26,$05,$24,$25,$25,$25
        .BYTE $26,$02,$05,$35,$25,$25,$25,$2F
        .BYTE $05,$33,$28,$28,$28,$2E,$02,$05
        .BYTE $3D,$25,$25,$25,$39,$05,$3C,$28
        .BYTE $28,$28,$38,$04,$11,$24,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$26,$11,$24
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$26
        .BYTE $11,$24,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$26,$11,$24,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$26,$01,$0D,$21,$22
        .BYTE $22,$22,$22,$22,$22,$22,$22,$22
        .BYTE $22,$22,$23,$02,$07,$24,$25,$25
        .BYTE $25,$25,$25,$26,$07,$24,$25,$25
        .BYTE $25,$25,$25,$26,$06,$07,$3D,$25
        .BYTE $25,$25,$25,$25,$39,$07,$3C,$34
        .BYTE $25,$25,$25,$2D,$38,$06,$20,$3D
        .BYTE $25,$25,$25,$39,$06,$20,$3C,$34
        .BYTE $25,$2D,$38,$05,$20,$20,$3D,$25
        .BYTE $39,$05,$20,$20,$3C,$28,$38,$01
        .BYTE $0D,$27,$28,$28,$28,$28,$28,$28
        .BYTE $28,$28,$28,$28,$28,$29,$01,$06
        .BYTE $BF,$BF,$BF,$BF,$BF,$BF,$01,$07
        .BYTE $27,$28,$28,$28,$28,$28,$40,$08
        .BYTE $01,$26,$01,$26,$01,$26,$01,$26
        .BYTE $01,$26,$01,$26,$01,$26,$01,$26
        .BYTE $08,$01,$24,$01,$24,$01,$24,$01
        .BYTE $24,$01,$24,$01,$24,$01,$24,$01
        .BYTE $24,$03,$03,$5D,$5C,$5F,$03,$5E
        .BYTE $5B,$5F,$03,$5E,$61,$60,$05,$05
        .BYTE $41,$28,$28,$28,$40,$05,$26,$20
        .BYTE $20,$20,$24,$05,$26,$20,$20,$20
        .BYTE $24,$05,$26,$20,$20,$20,$24,$05
        .BYTE $3F,$22,$22,$22,$3E,$01,$11,$24
        .BYTE $25,$25,$25,$25,$25,$3F,$22,$22
        .BYTE $22,$3E,$25,$25,$25,$25,$25,$26
        .BYTE $04,$03,$EC,$8B,$89,$03,$ED,$8C
        .BYTE $8A,$03,$EE,$F0,$F2,$03,$EF,$F1
        .BYTE $F3,$03,$04,$20,$8F,$8E,$8D,$03
        .BYTE $20,$F5,$F4,$03,$F8,$F6,$F7,$05
        .BYTE $03,$6F,$6F,$6F,$03,$58,$55,$54
        .BYTE $03,$58,$6F,$54,$03,$58,$55,$54
        .BYTE $03,$58,$6F,$54,$07,$06,$6D,$69
        .BYTE $69,$69,$69,$6B,$06,$6A,$25,$25
        .BYTE $25,$25,$6A,$06,$6A,$25,$66,$63
        .BYTE $25,$6A,$06,$6A,$25,$67,$64,$25
        .BYTE $6A,$06,$6A,$25,$68,$65,$25,$6A
        .BYTE $06,$6A,$25,$25,$25,$25,$6A,$06
        .BYTE $6E,$69,$69,$69,$69,$6C,$07,$01
        .BYTE $DC,$01,$DD,$01,$DD,$01,$DD,$01
        .BYTE $DD,$01,$DD,$01,$DE,$01,$07,$E1
        .BYTE $E0,$E0,$E0,$E0,$E0,$DF,$07,$01
        .BYTE $DC,$01,$DD,$01,$DD,$01,$E2,$01
        .BYTE $DD,$01,$DD,$01,$DE,$01,$07,$E1
        .BYTE $E0,$E0,$E2,$E0,$E0,$DF,$05,$01
        .BYTE $DD,$01,$DD,$01,$DD,$01,$DD,$01
        .BYTE $DD,$01,$05,$E0,$E0,$E0,$E0,$E0
        .BYTE $03,$01,$DD,$01,$EA,$01,$DD,$01
        .BYTE $03,$E0,$E7,$E0,$03,$01,$DD,$01
        .BYTE $E8,$01,$DD,$01,$03,$E0,$E9,$E0
        .BYTE $03,$01,$DC,$01,$DD,$01,$DD,$01
        .BYTE $03,$E0,$E0,$DF,$03,$01,$DD,$01
        .BYTE $DD,$01,$DE,$01,$03,$E1,$E0,$E0
        .BYTE $02,$10,$20,$A9,$AB,$AF,$AA,$A8
        .BYTE $20,$20,$20,$20,$20,$A9,$AB,$AF
        .BYTE $AA,$A8,$10,$20,$A1,$A3,$BA,$A2
        .BYTE $A0,$20,$20,$20,$20,$20,$A1,$A3
        .BYTE $BA,$A2,$A0,$02,$10,$20,$A5,$A7
        .BYTE $B9,$A6,$A4,$20,$20,$20,$20,$20
        .BYTE $A5,$A7,$B9,$A6,$A4,$10,$20,$A1
        .BYTE $A3,$BA,$A2,$A0,$20,$20,$20,$20
        .BYTE $20,$A1,$A3,$BA,$A2,$A0,$04,$01
        .BYTE $BC,$04,$20,$20,$20,$BE,$01,$20
        .BYTE $03,$20,$20,$9D,$04,$02,$20,$9E
        .BYTE $01,$20,$01,$BC,$04,$20,$20,$20
        .BYTE $BB,$04,$03,$20,$20,$BC,$01,$9F
        .BYTE $01,$20,$02,$20,$BB,$04,$04,$20
        .BYTE $20,$20,$9D,$03,$20,$20,$BB,$01
        .BYTE $BC,$02,$20,$BD,$02,$11,$86,$83
        .BYTE $80,$86,$83,$80,$25,$25,$25,$25
        .BYTE $5C,$86,$83,$80,$86,$83,$80,$11
        .BYTE $88,$85,$82,$88,$85,$82,$25,$25
        .BYTE $25,$25,$5C,$88,$85,$82,$88,$85
        .BYTE $82,$02,$11,$86,$83,$80,$86,$83
        .BYTE $80,$86,$83,$80,$86,$83,$80,$25
        .BYTE $25,$25,$25,$26,$11,$88,$85,$82
        .BYTE $88,$85,$82,$88,$85,$82,$88,$85
        .BYTE $82,$25,$25,$25,$25,$26,$02,$11
        .BYTE $24,$25,$25,$25,$5C,$86,$83,$80
        .BYTE $86,$83,$80,$86,$83,$80,$86,$83
        .BYTE $80,$11,$24,$25,$25,$25,$5C,$88
        .BYTE $85,$82,$88,$85,$82,$88,$85,$82
        .BYTE $88,$85,$82,$03,$11,$24,$25,$25
        .BYTE $5C,$86,$80,$25,$25,$25,$25,$5C
        .BYTE $86,$80,$25,$25,$25,$26,$11,$24
        .BYTE $25,$25,$5C,$87,$81,$25,$25,$25
        .BYTE $25,$5C,$87,$81,$25,$25,$25,$26
        .BYTE $11,$24,$25,$25,$5C,$88,$82,$25
        .BYTE $25,$25,$25,$5C,$88,$82,$25,$25
        .BYTE $25,$26,$03,$11,$24,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$5C,$86,$80
        .BYTE $25,$25,$25,$25,$26,$11,$24,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$5C
        .BYTE $87,$81,$25,$25,$25,$25,$26,$11
        .BYTE $24,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$5C,$88,$82,$25,$25,$25,$25
        .BYTE $26,$03,$11,$24,$25,$25,$25,$5C
        .BYTE $86,$80,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$26,$11,$24,$25,$25
        .BYTE $25,$5C,$87,$81,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$26,$11,$24
        .BYTE $25,$25,$25,$5C,$88,$82,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$26
        .BYTE $02,$01,$CB,$01,$CC,$01,$07,$21
        .BYTE $22,$22,$22,$22,$22,$3E,$01,$07
        .BYTE $3F,$22,$22,$22,$22,$22,$23,$01
        .BYTE $07,$41,$28,$28,$28,$28,$28,$29
        .BYTE $01,$07,$21,$22,$22,$22,$22,$22
        .BYTE $23,$09,$0A,$20,$20,$20,$30,$22
        .BYTE $22,$22,$22,$22,$2B,$0A,$20,$20
        .BYTE $20,$32,$25,$25,$25,$25,$25,$2C
        .BYTE $0B,$20,$20,$30,$31,$25,$25,$25
        .BYTE $25,$25,$2A,$2B,$0B,$20,$20,$32
        .BYTE $25,$25,$25,$25,$25,$25,$25,$2C
        .BYTE $0C,$20,$30,$31,$25,$25,$25,$25
        .BYTE $25,$25,$25,$2A,$2B,$0C,$20,$32
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$2C,$0D,$30,$31,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$2A,$2B
        .BYTE $0D,$32,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$2C,$0D,$31
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$2A,$09,$0D,$34,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$2D,$0D,$35,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$25,$25,$25
        .BYTE $2F,$0D,$33,$34,$25,$25,$25,$25
        .BYTE $25,$25,$25,$25,$25,$2D,$2E,$0C
        .BYTE $20,$35,$25,$25,$25,$25,$25,$25
        .BYTE $25,$25,$25,$2F,$0C,$20,$33,$34
        .BYTE $25,$25,$25,$25,$25,$25,$25,$2D
        .BYTE $2E,$0B,$20,$20,$35,$25,$25,$25
        .BYTE $25,$25,$25,$25,$2F,$0B,$20,$20
        .BYTE $33,$34,$25,$25,$25,$25,$25,$2D
        .BYTE $2E,$0A,$20,$20,$20,$35,$25,$25
        .BYTE $25,$25,$25,$2F,$0A,$20,$20,$20
        .BYTE $33,$28,$28,$28,$28,$28,$2E,$02
        .BYTE $04,$5C,$5C,$5C,$D1,$04,$CD,$5C
        .BYTE $CE,$D2,$02,$03,$5C,$5C,$C9,$03
        .BYTE $CD,$CE,$CA,$04,$04,$5C,$86,$83
        .BYTE $80,$04,$5C,$88,$85,$82,$04,$5C
        .BYTE $5C,$5C,$5C,$04,$CD,$5C,$CE,$CD
        .BYTE $02,$01,$5C,$01,$5C,$05,$03,$9D
        .BYTE $9D,$9D,$03,$9D,$9E,$9D,$03,$9D
        .BYTE $9E,$9D,$03,$9D,$9E,$9D,$03,$9D
        .BYTE $9D,$9D,$01,$07,$27,$28,$28,$28
        .BYTE $28,$28,$29,$08,$01,$20,$01,$20
        .BYTE $01,$20,$01,$20,$01,$20,$01,$20
        .BYTE $01,$20,$01,$20,$0F,$08,$20,$20
        .BYTE $20,$20,$20,$30,$22,$2B,$08,$20
        .BYTE $20,$20,$20,$20,$32,$25,$2C,$09
        .BYTE $20,$20,$20,$20,$30,$31,$25,$2A
        .BYTE $2B,$09,$20,$20,$20,$20,$32,$25
        .BYTE $25,$25,$2C,$0A,$20,$20,$20,$30
        .BYTE $31,$3A,$22,$36,$2A,$2B,$0A,$20
        .BYTE $20,$20,$32,$25,$3B,$25,$37,$25
        .BYTE $2C,$0A,$20,$20,$20,$24,$25,$27
        .BYTE $28,$29,$25,$26,$0D,$AC,$20,$20
        .BYTE $24,$25,$25,$25,$25,$25,$26,$20
        .BYTE $20,$AC,$0D,$AD,$20,$20,$24,$25
        .BYTE $25,$25,$25,$25,$26,$20,$20,$AD
        .BYTE $0D,$AD,$21,$FF,$24,$9D,$CB,$AC
        .BYTE $25,$9D,$26,$22,$23,$AD,$0D,$AD
        .BYTE $24,$CC,$24,$25,$CC,$AD,$25,$25
        .BYTE $26,$25,$26,$AD,$0D,$AD,$27,$5C
        .BYTE $24,$9D,$5C,$AD,$25,$9D,$26,$28
        .BYTE $29,$AD,$0D,$AE,$20,$20,$27,$28
        .BYTE $5C,$AE,$28,$28,$29,$20,$20,$AE
        .BYTE $09,$20,$20,$20,$20,$53,$52,$52
        .BYTE $52,$51,$09,$20,$20,$20,$20,$27
        .BYTE $28,$28,$28,$29,$00
	
enemyMovementStrategyLoPtrArray  ;$C120
        .BYTE $00,<movementStrategy1,<movementStrategy2,<movementStrategy3,<movementStrategy4
        .BYTE <movementStrategy5,<movementStrategy6,<movementStrategy7
        .BYTE <movementStrategy8,<movementStrategy9,<movementStrategy10,<movementStrategy11
        .BYTE <movementStrategy12,<movementStrategy13,<movementStrategy14,<movementStrategy15
        .BYTE <movementStrategy16,<movementStrategy17,<movementStrategy18,<movementStrategy19a
        .BYTE <movementStrategy19,<movementStrategy20,<movementStrategy21,<movementStrategy22
        .BYTE <movementStrategy23,<movementStrategy24,<movementStrategy25,<movementStrategy26
        .BYTE <movementStrategy27,<movementStrategy28,<movementStrategy29,<movementStrategy30
        .BYTE <movementStrategy30a,<movementStrategy31,<movementStrategy32,<movementStrategy33
        .BYTE <movementStrategy34,<movementStrategy35,<movementStrategy36,<movementStrategy37
        .BYTE <movementStrategy38,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
enemyMovementStrategyHiPtrArray  ;$C190
        .BYTE $00,>movementStrategy1,>movementStrategy2,>movementStrategy3,>movementStrategy4
        .BYTE >movementStrategy5,>movementStrategy6,>movementStrategy7
        .BYTE >movementStrategy8,>movementStrategy9,>movementStrategy10,>movementStrategy11
        .BYTE >movementStrategy12,>movementStrategy13,>movementStrategy14,>movementStrategy15
        .BYTE >movementStrategy16,>movementStrategy17,>movementStrategy18,>movementStrategy19a
        .BYTE >movementStrategy19,>movementStrategy20,>movementStrategy21,>movementStrategy22
        .BYTE >movementStrategy23,>movementStrategy24,>movementStrategy25,>movementStrategy26
        .BYTE >movementStrategy27,>movementStrategy28,>movementStrategy29,>movementStrategy30
        .BYTE >movementStrategy30a,>movementStrategy31,>movementStrategy32,>movementStrategy33
        .BYTE >movementStrategy34,>movementStrategy35,>movementStrategy36,>movementStrategy37
        .BYTE >movementStrategy38,$00,$00,$00,$00,$00,$00,$00

        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        ; End of the Surface Data for Current Level

enemyFormationData  ;$C200
enemyFormationData1  ;$C200
        ; The first six bytes select the movement strategy
        ; for the formation from enemyMovementStrategyLoPtrArray.
        .BYTE $01 ; Movement Strategy: Enemy 1
        .BYTE $01 ; Movement Strategy: Enemy 2
        .BYTE $01 ; Movement Strategy: Enemy 3
        .BYTE $01 ; Movement Strategy: Enemy 4
        .BYTE $01 ; Movement Strategy: Enemy 5
        .BYTE $00 ; Movement Strategy: Enemy 6
        ; The next six bytes select the inital Y position for
        ; each enemy.
        .BYTE $9C ; Initial Y Position : Enemy 1
        .BYTE $6C ; Initial Y Position : Enemy 2
        .BYTE $B4 ; Initial Y Position : Enemy 3
        .BYTE $84 ; Initial Y Position : Enemy 4
        .BYTE $CC ; Initial Y Position : Enemy 5
        .BYTE $00 ; Initial Y Position : Enemy 6
        ; THe delay before adding the next enemy, think of it as
        ; the spacing between enemies as they enter the screen.
        .BYTE $05 ; Delay between spawning enemies.
        .BYTE $00 ; Initial X Position of Enemy 1
        ; The last byte is the sprite to be used for the enemies.
        .BYTE $09 ; Sprite Value for Enemies
        .BYTE $00 ; End Sentinel
enemyFormationData2  ;$C210
        .BYTE $02  ; Movement Strategy: Enemy 1
        .BYTE $02  ; Movement Strategy: Enemy 2
        .BYTE $02  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $09  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0E  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData3  ;$C220
        .BYTE $0B  ; Movement Strategy: Enemy 1
        .BYTE $0B  ; Movement Strategy: Enemy 2
        .BYTE $0B  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $CC  ; Initial Y Position : Enemy 1
        .BYTE $CC  ; Initial Y Position : Enemy 2
        .BYTE $CC  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData4  ;$C230
        .BYTE $03  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $05  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $03  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData5  ;$C240
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $04  ; Movement Strategy: Enemy 2
        .BYTE $06  ; Movement Strategy: Enemy 3
        .BYTE $03  ; Movement Strategy: Enemy 4
        .BYTE $05  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $01  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData6  ;$C250
        .BYTE $05  ; Movement Strategy: Enemy 1
        .BYTE $06  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $04  ; Movement Strategy: Enemy 4
        .BYTE $03  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $05  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $04  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData7  ;$C260
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $01  ; Movement Strategy: Enemy 4
        .BYTE $01  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $CC  ; Initial Y Position : Enemy 4
        .BYTE $84  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $05  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $00  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData8  ;$C270
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $04  ; Movement Strategy: Enemy 2
        .BYTE $06  ; Movement Strategy: Enemy 3
        .BYTE $03  ; Movement Strategy: Enemy 4
        .BYTE $05  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0D  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData9  ;$C280
        .BYTE $0C  ; Movement Strategy: Enemy 1
        .BYTE $08  ; Movement Strategy: Enemy 2
        .BYTE $0A  ; Movement Strategy: Enemy 3
        .BYTE $07  ; Movement Strategy: Enemy 4
        .BYTE $09  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $05  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData10  ;$C290
        .BYTE $0D  ; Movement Strategy: Enemy 1
        .BYTE $0D  ; Movement Strategy: Enemy 2
        .BYTE $0D  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData11  ;$C2A0
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $0F  ; Movement Strategy: Enemy 2
        .BYTE $11  ; Movement Strategy: Enemy 3
        .BYTE $0E  ; Movement Strategy: Enemy 4
        .BYTE $10  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $03  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData12  ;$C2B0
        .BYTE $10  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0E  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0B  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData13  ;$C2C0
        .BYTE $05  ; Movement Strategy: Enemy 1
        .BYTE $06  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $04  ; Movement Strategy: Enemy 4
        .BYTE $03  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0C  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData14  ;$C2D0
        .BYTE $0F  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $B4  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $0A  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData15  ;$C2E0
        .BYTE $13  ; Movement Strategy: Enemy 1
        .BYTE $00  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $00  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $07  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData16  ;$C2F0
        .BYTE $12  ; Movement Strategy: Enemy 1
        .BYTE $12  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $B4  ; Initial Y Position : Enemy 1
        .BYTE $CC  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData17  ;$C300
        .BYTE $13  ; Movement Strategy: Enemy 1
        .BYTE $13  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $09  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $06  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData18  ;$C310
        .BYTE $11  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0F  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $0C  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0A  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData19  ;$C320
        .BYTE $26  ; Movement Strategy: Enemy 1
        .BYTE $27  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $00  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0A  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData20  ;$C330
        .BYTE $26  ; Movement Strategy: Enemy 1
        .BYTE $27  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $00  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $06  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData21  ;$C340
        .BYTE $26  ; Movement Strategy: Enemy 1
        .BYTE $27  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $00  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $07  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData22  ;$C350
        .BYTE $26  ; Movement Strategy: Enemy 1
        .BYTE $27  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $00  ; Initial Y Position : Enemy 1
        .BYTE $00  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $04  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData23  ;$C360
        .BYTE $14  ; Movement Strategy: Enemy 1
        .BYTE $00  ; Movement Strategy: Enemy 2
        .BYTE $00  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $00  ; Initial Y Position : Enemy 2
        .BYTE $00  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $0F  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData24  ;$C370
        .BYTE $11  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0F  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $0A  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0F  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData25  ;$C380
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $0F  ; Movement Strategy: Enemy 2
        .BYTE $11  ; Movement Strategy: Enemy 3
        .BYTE $0E  ; Movement Strategy: Enemy 4
        .BYTE $10  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $02  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData26  ;$C390
        .BYTE $12  ; Movement Strategy: Enemy 1
        .BYTE $12  ; Movement Strategy: Enemy 2
        .BYTE $12  ; Movement Strategy: Enemy 3
        .BYTE $12  ; Movement Strategy: Enemy 4
        .BYTE $12  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $CC  ; Initial Y Position : Enemy 1
        .BYTE $CC  ; Initial Y Position : Enemy 2
        .BYTE $CC  ; Initial Y Position : Enemy 3
        .BYTE $CC  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $05  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData27  ;$C3A0
        .BYTE $15  ; Movement Strategy: Enemy 1
        .BYTE $15  ; Movement Strategy: Enemy 2
        .BYTE $15  ; Movement Strategy: Enemy 3
        .BYTE $15  ; Movement Strategy: Enemy 4
        .BYTE $15  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $6C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $84  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $0C  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $09  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData28  ;$C3B0
        .BYTE $16  ; Movement Strategy: Enemy 1
        .BYTE $12  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $CC  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData29  ;$C3C0
        .BYTE $16  ; Movement Strategy: Enemy 1
        .BYTE $12  ; Movement Strategy: Enemy 2
        .BYTE $16  ; Movement Strategy: Enemy 3
        .BYTE $12  ; Movement Strategy: Enemy 4
        .BYTE $16  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $84  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $84  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData30  ;$C3D0
        .BYTE $09  ; Movement Strategy: Enemy 1
        .BYTE $0A  ; Movement Strategy: Enemy 2
        .BYTE $0C  ; Movement Strategy: Enemy 3
        .BYTE $08  ; Movement Strategy: Enemy 4
        .BYTE $07  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $05  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData31  ;$C3E0
        .BYTE $17  ; Movement Strategy: Enemy 1
        .BYTE $19  ; Movement Strategy: Enemy 2
        .BYTE $17  ; Movement Strategy: Enemy 3
        .BYTE $1B  ; Movement Strategy: Enemy 4
        .BYTE $17  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0B  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData32  ;$C3F0
        .BYTE $19  ; Movement Strategy: Enemy 1
        .BYTE $18  ; Movement Strategy: Enemy 2
        .BYTE $17  ; Movement Strategy: Enemy 3
        .BYTE $1A  ; Movement Strategy: Enemy 4
        .BYTE $1B  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $08  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $09  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData33  ;$C400
        .BYTE $02  ; Movement Strategy: Enemy 1
        .BYTE $1C  ; Movement Strategy: Enemy 2
        .BYTE $02  ; Movement Strategy: Enemy 3
        .BYTE $1C  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0E  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData34  ;$C410
        .BYTE $02  ; Movement Strategy: Enemy 1
        .BYTE $02  ; Movement Strategy: Enemy 2
        .BYTE $1C  ; Movement Strategy: Enemy 3
        .BYTE $1C  ; Movement Strategy: Enemy 4
        .BYTE $17  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0E  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData35  ;$C420
        .BYTE $1D  ; Movement Strategy: Enemy 1
        .BYTE $1E  ; Movement Strategy: Enemy 2
        .BYTE $1F  ; Movement Strategy: Enemy 3
        .BYTE $21  ; Movement Strategy: Enemy 4
        .BYTE $20  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData36  ;$C430
        .BYTE $02  ; Movement Strategy: Enemy 1
        .BYTE $1C  ; Movement Strategy: Enemy 2
        .BYTE $02  ; Movement Strategy: Enemy 3
        .BYTE $1C  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $00  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData37  ;$C440
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $04  ; Movement Strategy: Enemy 2
        .BYTE $06  ; Movement Strategy: Enemy 3
        .BYTE $03  ; Movement Strategy: Enemy 4
        .BYTE $05  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $02  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData38  ;$C450
        .BYTE $05  ; Movement Strategy: Enemy 1
        .BYTE $06  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $04  ; Movement Strategy: Enemy 4
        .BYTE $03  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0D  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData39  ;$C460
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $22  ; Movement Strategy: Enemy 2
        .BYTE $22  ; Movement Strategy: Enemy 3
        .BYTE $23  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $01  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData40  ;$C470
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $04  ; Movement Strategy: Enemy 2
        .BYTE $06  ; Movement Strategy: Enemy 3
        .BYTE $03  ; Movement Strategy: Enemy 4
        .BYTE $05  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0C  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData41  ;$C480
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $22  ; Movement Strategy: Enemy 2
        .BYTE $22  ; Movement Strategy: Enemy 3
        .BYTE $23  ; Movement Strategy: Enemy 4
        .BYTE $23  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $6C  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $02  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData42  ;$C490
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $22  ; Movement Strategy: Enemy 4
        .BYTE $23  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $00  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData43  ;$C4A0
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $22  ; Movement Strategy: Enemy 3
        .BYTE $23  ; Movement Strategy: Enemy 4
        .BYTE $23  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $84  ; Initial Y Position : Enemy 4
        .BYTE $B4  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0C  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData44  ;$C4B0
        .BYTE $10  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0E  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $05  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $06  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData45  ;$C4C0
        .BYTE $02  ; Movement Strategy: Enemy 1
        .BYTE $1C  ; Movement Strategy: Enemy 2
        .BYTE $17  ; Movement Strategy: Enemy 3
        .BYTE $02  ; Movement Strategy: Enemy 4
        .BYTE $1C  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $B4  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $84  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $06  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData46  ;$C4D0
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $04  ; Movement Strategy: Enemy 2
        .BYTE $06  ; Movement Strategy: Enemy 3
        .BYTE $03  ; Movement Strategy: Enemy 4
        .BYTE $05  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $9C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $06  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $07  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData47  ;$C4E0
        .BYTE $10  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0E  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0D  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData48  ;$C4F0
        .BYTE $03  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $05  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0F  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData49  ;$C500
        .BYTE $05  ; Movement Strategy: Enemy 1
        .BYTE $06  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $04  ; Movement Strategy: Enemy 4
        .BYTE $03  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $0B  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData50  ;$C510
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $02  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $1C  ; Movement Strategy: Enemy 4
        .BYTE $01  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $04  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData51  ;$C520
        .BYTE $0A  ; Movement Strategy: Enemy 1
        .BYTE $0C  ; Movement Strategy: Enemy 2
        .BYTE $08  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $00  ; Initial X Position of Enemy 1
        .BYTE $05  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData52  ;$C530
        .BYTE $05  ; Movement Strategy: Enemy 1
        .BYTE $06  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $04  ; Movement Strategy: Enemy 4
        .BYTE $03  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $01  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData53  ;$C540
        .BYTE $16  ; Movement Strategy: Enemy 1
        .BYTE $16  ; Movement Strategy: Enemy 2
        .BYTE $16  ; Movement Strategy: Enemy 3
        .BYTE $16  ; Movement Strategy: Enemy 4
        .BYTE $16  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $6C  ; Initial Y Position : Enemy 2
        .BYTE $6C  ; Initial Y Position : Enemy 3
        .BYTE $6C  ; Initial Y Position : Enemy 4
        .BYTE $6C  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $05  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $08  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData54  ;$C550
        .BYTE $06  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $04  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $07  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData55  ;$C560
        .BYTE $06  ; Movement Strategy: Enemy 1
        .BYTE $01  ; Movement Strategy: Enemy 2
        .BYTE $04  ; Movement Strategy: Enemy 3
        .BYTE $00  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $84  ; Initial Y Position : Enemy 1
        .BYTE $9C  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $00  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $06  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData56  ;$C570
        .BYTE $10  ; Movement Strategy: Enemy 1
        .BYTE $11  ; Movement Strategy: Enemy 2
        .BYTE $01  ; Movement Strategy: Enemy 3
        .BYTE $0F  ; Movement Strategy: Enemy 4
        .BYTE $0E  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $6C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $9C  ; Initial Y Position : Enemy 3
        .BYTE $B4  ; Initial Y Position : Enemy 4
        .BYTE $CC  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $07  ; Delay between spawning enemies.
        .BYTE $80  ; Initial X Position of Enemy 1
        .BYTE $03  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel
enemyFormationData57  ;$C580
        .BYTE $01  ; Movement Strategy: Enemy 1
        .BYTE $22  ; Movement Strategy: Enemy 2
        .BYTE $22  ; Movement Strategy: Enemy 3
        .BYTE $28  ; Movement Strategy: Enemy 4
        .BYTE $00  ; Movement Strategy: Enemy 5
        .BYTE $00  ; Movement Strategy: Enemy 6
        .BYTE $9C  ; Initial Y Position : Enemy 1
        .BYTE $84  ; Initial Y Position : Enemy 2
        .BYTE $B4  ; Initial Y Position : Enemy 3
        .BYTE $9C  ; Initial Y Position : Enemy 4
        .BYTE $00  ; Initial Y Position : Enemy 5
        .BYTE $00  ; Initial Y Position : Enemy 6
        .BYTE $00  ; Delay between spawning enemies.
        .BYTE $FF  ; Initial X Position of Enemy 1
        .BYTE $0A  ; Sprite Value for Enemies
        .BYTE $00  ; End Sentinel

level1EnemyFormationOrder  ;$C590
        .BYTE $00,$19,$04,$0C,$01,$29,$02,$00
        .BYTE $FF
level2EnemyFormationOrder  ;$C599
        .BYTE $0C,$2F,$22,$08,$1E,$20,$02,$0C
        .BYTE $FF
level3EnemyFormationOrder  ;$C5A2
        .BYTE $21,$06,$1F,$1C,$25,$0F,$31,$26
        .BYTE $21,$FF
level4EnemyFormationOrder  ;$C5AC
        .BYTE $1D,$07,$1A,$0A,$34,$0B,$0D,$31
        .BYTE $1D,$FF
level5EnemyFormationOrder  ;$C5B6
        .BYTE $04,$0E,$2A,$1C,$37,$32,$23,$17
        .BYTE $2E,$04,$FF
level6EnemyFormationOrder  ;$C5C1
        .BYTE $29,$1E,$0D,$2C,$0F,$1F,$2D,$2F
        .BYTE $0A,$29,$FF
level7EnemyFormationOrder  ;$C5CC
        .BYTE $0B,$05,$1C,$0C,$16,$2E,$36,$11
        .BYTE $02,$0A,$0B,$FF
level8EnemyFormationOrder  ;$C5D8
        .BYTE $07,$19,$03,$17,$24,$1D,$02,$21
        .BYTE $0E,$0D,$07,$FF
level9EnemyFormationOrder  ;$C5E4
        .BYTE $18,$09,$11,$30,$0A,$35,$0D,$26
        .BYTE $2B,$23,$17,$18,$FF
level10EnemyFormationOrder  ;$C5F1
        .BYTE $2F,$1B,$11,$25,$2A,$33,$31
        .BYTE $08,$1C,$10,$06,$2F,$FF
level11EnemyFormationOrder  ;$C5FE
        .BYTE $05,$16,$35,$27,$0D,$22,$0A,$00
        .BYTE $36,$1D,$2F,$19,$05,$FF
level12EnemyFormationOrder  ;$C60C
        .BYTE $37,$1C,$08,$1E,$2F,$2C,$28,$20
        .BYTE $34,$16,$2D,$1F,$37,$FF
level13EnemyFormationOrder  ;$C61A
        .BYTE $35,$18,$33,$09,$0B,$2A,$00,$0E
        .BYTE $31,$16,$2C,$29,$37,$35,$FF
level14EnemyFormationOrder  ;$C629
        .BYTE $36,$2E,$0D,$16,$1B,$1A,$1D,$04
        .BYTE $20,$28,$30,$27,$03,$36,$FF
level15EnemyFormationOrder  ;$C638
        .BYTE $38,$19,$34,$31,$20,$06,$18,$32
        .BYTE $30,$16,$16,$1F,$0C,$35,$38,$FF

; Each movement strategy consists of units made up
; of two bytes. The first byte contains information
; about the movement to perform. The second byte dictates
; how many times the movement should be performed before moving
; to the next unit. Each movement strategy is terminated by a 
; byte pair  made up of a $00 and $FF.
movementStrategy1  ;$C648
        .BYTE $82 ; Movement Strategy: Move forward.
        .BYTE $08 ; Perform for 8 ticks.
        .BYTE $00, $FF ; Terminal Sentinel
movementStrategy2  ;$C64C
        .BYTE $82 ; Move forward.
        .BYTE $08 ; Repeat for 8 ticks.
        .BYTE $80 ; Fire bullet.
        .BYTE $10 ; Repeat for 16 ticks.
        .BYTE $84 ; Move down 
        .BYTE $08 ; 8 ticks.
        .BYTE $80 ; Fire bullet.
        .BYTE $10 ; 16 ticks.
        .BYTE $88 ; Move up
        .BYTE $10 ; 16 ticks.
        .BYTE $80 ; Fire bullet.
        .BYTE $10 ; 16 ticks.
        .BYTE $84 ; Move down
        .BYTE $08 ; 8 ticks.
        .BYTE $82 ; Move forward.
        .BYTE $08 ; 8 ticks.
        .BYTE $00,$FF ; Terminal sentinel.
movementStrategy3  ;$C65E
        .BYTE $82,$08,$80,$10,$88,$06,$80,$08
        .BYTE $84,$06,$00,$FF
movementStrategy4  ;$C66A
        .BYTE $82,$08,$80,$10,$88,$06
        .BYTE $80,$0C,$84,$06,$00,$FF
movementStrategy5  ;$C676
        .BYTE $82,$08,$80,$10,$84,$06,$80,$08
        .BYTE $88,$06,$00,$FF
movementStrategy6  ;$C682
        .BYTE $82,$08,$80,$10,$84,$06,$80,$0C
        .BYTE $88,$06,$00,$FF
movementStrategy7  ;$C68E
        .BYTE $82,$08,$80,$10,$20,$89,$06,$80
        .BYTE $06,$20,$82,$08,$00,$FF
movementStrategy8  ;$C69C
        .BYTE $82,$08,$80,$10,$20,$89,$08,$80
        .BYTE $06,$20,$82,$08,$00,$FF
movementStrategy9  ;$C6AA
        .BYTE $82,$08,$80,$10,$20,$85
        .BYTE $06,$80,$06,$20,$82,$08,$00,$FF
movementStrategy10  ;$C6B8
        .BYTE $82,$08,$80,$10,$20,$85,$08,$80
        .BYTE $06,$20,$82,$08,$00,$FF
movementStrategy11  ;$C6C6
        .BYTE $82,$08,$80,$28,$89,$0A,$85,$0A
        .BYTE $86,$0A,$8A,$0A,$80,$28,$89,$0A
        .BYTE $85,$0A,$86,$0A,$8A,$0A,$00,$FF
movementStrategy12  ;$C6DE
        .BYTE $82,$08,$80,$10,$20,$81,$07,$80
        .BYTE $08,$20,$82,$08,$00,$FF
movementStrategy13  ;$C6EC
        .BYTE $82,$08,$80,$28,$85,$0A,$89,$0A
        .BYTE $8A,$0A,$86,$0A,$80,$28,$85,$0A
        .BYTE $89,$0A,$8A,$0A,$86,$0A,$00,$FF
movementStrategy14  ;$C704
        .BYTE $82,$08,$80,$10,$88,$06,$80,$08
        .BYTE $84,$06,$80,$40,$84,$06,$80,$03
        .BYTE $88,$06,$00,$FF
movementStrategy15  ;$C718
        .BYTE $82,$08,$80,$10,$88,$06,$80,$0C
        .BYTE $84,$06,$80,$40,$84,$06,$80,$06
        .BYTE $88,$06,$00,$FF
movementStrategy16  ;$C72C
        .BYTE $82,$08,$80,$10,$84,$06,$80,$08
        .BYTE $88,$06,$80,$40,$88,$06,$80,$03
        .BYTE $84,$06,$00,$FF
movementStrategy17  ;$C740
        .BYTE $82,$08,$80,$10,$84,$06,$80,$0C
        .BYTE $88,$06,$80,$40,$88,$06,$80,$06
        .BYTE $84,$06,$00,$FF
movementStrategy18  ;$C754
        .BYTE $82,$08,$80,$28,$89,$0A,$85,$0A
        .BYTE $86,$0A,$8A,$0A,$80,$14,$88,$06
        .BYTE $80,$0C,$84,$06,$80,$14,$85,$0A
        .BYTE $89,$0A,$8A,$0A,$86,$0A,$00,$FF
movementStrategy19a  ;$C774
        .BYTE $82,$06,$40,$FF
movementStrategy19  ;$C778
        .BYTE $82,$06,$C0,$28,$81,$06,$20,$80
        .BYTE $28,$10,$80,$14,$82,$06,$40,$FF
movementStrategy20  ;$C788
        .BYTE $82,$08,$80,$14,$81,$08,$20,$80
        .BYTE $3C,$10,$82,$08,$80,$28,$82,$06
        .BYTE $00,$FF
movementStrategy21  ;$C79A
        .BYTE $82,$08,$80,$28,$85,$0A,$89,$0A
        .BYTE $8A,$0A,$86,$0A,$80,$14,$84,$06
        .BYTE $80,$0C,$88,$06,$80,$14,$89,$0A
        .BYTE $85,$0A,$86,$0A,$8A,$0A,$00,$FF
movementStrategy22  ;$C7BA
        .BYTE $82,$08,$80,$50,$82,$04,$00,$FF
movementStrategy23  ;$C7C2
        .BYTE $82,$08,$80,$14,$88,$08,$80,$08
        .BYTE $84,$08,$80,$24,$86,$04,$84,$08
        .BYTE $80,$10,$88,$0C,$00,$FF
movementStrategy24  ;$C7D8
        .BYTE $82,$08,$80,$14,$88,$0A,$80,$0A
        .BYTE $84,$0A,$80,$1E,$86,$04,$84,$06
        .BYTE $80,$0A,$88,$0A,$00,$FF
movementStrategy25  ;$C7EE
        .BYTE $82,$08,$80,$14,$84,$08,$80,$08
        .BYTE $88,$08,$80,$24,$8A,$04,$88,$08
        .BYTE $80,$10,$84,$0C,$00,$FF
movementStrategy26  ;$C804
        .BYTE $82,$08,$80,$14,$84,$0A,$80,$0A
        .BYTE $88,$0A,$80,$1E,$8A,$04,$88,$06
        .BYTE $80,$0A,$84,$0A,$00,$FF
movementStrategy27  ;$C81A
        .BYTE $82,$08,$80,$10,$88,$08,$80,$10
        .BYTE $84,$10,$80,$10,$88,$08,$82,$08
        .BYTE $00,$FF
movementStrategy28  ;$C82C
        .BYTE $82,$08,$80,$1E,$85,$08,$80,$08
        .BYTE $89,$08,$00,$FF
movementStrategy29  ;$C838
        .BYTE $82,$08,$80,$24,$85,$08,$80,$02
        .BYTE $89,$08,$00,$FF
movementStrategy30  ;$C844
        .BYTE $82,$08,$80,$26,$81,$10,$00,$FF
movementStrategy30a  ;$C84C
        .BYTE $82,$08,$80,$1E,$89,$08,$80,$08
        .BYTE $85,$08,$00,$FF
movementStrategy31  ;$C858
        .BYTE $82,$08,$80,$24,$89,$08,$80,$02
        .BYTE $85,$08,$00,$FF
movementStrategy32  ;$C864
        .BYTE $80,$06,$82,$08,$00,$FF
movementStrategy33  ;$C86A
        .BYTE $80,$0C,$82,$08,$00,$FF
movementStrategy34  ;$C870
        .BYTE $80,$12,$82,$08,$00,$FF
movementStrategy35  ;$C876
        .BYTE $82,$08,$80,$50,$40,$FF
movementStrategy36  ;$C87C
        .BYTE $82,$08,$C0,$1E,$10,$C0,$1E,$10
        .BYTE $C0,$14,$10,$81,$08,$20,$82,$0A
        .BYTE $00,$FF
movementStrategy37  ;$C88E
        .BYTE $82,$08,$C0,$1E,$10,$81,$08,$20
        .BYTE $80,$1E,$10,$82,$08,$C0,$28,$10
        .BYTE $40,$FF
movementStrategy38  ;$C8A0
        .BYTE $80,$0C,$82,$08,$80,$1E,$81,$02
        .BYTE $C0,$10,$82,$02,$10,$40,$FF
        .BYTE $00