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
; Music Banks
; ===========================================================================
; Music Bank 1
; ---------------------------------------------------------------------------
Mus_Bank1_Start:	startBank
	Music_Master_Table
MusData_GHZ:			include "sound/music/Mus - GHZ.asm"
MusData_MZ:		    	include "sound/music/Mus - MZ.asm"
MusData_SYZ:			include "sound/music/Mus - SYZ.asm"
MusData_LZ:		    	include "sound/music/Mus - LZ.asm"
MusData_SLZ:			include "sound/music/Mus - SLZ.asm"
MusData_SBZ:			include "sound/music/Mus - SBZ.asm"
MusData_Invincible:		include "sound/music/Mus - Invincibility.asm"
MusData_ExtraLife:		include "sound/music/Mus - Extra Life.asm"
MusData_SS:			    include "sound/music/Mus - Special Stage.asm"
MusData_Title:			include "sound/music/Mus - Title Screen.asm"
MusData_Ending:			include "sound/music/Mus - Ending.asm"
MusData_Boss:			include "sound/music/Mus - Boss.asm"
MusData_FZ:		    	include "sound/music/Mus - FZ.asm"
MusData_GotThrough:		include "sound/music/Mus - Sonic Got Through.asm"
MusData_GameOver:		include "sound/music/Mus - Game Over.asm"
MusData_Continue:		include "sound/music/Mus - Continue Screen.asm"
MusData_Credits:		include "sound/music/Mus - Credits.asm"
MusData_Drowning:		include "sound/music/Mus - Drowning.asm"
MusData_Emerald:		include "sound/music/Mus - Get Emerald.asm"

	finishBank
; ---------------------------------------------------------------------------
