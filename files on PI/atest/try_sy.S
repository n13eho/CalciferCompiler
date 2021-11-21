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
	.file	"try.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	_sysy_start,8,4
	.comm	_sysy_end,8,4
	.comm	_sysy_l1,4096,4
	.comm	_sysy_l2,4096,4
	.comm	_sysy_h,4096,4
	.comm	_sysy_m,4096,4
	.comm	_sysy_s,4096,4
	.comm	_sysy_us,4096,4
	.comm	_sysy_idx,4,4
	.global	SHIFT_TABLE
	.section	.rodata
	.align	2
	.type	SHIFT_TABLE, %object
	.size	SHIFT_TABLE, 64
SHIFT_TABLE:
	.word	1
	.word	2
	.word	4
	.word	8
	.word	16
	.word	32
	.word	64
	.word	128
	.word	256
	.word	512
	.word	1024
	.word	2048
	.word	4096
	.word	8192
	.word	16384
	.word	32768
	.global	__aeabi_idiv
	.text
	.align	2
	.global	long_func
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	long_func, %function
long_func:
.LFB0:
	.file 1 "try.c"
	.loc 1 6 17
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 360
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	add	fp, sp, #4
	.cfi_def_cfa 11, 4
	sub	sp, sp, #360
.LBB2:
	.loc 1 9 9
	mov	r3, #2
	str	r3, [fp, #-28]
	.loc 1 9 17
	mov	r3, #0
	str	r3, [fp, #-32]
	.loc 1 9 25
	mov	r3, #1
	str	r3, [fp, #-36]
	.loc 1 10 11
	b	.L2
.L92:
	.loc 1 11 11
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 12 9
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 13 9
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-16]
	.loc 1 14 9
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 15 13
	b	.L3
.L5:
	.loc 1 16 13
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 16 12
	cmp	r3, #0
	beq	.L4
	.loc 1 16 19 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L4
	.loc 1 17 38
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 17 15
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L4:
	.loc 1 19 11
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 20 11
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 21 11
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L3:
	.loc 1 15 13
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L5
	.loc 1 23 10
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L6
.LBB3:
	.loc 1 25 15
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-40]
	.loc 1 25 26
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-44]
	.loc 1 25 35
	mov	r3, #0
	str	r3, [fp, #-48]
	.loc 1 26 17
	b	.L7
.L45:
	.loc 1 27 17
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 28 15
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 29 15
	ldr	r3, [fp, #-44]
	str	r3, [fp, #-16]
	.loc 1 30 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 31 19
	b	.L8
.L10:
	.loc 1 32 19
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 32 18
	cmp	r3, #0
	beq	.L9
	.loc 1 32 25 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L9
	.loc 1 33 44
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 33 21
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L9:
	.loc 1 35 17
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 36 17
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 37 17
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L8:
	.loc 1 31 19
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L10
	.loc 1 39 16
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L11
.LBB4:
	.loc 1 41 21
	ldr	r3, [fp, #-48]
	str	r3, [fp, #-52]
	.loc 1 41 32
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-56]
	.loc 1 42 23
	b	.L12
.L24:
	.loc 1 43 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 44 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 45 21
	ldr	r3, [fp, #-52]
	str	r3, [fp, #-16]
	.loc 1 46 21
	ldr	r3, [fp, #-56]
	str	r3, [fp, #-20]
	.loc 1 47 25
	b	.L13
.L17:
	.loc 1 48 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 48 24
	cmp	r3, #0
	beq	.L14
	.loc 1 49 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 49 26
	cmp	r3, #0
	bne	.L16
	.loc 1 50 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 50 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L16
.L14:
	.loc 1 52 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 52 31
	cmp	r3, #0
	beq	.L16
	.loc 1 53 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 53 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L16:
	.loc 1 55 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 56 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 57 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L13:
	.loc 1 47 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L17
	.loc 1 59 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-300]
	.loc 1 60 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 61 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 62 21
	ldr	r3, [fp, #-52]
	str	r3, [fp, #-16]
	.loc 1 63 21
	ldr	r3, [fp, #-56]
	str	r3, [fp, #-20]
	.loc 1 64 25
	b	.L18
.L20:
	.loc 1 65 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 65 24
	cmp	r3, #0
	beq	.L19
	.loc 1 65 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L19
	.loc 1 66 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 66 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L19:
	.loc 1 68 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 69 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 70 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L18:
	.loc 1 64 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L20
	.loc 1 72 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-56]
	.loc 1 76 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 77 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 78 40
	mov	r2, #2
	.loc 1 78 23
	ldr	r3, [fp, #-56]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 79 23
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 80 27
	b	.L21
.L23:
	.loc 1 81 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 81 26
	cmp	r3, #0
	beq	.L22
	.loc 1 81 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L22
	.loc 1 82 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 82 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L22:
	.loc 1 84 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 85 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 86 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L21:
	.loc 1 80 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L23
	.loc 1 89 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-56]
	.loc 1 90 22
	ldr	r3, [fp, #-300]
	str	r3, [fp, #-52]
.L12:
	.loc 1 42 23
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	bne	.L24
	.loc 1 92 21
	ldr	r3, [fp, #-52]
	str	r3, [fp, #-8]
.LBE4:
	.loc 1 94 20
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-48]
.L11:
.LBB5:
	.loc 1 97 19
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-60]
	.loc 1 97 28
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-64]
	.loc 1 98 21
	b	.L25
.L37:
	.loc 1 99 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 100 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 101 19
	ldr	r3, [fp, #-60]
	str	r3, [fp, #-16]
	.loc 1 102 19
	ldr	r3, [fp, #-64]
	str	r3, [fp, #-20]
	.loc 1 103 23
	b	.L26
.L30:
	.loc 1 104 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 104 22
	cmp	r3, #0
	beq	.L27
	.loc 1 105 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 105 24
	cmp	r3, #0
	bne	.L29
	.loc 1 106 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 106 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L29
.L27:
	.loc 1 108 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 108 29
	cmp	r3, #0
	beq	.L29
	.loc 1 109 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 109 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L29:
	.loc 1 111 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 112 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 113 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L26:
	.loc 1 103 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L30
	.loc 1 115 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-304]
	.loc 1 116 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 117 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 118 19
	ldr	r3, [fp, #-60]
	str	r3, [fp, #-16]
	.loc 1 119 19
	ldr	r3, [fp, #-64]
	str	r3, [fp, #-20]
	.loc 1 120 23
	b	.L31
.L33:
	.loc 1 121 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 121 22
	cmp	r3, #0
	beq	.L32
	.loc 1 121 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L32
	.loc 1 122 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 122 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L32:
	.loc 1 124 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 125 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 126 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L31:
	.loc 1 120 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L33
	.loc 1 128 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-64]
	.loc 1 132 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 133 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 134 38
	mov	r2, #2
	.loc 1 134 21
	ldr	r3, [fp, #-64]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 135 21
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 136 25
	b	.L34
.L36:
	.loc 1 137 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 137 24
	cmp	r3, #0
	beq	.L35
	.loc 1 137 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L35
	.loc 1 138 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 138 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L35:
	.loc 1 140 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 141 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 142 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L34:
	.loc 1 136 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L36
	.loc 1 145 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-64]
	.loc 1 146 20
	ldr	r3, [fp, #-304]
	str	r3, [fp, #-60]
.L25:
	.loc 1 98 21
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	bne	.L37
	.loc 1 148 19
	ldr	r3, [fp, #-60]
	str	r3, [fp, #-8]
.LBE5:
	.loc 1 150 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-40]
	.loc 1 151 15
	ldr	r3, [fp, #-44]
	str	r3, [fp, #-16]
	.loc 1 152 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 153 16
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L38
	.loc 1 154 18
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L39
	.loc 1 155 21
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L41
.L39:
	.loc 1 157 21
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L41
.L38:
	.loc 1 159 23
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L42
	.loc 1 160 18
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L43
	.loc 1 161 36
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 161 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL0:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 162 25
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 162 54
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 162 46
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 162 21
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L41
.L43:
	.loc 1 164 38
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 164 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL1:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L41
.L42:
	.loc 1 167 19
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L41:
	.loc 1 169 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-44]
.L7:
	.loc 1 26 17
	ldr	r3, [fp, #-44]
	cmp	r3, #0
	bne	.L45
	.loc 1 171 15
	ldr	r3, [fp, #-48]
	str	r3, [fp, #-8]
.LBE3:
	.loc 1 173 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-36]
.L6:
.LBB6:
	.loc 1 176 13
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-68]
	.loc 1 176 22
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-72]
	.loc 1 176 31
	mov	r3, #0
	str	r3, [fp, #-76]
	.loc 1 177 15
	b	.L46
.L84:
	.loc 1 178 15
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 179 13
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 180 13
	ldr	r3, [fp, #-72]
	str	r3, [fp, #-16]
	.loc 1 181 13
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 182 17
	b	.L47
.L49:
	.loc 1 183 17
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 183 16
	cmp	r3, #0
	beq	.L48
	.loc 1 183 23 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L48
	.loc 1 184 42
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 184 19
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L48:
	.loc 1 186 15
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 187 15
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 188 15
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L47:
	.loc 1 182 17
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L49
	.loc 1 190 14
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L50
.LBB7:
	.loc 1 192 19
	ldr	r3, [fp, #-76]
	str	r3, [fp, #-80]
	.loc 1 192 30
	ldr	r3, [fp, #-68]
	str	r3, [fp, #-84]
	.loc 1 193 21
	b	.L51
.L63:
	.loc 1 194 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 195 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 196 19
	ldr	r3, [fp, #-80]
	str	r3, [fp, #-16]
	.loc 1 197 19
	ldr	r3, [fp, #-84]
	str	r3, [fp, #-20]
	.loc 1 198 23
	b	.L52
.L56:
	.loc 1 199 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 199 22
	cmp	r3, #0
	beq	.L53
	.loc 1 200 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 200 24
	cmp	r3, #0
	bne	.L55
	.loc 1 201 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 201 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L55
.L53:
	.loc 1 203 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 203 29
	cmp	r3, #0
	beq	.L55
	.loc 1 204 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 204 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L55:
	.loc 1 206 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 207 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 208 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L52:
	.loc 1 198 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L56
	.loc 1 210 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-308]
	.loc 1 211 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 212 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 213 19
	ldr	r3, [fp, #-80]
	str	r3, [fp, #-16]
	.loc 1 214 19
	ldr	r3, [fp, #-84]
	str	r3, [fp, #-20]
	.loc 1 215 23
	b	.L57
.L59:
	.loc 1 216 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 216 22
	cmp	r3, #0
	beq	.L58
	.loc 1 216 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L58
	.loc 1 217 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 217 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L58:
	.loc 1 219 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 220 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 221 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L57:
	.loc 1 215 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L59
	.loc 1 223 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-84]
	.loc 1 227 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 228 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 229 38
	mov	r2, #2
	.loc 1 229 21
	ldr	r3, [fp, #-84]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 230 21
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 231 25
	b	.L60
.L62:
	.loc 1 232 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 232 24
	cmp	r3, #0
	beq	.L61
	.loc 1 232 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L61
	.loc 1 233 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 233 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L61:
	.loc 1 235 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 236 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 237 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L60:
	.loc 1 231 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L62
	.loc 1 240 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-84]
	.loc 1 241 20
	ldr	r3, [fp, #-308]
	str	r3, [fp, #-80]
.L51:
	.loc 1 193 21
	ldr	r3, [fp, #-84]
	cmp	r3, #0
	bne	.L63
	.loc 1 243 19
	ldr	r3, [fp, #-80]
	str	r3, [fp, #-8]
.LBE7:
	.loc 1 245 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-76]
.L50:
.LBB8:
	.loc 1 248 17
	ldr	r3, [fp, #-68]
	str	r3, [fp, #-88]
	.loc 1 248 26
	ldr	r3, [fp, #-68]
	str	r3, [fp, #-92]
	.loc 1 249 19
	b	.L64
.L76:
	.loc 1 250 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 251 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 252 17
	ldr	r3, [fp, #-88]
	str	r3, [fp, #-16]
	.loc 1 253 17
	ldr	r3, [fp, #-92]
	str	r3, [fp, #-20]
	.loc 1 254 21
	b	.L65
.L69:
	.loc 1 255 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 255 20
	cmp	r3, #0
	beq	.L66
	.loc 1 256 29
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 256 22
	cmp	r3, #0
	bne	.L68
	.loc 1 257 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 257 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L68
.L66:
	.loc 1 259 28
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 259 27
	cmp	r3, #0
	beq	.L68
	.loc 1 260 46
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 260 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L68:
	.loc 1 262 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 263 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 264 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L65:
	.loc 1 254 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L69
	.loc 1 266 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-312]
	.loc 1 267 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 268 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 269 17
	ldr	r3, [fp, #-88]
	str	r3, [fp, #-16]
	.loc 1 270 17
	ldr	r3, [fp, #-92]
	str	r3, [fp, #-20]
	.loc 1 271 21
	b	.L70
.L72:
	.loc 1 272 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 272 20
	cmp	r3, #0
	beq	.L71
	.loc 1 272 27 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L71
	.loc 1 273 46
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 273 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L71:
	.loc 1 275 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 276 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 277 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L70:
	.loc 1 271 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L72
	.loc 1 279 17
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-92]
	.loc 1 283 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 284 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 285 36
	mov	r2, #2
	.loc 1 285 19
	ldr	r3, [fp, #-92]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 286 19
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 287 23
	b	.L73
.L75:
	.loc 1 288 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 288 22
	cmp	r3, #0
	beq	.L74
	.loc 1 288 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L74
	.loc 1 289 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 289 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L74:
	.loc 1 291 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 292 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 293 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L73:
	.loc 1 287 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L75
	.loc 1 296 17
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-92]
	.loc 1 297 18
	ldr	r3, [fp, #-312]
	str	r3, [fp, #-88]
.L64:
	.loc 1 249 19
	ldr	r3, [fp, #-92]
	cmp	r3, #0
	bne	.L76
	.loc 1 299 17
	ldr	r3, [fp, #-88]
	str	r3, [fp, #-8]
.LBE8:
	.loc 1 301 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-68]
	.loc 1 302 13
	ldr	r3, [fp, #-72]
	str	r3, [fp, #-16]
	.loc 1 303 13
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 304 14
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L77
	.loc 1 305 16
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L78
	.loc 1 306 19
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L80
.L78:
	.loc 1 308 19
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L80
.L77:
	.loc 1 310 21
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L81
	.loc 1 311 16
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L82
	.loc 1 312 34
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 312 17
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL2:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 313 23
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 313 52
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 313 44
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 313 19
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L80
.L82:
	.loc 1 315 36
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 315 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL3:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L80
.L81:
	.loc 1 318 17
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L80:
	.loc 1 320 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-72]
.L46:
	.loc 1 177 15
	ldr	r3, [fp, #-72]
	cmp	r3, #0
	bne	.L84
	.loc 1 322 13
	ldr	r3, [fp, #-76]
	str	r3, [fp, #-8]
.LBE6:
	.loc 1 324 10
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-28]
	.loc 1 325 9
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-16]
	.loc 1 326 9
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 327 10
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L85
	.loc 1 328 12
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L86
	.loc 1 329 15
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L88
.L86:
	.loc 1 331 15
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L88
.L85:
	.loc 1 333 17
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L89
	.loc 1 334 12
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L90
	.loc 1 335 30
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 335 13
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL4:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 336 19
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 336 48
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 336 40
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 336 15
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L88
.L90:
	.loc 1 338 32
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 338 15
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL5:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L88
.L89:
	.loc 1 341 13
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L88:
	.loc 1 343 10
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
.L2:
	.loc 1 10 11
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bgt	.L92
	.loc 1 345 9
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-8]
.LBE2:
	.loc 1 347 3
	ldr	r0, [fp, #-8]
	bl	putint
	.loc 1 348 3
	mov	r0, #10
	bl	putch
.LBB9:
	.loc 1 350 9
	mov	r3, #2
	str	r3, [fp, #-96]
	.loc 1 350 17
	mov	r3, #1
	str	r3, [fp, #-100]
	.loc 1 350 25
	mov	r3, #1
	str	r3, [fp, #-104]
	.loc 1 351 11
	b	.L93
.L183:
	.loc 1 352 11
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 353 9
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 354 9
	ldr	r3, [fp, #-100]
	str	r3, [fp, #-16]
	.loc 1 355 9
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 356 13
	b	.L94
.L96:
	.loc 1 357 13
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 357 12
	cmp	r3, #0
	beq	.L95
	.loc 1 357 19 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L95
	.loc 1 358 38
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 358 15
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L95:
	.loc 1 360 11
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 361 11
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 362 11
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L94:
	.loc 1 356 13
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L96
	.loc 1 364 10
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L97
.LBB10:
	.loc 1 366 15
	ldr	r3, [fp, #-104]
	str	r3, [fp, #-108]
	.loc 1 366 26
	ldr	r3, [fp, #-96]
	str	r3, [fp, #-112]
	.loc 1 366 35
	mov	r3, #0
	str	r3, [fp, #-116]
	.loc 1 367 17
	b	.L98
.L136:
	.loc 1 368 17
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 369 15
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 370 15
	ldr	r3, [fp, #-112]
	str	r3, [fp, #-16]
	.loc 1 371 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 372 19
	b	.L99
.L101:
	.loc 1 373 19
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 373 18
	cmp	r3, #0
	beq	.L100
	.loc 1 373 25 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L100
	.loc 1 374 44
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 374 21
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L100:
	.loc 1 376 17
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 377 17
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 378 17
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L99:
	.loc 1 372 19
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L101
	.loc 1 380 16
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L102
.LBB11:
	.loc 1 382 21
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-120]
	.loc 1 382 32
	ldr	r3, [fp, #-108]
	str	r3, [fp, #-124]
	.loc 1 383 23
	b	.L103
.L115:
	.loc 1 384 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 385 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 386 21
	ldr	r3, [fp, #-120]
	str	r3, [fp, #-16]
	.loc 1 387 21
	ldr	r3, [fp, #-124]
	str	r3, [fp, #-20]
	.loc 1 388 25
	b	.L104
.L373:
	.align	2
.L372:
	.word	65535
	.word	SHIFT_TABLE
.L108:
	.loc 1 389 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 389 24
	cmp	r3, #0
	beq	.L105
	.loc 1 390 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 390 26
	cmp	r3, #0
	bne	.L107
	.loc 1 391 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 391 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L107
.L105:
	.loc 1 393 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 393 31
	cmp	r3, #0
	beq	.L107
	.loc 1 394 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 394 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L107:
	.loc 1 396 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 397 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 398 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L104:
	.loc 1 388 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L108
	.loc 1 400 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-316]
	.loc 1 401 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 402 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 403 21
	ldr	r3, [fp, #-120]
	str	r3, [fp, #-16]
	.loc 1 404 21
	ldr	r3, [fp, #-124]
	str	r3, [fp, #-20]
	.loc 1 405 25
	b	.L109
.L111:
	.loc 1 406 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 406 24
	cmp	r3, #0
	beq	.L110
	.loc 1 406 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L110
	.loc 1 407 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 407 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L110:
	.loc 1 409 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 410 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 411 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L109:
	.loc 1 405 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L111
	.loc 1 413 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-124]
	.loc 1 417 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 418 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 419 40
	mov	r2, #2
	.loc 1 419 23
	ldr	r3, [fp, #-124]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 420 23
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 421 27
	b	.L112
.L114:
	.loc 1 422 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 422 26
	cmp	r3, #0
	beq	.L113
	.loc 1 422 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L113
	.loc 1 423 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 423 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L113:
	.loc 1 425 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 426 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 427 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L112:
	.loc 1 421 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L114
	.loc 1 430 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-124]
	.loc 1 431 22
	ldr	r3, [fp, #-316]
	str	r3, [fp, #-120]
.L103:
	.loc 1 383 23
	ldr	r3, [fp, #-124]
	cmp	r3, #0
	bne	.L115
	.loc 1 433 21
	ldr	r3, [fp, #-120]
	str	r3, [fp, #-8]
.LBE11:
	.loc 1 435 20
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-116]
.L102:
.LBB12:
	.loc 1 438 19
	ldr	r3, [fp, #-108]
	str	r3, [fp, #-128]
	.loc 1 438 28
	ldr	r3, [fp, #-108]
	str	r3, [fp, #-132]
	.loc 1 439 21
	b	.L116
.L128:
	.loc 1 440 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 441 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 442 19
	ldr	r3, [fp, #-128]
	str	r3, [fp, #-16]
	.loc 1 443 19
	ldr	r3, [fp, #-132]
	str	r3, [fp, #-20]
	.loc 1 444 23
	b	.L117
.L121:
	.loc 1 445 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 445 22
	cmp	r3, #0
	beq	.L118
	.loc 1 446 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 446 24
	cmp	r3, #0
	bne	.L120
	.loc 1 447 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 447 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L120
.L118:
	.loc 1 449 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 449 29
	cmp	r3, #0
	beq	.L120
	.loc 1 450 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 450 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L120:
	.loc 1 452 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 453 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 454 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L117:
	.loc 1 444 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L121
	.loc 1 456 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-320]
	.loc 1 457 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 458 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 459 19
	ldr	r3, [fp, #-128]
	str	r3, [fp, #-16]
	.loc 1 460 19
	ldr	r3, [fp, #-132]
	str	r3, [fp, #-20]
	.loc 1 461 23
	b	.L122
.L124:
	.loc 1 462 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 462 22
	cmp	r3, #0
	beq	.L123
	.loc 1 462 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L123
	.loc 1 463 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 463 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L123:
	.loc 1 465 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 466 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 467 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L122:
	.loc 1 461 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L124
	.loc 1 469 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-132]
	.loc 1 473 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 474 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 475 38
	mov	r2, #2
	.loc 1 475 21
	ldr	r3, [fp, #-132]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 476 21
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 477 25
	b	.L125
.L127:
	.loc 1 478 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 478 24
	cmp	r3, #0
	beq	.L126
	.loc 1 478 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L126
	.loc 1 479 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 479 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L126:
	.loc 1 481 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 482 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 483 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L125:
	.loc 1 477 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L127
	.loc 1 486 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-132]
	.loc 1 487 20
	ldr	r3, [fp, #-320]
	str	r3, [fp, #-128]
.L116:
	.loc 1 439 21
	ldr	r3, [fp, #-132]
	cmp	r3, #0
	bne	.L128
	.loc 1 489 19
	ldr	r3, [fp, #-128]
	str	r3, [fp, #-8]
.LBE12:
	.loc 1 491 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-108]
	.loc 1 492 15
	ldr	r3, [fp, #-112]
	str	r3, [fp, #-16]
	.loc 1 493 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 494 16
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L129
	.loc 1 495 18
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L130
	.loc 1 496 21
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L132
.L130:
	.loc 1 498 21
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L132
.L129:
	.loc 1 500 23
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L133
	.loc 1 501 18
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L134
	.loc 1 502 36
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 502 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL6:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 503 25
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 503 54
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 503 46
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 503 21
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L132
.L134:
	.loc 1 505 38
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 505 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL7:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L132
.L133:
	.loc 1 508 19
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L132:
	.loc 1 510 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-112]
.L98:
	.loc 1 367 17
	ldr	r3, [fp, #-112]
	cmp	r3, #0
	bne	.L136
	.loc 1 512 15
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-8]
.LBE10:
	.loc 1 514 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-104]
.L97:
.LBB13:
	.loc 1 517 13
	ldr	r3, [fp, #-96]
	str	r3, [fp, #-136]
	.loc 1 517 22
	ldr	r3, [fp, #-96]
	str	r3, [fp, #-140]
	.loc 1 517 31
	mov	r3, #0
	str	r3, [fp, #-144]
	.loc 1 518 15
	b	.L137
.L175:
	.loc 1 519 15
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 520 13
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 521 13
	ldr	r3, [fp, #-140]
	str	r3, [fp, #-16]
	.loc 1 522 13
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 523 17
	b	.L138
.L140:
	.loc 1 524 17
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 524 16
	cmp	r3, #0
	beq	.L139
	.loc 1 524 23 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L139
	.loc 1 525 42
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 525 19
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L139:
	.loc 1 527 15
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 528 15
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 529 15
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L138:
	.loc 1 523 17
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L140
	.loc 1 531 14
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L141
.LBB14:
	.loc 1 533 19
	ldr	r3, [fp, #-144]
	str	r3, [fp, #-148]
	.loc 1 533 30
	ldr	r3, [fp, #-136]
	str	r3, [fp, #-152]
	.loc 1 534 21
	b	.L142
.L154:
	.loc 1 535 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 536 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 537 19
	ldr	r3, [fp, #-148]
	str	r3, [fp, #-16]
	.loc 1 538 19
	ldr	r3, [fp, #-152]
	str	r3, [fp, #-20]
	.loc 1 539 23
	b	.L143
.L147:
	.loc 1 540 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 540 22
	cmp	r3, #0
	beq	.L144
	.loc 1 541 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 541 24
	cmp	r3, #0
	bne	.L146
	.loc 1 542 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 542 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L146
.L144:
	.loc 1 544 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 544 29
	cmp	r3, #0
	beq	.L146
	.loc 1 545 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 545 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L146:
	.loc 1 547 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 548 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 549 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L143:
	.loc 1 539 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L147
	.loc 1 551 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-324]
	.loc 1 552 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 553 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 554 19
	ldr	r3, [fp, #-148]
	str	r3, [fp, #-16]
	.loc 1 555 19
	ldr	r3, [fp, #-152]
	str	r3, [fp, #-20]
	.loc 1 556 23
	b	.L148
.L150:
	.loc 1 557 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 557 22
	cmp	r3, #0
	beq	.L149
	.loc 1 557 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L149
	.loc 1 558 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 558 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L149:
	.loc 1 560 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 561 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 562 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L148:
	.loc 1 556 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L150
	.loc 1 564 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-152]
	.loc 1 568 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 569 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 570 38
	mov	r2, #2
	.loc 1 570 21
	ldr	r3, [fp, #-152]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 571 21
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 572 25
	b	.L151
.L153:
	.loc 1 573 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 573 24
	cmp	r3, #0
	beq	.L152
	.loc 1 573 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L152
	.loc 1 574 50
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 574 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L152:
	.loc 1 576 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 577 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 578 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L151:
	.loc 1 572 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L153
	.loc 1 581 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-152]
	.loc 1 582 20
	ldr	r3, [fp, #-324]
	str	r3, [fp, #-148]
.L142:
	.loc 1 534 21
	ldr	r3, [fp, #-152]
	cmp	r3, #0
	bne	.L154
	.loc 1 584 19
	ldr	r3, [fp, #-148]
	str	r3, [fp, #-8]
.LBE14:
	.loc 1 586 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-144]
.L141:
.LBB15:
	.loc 1 589 17
	ldr	r3, [fp, #-136]
	str	r3, [fp, #-156]
	.loc 1 589 26
	ldr	r3, [fp, #-136]
	str	r3, [fp, #-160]
	.loc 1 590 19
	b	.L155
.L167:
	.loc 1 591 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 592 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 593 17
	ldr	r3, [fp, #-156]
	str	r3, [fp, #-16]
	.loc 1 594 17
	ldr	r3, [fp, #-160]
	str	r3, [fp, #-20]
	.loc 1 595 21
	b	.L156
.L160:
	.loc 1 596 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 596 20
	cmp	r3, #0
	beq	.L157
	.loc 1 597 29
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 597 22
	cmp	r3, #0
	bne	.L159
	.loc 1 598 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 598 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L159
.L157:
	.loc 1 600 28
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 600 27
	cmp	r3, #0
	beq	.L159
	.loc 1 601 46
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 601 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L159:
	.loc 1 603 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 604 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 605 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L156:
	.loc 1 595 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L160
	.loc 1 607 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-328]
	.loc 1 608 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 609 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 610 17
	ldr	r3, [fp, #-156]
	str	r3, [fp, #-16]
	.loc 1 611 17
	ldr	r3, [fp, #-160]
	str	r3, [fp, #-20]
	.loc 1 612 21
	b	.L161
.L163:
	.loc 1 613 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 613 20
	cmp	r3, #0
	beq	.L162
	.loc 1 613 27 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L162
	.loc 1 614 46
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 614 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L162:
	.loc 1 616 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 617 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 618 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L161:
	.loc 1 612 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L163
	.loc 1 620 17
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-160]
	.loc 1 624 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 625 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 626 36
	mov	r2, #2
	.loc 1 626 19
	ldr	r3, [fp, #-160]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 627 19
	ldr	r3, .L372
	str	r3, [fp, #-20]
	.loc 1 628 23
	b	.L164
.L166:
	.loc 1 629 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 629 22
	cmp	r3, #0
	beq	.L165
	.loc 1 629 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L165
	.loc 1 630 48
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 630 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L165:
	.loc 1 632 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 633 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 634 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L164:
	.loc 1 628 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L166
	.loc 1 637 17
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-160]
	.loc 1 638 18
	ldr	r3, [fp, #-328]
	str	r3, [fp, #-156]
.L155:
	.loc 1 590 19
	ldr	r3, [fp, #-160]
	cmp	r3, #0
	bne	.L167
	.loc 1 640 17
	ldr	r3, [fp, #-156]
	str	r3, [fp, #-8]
.LBE15:
	.loc 1 642 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-136]
	.loc 1 643 13
	ldr	r3, [fp, #-140]
	str	r3, [fp, #-16]
	.loc 1 644 13
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 645 14
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L168
	.loc 1 646 16
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L169
	.loc 1 647 19
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L171
.L169:
	.loc 1 649 19
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L171
.L168:
	.loc 1 651 21
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L172
	.loc 1 652 16
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L173
	.loc 1 653 34
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 653 17
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL8:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 654 23
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 654 52
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 654 44
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 654 19
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L171
.L173:
	.loc 1 656 36
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 656 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL9:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L171
.L172:
	.loc 1 659 17
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L171:
	.loc 1 661 14
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-140]
.L137:
	.loc 1 518 15
	ldr	r3, [fp, #-140]
	cmp	r3, #0
	bne	.L175
	.loc 1 663 13
	ldr	r3, [fp, #-144]
	str	r3, [fp, #-8]
.LBE13:
	.loc 1 665 10
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-96]
	.loc 1 666 9
	ldr	r3, [fp, #-100]
	str	r3, [fp, #-16]
	.loc 1 667 9
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 668 10
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L176
	.loc 1 669 12
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L177
	.loc 1 670 15
	ldr	r3, .L372
	str	r3, [fp, #-8]
	b	.L179
.L177:
	.loc 1 672 15
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L179
.L176:
	.loc 1 674 17
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L180
	.loc 1 675 12
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L181
	.loc 1 676 30
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 676 13
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL10:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 677 19
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 677 48
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 677 40
	ldr	r1, .L372+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 677 15
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L179
.L181:
	.loc 1 679 32
	ldr	r2, .L372+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 679 15
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL11:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L179
.L180:
	.loc 1 682 13
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L179:
	.loc 1 684 10
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-100]
.L93:
	.loc 1 351 11
	ldr	r3, [fp, #-100]
	cmp	r3, #0
	bgt	.L183
	.loc 1 686 9
	ldr	r3, [fp, #-104]
	str	r3, [fp, #-8]
.LBE9:
	.loc 1 688 3
	ldr	r0, [fp, #-8]
	bl	putint
	.loc 1 689 3
	mov	r0, #10
	bl	putch
	.loc 1 690 7
	mov	r3, #2
	str	r3, [fp, #-24]
	.loc 1 691 9
	b	.L184
.L276:
.LBB16:
	.loc 1 693 11
	mov	r3, #2
	str	r3, [fp, #-164]
	.loc 1 693 19
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-168]
	.loc 1 693 29
	mov	r3, #1
	str	r3, [fp, #-172]
	.loc 1 694 13
	b	.L185
.L275:
	.loc 1 695 13
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 696 11
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 697 11
	ldr	r3, [fp, #-168]
	str	r3, [fp, #-16]
	.loc 1 698 11
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 699 15
	b	.L186
.L188:
	.loc 1 700 15
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 700 14
	cmp	r3, #0
	beq	.L187
	.loc 1 700 21 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L187
	.loc 1 701 40
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 701 17
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L187:
	.loc 1 703 13
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 704 13
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 705 13
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L186:
	.loc 1 699 15
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L188
	.loc 1 707 12
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L189
.LBB17:
	.loc 1 709 17
	ldr	r3, [fp, #-172]
	str	r3, [fp, #-176]
	.loc 1 709 28
	ldr	r3, [fp, #-164]
	str	r3, [fp, #-180]
	.loc 1 709 37
	mov	r3, #0
	str	r3, [fp, #-184]
	.loc 1 710 19
	b	.L190
.L228:
	.loc 1 711 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 712 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 713 17
	ldr	r3, [fp, #-180]
	str	r3, [fp, #-16]
	.loc 1 714 17
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 715 21
	b	.L191
.L193:
	.loc 1 716 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 716 20
	cmp	r3, #0
	beq	.L192
	.loc 1 716 27 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L192
	.loc 1 717 46
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 717 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L192:
	.loc 1 719 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 720 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 721 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L191:
	.loc 1 715 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L193
	.loc 1 723 18
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L194
.LBB18:
	.loc 1 725 23
	ldr	r3, [fp, #-184]
	str	r3, [fp, #-188]
	.loc 1 725 34
	ldr	r3, [fp, #-176]
	str	r3, [fp, #-192]
	.loc 1 726 25
	b	.L195
.L207:
	.loc 1 727 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 728 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 729 23
	ldr	r3, [fp, #-188]
	str	r3, [fp, #-16]
	.loc 1 730 23
	ldr	r3, [fp, #-192]
	str	r3, [fp, #-20]
	.loc 1 731 27
	b	.L196
.L200:
	.loc 1 732 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 732 26
	cmp	r3, #0
	beq	.L197
	.loc 1 733 35
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 733 28
	cmp	r3, #0
	bne	.L199
	.loc 1 734 54
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 734 31
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L199
.L197:
	.loc 1 736 34
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 736 33
	cmp	r3, #0
	beq	.L199
	.loc 1 737 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 737 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L199:
	.loc 1 739 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 740 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 741 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L196:
	.loc 1 731 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L200
	.loc 1 743 25
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-332]
	.loc 1 744 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 745 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 746 23
	ldr	r3, [fp, #-188]
	str	r3, [fp, #-16]
	.loc 1 747 23
	ldr	r3, [fp, #-192]
	str	r3, [fp, #-20]
	.loc 1 748 27
	b	.L201
.L203:
	.loc 1 749 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 749 26
	cmp	r3, #0
	beq	.L202
	.loc 1 749 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L202
	.loc 1 750 52
	ldr	r2, .L372+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 750 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L202:
	.loc 1 752 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 753 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 754 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L201:
	.loc 1 748 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L203
	.loc 1 756 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-192]
	.loc 1 760 27
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 761 25
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 762 42
	mov	r2, #2
	.loc 1 762 25
	ldr	r3, [fp, #-192]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 763 25
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 764 29
	b	.L204
.L206:
	.loc 1 765 29
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 765 28
	cmp	r3, #0
	beq	.L205
	.loc 1 765 35 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L205
	.loc 1 766 54
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 766 31
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L205:
	.loc 1 768 27
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 769 27
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 770 27
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L204:
	.loc 1 764 29
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L206
	.loc 1 773 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-192]
	.loc 1 774 24
	ldr	r3, [fp, #-332]
	str	r3, [fp, #-188]
.L195:
	.loc 1 726 25
	ldr	r3, [fp, #-192]
	cmp	r3, #0
	bne	.L207
	.loc 1 776 23
	ldr	r3, [fp, #-188]
	str	r3, [fp, #-8]
.LBE18:
	.loc 1 778 22
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-184]
.L194:
.LBB19:
	.loc 1 781 21
	ldr	r3, [fp, #-176]
	str	r3, [fp, #-196]
	.loc 1 781 30
	ldr	r3, [fp, #-176]
	str	r3, [fp, #-200]
	.loc 1 782 23
	b	.L208
.L220:
	.loc 1 783 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 784 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 785 21
	ldr	r3, [fp, #-196]
	str	r3, [fp, #-16]
	.loc 1 786 21
	ldr	r3, [fp, #-200]
	str	r3, [fp, #-20]
	.loc 1 787 25
	b	.L209
.L213:
	.loc 1 788 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 788 24
	cmp	r3, #0
	beq	.L210
	.loc 1 789 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 789 26
	cmp	r3, #0
	bne	.L212
	.loc 1 790 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 790 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L212
.L210:
	.loc 1 792 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 792 31
	cmp	r3, #0
	beq	.L212
	.loc 1 793 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 793 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L212:
	.loc 1 795 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 796 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 797 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L209:
	.loc 1 787 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L213
	.loc 1 799 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-336]
	.loc 1 800 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 801 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 802 21
	ldr	r3, [fp, #-196]
	str	r3, [fp, #-16]
	.loc 1 803 21
	ldr	r3, [fp, #-200]
	str	r3, [fp, #-20]
	.loc 1 804 25
	b	.L214
.L216:
	.loc 1 805 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 805 24
	cmp	r3, #0
	beq	.L215
	.loc 1 805 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L215
	.loc 1 806 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 806 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L215:
	.loc 1 808 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 809 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 810 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L214:
	.loc 1 804 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L216
	.loc 1 812 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-200]
	.loc 1 816 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 817 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 818 40
	mov	r2, #2
	.loc 1 818 23
	ldr	r3, [fp, #-200]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 819 23
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 820 27
	b	.L217
.L219:
	.loc 1 821 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 821 26
	cmp	r3, #0
	beq	.L218
	.loc 1 821 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L218
	.loc 1 822 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 822 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L218:
	.loc 1 824 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 825 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 826 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L217:
	.loc 1 820 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L219
	.loc 1 829 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-200]
	.loc 1 830 22
	ldr	r3, [fp, #-336]
	str	r3, [fp, #-196]
.L208:
	.loc 1 782 23
	ldr	r3, [fp, #-200]
	cmp	r3, #0
	bne	.L220
	.loc 1 832 21
	ldr	r3, [fp, #-196]
	str	r3, [fp, #-8]
.LBE19:
	.loc 1 834 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-176]
	.loc 1 835 17
	ldr	r3, [fp, #-180]
	str	r3, [fp, #-16]
	.loc 1 836 17
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 837 18
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L221
	.loc 1 838 20
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L222
	.loc 1 839 23
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L224
.L222:
	.loc 1 841 23
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L224
.L221:
	.loc 1 843 25
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L225
	.loc 1 844 20
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L226
	.loc 1 845 38
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 845 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL12:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 846 27
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 846 56
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 846 48
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 846 23
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L224
.L226:
	.loc 1 848 40
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 848 23
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL13:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L224
.L225:
	.loc 1 851 21
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L224:
	.loc 1 853 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-180]
.L190:
	.loc 1 710 19
	ldr	r3, [fp, #-180]
	cmp	r3, #0
	bne	.L228
	.loc 1 855 17
	ldr	r3, [fp, #-184]
	str	r3, [fp, #-8]
.LBE17:
	.loc 1 857 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-172]
.L189:
.LBB20:
	.loc 1 860 15
	ldr	r3, [fp, #-164]
	str	r3, [fp, #-204]
	.loc 1 860 24
	ldr	r3, [fp, #-164]
	str	r3, [fp, #-208]
	.loc 1 860 33
	mov	r3, #0
	str	r3, [fp, #-212]
	.loc 1 861 17
	b	.L229
.L267:
	.loc 1 862 17
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 863 15
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 864 15
	ldr	r3, [fp, #-208]
	str	r3, [fp, #-16]
	.loc 1 865 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 866 19
	b	.L230
.L232:
	.loc 1 867 19
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 867 18
	cmp	r3, #0
	beq	.L231
	.loc 1 867 25 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L231
	.loc 1 868 44
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 868 21
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L231:
	.loc 1 870 17
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 871 17
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 872 17
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L230:
	.loc 1 866 19
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L232
	.loc 1 874 16
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L233
.LBB21:
	.loc 1 876 21
	ldr	r3, [fp, #-212]
	str	r3, [fp, #-216]
	.loc 1 876 32
	ldr	r3, [fp, #-204]
	str	r3, [fp, #-220]
	.loc 1 877 23
	b	.L234
.L246:
	.loc 1 878 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 879 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 880 21
	ldr	r3, [fp, #-216]
	str	r3, [fp, #-16]
	.loc 1 881 21
	ldr	r3, [fp, #-220]
	str	r3, [fp, #-20]
	.loc 1 882 25
	b	.L235
.L239:
	.loc 1 883 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 883 24
	cmp	r3, #0
	beq	.L236
	.loc 1 884 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 884 26
	cmp	r3, #0
	bne	.L238
	.loc 1 885 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 885 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L238
.L236:
	.loc 1 887 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 887 31
	cmp	r3, #0
	beq	.L238
	.loc 1 888 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 888 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L238:
	.loc 1 890 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 891 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 892 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L235:
	.loc 1 882 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L239
	.loc 1 894 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-340]
	.loc 1 895 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 896 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 897 21
	ldr	r3, [fp, #-216]
	str	r3, [fp, #-16]
	.loc 1 898 21
	ldr	r3, [fp, #-220]
	str	r3, [fp, #-20]
	.loc 1 899 25
	b	.L240
.L242:
	.loc 1 900 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 900 24
	cmp	r3, #0
	beq	.L241
	.loc 1 900 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L241
	.loc 1 901 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 901 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L241:
	.loc 1 903 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 904 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 905 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L240:
	.loc 1 899 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L242
	.loc 1 907 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-220]
	.loc 1 911 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 912 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 913 40
	mov	r2, #2
	.loc 1 913 23
	ldr	r3, [fp, #-220]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 914 23
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 915 27
	b	.L243
.L245:
	.loc 1 916 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 916 26
	cmp	r3, #0
	beq	.L244
	.loc 1 916 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L244
	.loc 1 917 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 917 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L244:
	.loc 1 919 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 920 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 921 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L243:
	.loc 1 915 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L245
	.loc 1 924 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-220]
	.loc 1 925 22
	ldr	r3, [fp, #-340]
	str	r3, [fp, #-216]
.L234:
	.loc 1 877 23
	ldr	r3, [fp, #-220]
	cmp	r3, #0
	bne	.L246
	.loc 1 927 21
	ldr	r3, [fp, #-216]
	str	r3, [fp, #-8]
.LBE21:
	.loc 1 929 20
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-212]
.L233:
.LBB22:
	.loc 1 932 19
	ldr	r3, [fp, #-204]
	str	r3, [fp, #-224]
	.loc 1 932 28
	ldr	r3, [fp, #-204]
	str	r3, [fp, #-228]
	.loc 1 933 21
	b	.L247
.L259:
	.loc 1 934 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 935 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 936 19
	ldr	r3, [fp, #-224]
	str	r3, [fp, #-16]
	.loc 1 937 19
	ldr	r3, [fp, #-228]
	str	r3, [fp, #-20]
	.loc 1 938 23
	b	.L248
.L252:
	.loc 1 939 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 939 22
	cmp	r3, #0
	beq	.L249
	.loc 1 940 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 940 24
	cmp	r3, #0
	bne	.L251
	.loc 1 941 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 941 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L251
.L249:
	.loc 1 943 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 943 29
	cmp	r3, #0
	beq	.L251
	.loc 1 944 48
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 944 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L251:
	.loc 1 946 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 947 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 948 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L248:
	.loc 1 938 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L252
	.loc 1 950 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-344]
	.loc 1 951 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 952 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 953 19
	ldr	r3, [fp, #-224]
	str	r3, [fp, #-16]
	.loc 1 954 19
	ldr	r3, [fp, #-228]
	str	r3, [fp, #-20]
	.loc 1 955 23
	b	.L253
.L255:
	.loc 1 956 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 956 22
	cmp	r3, #0
	beq	.L254
	.loc 1 956 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L254
	.loc 1 957 48
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 957 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L254:
	.loc 1 959 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 960 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 961 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L253:
	.loc 1 955 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L255
	.loc 1 963 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-228]
	.loc 1 967 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 968 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 969 38
	mov	r2, #2
	.loc 1 969 21
	ldr	r3, [fp, #-228]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 970 21
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 971 25
	b	.L256
.L258:
	.loc 1 972 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 972 24
	cmp	r3, #0
	beq	.L257
	.loc 1 972 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L257
	.loc 1 973 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 973 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L257:
	.loc 1 975 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 976 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 977 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L256:
	.loc 1 971 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L258
	.loc 1 980 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-228]
	.loc 1 981 20
	ldr	r3, [fp, #-344]
	str	r3, [fp, #-224]
.L247:
	.loc 1 933 21
	ldr	r3, [fp, #-228]
	cmp	r3, #0
	bne	.L259
	.loc 1 983 19
	ldr	r3, [fp, #-224]
	str	r3, [fp, #-8]
.LBE22:
	.loc 1 985 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-204]
	.loc 1 986 15
	ldr	r3, [fp, #-208]
	str	r3, [fp, #-16]
	.loc 1 987 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 988 16
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L260
	.loc 1 989 18
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L261
	.loc 1 990 21
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L263
.L261:
	.loc 1 992 21
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L263
.L260:
	.loc 1 994 23
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L264
	.loc 1 995 18
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L265
	.loc 1 996 36
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 996 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL14:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 997 25
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 997 54
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 997 46
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 997 21
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L263
.L265:
	.loc 1 999 38
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 999 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL15:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L263
.L264:
	.loc 1 1002 19
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L263:
	.loc 1 1004 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-208]
.L229:
	.loc 1 861 17
	ldr	r3, [fp, #-208]
	cmp	r3, #0
	bne	.L267
	.loc 1 1006 15
	ldr	r3, [fp, #-212]
	str	r3, [fp, #-8]
.LBE20:
	.loc 1 1008 12
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-164]
	.loc 1 1009 11
	ldr	r3, [fp, #-168]
	str	r3, [fp, #-16]
	.loc 1 1010 11
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1011 12
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L268
	.loc 1 1012 14
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L269
	.loc 1 1013 17
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L271
.L269:
	.loc 1 1015 17
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L271
.L268:
	.loc 1 1017 19
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L272
	.loc 1 1018 14
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L273
	.loc 1 1019 32
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1019 15
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL16:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 1020 21
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 1020 50
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 1020 42
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 1020 17
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L271
.L273:
	.loc 1 1022 34
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1022 17
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL17:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L271
.L272:
	.loc 1 1025 15
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L271:
	.loc 1 1027 12
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-168]
.L185:
	.loc 1 694 13
	ldr	r3, [fp, #-168]
	cmp	r3, #0
	bgt	.L275
	.loc 1 1029 11
	ldr	r3, [fp, #-172]
	str	r3, [fp, #-8]
.LBE16:
	.loc 1 1031 5
	ldr	r0, [fp, #-8]
	bl	putint
	.loc 1 1032 5
	mov	r0, #10
	bl	putch
	.loc 1 1033 9
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L184:
	.loc 1 691 9
	ldr	r3, [fp, #-24]
	cmp	r3, #15
	ble	.L276
	.loc 1 1035 7
	mov	r3, #0
	str	r3, [fp, #-24]
	.loc 1 1036 9
	b	.L277
.L371:
.LBB23:
	.loc 1 1038 11
	mov	r3, #2
	str	r3, [fp, #-232]
	.loc 1 1038 19
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-236]
	.loc 1 1038 29
	mov	r3, #1
	str	r3, [fp, #-240]
	.loc 1 1039 13
	b	.L278
.L368:
	.loc 1 1040 13
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1041 11
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1042 11
	ldr	r3, [fp, #-236]
	str	r3, [fp, #-16]
	.loc 1 1043 11
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1044 15
	b	.L279
.L281:
	.loc 1 1045 15
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1045 14
	cmp	r3, #0
	beq	.L280
	.loc 1 1045 21 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L280
	.loc 1 1046 40
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1046 17
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L280:
	.loc 1 1048 13
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1049 13
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1050 13
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L279:
	.loc 1 1044 15
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L281
	.loc 1 1052 12
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L282
.LBB24:
	.loc 1 1054 17
	ldr	r3, [fp, #-240]
	str	r3, [fp, #-244]
	.loc 1 1054 28
	ldr	r3, [fp, #-232]
	str	r3, [fp, #-248]
	.loc 1 1054 37
	mov	r3, #0
	str	r3, [fp, #-252]
	.loc 1 1055 19
	b	.L283
.L321:
	.loc 1 1056 19
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1057 17
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1058 17
	ldr	r3, [fp, #-248]
	str	r3, [fp, #-16]
	.loc 1 1059 17
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1060 21
	b	.L284
.L286:
	.loc 1 1061 21
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1061 20
	cmp	r3, #0
	beq	.L285
	.loc 1 1061 27 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L285
	.loc 1 1062 46
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1062 23
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L285:
	.loc 1 1064 19
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1065 19
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1066 19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L284:
	.loc 1 1060 21
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L286
	.loc 1 1068 18
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L287
.LBB25:
	.loc 1 1070 23
	ldr	r3, [fp, #-252]
	str	r3, [fp, #-256]
	.loc 1 1070 34
	ldr	r3, [fp, #-244]
	str	r3, [fp, #-260]
	.loc 1 1071 25
	b	.L288
.L300:
	.loc 1 1072 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1073 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1074 23
	ldr	r3, [fp, #-256]
	str	r3, [fp, #-16]
	.loc 1 1075 23
	ldr	r3, [fp, #-260]
	str	r3, [fp, #-20]
	.loc 1 1076 27
	b	.L289
.L293:
	.loc 1 1077 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1077 26
	cmp	r3, #0
	beq	.L290
	.loc 1 1078 35
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1078 28
	cmp	r3, #0
	bne	.L292
	.loc 1 1079 54
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1079 31
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L292
.L290:
	.loc 1 1081 34
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1081 33
	cmp	r3, #0
	beq	.L292
	.loc 1 1082 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1082 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L292:
	.loc 1 1084 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1085 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1086 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L289:
	.loc 1 1076 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L293
	.loc 1 1088 25
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-348]
	.loc 1 1089 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1090 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1091 23
	ldr	r3, [fp, #-256]
	str	r3, [fp, #-16]
	.loc 1 1092 23
	ldr	r3, [fp, #-260]
	str	r3, [fp, #-20]
	.loc 1 1093 27
	b	.L294
.L296:
	.loc 1 1094 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1094 26
	cmp	r3, #0
	beq	.L295
	.loc 1 1094 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L295
	.loc 1 1095 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1095 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L295:
	.loc 1 1097 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1098 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1099 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L294:
	.loc 1 1093 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L296
	.loc 1 1101 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-260]
	.loc 1 1105 27
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1106 25
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1107 42
	mov	r2, #2
	.loc 1 1107 25
	ldr	r3, [fp, #-260]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 1108 25
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 1109 29
	b	.L297
.L299:
	.loc 1 1110 29
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1110 28
	cmp	r3, #0
	beq	.L298
	.loc 1 1110 35 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L298
	.loc 1 1111 54
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1111 31
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L298:
	.loc 1 1113 27
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1114 27
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1115 27
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L297:
	.loc 1 1109 29
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L299
	.loc 1 1118 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-260]
	.loc 1 1119 24
	ldr	r3, [fp, #-348]
	str	r3, [fp, #-256]
.L288:
	.loc 1 1071 25
	ldr	r3, [fp, #-260]
	cmp	r3, #0
	bne	.L300
	.loc 1 1121 23
	ldr	r3, [fp, #-256]
	str	r3, [fp, #-8]
.LBE25:
	.loc 1 1123 22
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-252]
.L287:
.LBB26:
	.loc 1 1126 21
	ldr	r3, [fp, #-244]
	str	r3, [fp, #-264]
	.loc 1 1126 30
	ldr	r3, [fp, #-244]
	str	r3, [fp, #-268]
	.loc 1 1127 23
	b	.L301
.L313:
	.loc 1 1128 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1129 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1130 21
	ldr	r3, [fp, #-264]
	str	r3, [fp, #-16]
	.loc 1 1131 21
	ldr	r3, [fp, #-268]
	str	r3, [fp, #-20]
	.loc 1 1132 25
	b	.L302
.L306:
	.loc 1 1133 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1133 24
	cmp	r3, #0
	beq	.L303
	.loc 1 1134 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1134 26
	cmp	r3, #0
	bne	.L305
	.loc 1 1135 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1135 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L305
.L375:
	.align	2
.L374:
	.word	65535
	.word	SHIFT_TABLE
.L303:
	.loc 1 1137 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1137 31
	cmp	r3, #0
	beq	.L305
	.loc 1 1138 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1138 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L305:
	.loc 1 1140 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1141 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1142 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L302:
	.loc 1 1132 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L306
	.loc 1 1144 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-352]
	.loc 1 1145 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1146 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1147 21
	ldr	r3, [fp, #-264]
	str	r3, [fp, #-16]
	.loc 1 1148 21
	ldr	r3, [fp, #-268]
	str	r3, [fp, #-20]
	.loc 1 1149 25
	b	.L307
.L309:
	.loc 1 1150 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1150 24
	cmp	r3, #0
	beq	.L308
	.loc 1 1150 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L308
	.loc 1 1151 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1151 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L308:
	.loc 1 1153 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1154 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1155 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L307:
	.loc 1 1149 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L309
	.loc 1 1157 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-268]
	.loc 1 1161 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1162 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1163 40
	mov	r2, #2
	.loc 1 1163 23
	ldr	r3, [fp, #-268]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 1164 23
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 1165 27
	b	.L310
.L312:
	.loc 1 1166 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1166 26
	cmp	r3, #0
	beq	.L311
	.loc 1 1166 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L311
	.loc 1 1167 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1167 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L311:
	.loc 1 1169 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1170 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1171 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L310:
	.loc 1 1165 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L312
	.loc 1 1174 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-268]
	.loc 1 1175 22
	ldr	r3, [fp, #-352]
	str	r3, [fp, #-264]
.L301:
	.loc 1 1127 23
	ldr	r3, [fp, #-268]
	cmp	r3, #0
	bne	.L313
	.loc 1 1177 21
	ldr	r3, [fp, #-264]
	str	r3, [fp, #-8]
.LBE26:
	.loc 1 1179 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-244]
	.loc 1 1180 17
	ldr	r3, [fp, #-248]
	str	r3, [fp, #-16]
	.loc 1 1181 17
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1182 18
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L314
	.loc 1 1183 20
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L315
	.loc 1 1184 23
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L317
.L315:
	.loc 1 1186 23
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L317
.L314:
	.loc 1 1188 25
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L318
	.loc 1 1189 20
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L319
	.loc 1 1190 38
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1190 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL18:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 1191 27
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 1191 56
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 1191 48
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 1191 23
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L317
.L319:
	.loc 1 1193 40
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1193 23
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL19:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L317
.L318:
	.loc 1 1196 21
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L317:
	.loc 1 1198 18
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-248]
.L283:
	.loc 1 1055 19
	ldr	r3, [fp, #-248]
	cmp	r3, #0
	bne	.L321
	.loc 1 1200 17
	ldr	r3, [fp, #-252]
	str	r3, [fp, #-8]
.LBE24:
	.loc 1 1202 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-240]
.L282:
.LBB27:
	.loc 1 1205 15
	ldr	r3, [fp, #-232]
	str	r3, [fp, #-272]
	.loc 1 1205 24
	ldr	r3, [fp, #-232]
	str	r3, [fp, #-276]
	.loc 1 1205 33
	mov	r3, #0
	str	r3, [fp, #-280]
	.loc 1 1206 17
	b	.L322
.L360:
	.loc 1 1207 17
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1208 15
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1209 15
	ldr	r3, [fp, #-276]
	str	r3, [fp, #-16]
	.loc 1 1210 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1211 19
	b	.L323
.L325:
	.loc 1 1212 19
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1212 18
	cmp	r3, #0
	beq	.L324
	.loc 1 1212 25 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L324
	.loc 1 1213 44
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1213 21
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L324:
	.loc 1 1215 17
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1216 17
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1217 17
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L323:
	.loc 1 1211 19
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L325
	.loc 1 1219 16
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L326
.LBB28:
	.loc 1 1221 21
	ldr	r3, [fp, #-280]
	str	r3, [fp, #-284]
	.loc 1 1221 32
	ldr	r3, [fp, #-272]
	str	r3, [fp, #-288]
	.loc 1 1222 23
	b	.L327
.L339:
	.loc 1 1223 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1224 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1225 21
	ldr	r3, [fp, #-284]
	str	r3, [fp, #-16]
	.loc 1 1226 21
	ldr	r3, [fp, #-288]
	str	r3, [fp, #-20]
	.loc 1 1227 25
	b	.L328
.L332:
	.loc 1 1228 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1228 24
	cmp	r3, #0
	beq	.L329
	.loc 1 1229 33
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1229 26
	cmp	r3, #0
	bne	.L331
	.loc 1 1230 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1230 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L331
.L329:
	.loc 1 1232 32
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1232 31
	cmp	r3, #0
	beq	.L331
	.loc 1 1233 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1233 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L331:
	.loc 1 1235 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1236 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1237 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L328:
	.loc 1 1227 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L332
	.loc 1 1239 23
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-356]
	.loc 1 1240 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1241 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1242 21
	ldr	r3, [fp, #-284]
	str	r3, [fp, #-16]
	.loc 1 1243 21
	ldr	r3, [fp, #-288]
	str	r3, [fp, #-20]
	.loc 1 1244 25
	b	.L333
.L335:
	.loc 1 1245 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1245 24
	cmp	r3, #0
	beq	.L334
	.loc 1 1245 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L334
	.loc 1 1246 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1246 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L334:
	.loc 1 1248 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1249 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1250 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L333:
	.loc 1 1244 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L335
	.loc 1 1252 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-288]
	.loc 1 1256 25
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1257 23
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1258 40
	mov	r2, #2
	.loc 1 1258 23
	ldr	r3, [fp, #-288]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 1259 23
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 1260 27
	b	.L336
.L338:
	.loc 1 1261 27
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1261 26
	cmp	r3, #0
	beq	.L337
	.loc 1 1261 33 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L337
	.loc 1 1262 52
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1262 29
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L337:
	.loc 1 1264 25
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1265 25
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1266 25
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L336:
	.loc 1 1260 27
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L338
	.loc 1 1269 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-288]
	.loc 1 1270 22
	ldr	r3, [fp, #-356]
	str	r3, [fp, #-284]
.L327:
	.loc 1 1222 23
	ldr	r3, [fp, #-288]
	cmp	r3, #0
	bne	.L339
	.loc 1 1272 21
	ldr	r3, [fp, #-284]
	str	r3, [fp, #-8]
.LBE28:
	.loc 1 1274 20
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-280]
.L326:
.LBB29:
	.loc 1 1277 19
	ldr	r3, [fp, #-272]
	str	r3, [fp, #-292]
	.loc 1 1277 28
	ldr	r3, [fp, #-272]
	str	r3, [fp, #-296]
	.loc 1 1278 21
	b	.L340
.L352:
	.loc 1 1279 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1280 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1281 19
	ldr	r3, [fp, #-292]
	str	r3, [fp, #-16]
	.loc 1 1282 19
	ldr	r3, [fp, #-296]
	str	r3, [fp, #-20]
	.loc 1 1283 23
	b	.L341
.L345:
	.loc 1 1284 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1284 22
	cmp	r3, #0
	beq	.L342
	.loc 1 1285 31
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1285 24
	cmp	r3, #0
	bne	.L344
	.loc 1 1286 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1286 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L344
.L342:
	.loc 1 1288 30
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	.loc 1 1288 29
	cmp	r3, #0
	beq	.L344
	.loc 1 1289 48
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1289 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L344:
	.loc 1 1291 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1292 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1293 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L341:
	.loc 1 1283 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L345
	.loc 1 1295 21
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-360]
	.loc 1 1296 21
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1297 19
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1298 19
	ldr	r3, [fp, #-292]
	str	r3, [fp, #-16]
	.loc 1 1299 19
	ldr	r3, [fp, #-296]
	str	r3, [fp, #-20]
	.loc 1 1300 23
	b	.L346
.L348:
	.loc 1 1301 23
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1301 22
	cmp	r3, #0
	beq	.L347
	.loc 1 1301 29 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L347
	.loc 1 1302 48
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1302 25
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L347:
	.loc 1 1304 21
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1305 21
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1306 21
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L346:
	.loc 1 1300 23
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L348
	.loc 1 1308 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-296]
	.loc 1 1312 23
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 1313 21
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 1314 38
	mov	r2, #2
	.loc 1 1314 21
	ldr	r3, [fp, #-296]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	.loc 1 1315 21
	ldr	r3, .L374
	str	r3, [fp, #-20]
	.loc 1 1316 25
	b	.L349
.L351:
	.loc 1 1317 25
	ldr	r3, [fp, #-16]
	and	r3, r3, #1
	.loc 1 1317 24
	cmp	r3, #0
	beq	.L350
	.loc 1 1317 31 discriminator 1
	ldr	r3, [fp, #-20]
	and	r3, r3, #1
	cmp	r3, #0
	beq	.L350
	.loc 1 1318 50
	ldr	r2, .L374+4
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1318 27
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	str	r3, [fp, #-8]
.L350:
	.loc 1 1320 23
	ldr	r3, [fp, #-16]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-16]
	.loc 1 1321 23
	ldr	r3, [fp, #-20]
	lsr	r2, r3, #31
	add	r3, r2, r3
	asr	r3, r3, #1
	str	r3, [fp, #-20]
	.loc 1 1322 23
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L349:
	.loc 1 1316 25
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L351
	.loc 1 1325 19
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-296]
	.loc 1 1326 20
	ldr	r3, [fp, #-360]
	str	r3, [fp, #-292]
.L340:
	.loc 1 1278 21
	ldr	r3, [fp, #-296]
	cmp	r3, #0
	bne	.L352
	.loc 1 1328 19
	ldr	r3, [fp, #-292]
	str	r3, [fp, #-8]
.LBE29:
	.loc 1 1330 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-272]
	.loc 1 1331 15
	ldr	r3, [fp, #-276]
	str	r3, [fp, #-16]
	.loc 1 1332 15
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1333 16
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L353
	.loc 1 1334 18
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L354
	.loc 1 1335 21
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L356
.L354:
	.loc 1 1337 21
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L356
.L353:
	.loc 1 1339 23
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L357
	.loc 1 1340 18
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L358
	.loc 1 1341 36
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1341 19
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL20:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 1342 25
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 1342 54
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 1342 46
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 1342 21
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L356
.L358:
	.loc 1 1344 38
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1344 21
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL21:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L356
.L357:
	.loc 1 1347 19
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L356:
	.loc 1 1349 16
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-276]
.L322:
	.loc 1 1206 17
	ldr	r3, [fp, #-276]
	cmp	r3, #0
	bne	.L360
	.loc 1 1351 15
	ldr	r3, [fp, #-280]
	str	r3, [fp, #-8]
.LBE27:
	.loc 1 1353 12
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-232]
	.loc 1 1354 11
	ldr	r3, [fp, #-236]
	str	r3, [fp, #-16]
	.loc 1 1355 11
	mov	r3, #1
	str	r3, [fp, #-20]
	.loc 1 1356 12
	ldr	r3, [fp, #-20]
	cmp	r3, #14
	ble	.L361
	.loc 1 1357 14
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L362
	.loc 1 1358 17
	ldr	r3, .L374
	str	r3, [fp, #-8]
	b	.L364
.L362:
	.loc 1 1360 17
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L364
.L361:
	.loc 1 1362 19
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	ble	.L365
	.loc 1 1363 14
	ldr	r3, [fp, #-16]
	cmp	r3, #32768
	blt	.L366
	.loc 1 1364 32
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1364 15
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL22:
	mov	r3, r0
	str	r3, [fp, #-16]
	.loc 1 1365 21
	ldr	r3, [fp, #-16]
	add	r2, r3, #65536
	.loc 1 1365 50
	ldr	r3, [fp, #-20]
	rsb	r3, r3, #16
	.loc 1 1365 42
	ldr	r1, .L374+4
	ldr	r3, [r1, r3, lsl #2]
	.loc 1 1365 17
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L364
.L366:
	.loc 1 1367 34
	ldr	r2, .L374+4
	ldr	r3, [fp, #-20]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1367 17
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	__aeabi_idiv
.LVL23:
	mov	r3, r0
	str	r3, [fp, #-8]
	b	.L364
.L365:
	.loc 1 1370 15
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
.L364:
	.loc 1 1372 12
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-236]
.L278:
	.loc 1 1039 13
	ldr	r3, [fp, #-236]
	cmp	r3, #0
	bgt	.L368
	.loc 1 1374 11
	ldr	r3, [fp, #-240]
	str	r3, [fp, #-8]
.LBE23:
	.loc 1 1376 20
	ldr	r2, .L374+4
	ldr	r3, [fp, #-24]
	ldr	r3, [r2, r3, lsl #2]
	.loc 1 1376 8
	ldr	r2, [fp, #-8]
	cmp	r2, r3
	beq	.L369
	.loc 1 1376 41 discriminator 1
	mov	r3, #1
	b	.L370
.L369:
	.loc 1 1377 9
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L277:
	.loc 1 1036 9
	ldr	r3, [fp, #-24]
	cmp	r3, #15
	ble	.L371
	.loc 1 1379 10
	mov	r3, #0
.L370:
	.loc 1 1380 1
	mov	r0, r3
	sub	sp, fp, #4
	.cfi_def_cfa 13, 8
	@ sp needed
	pop	{fp, pc}
	.cfi_endproc
.LFE0:
	.size	long_func, .-long_func
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
.LFB1:
	.loc 1 1382 12
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	add	fp, sp, #4
	.cfi_def_cfa 11, 4
	.loc 1 1383 10
	bl	long_func
	mov	r3, r0
	.loc 1 1384 1
	mov	r0, r3
	pop	{fp, pc}
	.cfi_endproc
.LFE1:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/8/include/stddef.h"
	.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
	.file 4 "/usr/include/arm-linux-gnueabihf/bits/types/struct_FILE.h"
	.file 5 "/usr/include/arm-linux-gnueabihf/bits/types/FILE.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/arm-linux-gnueabihf/bits/sys_errlist.h"
	.file 8 "/usr/include/arm-linux-gnueabihf/bits/types/struct_timeval.h"
	.file 9 "/usr/include/arm-linux-gnueabihf/sys/time.h"
	.file 10 "./sysyruntime/sylib.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xb38
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF73
	.byte	0xc
	.4byte	.LASF74
	.4byte	.LASF75
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF8
	.byte	0x2
	.byte	0xd8
	.byte	0x17
	.4byte	0x31
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x4
	.byte	0x4
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x6
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.4byte	.LASF9
	.byte	0x3
	.byte	0x41
	.byte	0x25
	.4byte	0x69
	.uleb128 0x2
	.4byte	.LASF10
	.byte	0x3
	.byte	0x96
	.byte	0x19
	.4byte	0x8f
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF11
	.uleb128 0x2
	.4byte	.LASF12
	.byte	0x3
	.byte	0x97
	.byte	0x1b
	.4byte	0x77
	.uleb128 0x2
	.4byte	.LASF13
	.byte	0x3
	.byte	0x9e
	.byte	0x1a
	.4byte	0x8f
	.uleb128 0x2
	.4byte	.LASF14
	.byte	0x3
	.byte	0xa0
	.byte	0x1f
	.4byte	0x8f
	.uleb128 0x7
	.byte	0x4
	.4byte	0xc0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF15
	.uleb128 0x6
	.4byte	0xc0
	.uleb128 0x8
	.4byte	.LASF54
	.byte	0x98
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.4byte	0x253
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.4byte	0x5d
	.byte	0
	.uleb128 0x9
	.4byte	.LASF17
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.4byte	0xba
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF18
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.4byte	0xba
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF19
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.4byte	0xba
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF20
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.4byte	0xba
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF21
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.4byte	0xba
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF22
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.4byte	0xba
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF23
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.4byte	0xba
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF24
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.4byte	0xba
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF25
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.4byte	0xba
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.4byte	0xba
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.4byte	0xba
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.4byte	0x26c
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.4byte	0x272
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.4byte	0x5d
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.4byte	0x5d
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.4byte	0x83
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.4byte	0x41
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.4byte	0x4f
	.byte	0x46
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.4byte	0x278
	.byte	0x47
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.4byte	0x288
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.4byte	0x96
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.4byte	0x293
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.4byte	0x29e
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF40
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.4byte	0x272
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF41
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.4byte	0x38
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF42
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.4byte	0x25
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF43
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.4byte	0x5d
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF44
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.4byte	0x2a4
	.byte	0x70
	.byte	0
	.uleb128 0x2
	.4byte	.LASF45
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.4byte	0xcc
	.uleb128 0xa
	.4byte	.LASF76
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.4byte	.LASF46
	.uleb128 0x7
	.byte	0x4
	.4byte	0x267
	.uleb128 0x7
	.byte	0x4
	.4byte	0xcc
	.uleb128 0xc
	.4byte	0xc0
	.4byte	0x288
	.uleb128 0xd
	.4byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x25f
	.uleb128 0xb
	.4byte	.LASF47
	.uleb128 0x7
	.byte	0x4
	.4byte	0x28e
	.uleb128 0xb
	.4byte	.LASF48
	.uleb128 0x7
	.byte	0x4
	.4byte	0x299
	.uleb128 0xc
	.4byte	0xc0
	.4byte	0x2b4
	.uleb128 0xd
	.4byte	0x31
	.byte	0x27
	.byte	0
	.uleb128 0xe
	.4byte	.LASF49
	.byte	0x6
	.byte	0x89
	.byte	0xe
	.4byte	0x2c0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x253
	.uleb128 0xe
	.4byte	.LASF50
	.byte	0x6
	.byte	0x8a
	.byte	0xe
	.4byte	0x2c0
	.uleb128 0xe
	.4byte	.LASF51
	.byte	0x6
	.byte	0x8b
	.byte	0xe
	.4byte	0x2c0
	.uleb128 0xe
	.4byte	.LASF52
	.byte	0x7
	.byte	0x1a
	.byte	0xc
	.4byte	0x5d
	.uleb128 0xc
	.4byte	0x300
	.4byte	0x2f5
	.uleb128 0xf
	.byte	0
	.uleb128 0x6
	.4byte	0x2ea
	.uleb128 0x7
	.byte	0x4
	.4byte	0xc7
	.uleb128 0x6
	.4byte	0x2fa
	.uleb128 0xe
	.4byte	.LASF53
	.byte	0x7
	.byte	0x1b
	.byte	0x1a
	.4byte	0x2f5
	.uleb128 0x8
	.4byte	.LASF55
	.byte	0x8
	.byte	0x8
	.byte	0x8
	.byte	0x8
	.4byte	0x339
	.uleb128 0x9
	.4byte	.LASF56
	.byte	0x8
	.byte	0xa
	.byte	0xc
	.4byte	0xa2
	.byte	0
	.uleb128 0x9
	.4byte	.LASF57
	.byte	0x8
	.byte	0xb
	.byte	0x11
	.4byte	0xae
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.4byte	.LASF58
	.byte	0x8
	.byte	0x9
	.byte	0x34
	.byte	0x8
	.4byte	0x361
	.uleb128 0x9
	.4byte	.LASF59
	.byte	0x9
	.byte	0x36
	.byte	0x9
	.4byte	0x5d
	.byte	0
	.uleb128 0x9
	.4byte	.LASF60
	.byte	0x9
	.byte	0x37
	.byte	0x9
	.4byte	0x5d
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x339
	.uleb128 0x10
	.4byte	0x361
	.uleb128 0x11
	.4byte	.LASF61
	.byte	0xa
	.byte	0xc
	.byte	0x10
	.4byte	0x311
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_start
	.uleb128 0x11
	.4byte	.LASF62
	.byte	0xa
	.byte	0xc
	.byte	0x1c
	.4byte	0x311
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_end
	.uleb128 0xc
	.4byte	0x5d
	.4byte	0x3a1
	.uleb128 0x12
	.4byte	0x31
	.2byte	0x3ff
	.byte	0
	.uleb128 0x11
	.4byte	.LASF63
	.byte	0xa
	.byte	0x10
	.byte	0x5
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_l1
	.uleb128 0x11
	.4byte	.LASF64
	.byte	0xa
	.byte	0x10
	.byte	0x17
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_l2
	.uleb128 0x11
	.4byte	.LASF65
	.byte	0xa
	.byte	0x11
	.byte	0x5
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_h
	.uleb128 0x11
	.4byte	.LASF66
	.byte	0xa
	.byte	0x11
	.byte	0x17
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_m
	.uleb128 0x11
	.4byte	.LASF67
	.byte	0xa
	.byte	0x11
	.byte	0x28
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_s
	.uleb128 0x11
	.4byte	.LASF68
	.byte	0xa
	.byte	0x11
	.byte	0x39
	.4byte	0x390
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_us
	.uleb128 0x11
	.4byte	.LASF69
	.byte	0xa
	.byte	0x12
	.byte	0x5
	.4byte	0x5d
	.uleb128 0x5
	.byte	0x3
	.4byte	_sysy_idx
	.uleb128 0xc
	.4byte	0x64
	.4byte	0x42f
	.uleb128 0xd
	.4byte	0x31
	.byte	0xf
	.byte	0
	.uleb128 0x6
	.4byte	0x41f
	.uleb128 0x11
	.4byte	.LASF70
	.byte	0x1
	.byte	0x3
	.byte	0xb
	.4byte	0x42f
	.uleb128 0x5
	.byte	0x3
	.4byte	SHIFT_TABLE
	.uleb128 0x13
	.4byte	.LASF77
	.byte	0x1
	.2byte	0x566
	.byte	0x5
	.4byte	0x5d
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x14
	.4byte	.LASF78
	.byte	0x1
	.byte	0x6
	.byte	0x5
	.4byte	0x5d
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x15
	.ascii	"ans\000"
	.byte	0x1
	.byte	0x7
	.byte	0x7
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x15
	.ascii	"i\000"
	.byte	0x1
	.byte	0x7
	.byte	0xc
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x15
	.ascii	"x\000"
	.byte	0x1
	.byte	0x7
	.byte	0xf
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x15
	.ascii	"y\000"
	.byte	0x1
	.byte	0x7
	.byte	0x12
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.ascii	"cur\000"
	.byte	0x1
	.byte	0x7
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x16
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.4byte	0x643
	.uleb128 0x15
	.ascii	"pl\000"
	.byte	0x1
	.byte	0x9
	.byte	0x9
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x15
	.ascii	"pr\000"
	.byte	0x1
	.byte	0x9
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x17
	.4byte	.LASF71
	.byte	0x1
	.byte	0x9
	.byte	0x19
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x16
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.4byte	0x598
	.uleb128 0x15
	.ascii	"ml\000"
	.byte	0x1
	.byte	0x19
	.byte	0xf
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x15
	.ascii	"mr\000"
	.byte	0x1
	.byte	0x19
	.byte	0x1a
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x17
	.4byte	.LASF72
	.byte	0x1
	.byte	0x19
	.byte	0x23
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x16
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.4byte	0x561
	.uleb128 0x15
	.ascii	"al\000"
	.byte	0x1
	.byte	0x29
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x15
	.ascii	"c\000"
	.byte	0x1
	.byte	0x29
	.byte	0x20
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x15
	.ascii	"sum\000"
	.byte	0x1
	.byte	0x29
	.byte	0x28
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -304
	.byte	0
	.uleb128 0x18
	.4byte	.LBB5
	.4byte	.LBE5-.LBB5
	.uleb128 0x15
	.ascii	"al\000"
	.byte	0x1
	.byte	0x61
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x15
	.ascii	"c\000"
	.byte	0x1
	.byte	0x61
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x15
	.ascii	"sum\000"
	.byte	0x1
	.byte	0x61
	.byte	0x24
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -308
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LBB6
	.4byte	.LBE6-.LBB6
	.uleb128 0x15
	.ascii	"ml\000"
	.byte	0x1
	.byte	0xb0
	.byte	0xd
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x15
	.ascii	"mr\000"
	.byte	0x1
	.byte	0xb0
	.byte	0x16
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x17
	.4byte	.LASF72
	.byte	0x1
	.byte	0xb0
	.byte	0x1f
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x16
	.4byte	.LBB7
	.4byte	.LBE7-.LBB7
	.4byte	0x60a
	.uleb128 0x15
	.ascii	"al\000"
	.byte	0x1
	.byte	0xc0
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x15
	.ascii	"c\000"
	.byte	0x1
	.byte	0xc0
	.byte	0x1e
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x15
	.ascii	"sum\000"
	.byte	0x1
	.byte	0xc0
	.byte	0x26
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -312
	.byte	0
	.uleb128 0x18
	.4byte	.LBB8
	.4byte	.LBE8-.LBB8
	.uleb128 0x15
	.ascii	"al\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.uleb128 0x15
	.ascii	"c\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x1a
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x15
	.ascii	"sum\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x22
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -316
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.4byte	.LBB9
	.4byte	.LBE9-.LBB9
	.4byte	0x7ec
	.uleb128 0x19
	.ascii	"pl\000"
	.byte	0x1
	.2byte	0x15e
	.byte	0x9
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -100
	.uleb128 0x19
	.ascii	"pr\000"
	.byte	0x1
	.2byte	0x15e
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1a
	.4byte	.LASF71
	.byte	0x1
	.2byte	0x15e
	.byte	0x19
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.uleb128 0x16
	.4byte	.LBB10
	.4byte	.LBE10-.LBB10
	.4byte	0x738
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x16e
	.byte	0xf
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x16e
	.byte	0x1a
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x16e
	.byte	0x23
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x16
	.4byte	.LBB11
	.4byte	.LBE11-.LBB11
	.4byte	0x6fd
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x17e
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -124
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x17e
	.byte	0x20
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x17e
	.byte	0x28
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -320
	.byte	0
	.uleb128 0x18
	.4byte	.LBB12
	.4byte	.LBE12-.LBB12
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x1b6
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -132
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x1b6
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x1b6
	.byte	0x24
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -324
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LBB13
	.4byte	.LBE13-.LBB13
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x205
	.byte	0xd
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -140
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x205
	.byte	0x16
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x205
	.byte	0x1f
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x16
	.4byte	.LBB14
	.4byte	.LBE14-.LBB14
	.4byte	0x7b0
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x215
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x215
	.byte	0x1e
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -156
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x215
	.byte	0x26
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -328
	.byte	0
	.uleb128 0x18
	.4byte	.LBB15
	.4byte	.LBE15-.LBB15
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x24d
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x24d
	.byte	0x1a
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -164
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x24d
	.byte	0x22
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -332
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.4byte	.LBB16
	.4byte	.LBE16-.LBB16
	.4byte	0x995
	.uleb128 0x19
	.ascii	"pl\000"
	.byte	0x1
	.2byte	0x2b5
	.byte	0xb
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.uleb128 0x19
	.ascii	"pr\000"
	.byte	0x1
	.2byte	0x2b5
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -172
	.uleb128 0x1a
	.4byte	.LASF71
	.byte	0x1
	.2byte	0x2b5
	.byte	0x1d
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x16
	.4byte	.LBB17
	.4byte	.LBE17-.LBB17
	.4byte	0x8e1
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x2c5
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -180
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x2c5
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -184
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x2c5
	.byte	0x25
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -188
	.uleb128 0x16
	.4byte	.LBB18
	.4byte	.LBE18-.LBB18
	.4byte	0x8a6
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x2d5
	.byte	0x17
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -192
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x2d5
	.byte	0x22
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -196
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x2d5
	.byte	0x2a
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -336
	.byte	0
	.uleb128 0x18
	.4byte	.LBB19
	.4byte	.LBE19-.LBB19
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x30d
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -200
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x30d
	.byte	0x1e
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -204
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x30d
	.byte	0x26
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -340
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LBB20
	.4byte	.LBE20-.LBB20
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x35c
	.byte	0xf
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -208
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x35c
	.byte	0x18
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -212
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x35c
	.byte	0x21
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -216
	.uleb128 0x16
	.4byte	.LBB21
	.4byte	.LBE21-.LBB21
	.4byte	0x959
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x36c
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -220
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x36c
	.byte	0x20
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -224
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x36c
	.byte	0x28
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -344
	.byte	0
	.uleb128 0x18
	.4byte	.LBB22
	.4byte	.LBE22-.LBB22
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x3a4
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -228
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x3a4
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -232
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x3a4
	.byte	0x24
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -348
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LBB23
	.4byte	.LBE23-.LBB23
	.uleb128 0x19
	.ascii	"pl\000"
	.byte	0x1
	.2byte	0x40e
	.byte	0xb
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -236
	.uleb128 0x19
	.ascii	"pr\000"
	.byte	0x1
	.2byte	0x40e
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -240
	.uleb128 0x1a
	.4byte	.LASF71
	.byte	0x1
	.2byte	0x40e
	.byte	0x1d
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -244
	.uleb128 0x16
	.4byte	.LBB24
	.4byte	.LBE24-.LBB24
	.4byte	0xa86
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x41e
	.byte	0x11
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -248
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x41e
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -252
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x41e
	.byte	0x25
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -256
	.uleb128 0x16
	.4byte	.LBB25
	.4byte	.LBE25-.LBB25
	.4byte	0xa4b
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x42e
	.byte	0x17
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -260
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x42e
	.byte	0x22
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -264
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x42e
	.byte	0x2a
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -352
	.byte	0
	.uleb128 0x18
	.4byte	.LBB26
	.4byte	.LBE26-.LBB26
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x466
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -268
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x466
	.byte	0x1e
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -272
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x466
	.byte	0x26
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -356
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LBB27
	.4byte	.LBE27-.LBB27
	.uleb128 0x19
	.ascii	"ml\000"
	.byte	0x1
	.2byte	0x4b5
	.byte	0xf
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -276
	.uleb128 0x19
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x4b5
	.byte	0x18
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -280
	.uleb128 0x1a
	.4byte	.LASF72
	.byte	0x1
	.2byte	0x4b5
	.byte	0x21
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -284
	.uleb128 0x16
	.4byte	.LBB28
	.4byte	.LBE28-.LBB28
	.4byte	0xafe
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x4c5
	.byte	0x15
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -288
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x4c5
	.byte	0x20
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -292
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x4c5
	.byte	0x28
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -360
	.byte	0
	.uleb128 0x18
	.4byte	.LBB29
	.4byte	.LBE29-.LBB29
	.uleb128 0x19
	.ascii	"al\000"
	.byte	0x1
	.2byte	0x4fd
	.byte	0x13
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -296
	.uleb128 0x19
	.ascii	"c\000"
	.byte	0x1
	.2byte	0x4fd
	.byte	0x1c
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -300
	.uleb128 0x19
	.ascii	"sum\000"
	.byte	0x1
	.2byte	0x4fd
	.byte	0x24
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -364
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF24:
	.ascii	"_IO_buf_end\000"
.LASF9:
	.ascii	"__quad_t\000"
.LASF32:
	.ascii	"_old_offset\000"
.LASF71:
	.ascii	"pres\000"
.LASF56:
	.ascii	"tv_sec\000"
.LASF52:
	.ascii	"sys_nerr\000"
.LASF27:
	.ascii	"_IO_save_end\000"
.LASF78:
	.ascii	"long_func\000"
.LASF5:
	.ascii	"short int\000"
.LASF8:
	.ascii	"size_t\000"
.LASF64:
	.ascii	"_sysy_l2\000"
.LASF37:
	.ascii	"_offset\000"
.LASF73:
	.ascii	"GNU C17 8.3.0 -mfloat-abi=hard -mfpu=vfp -mtls-dial"
	.ascii	"ect=gnu -marm -march=armv6+fp -g\000"
.LASF72:
	.ascii	"mres\000"
.LASF21:
	.ascii	"_IO_write_ptr\000"
.LASF16:
	.ascii	"_flags\000"
.LASF23:
	.ascii	"_IO_buf_base\000"
.LASF28:
	.ascii	"_markers\000"
.LASF18:
	.ascii	"_IO_read_end\000"
.LASF41:
	.ascii	"_freeres_buf\000"
.LASF58:
	.ascii	"timezone\000"
.LASF65:
	.ascii	"_sysy_h\000"
.LASF66:
	.ascii	"_sysy_m\000"
.LASF45:
	.ascii	"FILE\000"
.LASF51:
	.ascii	"stderr\000"
.LASF6:
	.ascii	"long long int\000"
.LASF36:
	.ascii	"_lock\000"
.LASF11:
	.ascii	"long int\000"
.LASF33:
	.ascii	"_cur_column\000"
.LASF60:
	.ascii	"tz_dsttime\000"
.LASF63:
	.ascii	"_sysy_l1\000"
.LASF74:
	.ascii	"try.c\000"
.LASF70:
	.ascii	"SHIFT_TABLE\000"
.LASF54:
	.ascii	"_IO_FILE\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF69:
	.ascii	"_sysy_idx\000"
.LASF4:
	.ascii	"signed char\000"
.LASF38:
	.ascii	"_codecvt\000"
.LASF7:
	.ascii	"long long unsigned int\000"
.LASF62:
	.ascii	"_sysy_end\000"
.LASF0:
	.ascii	"unsigned int\000"
.LASF46:
	.ascii	"_IO_marker\000"
.LASF35:
	.ascii	"_shortbuf\000"
.LASF20:
	.ascii	"_IO_write_base\000"
.LASF44:
	.ascii	"_unused2\000"
.LASF17:
	.ascii	"_IO_read_ptr\000"
.LASF2:
	.ascii	"short unsigned int\000"
.LASF15:
	.ascii	"char\000"
.LASF77:
	.ascii	"main\000"
.LASF39:
	.ascii	"_wide_data\000"
.LASF40:
	.ascii	"_freeres_list\000"
.LASF59:
	.ascii	"tz_minuteswest\000"
.LASF42:
	.ascii	"__pad5\000"
.LASF75:
	.ascii	"/home/pi/atest\000"
.LASF47:
	.ascii	"_IO_codecvt\000"
.LASF3:
	.ascii	"long unsigned int\000"
.LASF22:
	.ascii	"_IO_write_end\000"
.LASF12:
	.ascii	"__off64_t\000"
.LASF68:
	.ascii	"_sysy_us\000"
.LASF10:
	.ascii	"__off_t\000"
.LASF29:
	.ascii	"_chain\000"
.LASF55:
	.ascii	"timeval\000"
.LASF13:
	.ascii	"__time_t\000"
.LASF48:
	.ascii	"_IO_wide_data\000"
.LASF57:
	.ascii	"tv_usec\000"
.LASF26:
	.ascii	"_IO_backup_base\000"
.LASF49:
	.ascii	"stdin\000"
.LASF31:
	.ascii	"_flags2\000"
.LASF43:
	.ascii	"_mode\000"
.LASF19:
	.ascii	"_IO_read_base\000"
.LASF34:
	.ascii	"_vtable_offset\000"
.LASF61:
	.ascii	"_sysy_start\000"
.LASF25:
	.ascii	"_IO_save_base\000"
.LASF53:
	.ascii	"sys_errlist\000"
.LASF30:
	.ascii	"_fileno\000"
.LASF14:
	.ascii	"__suseconds_t\000"
.LASF50:
	.ascii	"stdout\000"
.LASF76:
	.ascii	"_IO_lock_t\000"
.LASF67:
	.ascii	"_sysy_s\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
