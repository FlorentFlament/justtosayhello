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

scroll_table
	dc.b $20, $23, $26, $29, $2c, $2f, $32, $34
	dc.b $37, $39, $3b, $3c, $3e, $3f, $3f, $40
	dc.b $40, $40, $3f, $3f, $3e, $3c, $3b, $39
	dc.b $37, $34, $32, $2f, $2c, $29, $26, $23
	dc.b $20, $1d, $1a, $17, $14, $11, $0e, $0c
	dc.b $09, $07, $05, $04, $02, $01, $01, $00
	dc.b $00, $00, $01, $01, $02, $04, $05, $07
	dc.b $09, $0c, $0e, $11, $14, $17, $1a, $1d

palette
	dc.b $68, $4a, $2a, $54, $d4, $c2, $a6, $00

alphabet
	;; @ or NULL
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; A
	dc.b %11111100
	dc.b %00010010
	dc.b %00010001
	dc.b %00010010
	dc.b %11111100
	dc.b %00000000
	;; B
	dc.b %11111111
	dc.b %10001001
	dc.b %10001001
	dc.b %10001110
	dc.b %01110000
	dc.b %00000000
	;; C
	dc.b %01111110
	dc.b %10000001
	dc.b %10000001
	dc.b %10000001
	dc.b %01000010
	dc.b %00000000
	;; D
	dc.b %11111111
	dc.b %10000001
	dc.b %10000001
	dc.b %01000010
	dc.b %00111100
	dc.b %00000000
	;; E
	dc.b %11111111
	dc.b %10001001
	dc.b %10001001
	dc.b %10001001
	dc.b %10000001
	dc.b %00000000
	;; F
	dc.b %11111111
	dc.b %00001001
	dc.b %00001001
	dc.b %00001001
	dc.b %00000001
	dc.b %00000000
	;; G
	dc.b %01111110
	dc.b %10000001
	dc.b %10010001
	dc.b %10010001
	dc.b %01110010
	dc.b %00000000
	;; H
	dc.b %11111111
	dc.b %00001000
	dc.b %00001000
	dc.b %00001000
	dc.b %11111111
	dc.b %00000000
	;; I
	dc.b %10000001
	dc.b %10000001
	dc.b %11111111
	dc.b %10000001
	dc.b %10000001
	dc.b %00000000
	;; J
	dc.b %01100000
	dc.b %10000001
	dc.b %10000001
	dc.b %01111111
	dc.b %00000001
	dc.b %00000000
	;; K
	dc.b %11111111
	dc.b %00001000
	dc.b %00010100
	dc.b %00100010
	dc.b %11000001
	dc.b %00000000
	;; L
	dc.b %11111111
	dc.b %10000000
	dc.b %10000000
	dc.b %10000000
	dc.b %10000000
	dc.b %00000000
	;; M
	dc.b %11111111
	dc.b %00001100
	dc.b %00110000
	dc.b %00001100
	dc.b %11111111
	dc.b %00000000
	;; N
	dc.b %11111111
	dc.b %00000110
	dc.b %00011000
	dc.b %01100000
	dc.b %11111111
	dc.b %00000000
	;; O
	dc.b %00111100
	dc.b %01000010
	dc.b %10000001
	dc.b %01000010
	dc.b %00111100
	dc.b %00000000
	;; P
	dc.b %11111111
	dc.b %00001001
	dc.b %00001001
	dc.b %00001001
	dc.b %00000110
	dc.b %00000000
	;; Q
	dc.b %00111100
	dc.b %01000010
	dc.b %10100001
	dc.b %01000010
	dc.b %10111100
	dc.b %00000000
	;; R
	dc.b %11111111
	dc.b %00011001
	dc.b %00101001
	dc.b %01001001
	dc.b %10000110
	dc.b %00000000
	;; S
	dc.b %01000110
	dc.b %10001001
	dc.b %10001001
	dc.b %10001001
	dc.b %01110010
	dc.b %00000000
	;; T
	dc.b %00000001
	dc.b %00000001
	dc.b %11111111
	dc.b %00000001
	dc.b %00000001
	dc.b %00000000
	;; U
	dc.b %01111111
	dc.b %10000000
	dc.b %10000000
	dc.b %10000000
	dc.b %01111111
	dc.b %00000000
	;; V
	dc.b %00000111
	dc.b %00111000
	dc.b %11000000
	dc.b %00111000
	dc.b %00000111
	dc.b %00000000
	;; W
	dc.b %00111111
	dc.b %11000000
	dc.b %00110000
	dc.b %11000000
	dc.b %00111111
	dc.b %00000000
	;; X
	dc.b %10000001
	dc.b %01100110
	dc.b %00011000
	dc.b %01100110
	dc.b %10000001
	dc.b %00000000
	;; Y
	dc.b %00000011
	dc.b %00001100
	dc.b %11110000
	dc.b %00001100
	dc.b %00000011
	dc.b %00000000
	;; Z
	dc.b %11000001
	dc.b %10100001
	dc.b %10011001
	dc.b %10000101
	dc.b %10000011
	dc.b %00000000
	;; [
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; \
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; ]
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; ^
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; _
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; <space>
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; !
	dc.b %00000000
	dc.b %00000000
	dc.b %10111111
	dc.b %00000111
	dc.b %00000000
	dc.b %00000000
	;; "
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; #
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; $
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; %
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; &
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; '
	dc.b %00000000
	dc.b %00000100
	dc.b %00000011
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; (
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; )
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; *
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; +
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; ,
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; -
	dc.b %00000000
	dc.b %00000000
	dc.b %00010000
	dc.b %00010000
	dc.b %00000000
	dc.b %00000000
	;; .
	dc.b %00000000
	dc.b %00000000
	dc.b %11000000
	dc.b %11000000
	dc.b %00000000
	dc.b %00000000
	;; /
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; 0
	dc.b %01111110
	dc.b %11100001
	dc.b %10011001
	dc.b %10000111
	dc.b %01111110
	dc.b %00000000
	;; 1
	dc.b %00000000
	dc.b %00000100
	dc.b %10000010
	dc.b %11111111
	dc.b %10000000
	dc.b %00000000
	;; 2
	dc.b %11000110
	dc.b %10100001
	dc.b %10010001
	dc.b %10001001
	dc.b %10000110
	dc.b %00000000
	;; 3
	dc.b %10000001
	dc.b %10001001
	dc.b %10001001
	dc.b %10001001
	dc.b %01110110
	dc.b %00000000
	;; 4
	dc.b %01100000
	dc.b %01011000
	dc.b %01000110
	dc.b %11100001
	dc.b %01000000
	dc.b %00000000
	;; 5
	dc.b %01001111
	dc.b %10001001
	dc.b %10001001
	dc.b %10001001
	dc.b %01110001
	dc.b %00000000
	;; 6
	dc.b %01111100
	dc.b %10010010
	dc.b %10010001
	dc.b %10010001
	dc.b %01100000
	dc.b %00000000
	;; 7
	dc.b %00000001
	dc.b %11000001
	dc.b %00110001
	dc.b %00001101
	dc.b %00000011
	dc.b %00000000
	;; 8
	dc.b %01110110
	dc.b %10001001
	dc.b %10001001
	dc.b %10001001
	dc.b %01110110
	dc.b %00000000
	;; 9
	dc.b %00000110
	dc.b %10001001
	dc.b %01001001
	dc.b %00101001
	dc.b %00011110
	dc.b %00000000
	;; :
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; ;
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; <
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; =
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; >
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	;; ?
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000

sprites_l
	dc.b $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55
	dc.b $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55
sprites_r
	dc.b $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55
	dc.b $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55, $aa, $55
sprites_c
	dc.b $68, $68, $68, $4a, $4a, $4a, $2a, $2a, $2a, $54, $54, $54
	dc.b $d4, $d4, $d4, $c2, $c2, $c2, $a6, $a6, $a6, $00, $00, $00
	
scroll_text
	dc.b "  JUST TO SAY HELLO... "
	dc.b "UNFORTUNATELY WE WERE NOT ABLE TO JOIN YOU THIS YEAR... "
	dc.b "AND WE KNOW WE ARE MISSING A MASSIVE AMAZING 2019 EDITION... "
	dc.b "BUT... YOU KNOW... SOMETIMES LAZINESS IS SO HUUUUGE... "
	dc.b "SHAME ON US... WE WILL DO BETTER NEXT TIME... "
	dc.b "BUT WE WANTED TO SAY HELLO AT LEAST... "
	dc.b "HAVE LOTTA FUN DUDES AND NA ZDROWIE !!! "
	dc.b "OUR LOVE GOES TO... "
	dc.b "MYSTIC BYTES - DENTIFRICE - OCEO - GENESIS PROJECT - ALTAIR - ZBORALKSI - "
	dc.b "COOKIES - LABORATOIRE PROUT - POPSY TEAM - RBBS - SECTOR ONE - TENFOUR - "
	dc.b "SWYNG - UNDEAD SCENERS - UP ROUGH - X-MEN .. "
	dc.b "AND YOU ..       ~"
