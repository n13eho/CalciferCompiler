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
	.file	"sylib.c"
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
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.text
	.align	2
	.global	getint
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	getint, %function
getint:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	sub	r3, fp, #8
	mov	r1, r3
	ldr	r0, .L3
	bl	__isoc99_scanf
	ldr	r3, [fp, #-8]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	getint, .-getint
	.section	.rodata
	.align	2
.LC1:
	.ascii	"%c\000"
	.text
	.align	2
	.global	getch
	.syntax unified
	.arm
	.fpu vfp
	.type	getch, %function
getch:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	sub	r3, fp, #5
	mov	r1, r3
	ldr	r0, .L7
	bl	__isoc99_scanf
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	.LC1
	.size	getch, .-getch
	.align	2
	.global	getarray
	.syntax unified
	.arm
	.fpu vfp
	.type	getarray, %function
getarray:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L13
	bl	__isoc99_scanf
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L10
.L11:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	mov	r1, r3
	ldr	r0, .L13
	bl	__isoc99_scanf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L10:
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	cmp	r2, r3
	blt	.L11
	ldr	r3, [fp, #-12]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L14:
	.align	2
.L13:
	.word	.LC0
	.size	getarray, .-getarray
	.align	2
	.global	putint
	.syntax unified
	.arm
	.fpu vfp
	.type	putint, %function
putint:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, .L16
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L17:
	.align	2
.L16:
	.word	.LC0
	.size	putint, .-putint
	.align	2
	.global	putch
	.syntax unified
	.arm
	.fpu vfp
	.type	putch, %function
putch:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	putchar
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	putch, .-putch
	.section	.rodata
	.align	2
.LC2:
	.ascii	"%d:\000"
	.align	2
.LC3:
	.ascii	" %d\000"
	.text
	.align	2
	.global	putarray
	.syntax unified
	.arm
	.fpu vfp
	.type	putarray, %function
putarray:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r1, [fp, #-16]
	ldr	r0, .L22
	bl	printf
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L20
.L21:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-20]
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r0, .L22+4
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L20:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	blt	.L21
	mov	r0, #10
	bl	putchar
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L23:
	.align	2
.L22:
	.word	.LC2
	.word	.LC3
	.size	putarray, .-putarray
	.align	2
	.global	before_main
	.syntax unified
	.arm
	.fpu vfp
	.type	before_main, %function
before_main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L25
.L26:
	ldr	r2, .L27
	ldr	r3, [fp, #-8]
	mov	r1, #0
	str	r1, [r2, r3, lsl #2]
	ldr	r2, .L27
	ldr	r3, [fp, #-8]
	ldr	r2, [r2, r3, lsl #2]
	ldr	r1, .L27+4
	ldr	r3, [fp, #-8]
	str	r2, [r1, r3, lsl #2]
	ldr	r2, .L27+4
	ldr	r3, [fp, #-8]
	ldr	r2, [r2, r3, lsl #2]
	ldr	r1, .L27+8
	ldr	r3, [fp, #-8]
	str	r2, [r1, r3, lsl #2]
	ldr	r2, .L27+8
	ldr	r3, [fp, #-8]
	ldr	r2, [r2, r3, lsl #2]
	ldr	r1, .L27+12
	ldr	r3, [fp, #-8]
	str	r2, [r1, r3, lsl #2]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L25:
	ldr	r3, [fp, #-8]
	cmp	r3, #1024
	blt	.L26
	ldr	r3, .L27+16
	mov	r2, #1
	str	r2, [r3]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L28:
	.align	2
.L27:
	.word	_sysy_us
	.word	_sysy_s
	.word	_sysy_m
	.word	_sysy_h
	.word	_sysy_idx
	.size	before_main, .-before_main
	.section	.init_array,"aw"
	.align	2
	.word	before_main
	.section	.rodata
	.align	2
.LC4:
	.ascii	"Timer@%04d-%04d: %dH-%dM-%dS-%dus\012\000"
	.align	2
.LC5:
	.ascii	"TOTAL: %dH-%dM-%dS-%dus\012\000"
	.text
	.align	2
	.global	after_main
	.syntax unified
	.arm
	.fpu vfp
	.type	after_main, %function
after_main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #24
	mov	r3, #1
	str	r3, [fp, #-16]
	b	.L30
.L31:
	ldr	r3, .L32
	ldr	lr, [r3]
	ldr	r2, .L32+4
	ldr	r3, [fp, #-16]
	ldr	r4, [r2, r3, lsl #2]
	ldr	r2, .L32+8
	ldr	r3, [fp, #-16]
	ldr	r5, [r2, r3, lsl #2]
	ldr	r2, .L32+12
	ldr	r3, [fp, #-16]
	ldr	r3, [r2, r3, lsl #2]
	ldr	r1, .L32+16
	ldr	r2, [fp, #-16]
	ldr	r2, [r1, r2, lsl #2]
	ldr	r0, .L32+20
	ldr	r1, [fp, #-16]
	ldr	r1, [r0, r1, lsl #2]
	ldr	ip, .L32+24
	ldr	r0, [fp, #-16]
	ldr	r0, [ip, r0, lsl #2]
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp]
	mov	r3, r5
	mov	r2, r4
	ldr	r1, .L32+28
	mov	r0, lr
	bl	fprintf
	ldr	r3, .L32+24
	ldr	r2, [r3]
	ldr	r1, .L32+24
	ldr	r3, [fp, #-16]
	ldr	r3, [r1, r3, lsl #2]
	add	r3, r2, r3
	ldr	r2, .L32+24
	str	r3, [r2]
	ldr	r3, .L32+20
	ldr	r2, [r3]
	ldr	r1, .L32+20
	ldr	r3, [fp, #-16]
	ldr	r3, [r1, r3, lsl #2]
	add	r3, r2, r3
	ldr	r2, .L32+20
	str	r3, [r2]
	ldr	r3, .L32+24
	ldr	r0, [r3]
	ldr	r3, .L32+32
	smull	r2, r3, r3, r0
	asr	r2, r3, #18
	asr	r3, r0, #31
	sub	r1, r2, r3
	mov	r2, r1
	lsl	r2, r2, #5
	sub	r2, r2, r1
	lsl	r3, r2, #6
	sub	r3, r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r1
	lsl	r3, r3, #6
	sub	r1, r0, r3
	ldr	r3, .L32+24
	str	r1, [r3]
	ldr	r3, .L32+16
	ldr	r2, [r3]
	ldr	r1, .L32+16
	ldr	r3, [fp, #-16]
	ldr	r3, [r1, r3, lsl #2]
	add	r3, r2, r3
	ldr	r2, .L32+16
	str	r3, [r2]
	ldr	r3, .L32+20
	ldr	r2, [r3]
	ldr	r3, .L32+36
	smull	r1, r3, r3, r2
	add	r3, r3, r2
	asr	r1, r3, #5
	asr	r3, r2, #31
	sub	r1, r1, r3
	mov	r3, r1
	lsl	r3, r3, #4
	sub	r3, r3, r1
	lsl	r3, r3, #2
	sub	r1, r2, r3
	ldr	r3, .L32+20
	str	r1, [r3]
	ldr	r3, .L32+12
	ldr	r2, [r3]
	ldr	r1, .L32+12
	ldr	r3, [fp, #-16]
	ldr	r3, [r1, r3, lsl #2]
	add	r3, r2, r3
	ldr	r2, .L32+12
	str	r3, [r2]
	ldr	r3, .L32+16
	ldr	r2, [r3]
	ldr	r3, .L32+36
	smull	r1, r3, r3, r2
	add	r3, r3, r2
	asr	r1, r3, #5
	asr	r3, r2, #31
	sub	r1, r1, r3
	mov	r3, r1
	lsl	r3, r3, #4
	sub	r3, r3, r1
	lsl	r3, r3, #2
	sub	r1, r2, r3
	ldr	r3, .L32+16
	str	r1, [r3]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L30:
	ldr	r3, .L32+40
	ldr	r3, [r3]
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	blt	.L31
	ldr	r3, .L32
	ldr	r0, [r3]
	ldr	r3, .L32+12
	ldr	r1, [r3]
	ldr	r3, .L32+16
	ldr	ip, [r3]
	ldr	r3, .L32+20
	ldr	r3, [r3]
	ldr	r2, .L32+24
	ldr	r2, [r2]
	str	r2, [sp, #4]
	str	r3, [sp]
	mov	r3, ip
	mov	r2, r1
	ldr	r1, .L32+44
	bl	fprintf
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
.L33:
	.align	2
.L32:
	.word	stderr
	.word	_sysy_l1
	.word	_sysy_l2
	.word	_sysy_h
	.word	_sysy_m
	.word	_sysy_s
	.word	_sysy_us
	.word	.LC4
	.word	1125899907
	.word	-2004318071
	.word	_sysy_idx
	.word	.LC5
	.size	after_main, .-after_main
	.section	.fini_array,"aw"
	.align	2
	.word	after_main
	.text
	.align	2
	.global	_sysy_starttime
	.syntax unified
	.arm
	.fpu vfp
	.type	_sysy_starttime, %function
_sysy_starttime:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, .L35
	ldr	r3, [r3]
	ldr	r1, .L35+4
	ldr	r2, [fp, #-8]
	str	r2, [r1, r3, lsl #2]
	mov	r1, #0
	ldr	r0, .L35+8
	bl	gettimeofday
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L36:
	.align	2
.L35:
	.word	_sysy_idx
	.word	_sysy_l1
	.word	_sysy_start
	.size	_sysy_starttime, .-_sysy_starttime
	.align	2
	.global	_sysy_stoptime
	.syntax unified
	.arm
	.fpu vfp
	.type	_sysy_stoptime, %function
_sysy_stoptime:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	mov	r1, #0
	ldr	r0, .L38
	bl	gettimeofday
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r1, .L38+8
	ldr	r2, [fp, #-8]
	str	r2, [r1, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+12
	ldr	r0, [r2, r3, lsl #2]
	ldr	r3, .L38
	ldr	r2, [r3]
	ldr	r3, .L38+16
	ldr	r3, [r3]
	sub	r1, r2, r3
	mov	r2, r1
	lsl	r2, r2, #5
	sub	r2, r2, r1
	lsl	r3, r2, #6
	sub	r3, r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r1
	lsl	r3, r3, #6
	mov	r2, r3
	ldr	r3, .L38
	ldr	r3, [r3, #4]
	add	r2, r2, r3
	ldr	r3, .L38+16
	ldr	r3, [r3, #4]
	sub	r2, r2, r3
	ldr	r3, .L38+4
	ldr	r3, [r3]
	add	r2, r0, r2
	ldr	r1, .L38+12
	str	r2, [r1, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+20
	ldr	r1, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+12
	ldr	r3, [r2, r3, lsl #2]
	ldr	r2, .L38+24
	smull	r0, r2, r2, r3
	asr	r2, r2, #18
	asr	r3, r3, #31
	sub	r2, r2, r3
	ldr	r3, .L38+4
	ldr	r3, [r3]
	add	r2, r1, r2
	ldr	r1, .L38+20
	str	r2, [r1, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+12
	ldr	r0, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	ip, [r3]
	ldr	r3, .L38+24
	smull	r2, r3, r3, r0
	asr	r2, r3, #18
	asr	r3, r0, #31
	sub	r1, r2, r3
	mov	r2, r1
	lsl	r2, r2, #5
	sub	r2, r2, r1
	lsl	r3, r2, #6
	sub	r3, r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r1
	lsl	r3, r3, #6
	sub	r1, r0, r3
	ldr	r3, .L38+12
	str	r1, [r3, ip, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+28
	ldr	r1, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+20
	ldr	r3, [r2, r3, lsl #2]
	ldr	r2, .L38+32
	smull	r0, r2, r2, r3
	add	r2, r2, r3
	asr	r2, r2, #5
	asr	r3, r3, #31
	sub	r2, r2, r3
	ldr	r3, .L38+4
	ldr	r3, [r3]
	add	r2, r1, r2
	ldr	r1, .L38+28
	str	r2, [r1, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+20
	ldr	r2, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r0, [r3]
	ldr	r3, .L38+32
	smull	r1, r3, r3, r2
	add	r3, r3, r2
	asr	r1, r3, #5
	asr	r3, r2, #31
	sub	r1, r1, r3
	mov	r3, r1
	lsl	r3, r3, #4
	sub	r3, r3, r1
	lsl	r3, r3, #2
	sub	r1, r2, r3
	ldr	r3, .L38+20
	str	r1, [r3, r0, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+36
	ldr	r1, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+28
	ldr	r3, [r2, r3, lsl #2]
	ldr	r2, .L38+32
	smull	r0, r2, r2, r3
	add	r2, r2, r3
	asr	r2, r2, #5
	asr	r3, r3, #31
	sub	r2, r2, r3
	ldr	r3, .L38+4
	ldr	r3, [r3]
	add	r2, r1, r2
	ldr	r1, .L38+36
	str	r2, [r1, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	ldr	r2, .L38+28
	ldr	r2, [r2, r3, lsl #2]
	ldr	r3, .L38+4
	ldr	r0, [r3]
	ldr	r3, .L38+32
	smull	r1, r3, r3, r2
	add	r3, r3, r2
	asr	r1, r3, #5
	asr	r3, r2, #31
	sub	r1, r1, r3
	mov	r3, r1
	lsl	r3, r3, #4
	sub	r3, r3, r1
	lsl	r3, r3, #2
	sub	r1, r2, r3
	ldr	r3, .L38+28
	str	r1, [r3, r0, lsl #2]
	ldr	r3, .L38+4
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L38+4
	str	r3, [r2]
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L39:
	.align	2
.L38:
	.word	_sysy_end
	.word	_sysy_idx
	.word	_sysy_l2
	.word	_sysy_us
	.word	_sysy_start
	.word	_sysy_s
	.word	1125899907
	.word	_sysy_m
	.word	-2004318071
	.word	_sysy_h
	.size	_sysy_stoptime, .-_sysy_stoptime
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
