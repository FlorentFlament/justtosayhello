	ORG FX_RAM
fxc_cnt		ds 1 ; Counter for FX
fxc_col		ds 2 ; pointer toward to current column
fxc_bit		ds 1 ; current bit in the column (in [0, 7])

fxc_reg_x	ds 1 ; Storage for X value
fxc_reg_x2	ds 1 ; Storage for x square
fxc_reg_y	ds 1 ; Stoarge for Y value

; The FX 24x24 frame buffer
; Split in 3x 8pixels columns
fxc_fb_c0	ds 24
fxc_fb_c1	ds 24
fxc_fb_c2	ds 24
