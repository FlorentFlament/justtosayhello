	ORG FX_RAM
fxc_cnt		ds 1 ; Counter for FX
fxc_col		ds 2 ; pointer toward to current column
fxc_bit		ds 1 ; current bit in the column (in [0, 7])

; Per frame constants
fxc_scale	ds 1 ; FX scale factor
fxc_scale2	ds 1 ; FX scale factor squared

fxc_cx		ds 1 ; FX center
fxc_cy		ds 1

fxc_dir		ds 1 ; Directions bit field
		     ; bit 0: X dir
		     ; bit 1: Y dir
		     ; bit 2: Scaling dir
		     ; bit 3: Translation dir

; Coordinates based computation
fxc_x		ds 1 ; Storage for X value
fxc_y		ds 1 ; Stoarge for Y value

fxc_tx		ds 1 ; FX translated coordinates
fxc_ty		ds 1

fxc_tx2		ds 1 ; Storage for tx square
fxc_dist2	ds 1 ; Squared distance

; The FX 24x24 frame buffer
; Split in 3x 8pixels columns
fxc_fb_c0	ds 24
fxc_fb_c1	ds 24
fxc_fb_c2	ds 24
