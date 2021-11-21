	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"test.c"
	.text
	.comm	_sysy_start,8,4
	.comm	_sysy_end,8,4
	.comm	_sysy_l1,4096,4
	.comm	_sysy_l2,4096,4
	.comm	_sysy_h,4096,4
	.comm	_sysy_m,4096,4
	.comm	_sysy_s,4096,4
	.comm	_sysy_us,4096,4
	.comm	_sysy_idx,4,4
	.global	max
	.section	.rodata
	.align	2
	.type	max, %object
	.size	max, 4
max:
	.word	1073741824
	.text
	.align	2
	.global	checkrange
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	checkrange, %function
checkrange:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	b	.L2
.L3:
	mov	r2, #1073741824
	ldr	r3, [fp, #-8]
	sub	r3, r3, r2
	str	r3, [fp, #-8]
.L2:
	mov	r2, #1073741824
	ldr	r3, [fp, #-8]
	cmp	r3, r2
	bgt	.L3
	b	.L4
.L5:
	mov	r2, #1073741824
	ldr	r3, [fp, #-8]
	add	r3, r3, r2
	str	r3, [fp, #-8]
.L4:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	blt	.L5
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	checkrange, .-checkrange
	.global	__aeabi_idiv
	.align	2
	.global	reduce
	.syntax unified
	.arm
	.fpu vfp
	.type	reduce, %function
reduce:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #44
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	ldr	r3, [fp, #-40]
	cmp	r3, #0
	bne	.L8
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	mov	r0, r3
	bl	checkrange
	mov	r3, r0
	b	.L9
.L8:
	ldr	r3, [fp, #-40]
	cmp	r3, #1
	bne	.L10
	mov	r3, #0
	str	r3, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-20]
	b	.L11
.L14:
	ldr	r1, [fp, #-20]
	ldr	r0, [fp, #-44]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	mov	r4, r3
	ldr	r1, [fp, #-20]
	ldr	r0, [fp, #-48]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	cmp	r4, r3
	bne	.L12
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #1
	str	r3, [fp, #-16]
	b	.L13
.L12:
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #1
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L13:
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #1
	str	r3, [fp, #-20]
.L11:
	mov	r2, #1073741824
	ldr	r3, [fp, #-20]
	cmp	r3, r2
	blt	.L14
	ldr	r3, [fp, #-16]
	b	.L9
.L10:
	ldr	r3, [fp, #-40]
	cmp	r3, #2
	bne	.L15
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	ble	.L16
	ldr	r3, [fp, #-44]
	b	.L9
.L16:
	ldr	r3, [fp, #-48]
	b	.L9
.L15:
	ldr	r3, [fp, #-40]
	cmp	r3, #3
	bne	.L17
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #1
	str	r3, [fp, #-28]
	b	.L18
.L22:
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-44]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	cmp	r3, #1
	beq	.L19
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-48]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	cmp	r3, #1
	bne	.L20
.L19:
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #1
	add	r3, r3, #1
	str	r3, [fp, #-24]
	b	.L21
.L20:
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #1
	str	r3, [fp, #-24]
.L21:
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #1
	str	r3, [fp, #-28]
.L18:
	mov	r2, #1073741824
	ldr	r3, [fp, #-28]
	cmp	r3, r2
	blt	.L22
	ldr	r3, [fp, #-24]
	b	.L9
.L17:
	ldr	r3, [fp, #-40]
	cmp	r3, #4
	bne	.L23
	mov	r3, #0
	str	r3, [fp, #-32]
	mov	r3, #1
	str	r3, [fp, #-36]
	b	.L24
.L27:
	ldr	r1, [fp, #-36]
	ldr	r0, [fp, #-44]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	cmp	r3, #1
	bne	.L25
	ldr	r1, [fp, #-36]
	ldr	r0, [fp, #-48]
	bl	__aeabi_idiv
	mov	r3, r0
	cmp	r3, #0
	and	r3, r3, #1
	rsblt	r3, r3, #0
	cmp	r3, #1
	bne	.L25
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #1
	add	r3, r3, #1
	str	r3, [fp, #-32]
	b	.L26
.L25:
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #1
	str	r3, [fp, #-32]
.L26:
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #1
	str	r3, [fp, #-36]
.L24:
	mov	r2, #1073741824
	ldr	r3, [fp, #-36]
	cmp	r3, r2
	blt	.L27
	ldr	r3, [fp, #-32]
	b	.L9
.L23:
	mov	r3, #0
.L9:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
	.size	reduce, .-reduce
	.align	2
	.global	getvalue
	.syntax unified
	.arm
	.fpu vfp
	.type	getvalue, %function
getvalue:
	@ args = 4, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	blt	.L29
	ldr	r3, [fp, #4]
	cmp	r3, #0
	blt	.L29
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	bge	.L29
	ldr	r2, [fp, #4]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	blt	.L30
.L29:
	mov	r3, #0
	b	.L31
.L30:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-16]
	mul	r2, r2, r3
	ldr	r3, [fp, #4]
	add	r3, r2, r3
	lsl	r3, r3, #2
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	ldr	r3, [r3]
.L31:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	getvalue, .-getvalue
	.align	2
	.global	convn
	.syntax unified
	.arm
	.fpu vfp
	.type	convn, %function
convn:
	@ args = 8, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #48
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-8]
	mov	r3, #0
	str	r3, [fp, #-12]
	mov	r3, #1
	str	r3, [fp, #-28]
.L44:
	mov	r3, #0
	str	r3, [fp, #-12]
.L41:
	mov	r3, #0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #8]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	rsb	r3, r3, #0
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r3, r2
	str	r3, [fp, #-16]
.L38:
	ldr	r3, [fp, #8]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	rsb	r3, r3, #0
	mov	r2, r3
	ldr	r3, [fp, #-12]
	add	r3, r3, r2
	str	r3, [fp, #-20]
.L35:
	ldr	r3, [fp, #-20]
	str	r3, [sp]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #4]
	ldr	r1, [fp, #-44]
	ldr	r0, [fp, #-36]
	bl	getvalue
	mov	r3, r0
	mov	r2, r3
	ldr	r1, [fp, #-24]
	ldr	r0, [fp, #-32]
	bl	reduce
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
	ldr	r3, [fp, #8]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #-20]
	cmp	r2, r3
	bge	.L50
	b	.L35
.L50:
	nop
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #8]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	bge	.L51
	b	.L38
.L51:
	nop
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #4]
	mul	r2, r2, r3
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	lsl	r3, r3, #2
	ldr	r2, [fp, #-40]
	add	r3, r2, r3
	ldr	r2, [fp, #-24]
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
	ldr	r0, [fp, #-12]
	bl	putch
	mov	r0, #10
	bl	putch
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #4]
	cmp	r2, r3
	bge	.L52
	b	.L41
.L52:
	nop
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-44]
	cmp	r2, r3
	bge	.L53
	b	.L44
.L53:
	nop
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	convn, .-convn
	.comm	a,40000000,4
	.comm	b,40000000,4
	.comm	kernelid,40000,4
	.align	2
	.global	memmove
	.syntax unified
	.arm
	.fpu vfp
	.type	memmove, %function
memmove:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L55
.L56:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-20]
	add	r2, r2, r3
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r1, [fp, #-16]
	add	r3, r1, r3
	ldr	r2, [r2]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L55:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	blt	.L56
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	memmove, .-memmove
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	bl	getint
	str	r0, [fp, #-12]
	bl	getint
	str	r0, [fp, #-16]
	bl	getint
	str	r0, [fp, #-20]
	ldr	r0, .L61
	bl	getarray
	ldr	r0, .L61+4
	bl	getarray
	str	r0, [fp, #-24]
	mov	r0, #111
	bl	_sysy_starttime
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L58
.L59:
	ldr	r2, .L61+4
	ldr	r3, [fp, #-8]
	ldr	r0, [r2, r3, lsl #2]
	ldr	r3, [fp, #-12]
	str	r3, [sp, #4]
	ldr	r3, [fp, #-20]
	str	r3, [sp]
	ldr	r3, [fp, #-16]
	ldr	r2, .L61+8
	ldr	r1, .L61
	bl	convn
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	mul	r3, r2, r3
	mov	r2, r3
	ldr	r1, .L61+8
	ldr	r0, .L61
	bl	memmove
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L58:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	blt	.L59
	mov	r0, #118
	bl	_sysy_stoptime
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	mul	r3, r2, r3
	ldr	r1, .L61
	mov	r0, r3
	bl	putarray
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L62:
	.align	2
.L61:
	.word	a
	.word	kernelid
	.word	b
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
