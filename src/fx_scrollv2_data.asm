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
	dc.w sprite_vp1_l
	dc.w sprite_vp1_r
	dc.w sprite_vp1_c
	dc.w sprite_vp2_l
	dc.w sprite_vp2_r
	dc.w sprite_vp2_c
	dc.w sprite_vp3_l
	dc.w sprite_vp3_r
	dc.w sprite_vp3_c
	dc.w sprite_vp4_l
	dc.w sprite_vp4_r
	dc.w sprite_vp4_c
	dc.w sprite_vp5_l
	dc.w sprite_vp5_r
	dc.w sprite_vp5_c
	dc.w sprite_vp6_l
	dc.w sprite_vp6_r
	dc.w sprite_vp6_c
	dc.w sprite_papal_l
	dc.w sprite_papal_r
	dc.w sprite_papal_c
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

sprite_vp2_l:
	dc.b $fe, $ff, $cf, $b7, $b7, $b7, $86, $ff
	dc.b $7f, $3f, $1f, $07, $09, $0c, $0f, $09
	dc.b $00, $0f, $1f, $0e, $0f, $06, $03, $01
sprite_vp2_r:
	dc.b $ff, $ff, $f3, $6d, $ed, $ed, $e1, $ff
	dc.b $fe, $7c, $f8, $e0, $90, $30, $f0, $90
	dc.b $00, $f0, $f8, $f0, $70, $e0, $c0, $80
sprite_vp2_c:
	dc.b $98, $98, $98, $98, $98, $98, $98, $98
	dc.b $98, $98, $98, $2a, $2a, $2a, $2a, $2a
	dc.b $2a, $2a, $0e, $0e, $0e, $0e, $0e, $0e

sprite_vp3_l:
	dc.b $ff, $fe, $fe, $ff, $7f, $3e, $1f, $87
	dc.b $ce, $ce, $6f, $6f, $39, $3f, $1f, $1f
	dc.b $3f, $3f, $7d, $6d, $6d, $c9, $18, $19
sprite_vp3_r:
	dc.b $7f, $ff, $ff, $7f, $7e, $fc, $f8, $e3
	dc.b $76, $76, $f6, $f6, $9c, $f8, $f8, $f8
	dc.b $fc, $bc, $b6, $b6, $b7, $b3, $90, $98
sprite_vp3_c:
	dc.b $44, $44, $44, $44, $46, $46, $46, $2a
	dc.b $2a, $2a, $2a, $2a, $2a, $2a, $a8, $a6
	dc.b $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e

sprite_vp4_l:
	dc.b $fe, $ff, $fe, $ff, $fe, $ff, $fe, $ff
	dc.b $7e, $3f, $1e, $05, $0d, $0e, $0f, $09
	dc.b $0f, $3f, $30, $20, $20, $1f, $0f, $07
sprite_vp4_r:
	dc.b $ff, $ff, $ff, $e7, $c3, $db, $db, $c3
	dc.b $fe, $fc, $78, $a0, $b0, $70, $f0, $90
	dc.b $f0, $fc, $0c, $04, $04, $f8, $f0, $e0
sprite_vp4_c:
	dc.b $98, $98, $98, $98, $98, $98, $98, $98
	dc.b $98, $98, $98, $46, $46, $46, $46, $46
	dc.b $46, $0e, $0e, $0e, $0e, $0e, $0e, $0e

sprite_vp5_l:
	dc.b $f7, $f6, $eb, $f7, $f7, $eb, $77, $76
	dc.b $3f, $1f, $03, $01, $09, $08, $0c, $0f
	dc.b $09, $0f, $7f, $3f, $0f, $1e, $3f, $0f
sprite_vp5_r:
	dc.b $ef, $ef, $d7, $ef, $6f, $d7, $ee, $ee
	dc.b $fc, $f8, $c0, $80, $90, $10, $30, $f0
	dc.b $90, $f0, $f0, $f8, $78, $38, $7c, $f0
sprite_vp5_c:
	dc.b $06, $06, $06, $06, $06, $06, $06, $06
	dc.b $06, $06, $2a, $2a, $2a, $2a, $2a, $2a
	dc.b $2a, $2a, $08, $08, $06, $06, $06, $06

sprite_vp6_l:
	dc.b $ff, $ff, $ff, $fe, $fe, $fe, $ff, $ff
	dc.b $ff, $fe, $7e, $3e, $1f, $03, $04, $0d
	dc.b $0e, $0f, $09, $0f, $0f, $1f, $1f, $1f
sprite_vp6_r:
	dc.b $7f, $7f, $7f, $ff, $ff, $f7, $63, $63
	dc.b $77, $ff, $fe, $fc, $f8, $c0, $20, $b0
	dc.b $70, $f0, $90, $f0, $f0, $f0, $e0, $c0
sprite_vp6_c:
	dc.b $36, $36, $38, $36, $36, $38, $36, $36
	dc.b $38, $36, $36, $38, $36, $46, $46, $46
	dc.b $46, $46, $46, $46, $36, $36, $36, $38
	
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
