;;; Position of the sprite must be in A
;;; Argument is the sprite to use (0 or 1)
;;; The macro uses A
	MAC SET_SPRITE
	sta WSYNC
	sleep 14

	sec
	; Beware ! this loop must not cross a page !
	echo "[FX position dot Loop]", ({1})d, "start :", *
.rough_loop:
	; The pos_star loop consumes 15 (5*3) pixels
	sbc #$0f	      ; 2 cycles
	bcs .rough_loop ; 3 cycles
	echo "[FX position dot Loop]", ({1})d, "end :", *
	sta RESP{1}

	; A register has value is in [-15 .. -1]
	adc #$07 ; A in [-8 .. 6]
	eor #$ff ; A in [-7 .. 7]
	REPEAT 4
	asl
	REPEND
	sta HMP{1} ; Fine position of missile or sprite

	; Commit position
	sta WSYNC
	sta HMOVE
	;; Don't move sprite anymore
	SLEEP 24		; 24 cumpute cycle to wait before writing to HMP again
	lda #$00
	sta HMP{1}
	ENDM

set_sprite_0 SUBROUTINE
	SET_SPRITE 0
	rts

set_sprite_1 SUBROUTINE
	SET_SPRITE 1
	rts

set_wsprite_up SUBROUTINE
	lda sp_pos_up
	clc
	adc #1
	jsr set_sprite_0
	lda sp_pos_up
	clc
	adc #9
	jsr set_sprite_1
	rts

set_wsprite_down SUBROUTINE
	lda sp_pos_down
	clc
	adc #1
	jsr set_sprite_0
	lda sp_pos_down
	clc
	adc #9
	jsr set_sprite_1
	rts

fx_scrollv2_setup SUBROUTINE
	;;  Non-null settings
	lda #$FF        ; Playfield collor (yellow-ish)
	sta COLUPF

	lda #4
	sta line_cnt

	lda #<alphabet
	sta scr_line_pt
	lda #>alphabet
	sta scr_line_pt+1

	lda #<scroll_text
	sta scr_text_pt
	lda #>scroll_text
	sta scr_text_pt+1

	rts

fx_scrollv2_overscan SUBROUTINE
	inc frame_cnt
	rts

;;; Sprites house keeping
	mac UPDATE_SPRITES
	lda sp_pos_up
	cmp #144
	bne .finalize
	lda #$ff
	sta sp_pos_up
.finalize
	inc sp_pos_up
	jsr set_wsprite_up
	endm
	
;compute_frame SUBROUTINE
fx_scrollv2_vblank SUBROUTINE
	UPDATE_SPRITES

	lda frame_cnt
	and #$03		; Odd or even ?
	beq .process_line
	rts

.process_line
	ldy #0
	lda (scr_line_pt),Y
	sta cur_line

	ldx #7			; Processing 8 lines
.scroll_line
	;; Getting each bit in the carriage flag
	lsr cur_line
	;; P0: 4 highest bits reverse order
	;; P1: 8 bits normal order
	;; P2: 8 bits reverse order
	ror fb5,X
	rol fb4,X
	ror fb3,X
	;; Skipping 4 least significant bits
	lda fb3,X
	lsr
	lsr
	lsr
	lsr
	ror fb2,X
	rol fb1,X
	ror fb0,X
	dex
	bpl .scroll_line

	;; Preparing next line to display
	lda line_cnt
	bpl .next_line
.next_char
	lda #1
	clc
	adc scr_text_pt
	sta scr_text_pt
	lda #0
	adc scr_text_pt+1
	sta scr_text_pt+1

	ldy #0
	lda (scr_text_pt),Y
	cmp #$7E		; This is ~
	bne .character_graphic
	lda #<scroll_text
	sta scr_text_pt
	lda #>scroll_text
	sta scr_text_pt+1
	lda #$20

.character_graphic
	and #$3F		; Using 6 low bits as index on chars
	asl			; And multiply by 6 (6 lines per char)
	sta tmp
	asl
	clc			; 16 bits addition to alphabet @
	adc #<alphabet
	sta scr_line_pt
	lda #0
	adc #>alphabet
	sta scr_line_pt+1
	lda tmp
	clc
	adc scr_line_pt
	sta scr_line_pt
	lda #0
	adc scr_line_pt+1
	sta scr_line_pt+1

	lda #4
	sta line_cnt
	rts
.next_line
	lda 1
	clc
	adc scr_line_pt
	sta scr_line_pt
	lda #0
	adc scr_line_pt+1
	sta scr_line_pt+1

	dec line_cnt
	rts

;;; Display one line
	mac DRAW_ONE_LINE
	lda #5
	sta tmp
.text_line
	ldy tmp2
	lda palette,Y
	sta COLUPF		; 3

	sta WSYNC		; 3
	;; HBLANK is 68 clocks count i.e 22.66 machine cycles
	;; PF0 displayed between clock 68 and 84
	;; PF1 displayed between clock 84 and 116
	;; PF2 displayed between clock 116 and 148

	;; Background
	;; First left of the screen
	lda fb0 + {1}		; 3
	sta PF0			; 3
	lda fb1 + {1}		; 3
	sta PF1			; 3
	lda fb2 + {1}		; 3
	sta PF2			; 3
	txa
	lsr
	lsr
	nop
	and #$07
	sta tmp2
	;SLEEP 12
	lda fb3 + {1}		; 3
	sta PF0			; 3
	lda fb4 + {1}		; 3
	sta PF1			; 3
	lda fb5 + {1}		; 3
	sta PF2			; 3
	;; 48 cycles = 144 clocks count

	inx
	dec tmp
	bpl .text_line
	endm

;;; Scroller part
	mac FX_SCROLLER
	;; Compute sine offset text
	lda frame_cnt
	lsr
	and #$3F		; 64 modulus
	tay
	ldx scroll_table,Y
	stx cur_offset
.offset
	sta WSYNC
	dex
	bpl .offset

	ldx col_start
LINE_NUM SET 7
	REPEAT 8
	DRAW_ONE_LINE LINE_NUM
LINE_NUM SET LINE_NUM - 1
	REPEND
	endm

;;; Sprite part
;;; Uses X, Y and A
	mac FX_SPRITE
	ldy #47
.sprite_loop
	tya
	lsr
	tax
	sta WSYNC
	lda sprites_l,X
	sta GRP0
	lda sprites_r,X
	sta GRP1
	lda sprites_c,X
	sta COLUP0
	sta COLUP1
	dey
	bpl .sprite_loop
	sta WSYNC

	lda #0
	sta GRP0
	sta GRP1
	sta COLUP0
	sta COLUP1
	endm
	
;display_scroll_frame SUBROUTINE
fx_scrollv2_kernel SUBROUTINE
	;; Vertical padding at the top of the screen
	FX_SPRITE
	
;	ldx #57
;.y_padding
;	sta WSYNC
;	dex
;	bpl .y_padding

	FX_SCROLLER

	; Displaying blank lines until the end
	sta WSYNC
	lda #$0
	sta PF0
	sta PF1
	sta PF2

	;; Set background to black at the end of frame
	lda #$00
	sta COLUBK
	inc col_start
	rts
