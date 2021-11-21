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
	.file	"a.cpp"
	.globl	main                    @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	32                      @ @main
main:
	.fnstart
@ %bb.0:
	.pad	#20
	sub	sp, sp, #20
	ldr	r0, .LCPI0_0
	ldr	r1, .LCPI0_1
	ldr	r2, .LCPI0_2
	ldr	r3, .LCPI0_3
	str	r3, [sp, #16]
	str	r2, [sp, #12]
	str	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r0, [sp, #12]
	str	r0, [sp]
	ldr	r0, [sp, #12]
	ldr	r1, [sp, #8]
	cmp	r0, r1
	ble	.LBB0_2
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	cmp	r0, r1
	bgt	.LBB0_3
.LBB0_2:
	ldr	r0, [sp, #12]
	ldr	r1, [sp]
	cmp	r0, r1
	ble	.LBB0_4
.LBB0_3:
	ldr	r0, [sp]
	ldr	r1, [sp]
	mul	r0, r0, r1
	str	r0, [sp]
.LBB0_4:
	ldr	r0, .LCPI0_3
	add	sp, sp, #20
	bx	lr
	.p2align	2
@ %bb.5:
.LCPI0_0:
	.long	4                       @ 0x4
.LCPI0_1:
	.long	3                       @ 0x3
.LCPI0_2:
	.long	2                       @ 0x2
.LCPI0_3:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"clang version 7.0.1-8+rpi3+deb10u2 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym main
	.eabi_attribute	30, 6	@ Tag_ABI_optimization_goals
