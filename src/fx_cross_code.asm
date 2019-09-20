H_LINES = (240-(8*3*8))/2 ; Header lines
K_LINES = 3*8 ; Kernel lines
FB_COLS = 3*8 ; Frame buffer columns count

fxc_col_table:
	dc.w fxc_fb_c0
	dc.w fxc_fb_c1
	dc.w fxc_fb_c2
fxc_mask_to_1:
	dc.b #$80, #$40, #$20, #$10, #$08, #$04, #$02, #$01
fxc_mask_to_0:
	dc.b #$7f, #$bf, #$df, #$ef, #$f7, #$fb, #$fd, #$fe

	; The multipication will act on
	; - fxc_dist2
	; - fxc_scale
	; - fxc_scale2
	; fxc_dist must be stored in A already
	; A will contain the scaled distance
	; Will corrupt Y and A
	MAC m_scale_mul_sub
	sec
	sbc fxc_scale
	bpl .positive
	eor #$ff
	clc
	adc #$01
.positive
	tay
	lda fxc_square,Y
	sta tmp
	lda fxc_dist2
	adc fxc_scale2 ; can't be any carry
	sec
	sbc tmp
	lsr
	ENDM

	; Update fxc_col according to the value stored in fxc_x
	; Must be between 0 and 23
	; Pointer fxc_col will be updated to point towards the good
        ; column
	; Registers A and Y will be corrupted
	MAC m_fxc_update_col
	lda fxc_x ; A is 000xx___
	and #$18 ; A is 000xx000
	lsr
	lsr      ; A is 00000xx0
	tay
	lda fxc_col_table,Y
	sta fxc_col
	lda fxc_col_table+1,Y
	sta fxc_col+1
	ENDM fxc_set_col

	; Update fxc_bit according to the value stored in fxc_x
	; Register A is corrupted
	MAC m_fxc_update_bit
	lda fxc_x
	and #$07
	sta fxc_bit
	ENDM m_fxc_update_bit

	; fxc_col and fxc_bit have been previously set
	; fxc_y contains the line (offset)
	; A and Y are corrupted
	MAC m_fxc_set_fb_to_0
	ldy fxc_bit
	lda fxc_mask_to_0,Y
	ldy fxc_y
	and (fxc_col),Y
	sta (fxc_col),Y
	ENDM m_fxc_set_fb_to_0
	
	MAC m_fxc_set_fb_to_1
	ldy fxc_bit
	lda fxc_mask_to_1,Y
	ldy fxc_y
	ora (fxc_col),Y
	sta (fxc_col),Y
	ENDM m_fxc_set_fb_to_1

	; Handles/Updates:
	; - fxc_y
	; - fxc_x
	; - fxc_x2
	; - fxc_col
	; - fxc_bit
	; As well as the whole framebuffer
	; Corrupts A and Y
	MAC m_fxc_fb_next
	ldy fxc_y
	bne .next_y
	ldy fxc_x
	bne .next_x
	jsr fxc_next_frame

	; Compute X and Y dependant vars
	ldy #(FB_COLS-1)
.next_x
	dey
	sty fxc_x
	m_fxc_update_col
	m_fxc_update_bit
	lda fxc_x
	sec
	sbc fxc_cx
	bpl .positive_x
	eor #$ff
	clc
	adc #$01
.positive_x
	sta fxc_tx
	tay
        lda fxc_square,Y
	sta fxc_tx2
	ldy #(K_LINES)
.next_y
	dey
	sty fxc_y
	tya
	sec
	sbc fxc_cy
	bpl .positive_y
	eor #$ff
	clc
	adc #$01
.positive_y
	tay
        lda fxc_square,Y
	clc
	adc fxc_tx2
	sta fxc_dist2
	tay
	lda fxc_sqrt,Y

	; Now computing scale and offset
	m_scale_mul_sub
	clc
	adc fxc_cnt
	and #$08 ; consider 5th bit
	beq .set_0 ; if bit is zero
	; otherwise
	m_fxc_set_fb_to_1
	jmp .continue
.set_0
	m_fxc_set_fb_to_0
.continue
	ENDM

fxc_next_frame SUBROUTINE
	; Per frame house keeping
	ldy fxc_cnt
	iny
	sty fxc_cnt

	; Compute next scaling factor
	lda fxc_dir
	and #$04
	beq .scale_backward
.scale_forward
	lda fxc_scale
	cmp #$30
	bpl .scale_switch_dir
	inc fxc_scale
	jmp .scale_finalize
.scale_backward
	lda fxc_scale
	cmp #$04
	bmi .scale_switch_dir
	dec fxc_scale
	jmp .scale_finalize
.scale_switch_dir
	lda fxc_dir
	eor #$04
	sta fxc_dir
.scale_finalize
	ldy fxc_scale
	lda fxc_square,Y
	sta fxc_scale2

	; Compute next center x coordinate
	lda fxc_dir
	and #$01
	beq .cx_left
.cx_right
	lda fxc_cx
	cmp #23
	bpl .cx_switch_dir
	inc fxc_cx
	jmp .cx_finalize
.cx_left
	lda fxc_cx
	cmp #1
	bmi .cx_switch_dir
	dec fxc_cx
	jmp .cx_finalize
.cx_switch_dir
	lda fxc_dir
	eor #$01
	sta fxc_dir
.cx_finalize

	ldy fxc_cy
	iny
	tya
	and #$0f
	sta fxc_cy
	rts

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
fx_glitchy_vblank SUBROUTINE
	ldy #K_LINES-1
.next
	lda (frame_cnt),Y
	sta fxc_fb_c0,Y
	lda (tt_cur_note_index_c0),Y
	sta fxc_fb_c1,Y
	lda (tt_envelope_index_c0),Y
	sta fxc_fb_c2,Y
	dey
	bpl .next

	ldy #0
	lda (tt_cur_ins_c0),Y
	ora #$03
	sta COLUP0
	sta COLUP1
	sta COLUPF
	rts

fxc_compute_loop SUBROUTINE
	m_fxc_fb_next
	dex
	bmi .end
	jmp fxc_compute_loop
.end
	rts
	
fx_cross_vblank SUBROUTINE
	ldx #28
	jsr fxc_compute_loop
	rts
	
fx_cross_overscan SUBROUTINE
	ldx #30
	jsr fxc_compute_loop
	rts
	
fx_cross_kernel SUBROUTINE
	ldy #K_LINES-1
.next
	ldx #7
.line
	sta WSYNC
	lda #$00
	sta PF1
	lda fxc_fb_c0,Y
	sta GRP0
	lda fxc_fb_c1,Y
	sta GRP1
	SLEEP 20
	lda fxc_fb_c2,Y
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
