; ===========================================================================
; ║                                                                         ║
; ║                             SONIC&K SOUND DRIVER                        ║
; ║                         Modified SMPS Z80 Type 2 DAC                    ║
; ║                                                                         ║
; ===========================================================================
; Disassembled by MarkeyJester
; Routines, pointers and stuff by Linncaki
; Thoroughly commented and improved (including optional bugfixes) by Flamewing
; ===========================================================================
; Permission to use, copy, modify, and/or distribute this software for any
; purpose with or without fee is hereby granted.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
; OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
; ===========================================================================
; Sound Bank
; ===========================================================================
SndBank:			startBank

; ===========================================================================
; SFX Pointers
; ===========================================================================
		Snd_Master_Table
; ---------------------------------------------------------------------------
SEGA_PCM:	binclude "Sound/Sega PCM.pcm"
SEGA_PCM_End
		even

; Normal
Sound_Ring:		    	include "sound/sfx/SndB5 - Ring (Right).asm"
Sound_RingLeft:			include "sound/sfx/SndCE - Ring (Left).asm"
Sound_Jump:		    	include "sound/sfx/SndA0 - Jump.asm"
Sound_Lamppost:			include "sound/sfx/SndA1 - Lamppost.asm"
Sound_UnkA2:			include "sound/sfx/SndA2.asm"
Sound_Death:			include "sound/sfx/SndA3 - Death.asm"
Sound_Skid:		    	include "sound/sfx/SndA4 - Skid.asm"
Sound_UnkA5:			include "sound/sfx/SndA5.asm"
Sound_HitSpikes:		include "sound/sfx/SndA6 - Hit Spikes.asm"
Sound_Push:		    	include "sound/sfx/SndA7 - Push Block.asm"
Sound_SSGoal:			include "sound/sfx/SndA8 - SS Goal.asm"
Sound_SSItem:			include "sound/sfx/SndA9 - SS Item.asm"
Sound_Splash:			include "sound/sfx/SndAA - Splash.asm"
Sound_UnkAB:			include "sound/sfx/SndAB.asm"
Sound_HitBoss:			include "sound/sfx/SndAC - Hit Boss.asm"
Sound_Bubble:			include "sound/sfx/SndAD - Get Bubble.asm"
Sound_Fireball:			include "sound/sfx/SndAE - Fireball.asm"
Sound_Shield:			include "sound/sfx/SndAF - Shield.asm"
Sound_Saw:		    	include "sound/sfx/SndB0 - Saw.asm"
Sound_Electric:			include "sound/sfx/SndB1 - Electric.asm"
Sound_Drown:			include "sound/sfx/SndB2 - Drown Death.asm"
Sound_Flamethrower:		include "sound/sfx/SndB3 - Flamethrower.asm"
Sound_Bumper:			include "sound/sfx/SndB4 - Bumper.asm"
Sound_SpikesMove:		include "sound/sfx/SndB6 - Spikes Move.asm"
Sound_Rumbling:			include "sound/sfx/SndB7 - Rumbling.asm"
Sound_UnkB8:			include "sound/sfx/SndB8.asm"
Sound_Collapse:			include "sound/sfx/SndB9 - Collapse.asm"
Sound_SSGlass:			include "sound/sfx/SndBA - SS Glass.asm"
Sound_Door:		    	include "sound/sfx/SndBB - Door.asm"
Sound_Teleport:			include "sound/sfx/SndBC - Teleport.asm"
Sound_ChainStomp:		include "sound/sfx/SndBD - ChainStomp.asm"
Sound_Roll:		    	include "sound/sfx/SndBE - Roll.asm"
Sound_Continue:			include "sound/sfx/SndBF - Get Continue.asm"
Sound_Basaran:			include "sound/sfx/SndC0 - Basaran Flap.asm"
Sound_BreakItem:		include "sound/sfx/SndC1 - Break Item.asm"
Sound_Warning:			include "sound/sfx/SndC2 - Drown Warning.asm"
Sound_GiantRing:		include "sound/sfx/SndC3 - Giant Ring.asm"
Sound_Bomb:		    	include "sound/sfx/SndC4 - Bomb.asm"
Sound_Cash:			    include "sound/sfx/SndC5 - Cash Register.asm"
Sound_RingLoss:			include "sound/sfx/SndC6 - Ring Loss.asm"
Sound_ChainRise:		include "sound/sfx/SndC7 - Chain Rising.asm"
Sound_Burning:			include "sound/sfx/SndC8 - Burning.asm"
Sound_Bonus:			include "sound/sfx/SndC9 - Hidden Bonus.asm"
Sound_EnterSS:			include "sound/sfx/SndCA - Enter SS.asm"
Sound_WallSmash:		include "sound/sfx/SndCB - Wall Smash.asm"
Sound_Spring:			include "sound/sfx/SndCC - Spring.asm"
Sound_Switch:			include "sound/sfx/SndCD - Switch.asm"
Sound_Signpost:			include "sound/sfx/SndCF - Signpost.asm"
Sound_Spindash:			include "sound/sfx/Snd - Spin Dash.asm"

; Continuous
Sound_Waterfall:		include "Sound/SFX/Continuous/Snd - Waterfall.asm"

	finishBank
; ---------------------------------------------------------------------------
