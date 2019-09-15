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

	; Update fxc_col according to the value stored in fxc_reg_x
	; Must be between 0 and 23
	; Pointer fxc_col will be updated to point towards the good
        ; column
	; Registers A and Y will be corrupted
	MAC m_fxc_update_col
	lda fxc_reg_x ; A is 000xx___
	and #$18 ; A is 000xx000
	lsr
	lsr      ; A is 00000xx0
	tay
	lda fxc_col_table,Y
	sta fxc_col
	lda fxc_col_table+1,Y
	sta fxc_col+1
	ENDM fxc_set_col

	; Update fxc_bit according to the value stored in fxc_reg_x
	; Register A is corrupted
	MAC m_fxc_update_bit
	lda fxc_reg_x
	and #$07
	sta fxc_bit
	ENDM m_fxc_update_bit

	; fxc_col and fxc_bit have been previously set
	; fxc_reg_y contains the line (offset)
	; A and Y are corrupted
	MAC m_fxc_set_fb_to_0
	ldy fxc_bit
	lda fxc_mask_to_0,Y
	ldy fxc_reg_y
	and (fxc_col),Y
	sta (fxc_col),Y
	ENDM m_fxc_set_fb_to_0
	
	MAC m_fxc_set_fb_to_1
	ldy fxc_bit
	lda fxc_mask_to_1,Y
	ldy fxc_reg_y
	ora (fxc_col),Y
	sta (fxc_col),Y
	ENDM m_fxc_set_fb_to_1

	; Handles/Updates:
	; - fxc_reg_y
	; - fxc_reg_x
	; - fxc_reg_x2
	; - fxc_col
	; - fxc_bit
	; As well as the whole framebuffer
	; Corrupts A and Y
	MAC m_fxc_fb_next
	ldy fxc_reg_y
	bne .next_y
	ldy fxc_reg_x
	bne .next_x
	inc fxc_cnt
	ldy #(FB_COLS-1)	
.next_x
	dey
	sty fxc_reg_x
	m_fxc_update_col
	m_fxc_update_bit
	ldy fxc_reg_x
        lda fxc_square,Y
	sta fxc_reg_x2
	ldy #(K_LINES)
.next_y
	dey
	sty fxc_reg_y
        lda fxc_square,Y
	clc
	adc fxc_reg_x2
	tay
	lda fxc_sqrt,Y
	clc
	adc fxc_cnt
	and #$04 ; consider 5th bit
	beq .set_0 ; if bit is zero
	; otherwise
	m_fxc_set_fb_to_1
	jmp .continue
.set_0
	m_fxc_set_fb_to_0
.continue
	ENDM

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
	bpl fxc_compute_loop
	rts
	
fx_cross_vblank SUBROUTINE
	ldx #56
	jsr fxc_compute_loop
	rts
	
fx_cross_overscan SUBROUTINE
	ldx #65
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
