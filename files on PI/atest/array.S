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
	.file	"test.c"
	.globl	funcadd                 @ -- Begin function funcadd
	.p2align	2
	.type	funcadd,%function
	.code	32                      @ @funcadd
funcadd:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	str	r2, [sp]
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	add	r0, r0, r1
	ldr	r1, [sp]
	add	r0, r0, r1
	add	sp, sp, #12
	bx	lr
.Lfunc_end0:
	.size	funcadd, .Lfunc_end0-funcadd
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
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	.setfp	r11, sp, #8
	add	r11, sp, #8
	.pad	#72
	sub	sp, sp, #72
	ldr	r0, .LCPI1_0
	ldr	r1, .LCPI1_1
	ldr	r2, .LCPI1_2
	ldr	r3, .LCPI1_3
	ldr	r12, .LCPI1_4
	ldr	lr, .LCPI1_5
	ldr	r4, .LCPI1_6
	str	r4, [r11, #-12]
	str	lr, [r11, #-16]
	add	lr, sp, #24
	mov	r4, #0
	mov	r5, #40
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, lr
	str	r1, [sp, #16]           @ 4-byte Spill
	mov	r1, r4
	str	r2, [sp, #12]           @ 4-byte Spill
	mov	r2, r5
	str	r3, [sp, #8]            @ 4-byte Spill
	str	r12, [sp, #4]           @ 4-byte Spill
	bl	memset
	ldr	r1, [sp, #4]            @ 4-byte Reload
	str	r1, [sp, #24]
	ldr	r2, [sp, #8]            @ 4-byte Reload
	str	r2, [sp, #28]
	ldr	r3, [sp, #12]           @ 4-byte Reload
	str	r3, [sp, #32]
	ldr	r12, [sp, #16]          @ 4-byte Reload
	str	r12, [sp, #36]
	ldr	lr, [sp, #20]           @ 4-byte Reload
	str	lr, [sp, #40]
	ldr	r4, [r11, #-16]
	ldr	r1, [r11, #-16]
	ldr	r2, [sp, #28]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r4
	bl	funcadd
	str	r0, [r11, #-16]
	ldr	r0, [r11, #-16]
	sub	sp, r11, #8
	pop	{r4, r5, r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	44                      @ 0x2c
.LCPI1_1:
	.long	33                      @ 0x21
.LCPI1_2:
	.long	22                      @ 0x16
.LCPI1_3:
	.long	11                      @ 0xb
.LCPI1_4:
	.long	99                      @ 0x63
.LCPI1_5:
	.long	12                      @ 0xc
.LCPI1_6:
	.long	0                       @ 0x0
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"clang version 7.0.1-8+rpi3+deb10u2 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym funcadd
	.addrsig_sym main
	.eabi_attribute	30, 6	@ Tag_ABI_optimization_goals
