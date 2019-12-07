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

sprites_up:
	dc.w sprite_papal_l
	dc.w sprite_papal_r
	dc.w sprite_papal_c
	dc.w sprite_vp1_l
	dc.w sprite_vp1_r
	dc.w sprite_vp1_c
	dc.w $00, $00
	
sprites_down:
	dc.w sprite_atari_l
	dc.w sprite_atari_r
	dc.w sprite_atari_c
	dc.w $00, $00
	
sprite_papal_l:
	dc.b $ff, $fe, $fe, $fe, $fe, $78, $78, $3e
	dc.b $3e, $1f, $07, $0e, $0d, $0f, $09, $0f
	dc.b $0f, $1e, $1e, $1e, $1e, $1e, $0e, $07
sprite_papal_r:
	dc.b $ff, $7f, $7f, $7f, $7f, $1e, $1e, $7c
	dc.b $7c, $f8, $e0, $70, $b0, $f0, $90, $f0
	dc.b $f0, $78, $78, $78, $78, $78, $70, $e0
sprite_papal_c:
	dc.b $0a, $0e, $0e, $0e, $0e, $0e, $0e, $0e
	dc.b $0e, $0a, $2a, $2a, $2a, $2a, $2a, $2a
	dc.b $0a, $0e, $0e, $0e, $0e, $0e, $0e, $0e

sprite_atari_l:
	dc.b $aa, $aa, $eb, $aa, $49, $1c, $00, $ff
	dc.b $00, $00, $e1, $f1, $f1, $39, $1d, $0d
	dc.b $05, $05, $05, $05, $05, $05, $05, $05
sprite_atari_r:
	dc.b $aa, $aa, $b2, $aa, $30, $02, $00, $ff
	dc.b $00, $00, $87, $8f, $8f, $9c, $b8, $b0
	dc.b $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0
sprite_atari_c:
	dc.b $ca, $ca, $ca, $ca, $ca, $ca, $ca, $9a
	dc.b $ca, $ca, $ca, $ca, $ca, $ca, $ca, $ca
	dc.b $ca, $ca, $ca, $ca, $ca, $ca, $ca, $ca

sprite_vp1_l:
	dc.b $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	dc.b $ff, $7f, $3f, $1f, $07, $0d, $0c, $0f
	dc.b $09, $0f, $3f, $7f, $0f, $07, $07, $03
sprite_vp1_r:
	dc.b $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	dc.b $ff, $fe, $fc, $f8, $e0, $b0, $30, $f0
	dc.b $90, $f8, $fe, $ff, $f0, $e0, $e0, $80
sprite_vp1_c:
	dc.b $b4, $b4, $b4, $b4, $b8, $b8, $b8, $b8
	dc.b $62, $66, $64, $66, $2a, $2a, $2a, $2a
	dc.b $2a, $28, $28, $28, $44, $28, $28, $28


sprites_d:
	dc.b $68, $68, $68, $4a, $4a, $4a, $2a, $2a, $2a, $54, $54, $54
	dc.b $d4, $d4, $d4, $c2, $c2, $c2, $a6, $a6, $a6, $68, $68, $68
	
scroll_text
	dc.b "  JUST TO SAY HELLO... "
	dc.b "UNFORTUNATELY WE WERE NOT ABLE TO JOIN YOU THIS YEAR... "
	dc.b "AND WE KNOW WE ARE MISSING A MASSIVE AMAZING 2019 EDITION... "
	dc.b "BUT... YOU KNOW... SOMETIMES LAZINESS IS SO HUUUUGE... "
	dc.b "SHAME ON US... WE WILL DO BETTER NEXT TIME... "
	dc.b "BUT WE WANTED TO SAY HELLO AT LEAST... "
	dc.b "HAVE LOTTA FUN DUDES AND NA ZDROWIE !!! "
	dc.b "OUR LOVE GOES TO... "
	dc.b "MYSTIC BYTES - DENTIFRICE - OCEO - GENESIS PROJECT - ALTAIR - "
	dc.b "COOKIES - LABORATOIRE PROUT - POPSY TEAM - RBBS - W. ZBORALKSI - "
	dc.b "SECTOR ONE - TENFOUR - SWYNG - UNDEAD SCENERS - UP ROUGH - X-MEN... "
	dc.b "AND YOU...       ~"
