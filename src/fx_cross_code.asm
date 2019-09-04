H_LINES = (240-(6*3*8))/2
K_LINES = 3*8

fx_cross_init SUBROUTINE
	; Ensure PF isn't in mirror mode
	lda #$00
	sta CTRLPF

	; Setting Number and Size of sprites
	lda #$07
	sta NUSIZ0
	sta NUSIZ1
	
	; Setting the color of the sprites and playfield
	lda #$ff
	sta COLUP0
	sta COLUP1
	sta COLUPF
	
	; Clearing all sprites and playfield registers
	lda #$00
	sta GRP0
	sta GRP1
	sta PF0
	sta PF1
	sta PF2

	; Position sprites
	lda #0
	sta HMCLR
	sta WSYNC
	ldx #4
.wait_sp0
	dex
	bpl .wait_sp0
	nop
	sta RESP0
	SLEEP 8
	sta RESP1
	lda #$f0
	sta HMP0
	sta WSYNC
	sta HMOVE

	ldx #5
.wait_hmove
	dex
	bpl .wait_hmove
	rts

; Displays the picture in the frame_buf frame buffer
fx_cross_vblank SUBROUTINE
	ldy #K_LINES-1
.next
	lda (frame_cnt),Y
	sta frame_buf_c0,Y
	lda (frame_cnt+4),Y
	sta frame_buf_c1,Y
	lda (frame_cnt+6),Y
	sta frame_buf_c2,Y
	dey
	bpl .next

	ldy #0
	lda (frame_cnt),Y
	sta COLUP0
	sta COLUP1
	sta COLUPF
	rts
	
fx_cross_kernel SUBROUTINE
	ldy #H_LINES-1
.header_next
	sta WSYNC
	dey
	bpl .header_next

	ldy #K_LINES-1
.next
	ldx #5
.line
	sta WSYNC
	lda #$00
	sta PF1
	lda frame_buf_c0,Y
	sta GRP0
	lda frame_buf_c1,Y
	sta GRP1
	SLEEP 20
	lda frame_buf_c2,Y
	sta PF1
	dex
	bpl .line
	dey
	bpl .next

	sta WSYNC
	lda #00
	sta GRP0
	sta GRP1
	sta PF1
	rts
