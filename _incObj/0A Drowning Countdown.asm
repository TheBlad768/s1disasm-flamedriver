; ---------------------------------------------------------------------------
; Object 0A - drowning countdown numbers and small bubbles that float out of
; Sonic's mouth (LZ)
; ---------------------------------------------------------------------------

DrownCount:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Drown_Index(pc,d0.w),d1
		jmp	Drown_Index(pc,d1.w)
; ===========================================================================
Drown_Index:
ptr_Drown_Main:		dc.w Drown_Main-Drown_Index
ptr_Drown_Animate:	dc.w Drown_Animate-Drown_Index
ptr_Drown_ChkWater:	dc.w Drown_ChkWater-Drown_Index
ptr_Drown_Display:	dc.w Drown_Display-Drown_Index
ptr_Drown_Delete:	dc.w Drown_Delete-Drown_Index
ptr_Drown_Countdown:	dc.w Drown_Countdown-Drown_Index
ptr_Drown_AirLeft:	dc.w Drown_AirLeft-Drown_Index
			dc.w Drown_Display-Drown_Index
			dc.w Drown_Delete-Drown_Index

drown_origX = objoff_30		; original x-axis position
drown_time = objoff_38		; time between each number changes

id_Drown_Main = ptr_Drown_Main-Drown_Index		; 0
id_Drown_Animate = ptr_Drown_Animate-Drown_Index		; 2
id_Drown_ChkWater = ptr_Drown_ChkWater-Drown_Index	; 4
id_Drown_Display = ptr_Drown_Display-Drown_Index		; 6
id_Drown_Delete = ptr_Drown_Delete-Drown_Index		; 8
id_Drown_Countdown = ptr_Drown_Countdown-Drown_Index	; $A
id_Drown_AirLeft = ptr_Drown_AirLeft-Drown_Index		; $C
; ===========================================================================

Drown_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bub,obMap(a0)
		move.w	#make_art_tile(ArtTile_LZ_Bubbles,0,1),obGfx(a0)
		move.b	#$84,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	obSubtype(a0),d0 ; get bubble type
		bpl.s	.smallbubble	; branch if $00-$7F

		addq.b	#8,obRoutine(a0) ; goto Drown_Countdown next
		move.l	#Map_Drown,obMap(a0)
		move.w	#make_art_tile(ArtTile_LZ_Sonic_Drowning,0,0),obGfx(a0)
		andi.w	#$7F,d0
		move.b	d0,objoff_33(a0)
		bra.w	Drown_Countdown
; ===========================================================================

.smallbubble:
		move.b	d0,obAnim(a0)
		move.w	obX(a0),drown_origX(a0)
		move.w	#-$88,obVelY(a0)

Drown_Animate:	; Routine 2
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l

Drown_ChkWater:	; Routine 4
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	; has bubble reached the water surface?
		blo.s	.wobble		; if not, branch

		move.b	#id_Drown_Display,obRoutine(a0) ; goto Drown_Display next
		addq.b	#7,obAnim(a0)
		cmpi.b	#$D,obAnim(a0)
		beq.s	Drown_Display
		bra.s	Drown_Display
; ===========================================================================

.wobble:
		tst.b	(f_wtunnelmode).w ; is Sonic in a water tunnel?
		beq.s	.notunnel	; if not, branch
		addq.w	#4,drown_origX(a0)

.notunnel:
		move.b	obAngle(a0),d0
		addq.b	#1,obAngle(a0)
		andi.w	#$7F,d0
		lea	(Drown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	drown_origX(a0),d0
		move.w	d0,obX(a0)
		bsr.s	Drown_ShowNumber
		jsr	(SpeedToPos).l
		tst.b	obRender(a0)
		bpl.s	.delete
		jmp	(DisplaySprite).l

.delete:
		jmp	(DeleteObject).l
; ===========================================================================

Drown_Display:	; Routine 6, Routine $E
		bsr.s	Drown_ShowNumber
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
; ===========================================================================

Drown_Delete:	; Routine 8, Routine $10
		jmp	(DeleteObject).l
; ===========================================================================

Drown_AirLeft:	; Routine $C
		cmpi.w	#$C,(v_air).w	; check air remaining
		bhi.s	Drown_AirLeft_Delete		; if higher than $C, branch
		subq.w	#1,drown_time(a0)
		bne.s	.display
		move.b	#id_Drown_Display+8,obRoutine(a0) ; goto Drown_Display next
		addq.b	#7,obAnim(a0)
		bra.s	Drown_Display
; ===========================================================================

.display:
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l
		tst.b	obRender(a0)
		bpl.s	Drown_AirLeft_Delete
		jmp	(DisplaySprite).l

Drown_AirLeft_Delete:	
		jmp	(DeleteObject).l
; ===========================================================================

Drown_ShowNumber:
		tst.w	drown_time(a0)
		beq.s	.nonumber
		subq.w	#1,drown_time(a0)	; decrement timer
		bne.s	.nonumber	; if time remains, branch
		cmpi.b	#7,obAnim(a0)
		bhs.s	.nonumber

		move.w	#15,drown_time(a0)
		clr.w	obVelY(a0)
		move.b	#$80,obRender(a0)
		move.w	obX(a0),d0
		sub.w	(v_screenposx).w,d0
		addi.w	#$80,d0
		move.w	d0,obX(a0)
		move.w	obY(a0),d0
		sub.w	(v_screenposy).w,d0
		addi.w	#$80,d0
		move.w	d0,obScreenY(a0)
		move.b	#id_Drown_AirLeft,obRoutine(a0) ; goto Drown_AirLeft next

.nonumber:
		rts	
; ===========================================================================
Drown_WobbleData:
		if Revision=0
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		else
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		endif
; ===========================================================================

Drown_Countdown:; Routine $A
		tst.w	objoff_2C(a0)
		bne.w	.loc_13F86
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.w	.nocountdown
		btst	#6,(v_player+obStatus).w ; is Sonic underwater?
		beq.w	.nocountdown	; if not, branch

		subq.w	#1,drown_time(a0)	; decrement timer
		bpl.w	.nochange	; branch if time remains
		move.w	#59,drown_time(a0)
		move.w	#1,objoff_36(a0)
		jsr	(RandomNumber).l
		andi.w	#1,d0
		move.b	d0,objoff_34(a0)
		move.w	(v_air).w,d0	; check air remaining
		cmpi.w	#25,d0
		beq.s	.warnsound	; play sound if	air is 25
		cmpi.w	#20,d0
		beq.s	.warnsound
		cmpi.w	#15,d0
		beq.s	.warnsound
		cmpi.w	#12,d0
		bhi.s	.reduceair	; if air is above 12, branch

		bne.s	.skipmusic	; if air is less than 12, branch
		move.w	#mus_Drowning,d0
		jsr	(PlaySound).l	; play countdown music

.skipmusic:
		subq.b	#1,objoff_32(a0)
		bpl.s	.reduceair
		move.b	objoff_33(a0),objoff_32(a0)
		bset	#7,objoff_36(a0)
		bra.s	.reduceair
; ===========================================================================

.warnsound:
		move.w	#sfx_AirDing,d0
		jsr	(PlaySound_Special).l	; play "ding-ding" warning sound

.reduceair:
		subq.w	#1,(v_air).w	; subtract 1 from air remaining
		bcc.w	.gotomakenum	; if air is above 0, branch

		; Sonic drowns here
		bsr.w	ResumeMusic
		move.b	#$81,(f_playerctrl).w ; lock controls and disable object interaction
		move.w	#sfx_Drown,d0
		jsr	(PlaySound_Special).l	; play drowning sound
		move.b	#$A,objoff_34(a0)
		move.w	#1,objoff_36(a0)
		move.w	#$78,objoff_2C(a0)
		move.l	a0,-(sp)
		lea	(v_player).w,a0
		bsr.w	Sonic_ResetOnFloor
		move.b	#id_Drown,obAnim(a0)	; use Sonic's drowning animation
		bset	#1,obStatus(a0)
		bset	#7,obGfx(a0)
		move.w	#0,obVelY(a0)
		move.w	#0,obVelX(a0)
		move.w	#0,obInertia(a0)
		move.b	#1,(f_nobgscroll).w
		movea.l	(sp)+,a0
		rts	
; ===========================================================================

.loc_13F86:
		subq.w	#1,objoff_2C(a0)
		bne.s	.loc_13F94
		move.b	#6,(v_player+obRoutine).w
		rts	
; ===========================================================================

.loc_13F94:
		move.l	a0,-(sp)
		lea	(v_player).w,a0
		jsr	(SpeedToPos).l
		addi.w	#$10,obVelY(a0)
		movea.l	(sp)+,a0
		bra.s	.nochange
; ===========================================================================

.gotomakenum:
		bra.s	.makenum
; ===========================================================================

.nochange:
		tst.w	objoff_36(a0)
		beq.w	.nocountdown
		subq.w	#1,objoff_3A(a0)
		bpl.w	.nocountdown

.makenum:
		jsr	(RandomNumber).l
		andi.w	#$F,d0
		move.w	d0,objoff_3A(a0)
		jsr	(FindFreeObj).l
		bne.w	.nocountdown
		_move.b	#id_DrownCount,obID(a1) ; load object
		move.w	(v_player+obX).w,obX(a1) ; match X position to Sonic
		moveq	#6,d0
		btst	#0,(v_player+obStatus).w
		beq.s	.noflip
		neg.w	d0
		move.b	#$40,obAngle(a1)

.noflip:
		add.w	d0,obX(a1)
		move.w	(v_player+obY).w,obY(a1)
		move.b	#6,obSubtype(a1)
		tst.w	objoff_2C(a0)
		beq.w	.loc_1403E
		andi.w	#7,objoff_3A(a0)
		addi.w	#0,objoff_3A(a0)
		move.w	(v_player+obY).w,d0
		subi.w	#$C,d0
		move.w	d0,obY(a1)
		jsr	(RandomNumber).l
		move.b	d0,obAngle(a1)
		move.w	(v_framecount).w,d0
		andi.b	#3,d0
		bne.s	.loc_14082
		move.b	#$E,obSubtype(a1)
		bra.s	.loc_14082
; ===========================================================================

.loc_1403E:
		btst	#7,objoff_36(a0)
		beq.s	.loc_14082
		move.w	(v_air).w,d2
		lsr.w	#1,d2
		jsr	(RandomNumber).l
		andi.w	#3,d0
		bne.s	.loc_1406A
		bset	#6,objoff_36(a0)
		bne.s	.loc_14082
		move.b	d2,obSubtype(a1)
		move.w	#$1C,drown_time(a1)

.loc_1406A:
		tst.b	objoff_34(a0)
		bne.s	.loc_14082
		bset	#6,objoff_36(a0)
		bne.s	.loc_14082
		move.b	d2,obSubtype(a1)
		move.w	#$1C,drown_time(a1)

.loc_14082:
		subq.b	#1,objoff_34(a0)
		bpl.s	.nocountdown
		clr.w	objoff_36(a0)

.nocountdown:
		rts	
