	.text
	.syntax unified
	.eabi_attribute	67, "2.09"	@ Tag_conformance
	.cpu	mpcore
	.eabi_attribute	6, 6	@ Tag_CPU_arch
	.eabi_attribute	8, 1	@ Tag_ARM_ISA_use
	.eabi_attribute	9, 1	@ Tag_THUMB_ISA_use
	.fpu	vfpv2
	.eabi_attribute	34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute	17, 1	@ Tag_ABI_PCS_GOT_use
	.eabi_attribute	20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute	21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute	23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute	24, 1	@ Tag_ABI_align_needed
	.eabi_attribute	25, 1	@ Tag_ABI_align_preserved
	.eabi_attribute	28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute	38, 1	@ Tag_ABI_FP_16bit_format
	.eabi_attribute	18, 4	@ Tag_ABI_PCS_wchar_t
	.eabi_attribute	26, 2	@ Tag_ABI_enum_size
	.eabi_attribute	14, 0	@ Tag_ABI_PCS_R9_use
	.file	"add.cpp"
	.globl	_Z3valii                @ -- Begin function _Z3valii
	.p2align	2
	.type	_Z3valii,%function
	.code	32                      @ @_Z3valii
_Z3valii:
	.fnstart
@ %bb.0:
	.pad	#40
	sub	sp, sp, #40
	ldr	r2, .LCPI0_0
	ldr	r3, .LCPI0_1
	ldr	r12, .LCPI0_2
	str	r0, [sp, #36]
	str	r1, [sp, #32]
	ldr	r0, [sp, #36]
	ldr	r1, [sp, #32]
	add	r0, r0, r1
	str	r0, [sp, #28]
	str	r12, [sp, #24]
	str	r3, [sp, #20]
	ldr	r0, [sp, #24]
	add	r0, r0, #90
	str	r0, [sp, #16]
	str	r2, [sp, #12]
	add	sp, sp, #40
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	5                       @ 0x5
.LCPI0_1:
	.long	6                       @ 0x6
.LCPI0_2:
	.long	2                       @ 0x2
.Lfunc_end0:
	.size	_Z3valii, .Lfunc_end0-_Z3valii
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_Z3addii                @ -- Begin function _Z3addii
	.p2align	2
	.type	_Z3addii,%function
	.code	32                      @ @_Z3addii
_Z3addii:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, sp, #16
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	ldr	r0, [sp, #12]
	ldr	r1, [sp, #8]
	add	r0, r0, r1
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #4]
	mul	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #16
	bx	lr
.Lfunc_end1:
	.size	_Z3addii, .Lfunc_end1-_Z3addii
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	main                    @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	32                      @ @main
main:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r0, .LCPI2_1
	ldr	r1, .LCPI2_2
	ldr	r2, .LCPI2_3
	ldr	r3, .LCPI2_0
	str	r3, [r11, #-4]
	str	r2, [r11, #-8]
	str	r1, [sp, #12]
	ldr	r1, [sp, #12]
	ldr	r2, [r11, #-8]
	ldr	r3, [sp, #12]
	ldr	r12, [sp, #12]
	mul	r3, r3, r12
	add	r2, r2, r3
	ldr	r3, [r11, #-8]
	mul	r0, r3, r0
	add	r0, r2, r0
	add	r0, r0, #8
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	_Z3addii
	ldr	r1, .LCPI2_0
	str	r0, [sp, #8]
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	3                       @ 0x3
.LCPI2_2:
	.long	2                       @ 0x2
.LCPI2_3:
	.long	1                       @ 0x1
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"clang version 7.0.1-8+rpi3+deb10u2 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _Z3valii
	.addrsig_sym _Z3addii
	.addrsig_sym main
	.eabi_attribute	30, 6	@ Tag_ABI_optimization_goals
