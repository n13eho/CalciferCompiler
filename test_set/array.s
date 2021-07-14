        .text
        .syntax unified
        .eabi_attribute 67, "2.09"      @ Tag_conformance
        .cpu    mpcore
        .eabi_attribute 6, 6    @ Tag_CPU_arch
        .eabi_attribute 8, 1    @ Tag_ARM_ISA_use
        .eabi_attribute 9, 1    @ Tag_THUMB_ISA_use
        .fpu    vfpv2
        .eabi_attribute 34, 0   @ Tag_CPU_unaligned_access
        .eabi_attribute 17, 1   @ Tag_ABI_PCS_GOT_use
        .eabi_attribute 20, 1   @ Tag_ABI_FP_denormal
        .eabi_attribute 21, 1   @ Tag_ABI_FP_exceptions
        .eabi_attribute 23, 3   @ Tag_ABI_FP_number_model
        .eabi_attribute 24, 1   @ Tag_ABI_align_needed
        .eabi_attribute 25, 1   @ Tag_ABI_align_preserved
        .eabi_attribute 28, 1   @ Tag_ABI_VFP_args
        .eabi_attribute 38, 1   @ Tag_ABI_FP_16bit_format
        .eabi_attribute 18, 4   @ Tag_ABI_PCS_wchar_t
        .eabi_attribute 26, 2   @ Tag_ABI_enum_size
        .eabi_attribute 14, 0   @ Tag_ABI_PCS_R9_use
        .file   "add.cpp"
        .globl  main                    @ -- Begin function main
        .p2align        2
        .type   main,%function
        .code   32                      @ @main
main:
        .fnstart
@ %bb.0:
        .save   {r4, r5, r6, r7, r11, lr}
        push    {r4, r5, r6, r7, r11, lr}
        .setfp  r11, sp, #16
        add     r11, sp, #16
        .pad    #44
        sub     sp, sp, #44
        ldr     r0, .LCPI0_0
        ldr     r1, .LCPI0_1
        mov     r2, #0
        str     r2, [r11, #-20]
        mov     r2, #1
        str     r2, [r11, #-24]
        mov     r2, #2
        str     r2, [r11, #-28]
        ldr     r2, .LCPI0_2
        add     r3, sp, #4
        ldm     r2, {r4, r5, r6, r7, r12, lr}
        stm     r3, {r4, r5, r6, r7, r12, lr}
        ldr     r2, [sp, #4]
        ldr     r3, [sp, #16]
        lsl     r2, r2, #1
        add     r2, r3, r2
        str     r2, [sp, #28]
        str     r1, [sp]                @ 4-byte Spill
        sub     sp, r11, #16
        pop     {r4, r5, r6, r7, r11, pc}
        .p2align        2
@ %bb.1:
.LCPI0_0:
        .long   0                       @ 0x0
.LCPI0_1:
        .long   1                       @ 0x1
.LCPI0_2:
        .long   .L_ZZ4mainE1p
.Lfunc_end0:
        .size   main, .Lfunc_end0-main
        .cantunwind
        .fnend
                                        @ -- End function
        .type   .L_ZZ4mainE1p,%object   @ @_ZZ4mainE1p
        .section        .rodata,"a",%progbits
        .p2align        2
.L_ZZ4mainE1p:
        .long   5                       @ 0x5
        .long   6                       @ 0x6
        .zero   8
        .zero   8
        .size   .L_ZZ4mainE1p, 24


        .ident  "clang version 7.0.1-8+rpi3+deb10u2 (tags/RELEASE_701/final)"
        .section        ".note.GNU-stack","",%progbits
        .addrsig
        .addrsig_sym main
        .eabi_attribute 30, 6   @ Tag_ABI_optimization_goals