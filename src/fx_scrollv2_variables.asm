;;; Framebuffer to prepare scrolling text
fb0	ds 8
fb1	ds 8
fb2	ds 8
fb3	ds 8
fb4	ds 8
fb5	ds 8

;;; Indexes into our data
scr_line_pt	ds 2	      ; 16 bits pointer to current character line
scr_text_pt	ds 2	      ; Index of last text character displayed
line_cnt	ds 1

;;; Temporary storage to consume line bits
cur_line	ds 1
frame_cnt	ds 1

;;; Colors
col_start	ds 1

;;; Sprites position
sp_pos_up	ds 1
sp_pos_down	ds 1

;;; Sprites pointers
sprite_lptr	ds 2
sprite_rptr	ds 2
sprite_cptr	ds 2

;;; Pointers torwards sprites data
sprite_up_ptr	ds 2
sprite_down_ptr	ds 2
	
;;; Temporary
cur_offset	ds 1
tmp		ds 1
tmp2		ds 1
