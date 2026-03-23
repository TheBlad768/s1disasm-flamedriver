; ---------------------------------------------------------------------------
; Sound commands list
; ---------------------------------------------------------------------------

	phase $E1
bgm__FirstCmd =				*		; ID of the first sound command
bgm_Fade =				*		; $E1 - fade out music
bgm_FadeOut				ds.b 1		; $E1 - fade out music
bgm_Stop				ds.b 1		; $E2 - stop music and sound effects
bgm_MutePSG				ds.b 1		; $E3 - mute all PSG channels
bgm_StopSFX				ds.b 1		; $E4 - stop all sound effects
bgm_FadeOut2				ds.b 1		; $E5 - fade out music (duplicate)
bgm__EndCmd =				*		; next ID after last sound command

bgm_FA =				$FA		; $FA - ???
bgm_StopSEGA =				$FE		; $FE - Stop SEGA sound
bgm_SEGA =				$FF		; $FF - Play SEGA sound

	dephase

; ---------------------------------------------------------------------------
; Music ID's list. These do not affect the sound driver, be careful
; ---------------------------------------------------------------------------

	phase $01
bgm__First =				*		; ID of the first music

; Levels
bgm_GHZ					ds.b 1		; $01
bgm_MZ					ds.b 1		; $02
bgm_SYZ					ds.b 1		; $03
bgm_LZ					ds.b 1		; $04
bgm_SLZ					ds.b 1		; $05
bgm_SBZ					ds.b 1		; $06

; Main
bgm_Invincible				ds.b 1		; $07
bgm_ExtraLife				ds.b 1		; $08
bgm_SS					ds.b 1		; $09
bgm_Title				ds.b 1		; $0A
bgm_Ending				ds.b 1		; $0B

; Bosses
bgm_Boss				ds.b 1		; $0C
bgm_FZ					ds.b 1		; $0D

; End
bgm_GotThrough				ds.b 1		; $0E
bgm_GameOver				ds.b 1		; $0F
bgm_Continue				ds.b 1		; $10
bgm_Credits				ds.b 1		; $11
bgm_Drowning				ds.b 1		; $12
bgm_Emerald				ds.b 1		; $13

bgm__End =				*		; next ID after last music

	dephase

; ---------------------------------------------------------------------------
; Sound effect ID's list. These do not affect the sound driver, be careful
; ---------------------------------------------------------------------------

	phase $01
sfx__First =				*		; ID of the first sound effect

sfx_Ring				ds.b 1		; $01
sfx_RingLeft				ds.b 1		; $02 (warning: You should make sure sfx_RingLeft is immediately after sfx_Ring)
sfx_Jump				ds.b 1		; $03
sfx_Lamppost				ds.b 1		; $04
sfx_A2					ds.b 1		; $05
sfx_Death				ds.b 1		; $06
sfx_Skid				ds.b 1		; $07
sfx_A5					ds.b 1		; $08
sfx_HitSpikes				ds.b 1		; $09
sfx_Push				ds.b 1		; $0A
sfx_SSGoal				ds.b 1		; $0B
sfx_SSItem				ds.b 1		; $0C
sfx_Splash				ds.b 1		; $0D
sfx_AB					ds.b 1		; $0E
sfx_HitBoss				ds.b 1		; $0F
sfx_Bubble				ds.b 1		; $10
sfx_Fireball				ds.b 1		; $11
sfx_Shield				ds.b 1		; $12
sfx_Saw					ds.b 1		; $13
sfx_Electric				ds.b 1		; $14
sfx_Drown				ds.b 1		; $15
sfx_Flamethrower			ds.b 1		; $16
sfx_Bumper				ds.b 1		; $17
sfx_SpikesMove				ds.b 1		; $18
sfx_Rumbling				ds.b 1		; $19
sfx_B8					ds.b 1		; $1A
sfx_Collapse				ds.b 1		; $1B
sfx_SSGlass				ds.b 1		; $1C
sfx_Door				ds.b 1		; $1D
sfx_Teleport				ds.b 1		; $1E
sfx_ChainStomp				ds.b 1		; $1F
sfx_Roll				ds.b 1		; $20
sfx_Continue				ds.b 1		; $21
sfx_Basaran				ds.b 1		; $22
sfx_BreakItem				ds.b 1		; $23
sfx_Warning				ds.b 1		; $24
sfx_GiantRing				ds.b 1		; $25
sfx_Bomb				ds.b 1		; $26
sfx_Cash				ds.b 1		; $27
sfx_RingLoss				ds.b 1		; $28
sfx_ChainRise				ds.b 1		; $29
sfx_Burning				ds.b 1		; $2A
sfx_Bonus				ds.b 1		; $2B
sfx_EnterSS				ds.b 1		; $2C
sfx_WallSmash				ds.b 1		; $2D
sfx_Spring				ds.b 1		; $2E
sfx_Switch				ds.b 1		; $2F
sfx_Signpost				ds.b 1		; $30
sfx_SpinDash				ds.b 1		; $31

; Continuous
sfx__FirstContinuous =			*		; ID of the first continuous sound effect
sfx_Waterfall				ds.b 1		; $01

sfx__End =				*		; next ID after the last sound effect

	dephase
	!org 0						; make sure we reset the ROM position to 0
