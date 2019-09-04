	PROCESSOR 6502
	INCLUDE "vcs.h" ; Provides RIOT & TIA memory map
	INCLUDE "macro.h" ; This file includes some helper macros

	SEG.U ram
	ORG $0080
fcnt	ds 1
tmp	ds 1
tmp1	ds 1
ptr	ds 2
ptr1	ds 2
	INCLUDE "skarmasea-zik_variables.asm"

	SEG code
	ORG $F000
; Loading a couple of data to have it aligned without loosing space
	INCLUDE "skarmasea-zik_trackdata.asm"

; Then the remaining of the code
init	CLEAN_START
	INCLUDE "skarmasea-zik_init.asm"

main_loop SUBROUTINE
	VERTICAL_SYNC		; 4 scanlines Vertical Sync signal

	; ===== VBLANK =====
	; 34 VBlank lines (76 cycles/line)
	lda #39
	sta TIM64T
	INCLUDE "skarmasea-zik_player.asm"
	jsr wait_timint

	; ===== KERNEL =====
	; 248 Kernel lines
	lda #19
	sta T1024T
	jsr wait_timint		; scanline 289 - cycle 30

	; ===== OVERSCAN ======
	; 26 Overscan lines
	lda #22
	sta TIM64T
	inc fcnt
	jsr wait_timint

	jmp main_loop		; scanline 308 - cycle 15

; X register must contain the number of scanlines to skip
; X register will have value 0 on exit
wait_timint:
	lda TIMINT
	beq wait_timint
	rts

	echo "ROM left: ", ($fffc - *)d, "bytes"

	SEG reset
	ORG $FFFC
	DC.W init
	DC.W init
