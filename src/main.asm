	PROCESSOR 6502
	INCLUDE "vcs.h" ; Provides RIOT & TIA memory map
	INCLUDE "macro.h" ; This file includes some helper macros

	SEG.U ram
	ORG $0080
	INCLUDE "ZommerLiebe_variables.asm"
	INCLUDE "fx_scrollv2_variables.asm"

	SEG code
	ORG $F000
	; Loading data to have it aligned without loosing space
	INCLUDE "ZommerLiebe_trackdata.asm"
	; Then loading FXs code
	INCLUDE "fx_scrollv2.asm"

; Then the remaining of the code
init	CLEAN_START
	INCLUDE "ZommerLiebe_init.asm"
	jsr fx_scrollv2_setup

main_loop SUBROUTINE
	VERTICAL_SYNC ; 4 scanlines Vertical Sync signal

	; ===== VBLANK =====
	; 34 VBlank lines (76 cycles/line)
	sta WSYNC ; Ensure determinism of timer setup
	lda #37
	sta TIM64T
	INCLUDE "skarmasea-zik_player.asm"
	jsr fx_scrollv2_vblank
	jsr wait_timint
	ldx #10
.vblank_pad
	dex
	bpl .vblank_pad

	; ===== KERNEL =====
	; 248 Kernel lines
	lda #19
	sta T1024T
	jsr fx_scrollv2_kernel
	jsr wait_timint

	; ===== OVERSCAN ======
	; 26 Overscan lines
	lda #22
	sta TIM64T
	jsr fx_scrollv2_overscan
	inc frame_cnt
	jsr wait_timint

	jmp main_loop

; X register must contain the number of scanlines to skip
; X register will have value 0 on exit
wait_timint SUBROUTINE
	lda TIMINT
	beq wait_timint
	rts

	echo "ROM left: ", ($fffc - *)d, "bytes"

	SEG reset
	ORG $FFFC
	DC.W init
	DC.W init
