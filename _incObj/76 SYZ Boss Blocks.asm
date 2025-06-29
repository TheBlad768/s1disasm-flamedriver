; ---------------------------------------------------------------------------
; Object 76 - blocks that Eggman picks up (SYZ)
; ---------------------------------------------------------------------------

BossBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	BossBlock_Index(pc,d0.w),d1
		jmp	BossBlock_Index(pc,d1.w)
; ===========================================================================
BossBlock_Index:
		dc.w BossBlock_Main-BossBlock_Index
		dc.w BossBlock_Action-BossBlock_Index
		dc.w loc_19762-BossBlock_Index
; ===========================================================================

BossBlock_Main:	; Routine 0
		moveq	#0,d4
		move.w	#boss_syz_x+$10,d5
		moveq	#9,d6
		lea	(a0),a1
		bra.s	BossBlock_MakeBlock
; ===========================================================================

BossBlock_Loop:
		jsr	(FindFreeObj).l
		bne.s	BossBlock_ExitLoop

BossBlock_MakeBlock:
		move.b	#id_BossBlock,obID(a1)
		move.l	#Map_BossBlock,obMap(a1)
		move.w	#make_art_tile(ArtTile_Level,2,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#$10,obHeight(a1)
		move.b	#3,obPriority(a1)
		move.w	d5,obX(a1)	; set x-position
		move.w	#$582,obY(a1)
		move.w	d4,obSubtype(a1)
		addi.w	#$101,d4
		addi.w	#$20,d5		; add $20 to next x-position
		addq.b	#2,obRoutine(a1)
		dbf	d6,BossBlock_Loop	; repeat sequence 9 more times

BossBlock_ExitLoop:
		rts	
; ===========================================================================

BossBlock_Action:	; Routine 2
		move.b	objoff_29(a0),d0
		cmp.b	obSubtype(a0),d0
		beq.s	BossBlock_Solid
		tst.b	d0
		bmi.s	loc_19718

loc_19712:
		bsr.w	BossBlock_Break
		bra.s	BossBlock_Display
; ===========================================================================

loc_19718:
		movea.l	objoff_34(a0),a1
		tst.b	obColProp(a1)
		beq.s	loc_19712
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w	#$2C,obY(a0)
		cmpa.w	a0,a1
		blo.s	BossBlock_Display
		move.w	obVelY(a1),d0
		ext.l	d0
		asr.l	#8,d0
		add.w	d0,obY(a0)
		bra.s	BossBlock_Display
; ===========================================================================

BossBlock_Solid:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	obX(a0),d4
		jsr	(SolidObject).l

BossBlock_Display:
		jmp	(DisplaySprite).l
; ===========================================================================

loc_19762:	; Routine 4
		tst.b	obRender(a0)
		bpl.s	BossBlock_Delete
		jsr	(ObjectFall).l
		jmp	(DisplaySprite).l
; ===========================================================================

BossBlock_Delete:
		jmp	(DeleteObject).l

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossBlock_Break:
		lea	BossBlock_FragSpeed(pc),a4
		lea	BossBlock_FragPos(pc),a5
		moveq	#1,d4
		moveq	#3,d1
		moveq	#$38,d2
		addq.b	#2,obRoutine(a0)
		move.b	#8,obActWid(a0)
		move.b	#8,obHeight(a0)
		lea	(a0),a1
		bra.s	BossBlock_MakeFrag
; ===========================================================================

BossBlock_LoopFrag:
		jsr	(FindNextFreeObj).l
		bne.s	loc_197D4

BossBlock_MakeFrag:
		lea	(a0),a2
		lea	(a1),a3
		moveq	#3,d3

loc_197AA:
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		dbf	d3,loc_197AA

		move.w	(a4)+,obVelX(a1)
		move.w	(a4)+,obVelY(a1)
		move.w	(a5)+,d3
		add.w	d3,obX(a1)
		move.w	(a5)+,d3
		add.w	d3,obY(a1)
		move.b	d4,obFrame(a1)
		addq.w	#1,d4
		dbf	d1,BossBlock_LoopFrag ; repeat sequence 3 more times

loc_197D4:
		move.w	#sfx_Collapse,d0
		jmp	(PlaySound_Special).l	; play smashing sound
; End of function BossBlock_Break

; ===========================================================================
BossBlock_FragSpeed:
		dc.w -$180, -$200
		dc.w $180, -$200
		dc.w -$100, -$100
		dc.w $100, -$100
BossBlock_FragPos:
		dc.w -8, -8
		dc.w $10, 0
		dc.w 0,	$10
		dc.w $10, $10
