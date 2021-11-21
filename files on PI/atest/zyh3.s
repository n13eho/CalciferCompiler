	.arch armv7ve
	.arm

.macro mov32, cond, reg, val
    movw\cond \reg, #:lower16:\val
    movt\cond \reg, #:upper16:\val
.endm
    
	.data
SHIFT_TABLE:
	.word 1
	.word 2
	.word 4
	.word 8
	.word 16
	.word 32
	.word 64
	.word 128
	.word 256
	.word 512
	.word 1024
	.word 2048
	.word 4096
	.word 8192
	.word 16384
	.word 32768
	.text
@ this is a start of function.
	.global long_func
	.type long_func, %function
long_func:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #300
.LB0:
	mov32 , r4, SHIFT_TABLE	@ 
	mov r0, #0
	str r0, [sp, #0]	@ str-all2mem 1
	mov r8, #0
	mov r0, #0
	str r0, [sp, #4]	@ str-all2mem 1
	mov r6, #2
	str r6, [sp, #8]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	mov r11, #1
@@ phi to mov
	mov r7, r11
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r11, r0
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #4]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #4]	@ str-all2mem 1
	b .LB1
.LB1:
	cmp r11, #0
	bgt .LB2
	b .LB3
.LB2:
	mov r8, #0
	mov r6, #0
	str r6, [sp, #8]	@ str-all2mem 1
	mov r0, r11
	str r0, [sp, #4]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #0]	@ str-all2mem 1
	b .LB4
.LB4:
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	cmp r6, #16
	blt .LB5
	b .LB6
.LB5:
	ldr r0, [sp, #4]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB8
	b .LB9
.LB8:
	ldr r0, [sp, #4]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #0]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	add r6, r6, #1
	str r6, [sp, #8]	@ str-all2mem 1
	b .LB4
.LB9:
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB7
	b .LB8
.LB7:
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r8, r8, r0
	b .LB8
.LB6:
	cmp r8, #0
	bne .LB10
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
@@ phi to mov
	mov r0, r5
	str r0, [sp, #4]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #40]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
	str r0, [sp, #48]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #52]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #56]	@ str-all2mem 1
	b .LB11
.LB10:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r8, r7
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r6, #0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #64]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #36]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #52]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB12
.LB12:
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB13
	b .LB14
.LB13:
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r8, #0
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, #1
	b .LB15
.LB15:
	cmp r8, #16
	blt .LB16
	b .LB17
.LB16:
	and r0, r9, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB19
	b .LB20
.LB19:
	asr r9, r9, #1

	asr r5, r5, #1

	add r8, r8, #1
	b .LB15
.LB20:
	and r0, r5, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB18
	b .LB19
.LB18:
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r7, r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB19
.LB17:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB21
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r9, r8
	b .LB22
.LB21:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	mov r9, r6
	ldr r0, [sp, #52]	@ ldr-all2mem 1
	mov r5, r0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB23
.LB23:
	cmp r5, #0
	bne .LB24
	b .LB25
.LB24:
	mov r8, #0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, r5
	str r6, [sp, #60]	@ str-all2mem 1
	b .LB26
.LB26:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB27
	b .LB28
.LB27:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB29
	b .LB30
.LB29:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB32
@@ phi to mov
	mov r6, r8
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB33
.LB32:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r8, r8, r6
@@ phi to mov
	mov r6, r8
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB33
.LB33:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r6
	b .LB31
.LB31:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB26
.LB30:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB34
@@ phi to mov
	mov r6, r8
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB35
.LB34:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r8, r8, r6
@@ phi to mov
	mov r6, r8
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB35
.LB35:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r6
	b .LB31
.LB28:
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB36
.LB36:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB37
	b .LB38
.LB37:
	and r6, r9, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB40
	b .LB41
.LB40:
	asr r9, r9, #1

	asr r5, r5, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB36
.LB41:
	and r6, r5, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB39
	b .LB40
.LB39:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r7, r7, r6
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB40
.LB38:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r9, r7
	mov r5, #1
	cmp r5, #15
	bgt .LB42
	b .LB43
.LB42:
	mov r9, #0
	b .LB44
.LB44:
	mov r6, r8
	str r6, [sp, #60]	@ str-all2mem 1
@@ phi to mov
	mov r7, r8
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r5, r9
	ldr r6, [sp, #60]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
	b .LB23
.LB43:
	mov r5, #0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	lsl r9, r9, #1

	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB45
.LB45:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB46
	b .LB47
.LB46:
	and r6, r9, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB49
	b .LB50
.LB49:
	asr r9, r9, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB45
.LB50:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB48
	b .LB49
.LB48:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r5, r5, r6
	b .LB49
.LB47:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB44
.LB25:
	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #64]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #68]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r9, r8
	b .LB22
.LB22:
	ldr r0, [sp, #52]	@ ldr-all2mem 1
	mov r8, r0
	ldr r0, [sp, #52]	@ ldr-all2mem 1
	mov r5, r0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB51
.LB51:
	cmp r5, #0
	bne .LB52
	b .LB53
.LB52:
	mov r9, #0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, r5
	str r6, [sp, #60]	@ str-all2mem 1
	b .LB54
.LB54:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB55
	b .LB56
.LB55:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB57
	b .LB58
.LB57:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB60
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB61
.LB60:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r9, r9, r6
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB61
.LB61:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB59
.LB59:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB54
.LB58:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB62
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB63
.LB62:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r9, r9, r6
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB63
.LB63:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB59
.LB56:
	mov r7, r9
	str r7, [sp, #16]	@ str-all2mem 1
	mov r9, #0
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB64
.LB64:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB65
	b .LB66
.LB65:
	and r6, r8, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
@@ phi to mov
	mov r6, r9
	str r6, [sp, #60]	@ str-all2mem 1
	beq .LB68
	b .LB69
.LB68:
	asr r9, r8, #1

	asr r5, r5, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r8, r0, #1
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r8, r9
	ldr r6, [sp, #60]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB64
.LB69:
	and r9, r5, #1
	cmp r9, #0
	bne .LB67
	b .LB68
.LB67:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r9, r0
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	lsl r9, r9, #0

	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r9, r6, r9
@@ phi to mov
	mov r6, r9
	str r6, [sp, #60]	@ str-all2mem 1
	b .LB68
.LB66:
	mov r5, #1
	cmp r5, #15
	bgt .LB70
	b .LB71
.LB70:
	mov r9, #0
	b .LB72
.LB72:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r8, r7
@@ phi to mov
	mov r5, r9
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB51
.LB71:
	mov r5, #0
	mov r8, #0
	lsl r9, r9, #1

	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB73
.LB73:
	cmp r8, #16
	blt .LB74
	b .LB75
.LB74:
	and r6, r9, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB77
	b .LB78
.LB77:
	asr r9, r9, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	add r8, r8, #1
	b .LB73
.LB78:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB76
	b .LB77
.LB76:
	mov r6, r8
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r5, r5, r6
	b .LB77
.LB75:
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB72
.LB53:
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #15
	bge .LB79
	b .LB80
.LB79:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	blt .LB82
	b .LB83
.LB82:
	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB84
.LB84:
	b .LB81
.LB83:
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB84
.LB81:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r6, r8
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #4]	@ ldr-all2mem 1
	str r0, [sp, #52]	@ str-all2mem 1
	b .LB12
.LB80:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	cmp r6, #0
	bgt .LB85
	b .LB86
.LB85:
	movw r6, #32767
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r0, r6
	bgt .LB88
	b .LB89
.LB88:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r0, #65536
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	rsb r6, r6, #15
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r6, #1
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	sub r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB90
.LB90:
	b .LB87
.LB89:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB90
.LB87:
	b .LB81
.LB86:
	b .LB87
.LB14:
	ldr r6, [sp, #60]	@ ldr-all2mem 1
	mov r8, r6
	mov r7, r8
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
@@ phi to mov
	mov r0, r5
	str r0, [sp, #4]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #40]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
	str r0, [sp, #48]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r0, [sp, #52]	@ ldr-all2mem 1
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #52]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #56]	@ str-all2mem 1
	b .LB11
.LB11:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r9, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r5, r0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #76]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #80]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #84]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
@@ phi to mov
	mov r6, r5
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r5, r9
	b .LB91
.LB91:
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB92
	b .LB93
.LB92:
	mov r9, #0
	mov r0, #0
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, #1
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB94
.LB94:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB95
	b .LB96
.LB95:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB98
	b .LB99
.LB98:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB94
.LB99:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB97
	b .LB98
.LB97:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	add r9, r9, r0
	b .LB98
.LB96:
	cmp r9, #0
	bne .LB100
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB101
.LB100:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r9, r7
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB102
.LB102:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB103
	b .LB104
.LB103:
	mov r9, #0
	mov r0, #0
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB105
.LB105:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB106
	b .LB107
.LB106:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB108
	b .LB109
.LB108:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB111
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB112
.LB111:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r9, r9, r6
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB112
.LB112:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB110
.LB110:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB105
.LB109:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r6, r6, #1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB113
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB114
.LB113:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
	add r9, r9, r6
@@ phi to mov
	mov r6, r9
	str r6, [sp, #32]	@ str-all2mem 1
	b .LB114
.LB114:
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB110
.LB107:
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
	mov r9, #0
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB115
.LB115:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB116
	b .LB117
.LB116:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB119
	b .LB120
.LB119:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB115
.LB120:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r6, r7, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB118
	b .LB119
.LB118:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r9, r9, r6
	b .LB119
.LB117:
	mov r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #15
	bgt .LB121
	b .LB122
.LB121:
	mov r9, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB123
.LB123:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r7, r9
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB102
.LB122:
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	lsl r9, r9, #1

	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r7
	b .LB124
.LB124:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB125
	b .LB126
.LB125:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r7, r6, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	beq .LB128
	b .LB129
.LB128:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	asr r7, r6, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB124
.LB129:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r7, r0, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB127
	b .LB128
.LB127:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	lsl r7, r7, #2
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r4, r7
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r7, [r7]	@ 
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	lsl r7, r7, #0

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r9, r9, r7
	b .LB128
.LB126:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB123
.LB104:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r9, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB101
.LB101:
	mov r9, r5
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB130
.LB130:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB131
	b .LB132
.LB131:
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	mov r9, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r5, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB133
.LB133:
	cmp r9, #16
	blt .LB134
	b .LB135
.LB134:
	and r6, r5, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB136
	b .LB137
.LB136:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r6, r7, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB139
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB140
.LB139:
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB140
.LB140:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB138
.LB138:
	asr r5, r5, #1

	mov r6, r5
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r5, r7, #1

	add r9, r9, #1
@@ phi to mov
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	b .LB133
.LB137:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r6, r7, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB141
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB142
.LB141:
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB142
.LB142:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB138
.LB135:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r9, #0
	mov r5, #0
	b .LB143
.LB143:
	cmp r5, #16
	blt .LB144
	b .LB145
.LB144:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB147
	b .LB148
.LB147:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #20]	@ str-all2mem 1
	add r5, r5, #1
	b .LB143
.LB148:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB146
	b .LB147
.LB146:
	mov r0, r5
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r9, r9, r0
	b .LB147
.LB145:
	mov r0, #1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #15
	bgt .LB149
	b .LB150
.LB149:
	mov r9, #0
	b .LB151
.LB151:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB130
.LB150:
	mov r5, #0
	mov r0, #0
	str r0, [sp, #20]	@ str-all2mem 1
	lsl r9, r9, #1

	mov32 , r0, 65535
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB152
.LB152:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB153
	b .LB154
.LB153:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r5, r0, #1
	cmp r5, #0
@@ phi to mov
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	beq .LB156
	b .LB157
.LB156:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r9, r0, #1

	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r9, r0, #1

	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r5, r0, #1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r6
	b .LB152
.LB157:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r9, r0, #1
	cmp r9, #0
	bne .LB155
	b .LB156
.LB155:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r9, r0
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	lsl r9, r9, #0

	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r9, r6, r9
@@ phi to mov
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB156
.LB154:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	b .LB151
.LB132:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r5, r0
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #15
	bge .LB158
	b .LB159
.LB158:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	blt .LB161
	b .LB162
.LB161:
	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB163
.LB163:
	b .LB160
.LB162:
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB163
.LB160:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #76]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #56]	@ str-all2mem 1
	b .LB91
.LB159:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bgt .LB164
	b .LB165
.LB164:
	movw r6, #32767
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	cmp r0, r6
	bgt .LB167
	b .LB168
.LB167:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r0, #65536
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	rsb r6, r6, #15
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r6, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	sub r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB169
.LB169:
	b .LB166
.LB168:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB169
.LB166:
	b .LB160
.LB165:
	b .LB166
.LB93:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r9, r7
	mov r6, r9
	str r6, [sp, #8]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #92]	@ str-all2mem 1
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	cmp r0, #15
	bge .LB170
	b .LB171
.LB170:
	cmp r11, #0
	blt .LB173
	b .LB174
.LB173:
	mov32 , r9, 65535
	b .LB175
.LB175:
@@ phi to mov
	mov r0, r11
	str r0, [sp, #96]	@ str-all2mem 1
@@ phi to mov
	mov r11, r9
	b .LB172
.LB174:
	mov r9, #0
	b .LB175
.LB172:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #76]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #80]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
	str r0, [sp, #84]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #4]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #40]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	ldr r0, [sp, #48]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #52]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #92]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #96]	@ ldr-all2mem 1
	str r0, [sp, #4]	@ str-all2mem 1
	b .LB1
.LB171:
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB176
	b .LB177
.LB176:
	movw r9, #32767
	cmp r11, r9
	bgt .LB179
	b .LB180
.LB179:
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	mov r9, r0
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	sdiv r11, r11, r9
	add r9, r11, #65536
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	rsb r5, r0, #15
	add r5, r5, #1
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	sub r9, r9, r5
	b .LB181
.LB181:
	b .LB178
.LB180:
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	mov r9, r0
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	sdiv r9, r11, r9
	b .LB181
.LB178:
@@ phi to mov
	mov r0, r11
	str r0, [sp, #96]	@ str-all2mem 1
@@ phi to mov
	mov r11, r9
	b .LB172
.LB177:
	mov r9, r11
	b .LB178
.LB3:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r11, r7
	mov r0, r11
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	mov r11, #2
	mov r9, #1
	mov r5, #1
@@ phi to mov
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	ldr r0, [sp, #4]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB182
.LB182:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB183
	b .LB184
.LB183:
	mov r9, #0
	mov r5, #0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r8, r0
	mov r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB185
.LB185:
	cmp r5, #16
	blt .LB186
	b .LB187
.LB186:
	and r0, r8, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB189
	b .LB190
.LB189:
	asr r8, r8, #1

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	add r5, r5, #1
	b .LB185
.LB190:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB188
	b .LB189
.LB188:
	mov r0, r5
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r9, r9, r0
	b .LB189
.LB187:
	cmp r9, #0
	bne .LB191
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #124]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #72]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB192
.LB191:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r9, r7
	mov r8, r11
	mov r0, #0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB193
.LB193:
	cmp r8, #0
	bne .LB194
	b .LB195
.LB194:
	mov r5, #0
	mov r6, #0
	str r6, [sp, #104]	@ str-all2mem 1
	mov r7, r8
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB196
.LB196:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	cmp r6, #16
	blt .LB197
	b .LB198
.LB197:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB200
	b .LB201
.LB200:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	add r6, r6, #1
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB196
.LB201:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB199
	b .LB200
.LB199:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r5, r5, r0
	b .LB200
.LB198:
	cmp r5, #0
	bne .LB202
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	b .LB203
.LB202:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r5, r0
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB204
.LB204:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB205
	b .LB206
.LB205:
	mov r6, #0
	str r6, [sp, #104]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #116]	@ str-all2mem 1
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	b .LB207
.LB207:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB208
	b .LB209
.LB208:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB210
	b .LB211
.LB210:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB213
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB214
.LB213:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r6, r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB214
.LB214:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB212
.LB212:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB207
.LB211:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB215
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB216
.LB215:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r6, r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB216
.LB216:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB212
.LB209:
	mov r0, #0
	str r0, [sp, #116]	@ str-all2mem 1
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB217
.LB217:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB218
	b .LB219
.LB218:
	and r6, r5, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB221
	b .LB222
.LB221:
	asr r5, r5, #1

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB217
.LB222:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB220
	b .LB221
.LB220:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r0, r0, r6
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB221
.LB219:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	mov r5, r0
	mov r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #15
	bgt .LB223
	b .LB224
.LB223:
	mov r5, #0
	b .LB225
.LB225:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #116]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB204
.LB224:
	mov r0, #0
	str r0, [sp, #128]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #116]	@ str-all2mem 1
	lsl r5, r5, #1

	mov32 , r7, 65535
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB226
.LB226:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB227
	b .LB228
.LB227:
	and r6, r5, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB230
	b .LB231
.LB230:
	asr r5, r5, #1

	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB226
.LB231:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r6, r7, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB229
	b .LB230
.LB229:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r0, r0, r6
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB230
.LB228:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	b .LB225
.LB206:
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
@@ phi to mov
	mov r6, r5
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	b .LB203
.LB203:
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
	mov r6, #0
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB232
.LB232:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB233
	b .LB234
.LB233:
	mov r9, #0
	mov r5, #0
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB235
.LB235:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB236
	b .LB237
.LB236:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r5, r0, #1
	cmp r5, #0
	bne .LB238
	b .LB239
.LB238:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r5, r6, #1
	cmp r5, #0
	beq .LB241
@@ phi to mov
	mov r5, r9
	b .LB242
.LB241:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r5, r7
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r9, r9, r5
@@ phi to mov
	mov r5, r9
	b .LB242
.LB242:
@@ phi to mov
	mov r9, r5
	b .LB240
.LB240:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r5, r0, #1

	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r0, r6, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r6, r7, #1
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r7, r6
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB235
.LB239:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r5, r6, #1
	cmp r5, #0
	bne .LB243
@@ phi to mov
	mov r5, r9
	b .LB244
.LB243:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r5, r7
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r9, r9, r5
@@ phi to mov
	mov r5, r9
	b .LB244
.LB244:
@@ phi to mov
	mov r9, r5
	b .LB240
.LB237:
	mov r6, r9
	str r6, [sp, #104]	@ str-all2mem 1
	mov r9, #0
	mov r5, #0
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	mov r7, r6
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB245
.LB245:
	cmp r5, #16
	blt .LB246
	b .LB247
.LB246:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB249
	b .LB250
.LB249:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	add r5, r5, #1
	b .LB245
.LB250:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r6, r7, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB248
	b .LB249
.LB248:
	mov r6, r5
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r9, r9, r6
	b .LB249
.LB247:
	mov r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #15
	bgt .LB251
	b .LB252
.LB251:
	mov r9, #0
	b .LB253
.LB253:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB232
.LB252:
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #128]	@ str-all2mem 1
	lsl r9, r9, #1

	mov r5, r9
	mov32 , r9, 65535
	b .LB254
.LB254:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB255
	b .LB256
.LB255:
	and r6, r5, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB258
	b .LB259
.LB258:
	asr r5, r5, #1

	asr r9, r9, #1

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB254
.LB259:
	and r6, r9, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB257
	b .LB258
.LB257:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r7, r7, r6
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB258
.LB256:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r7
	b .LB253
.LB234:
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	mov r9, r0
	mov r0, r9
	str r0, [sp, #108]	@ str-all2mem 1
	mov r9, r8
	mov r8, #1
	cmp r8, #15
	bge .LB260
	b .LB261
.LB260:
	cmp r9, #0
	blt .LB263
	b .LB264
.LB263:
	mov32 , r9, 65535
	b .LB265
.LB265:
	b .LB262
.LB264:
	mov r9, #0
	b .LB265
.LB262:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r6
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r8, r9
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB193
.LB261:
	cmp r8, #0
	bgt .LB266
	b .LB267
.LB266:
	movw r0, #32767
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r9, r0
	bgt .LB269
	b .LB270
.LB269:
	mov r0, r8
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	sdiv r9, r9, r0
	add r9, r9, #65536
	rsb r8, r8, #15
	add r8, r8, #1
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sub r9, r9, r8
	b .LB271
.LB271:
	b .LB268
.LB270:
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r9, r9, r8
	b .LB271
.LB268:
	b .LB262
.LB267:
	b .LB268
.LB195:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #152]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB192
.LB192:
	mov r5, r11
	mov r8, #0
	ldr r0, [sp, #132]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #100]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #136]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #108]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #112]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #76]	@ str-all2mem 1
	b .LB272
.LB272:
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB273
	b .LB274
.LB273:
	mov r11, #0
	mov r9, #0
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	mov r5, r0
	mov r8, #1
	b .LB275
.LB275:
	cmp r9, #16
	blt .LB276
	b .LB277
.LB276:
	and r10, r5, #1
	cmp r10, #0
	beq .LB279
	b .LB280
.LB279:
	asr r5, r5, #1

	asr r8, r8, #1

	add r9, r9, #1
	b .LB275
.LB280:
	and r10, r8, #1
	cmp r10, #0
	bne .LB278
	b .LB279
.LB278:
	mov r10, r9
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r11, r11, r10
	b .LB279
.LB277:
	cmp r11, #0
	bne .LB281
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #132]	@ str-all2mem 1
@@ phi to mov
	mov r8, r9
	b .LB282
.LB281:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	mov r5, r0
	mov r8, #0
@@ phi to mov
	mov r10, r5
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB283
.LB283:
	cmp r10, #0
	bne .LB284
	b .LB285
.LB284:
	mov r11, #0
	mov r9, #0
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r5, r0
	mov r8, r10
@@ phi to mov
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r8, r9
@@ phi to mov
	mov r9, r11
	b .LB286
.LB286:
	cmp r8, #16
	blt .LB287
	b .LB288
.LB287:
	and r11, r5, #1
	cmp r11, #0
	bne .LB289
	b .LB290
.LB289:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r11, r7, #1
	cmp r11, #0
	beq .LB292
@@ phi to mov
	mov r11, r9
	b .LB293
.LB292:
	mov r11, r8
	lsl r11, r11, #2
	add r11, r4, r11
	ldr r11, [r11]	@ 
	lsl r11, r11, #0

	add r11, r9, r11
	b .LB293
.LB293:
	b .LB291
.LB291:
	asr r9, r5, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r5, r7, #1

	add r8, r8, #1
@@ phi to mov
	mov r7, r5
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r5, r9
@@ phi to mov
	mov r9, r11
	b .LB286
.LB290:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r11, r7, #1
	cmp r11, #0
	bne .LB294
@@ phi to mov
	mov r11, r9
	b .LB295
.LB294:
	mov r11, r8
	lsl r11, r11, #2
	add r11, r4, r11
	ldr r11, [r11]	@ 
	lsl r11, r11, #0

	add r11, r9, r11
	b .LB295
.LB295:
	b .LB291
.LB288:
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
	mov r11, #0
	mov r9, #0
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r5, r0
	mov r8, r10
	b .LB296
.LB296:
	cmp r9, #16
	blt .LB297
	b .LB298
.LB297:
	and r10, r5, #1
	cmp r10, #0
	beq .LB300
	b .LB301
.LB300:
	asr r5, r5, #1

	asr r8, r8, #1

	add r9, r9, #1
	b .LB296
.LB301:
	and r10, r8, #1
	cmp r10, #0
	bne .LB299
	b .LB300
.LB299:
	mov r10, r9
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r11, r11, r10
	b .LB300
.LB298:
	mov r5, r11
	mov r11, #1
	cmp r11, #15
	bgt .LB302
	b .LB303
.LB302:
	mov r11, #0
@@ phi to mov
	mov r5, r9
	b .LB304
.LB304:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r9, r7
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
@@ phi to mov
	mov r10, r11
@@ phi to mov
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB283
.LB303:
	mov r11, #0
	mov r9, #0
	lsl r5, r5, #1

	mov32 , r8, 65535
	b .LB305
.LB305:
	cmp r9, #16
	blt .LB306
	b .LB307
.LB306:
	and r10, r5, #1
	cmp r10, #0
	beq .LB309
	b .LB310
.LB309:
	asr r5, r5, #1

	asr r8, r8, #1

	add r9, r9, #1
	b .LB305
.LB310:
	and r10, r8, #1
	cmp r10, #0
	bne .LB308
	b .LB309
.LB308:
	mov r10, r9
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r11, r11, r10
	b .LB309
.LB307:
@@ phi to mov
	mov r5, r9
	b .LB304
.LB285:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r11, r0
@@ phi to mov
	mov r7, r8
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r6, r10
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #132]	@ str-all2mem 1
@@ phi to mov
	mov r8, r9
	b .LB282
.LB282:
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, #0
	b .LB311
.LB311:
	cmp r9, #0
	bne .LB312
	b .LB313
.LB312:
	mov r5, #0
	mov r8, #0
	mov r10, r11
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB314
.LB314:
	cmp r8, #16
	blt .LB315
	b .LB316
.LB315:
	and r5, r10, #1
	cmp r5, #0
	bne .LB317
	b .LB318
.LB317:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r5, r7, #1
	cmp r5, #0
	beq .LB320
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	b .LB321
.LB320:
	mov r5, r8
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r5, r0, r5
	b .LB321
.LB321:
	b .LB319
.LB319:
	asr r10, r10, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	add r8, r8, #1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB314
.LB318:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r5, r7, #1
	cmp r5, #0
	bne .LB322
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	b .LB323
.LB322:
	mov r5, r8
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r5, r0, r5
	b .LB323
.LB323:
	b .LB319
.LB316:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r5, r0
	mov r8, #0
	mov r10, #0
@@ phi to mov
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r11, r8
	b .LB324
.LB324:
	cmp r10, #16
	blt .LB325
	b .LB326
.LB325:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r9, r0, #1
	cmp r9, #0
@@ phi to mov
	mov r9, r11
	beq .LB328
	b .LB329
.LB328:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r11, r0, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r8, r7, #1

	add r10, r10, #1
@@ phi to mov
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r11, r9
	b .LB324
.LB329:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r11, r7, #1
	cmp r11, #0
	bne .LB327
	b .LB328
.LB327:
	mov r11, r10
	lsl r11, r11, #2
	add r11, r4, r11
	ldr r11, [r11]	@ 
	lsl r11, r11, #0

	add r11, r9, r11
@@ phi to mov
	mov r9, r11
	b .LB328
.LB326:
	mov r9, #1
	cmp r9, #15
	bgt .LB330
	b .LB331
.LB330:
	mov r11, #0
@@ phi to mov
	mov r8, r10
	b .LB332
.LB332:
	mov r10, r5
@@ phi to mov
	mov r9, r11
@@ phi to mov
	mov r11, r10
	b .LB311
.LB331:
	mov r9, #0
	mov r8, #0
	lsl r11, r11, #1

	mov32 , r10, 65535
@@ phi to mov
	mov r7, r11
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r11, r8
	b .LB333
.LB333:
	cmp r11, #16
	blt .LB334
	b .LB335
.LB334:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r8, r7, #1
	cmp r8, #0
	beq .LB337
	b .LB338
.LB337:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r8, r7, #1

	asr r10, r10, #1

	add r11, r11, #1
@@ phi to mov
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB333
.LB338:
	and r8, r10, #1
	cmp r8, #0
	bne .LB336
	b .LB337
.LB336:
	mov r8, r11
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	lsl r8, r8, #0

	add r9, r9, r8
	b .LB337
.LB335:
@@ phi to mov
	mov r8, r11
@@ phi to mov
	mov r11, r9
	b .LB332
.LB313:
	mov r10, r11
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #15
	bge .LB339
	b .LB340
.LB339:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	blt .LB342
	b .LB343
.LB342:
	mov32 , r7, 65535
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB344
.LB344:
	b .LB341
.LB343:
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB344
.LB341:
@@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #132]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #108]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #112]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #76]	@ str-all2mem 1
	b .LB272
.LB340:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB345
	b .LB346
.LB345:
	movw r6, #32767
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	cmp r7, r6
	bgt .LB348
	b .LB349
.LB348:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	sdiv r7, r7, r6
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r7, #65536
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	rsb r0, r0, #15
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	sub r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB350
.LB350:
	b .LB347
.LB349:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	sdiv r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB350
.LB347:
	b .LB341
.LB346:
	b .LB347
.LB274:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, #1
	cmp r5, #15
	bge .LB351
	b .LB352
.LB351:
	cmp r9, #0
	blt .LB354
	b .LB355
.LB354:
	mov32 , r8, 65535
	b .LB356
.LB356:
	b .LB353
.LB355:
	mov r8, #0
	b .LB356
.LB353:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #132]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #140]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #112]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #124]	@ str-all2mem 1
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB182
.LB352:
	cmp r5, #0
	bgt .LB357
	b .LB358
.LB357:
	movw r8, #32767
	cmp r9, r8
	bgt .LB360
	b .LB361
.LB360:
	mov r8, r5
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r9, r9, r8
	add r8, r9, #65536
	rsb r10, r5, #15
	add r10, r10, #1
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	sub r8, r8, r10
	b .LB362
.LB362:
	b .LB359
.LB361:
	mov r8, r5
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r8, r9, r8
	b .LB362
.LB359:
	b .LB353
.LB358:
	mov r8, r9
	b .LB359
.LB184:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r11, r7
	mov r0, r11
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	mov r11, #2
@@ phi to mov
	mov r7, r11
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB363
.LB363:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB364
	b .LB365
.LB364:
	mov r11, #2
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r10, r7
	mov r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #160]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #164]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #172]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #176]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #180]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #184]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #188]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #192]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #196]	@ ldr-all2mem 1
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r0, [sp, #200]	@ ldr-all2mem 1
	str r0, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #204]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #132]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #164]	@ str-all2mem 1
@@ phi to mov
	mov r10, r9
	b .LB366
.LB366:
	ldr r0, [sp, #164]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB367
	b .LB368
.LB367:
	mov r9, #0
	mov r5, #0
	ldr r0, [sp, #164]	@ ldr-all2mem 1
	mov r8, r0
	mov r10, #1
	b .LB369
.LB369:
	cmp r5, #16
	blt .LB370
	b .LB371
.LB370:
	and r0, r8, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB373
	b .LB374
.LB373:
	asr r8, r8, #1

	asr r10, r10, #1

	add r5, r5, #1
	b .LB369
.LB374:
	and r0, r10, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB372
	b .LB373
.LB372:
	mov r0, r5
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r9, r9, r0
	b .LB373
.LB371:
	cmp r9, #0
	bne .LB375
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	str r0, [sp, #204]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #152]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB376
.LB375:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r9, r7
	mov r8, r11
	mov r10, #0
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	str r0, [sp, #212]	@ str-all2mem 1
	b .LB377
.LB377:
	cmp r8, #0
	bne .LB378
	b .LB379
.LB378:
	mov r5, #0
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, r8
	str r0, [sp, #12]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB380
.LB380:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB381
	b .LB382
.LB381:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB384
	b .LB385
.LB384:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB380
.LB385:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB383
	b .LB384
.LB383:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	add r5, r5, r0
	b .LB384
.LB382:
	cmp r5, #0
	bne .LB386
@@ phi to mov
	mov r0, r10
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r7
	b .LB387
.LB386:
	mov r5, r10
	mov r10, r9
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB388
.LB388:
	cmp r10, #0
	bne .LB389
	b .LB390
.LB389:
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	mov r0, r5
	str r0, [sp, #28]	@ str-all2mem 1
	mov r6, r10
	str r6, [sp, #88]	@ str-all2mem 1
	b .LB391
.LB391:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB392
	b .LB393
.LB392:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB394
	b .LB395
.LB394:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB397
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #136]	@ str-all2mem 1
	b .LB398
.LB397:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #136]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	add r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #136]	@ str-all2mem 1
	b .LB398
.LB398:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB396
.LB396:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB391
.LB395:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB399
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #136]	@ str-all2mem 1
	b .LB400
.LB399:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #136]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	add r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #136]	@ str-all2mem 1
	b .LB400
.LB400:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB396
.LB393:
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB401
.LB401:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB402
	b .LB403
.LB402:
	and r6, r5, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB405
	b .LB406
.LB405:
	asr r5, r5, #1

	asr r10, r10, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB401
.LB406:
	and r6, r10, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB404
	b .LB405
.LB404:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r0, r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB405
.LB403:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r5, r0
	mov r10, #1
	cmp r10, #15
	bgt .LB407
	b .LB408
.LB407:
	mov r5, #0
	b .LB409
.LB409:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r10, r5
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB388
.LB408:
	mov r10, #0
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	lsl r5, r5, #1

	mov32 , r0, 65535
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB410
.LB410:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB411
	b .LB412
.LB411:
	and r6, r5, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB414
	b .LB415
.LB414:
	asr r5, r5, #1

	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB410
.LB415:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB413
	b .LB414
.LB413:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	add r10, r10, r6
	b .LB414
.LB412:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r5, r10
	b .LB409
.LB390:
	mov r0, r5
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #136]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #212]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r7
	b .LB387
.LB387:
	mov r10, r9
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB416
.LB416:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB417
	b .LB418
.LB417:
	mov r5, #0
	mov r9, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB419
.LB419:
	cmp r9, #16
	blt .LB420
	b .LB421
.LB420:
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	and r10, r0, #1
	cmp r10, #0
	bne .LB422
	b .LB423
.LB422:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r10, r7, #1
	cmp r10, #0
	beq .LB425
@@ phi to mov
	mov r10, r5
	b .LB426
.LB425:
	mov r10, r9
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r5, r5, r10
@@ phi to mov
	mov r10, r5
	b .LB426
.LB426:
@@ phi to mov
	mov r5, r10
	b .LB424
.LB424:
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	asr r10, r0, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	add r9, r9, #1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB419
.LB423:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r10, r7, #1
	cmp r10, #0
	bne .LB427
@@ phi to mov
	mov r10, r5
	b .LB428
.LB427:
	mov r10, r9
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r5, r5, r10
@@ phi to mov
	mov r10, r5
	b .LB428
.LB428:
@@ phi to mov
	mov r5, r10
	b .LB424
.LB421:
	mov r9, r5
	mov r5, #0
	mov r10, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB429
.LB429:
	cmp r10, #16
	blt .LB430
	b .LB431
.LB430:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB433
	b .LB434
.LB433:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	add r10, r10, #1
	b .LB429
.LB434:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB432
	b .LB433
.LB432:
	mov r0, r10
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r5, r5, r0
	b .LB433
.LB431:
	mov r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #15
	bgt .LB435
	b .LB436
.LB435:
	mov r5, #0
	b .LB437
.LB437:
	mov r0, r9
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #100]	@ str-all2mem 1
	b .LB416
.LB436:
	mov r10, #0
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	lsl r5, r5, #1

	mov32 , r0, 65535
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r5, r10
	b .LB438
.LB438:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB439
	b .LB440
.LB439:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	and r10, r0, #1
	cmp r10, #0
	beq .LB442
	b .LB443
.LB442:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	asr r10, r0, #1

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB438
.LB443:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r10, r0, #1
	cmp r10, #0
	bne .LB441
	b .LB442
.LB441:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r10, r7
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r5, r5, r10
	b .LB442
.LB440:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r7
	b .LB437
.LB418:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, r8
	mov r8, #1
	cmp r8, #15
	bge .LB444
	b .LB445
.LB444:
	cmp r5, #0
	blt .LB447
	b .LB448
.LB447:
	mov32 , r5, 65535
	b .LB449
.LB449:
	b .LB446
.LB448:
	mov r5, #0
	b .LB449
.LB446:
	ldr r0, [sp, #216]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r0
@@ phi to mov
	mov r8, r5
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	b .LB377
.LB445:
	cmp r8, #0
	bgt .LB450
	b .LB451
.LB450:
	movw r10, #32767
	cmp r5, r10
	bgt .LB453
	b .LB454
.LB453:
	mov r10, r8
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	sdiv r5, r5, r10
	add r5, r5, #65536
	rsb r8, r8, #15
	add r8, r8, #1
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sub r5, r5, r8
	b .LB455
.LB455:
	b .LB452
.LB454:
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r5, r5, r8
	b .LB455
.LB452:
	b .LB446
.LB451:
	b .LB452
.LB379:
	mov r0, r10
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #204]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r6, r10
	str r6, [sp, #60]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #220]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #152]	@ str-all2mem 1
@@ phi to mov
	mov r9, r5
	b .LB376
.LB376:
	mov r5, r11
	mov r8, #0
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r6, r11
	str r6, [sp, #88]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #136]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #140]	@ str-all2mem 1
	b .LB456
.LB456:
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB457
	b .LB458
.LB457:
	mov r11, #0
	mov r9, #0
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	mov r5, r6
	mov r8, #1
@@ phi to mov
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB459
.LB459:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB460
	b .LB461
.LB460:
	and r9, r5, #1
	cmp r9, #0
@@ phi to mov
	mov r9, r11
	beq .LB463
	b .LB464
.LB463:
	asr r11, r5, #1

	asr r5, r8, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r8, r7, #1
	mov r10, r8
@@ phi to mov
	mov r8, r5
@@ phi to mov
	mov r5, r11
@@ phi to mov
	mov r7, r10
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r11, r9
	b .LB459
.LB464:
	and r11, r8, #1
	cmp r11, #0
	bne .LB462
	b .LB463
.LB462:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r11, r7
	lsl r11, r11, #2
	add r11, r4, r11
	ldr r11, [r11]	@ 
	lsl r11, r11, #0

	add r11, r9, r11
@@ phi to mov
	mov r9, r11
	b .LB463
.LB461:
	cmp r11, #0
	bne .LB465
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@@ phi to mov
	mov r11, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r7
	b .LB466
.LB465:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, #0
@@ phi to mov
	mov r8, r11
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r7
	b .LB467
.LB467:
	cmp r9, #0
	bne .LB468
	b .LB469
.LB468:
	mov r11, #0
	mov r5, #0
	mov r10, r8
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB470
.LB470:
	cmp r5, #16
	blt .LB471
	b .LB472
.LB471:
	and r0, r10, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB473
	b .LB474
.LB473:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB476
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB477
.LB476:
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r11, r11, r0
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB477
.LB477:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r11, r0
	b .LB475
.LB475:
	asr r10, r10, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	add r5, r5, #1
	b .LB470
.LB474:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB478
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB479
.LB478:
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r11, r11, r0
@@ phi to mov
	mov r0, r11
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB479
.LB479:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r11, r0
	b .LB475
.LB472:
	mov r7, r11
	str r7, [sp, #144]	@ str-all2mem 1
	mov r10, #0
	mov r11, #0
	mov r5, r8
@@ phi to mov
	mov r8, r11
@@ phi to mov
	mov r11, r10
	b .LB480
.LB480:
	cmp r8, #16
	blt .LB481
	b .LB482
.LB481:
	and r10, r5, #1
	cmp r10, #0
@@ phi to mov
	mov r10, r11
	beq .LB484
	b .LB485
.LB484:
	asr r11, r5, #1

	asr r9, r9, #1

	add r5, r8, #1
	mov r8, r5
@@ phi to mov
	mov r5, r11
@@ phi to mov
	mov r11, r10
	b .LB480
.LB485:
	and r11, r9, #1
	cmp r11, #0
	bne .LB483
	b .LB484
.LB483:
	mov r11, r8
	lsl r11, r11, #2
	add r11, r4, r11
	ldr r11, [r11]	@ 
	lsl r11, r11, #0

	add r11, r10, r11
@@ phi to mov
	mov r10, r11
	b .LB484
.LB482:
	mov r9, #1
	cmp r9, #15
	bgt .LB486
	b .LB487
.LB486:
	mov r11, #0
@@ phi to mov
	mov r10, r8
	b .LB488
.LB488:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r8, r7
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r5, r7
@@ phi to mov
	mov r9, r11
	b .LB467
.LB487:
	mov r9, #0
	mov r5, #0
	lsl r11, r11, #1

	mov32 , r8, 65535
	b .LB489
.LB489:
	cmp r5, #16
	blt .LB490
	b .LB491
.LB490:
	and r10, r11, #1
	cmp r10, #0
	beq .LB493
	b .LB494
.LB493:
	asr r11, r11, #1

	asr r8, r8, #1

	add r5, r5, #1
	b .LB489
.LB494:
	and r10, r8, #1
	cmp r10, #0
	bne .LB492
	b .LB493
.LB492:
	mov r10, r5
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	add r9, r9, r10
	b .LB493
.LB491:
@@ phi to mov
	mov r10, r5
@@ phi to mov
	mov r11, r9
	b .LB488
.LB469:
	mov r11, r8
	mov r7, r11
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r11, r5
@@ phi to mov
	mov r5, r8
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
	b .LB466
.LB466:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	mov r6, #0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r6, r10
	str r6, [sp, #120]	@ str-all2mem 1
	b .LB495
.LB495:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB496
	b .LB497
.LB496:
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	mov r10, #0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB498
.LB498:
	cmp r10, #16
	blt .LB499
	b .LB500
.LB499:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB501
	b .LB502
.LB501:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB504
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB505
.LB504:
	mov r0, r10
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB505
.LB505:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB503
.LB503:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #104]	@ str-all2mem 1
	add r10, r10, #1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	b .LB498
.LB502:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB506
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB507
.LB506:
	mov r0, r10
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB507
.LB507:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB503
.LB500:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #116]	@ str-all2mem 1
	mov r10, #0
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB508
.LB508:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB509
	b .LB510
.LB509:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r7, r0, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
@@ phi to mov
	mov r7, r10
	str r7, [sp, #144]	@ str-all2mem 1
	beq .LB512
	b .LB513
.LB512:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r10, r0, #1

	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r0, r6, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r6, r0, #1
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r7
	b .LB508
.LB513:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r10, r6, #1
	cmp r10, #0
	bne .LB511
	b .LB512
.LB511:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r10, r0
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	lsl r10, r10, #0

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r10, r7, r10
@@ phi to mov
	mov r7, r10
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB512
.LB510:
	mov r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #15
	bgt .LB514
	b .LB515
.LB514:
	mov r10, #0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB516
.LB516:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #120]	@ str-all2mem 1
	b .LB495
.LB515:
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #128]	@ str-all2mem 1
	lsl r10, r10, #1

	mov r6, r10
	str r6, [sp, #104]	@ str-all2mem 1
	mov32 , r10, 65535
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB517
.LB517:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB518
	b .LB519
.LB518:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r7, r6, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	beq .LB521
	b .LB522
.LB521:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r7, r6, #1

	str r7, [sp, #144]	@ str-all2mem 1
	asr r10, r10, #1

	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r6, r0, #1
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB517
.LB522:
	and r7, r10, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB520
	b .LB521
.LB520:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	lsl r7, r7, #2
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r4, r7
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r7, [r7]	@ 
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	lsl r7, r7, #0

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r0, r7
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB521
.LB519:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r0
	b .LB516
.LB497:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r10, r0
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	mov r7, r6
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #15
	bge .LB523
	b .LB524
.LB523:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	blt .LB526
	b .LB527
.LB526:
	mov32 , r7, 65535
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB528
.LB528:
	b .LB525
.LB527:
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB528
.LB525:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
@@ phi to mov
	mov r0, r11
	str r0, [sp, #116]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r5
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r7
	str r6, [sp, #88]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #140]	@ str-all2mem 1
	b .LB456
.LB524:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB529
	b .LB530
.LB529:
	movw r0, #32767
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	cmp r7, r0
	bgt .LB532
	b .LB533
.LB532:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	sdiv r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r7, #65536
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	rsb r0, r0, #15
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	sub r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB534
.LB534:
	b .LB531
.LB533:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	sdiv r7, r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB534
.LB531:
	b .LB525
.LB530:
	b .LB531
.LB458:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #164]	@ ldr-all2mem 1
	mov r9, r0
	mov r5, #1
	cmp r5, #15
	bge .LB535
	b .LB536
.LB535:
	cmp r9, #0
	blt .LB538
	b .LB539
.LB538:
	mov32 , r8, 65535
	b .LB540
.LB540:
	b .LB537
.LB539:
	mov r8, #0
	b .LB540
.LB537:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #160]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #212]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r6, [sp, #8]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #152]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #164]	@ str-all2mem 1
@@ phi to mov
	mov r10, r5
	b .LB366
.LB536:
	cmp r5, #0
	bgt .LB541
	b .LB542
.LB541:
	movw r8, #32767
	cmp r9, r8
	bgt .LB544
	b .LB545
.LB544:
	mov r8, r5
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r9, r9, r8
	add r8, r9, #65536
	rsb r10, r5, #15
	add r10, r10, #1
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	sub r8, r8, r10
	b .LB546
.LB546:
	b .LB543
.LB545:
	mov r8, r5
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r8, r9, r8
	b .LB546
.LB543:
	b .LB537
.LB542:
	mov r8, r9
	b .LB543
.LB368:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r11, r7
	mov r0, r11
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r11, r7, #1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #164]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #172]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #176]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #180]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #184]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #188]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #192]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	str r0, [sp, #196]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	str r0, [sp, #200]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #204]	@ str-all2mem 1
	ldr r0, [sp, #132]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
@@ phi to mov
	mov r7, r11
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r9, r10
	b .LB363
.LB365:
	mov r11, #0
	b .LB547
.LB547:
	cmp r11, #16
	blt .LB548
	b .LB549
.LB548:
	mov r9, #2
	mov r5, r11
	mov r8, #1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r0
	ldr r0, [sp, #232]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #236]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #240]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #244]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #248]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #252]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #256]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #260]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #264]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #268]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #272]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #276]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #280]	@ ldr-all2mem 1
	str r0, [sp, #212]	@ str-all2mem 1
	ldr r0, [sp, #284]	@ ldr-all2mem 1
	str r0, [sp, #216]	@ str-all2mem 1
	ldr r0, [sp, #288]	@ ldr-all2mem 1
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #292]	@ ldr-all2mem 1
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r0, [sp, #296]	@ ldr-all2mem 1
	str r0, [sp, #112]	@ str-all2mem 1
	b .LB550
.LB550:
	cmp r5, #0
	bgt .LB551
	b .LB552
.LB551:
	mov r1, #0
	mov r2, #0
	mov r3, r5
	mov r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r2
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB553
.LB553:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB554
	b .LB555
.LB554:
	and r2, r3, #1
	cmp r2, #0
	beq .LB557
	b .LB558
.LB557:
	asr r2, r3, #1

	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r3, r7, #1

	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r7, r0, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r7, r3
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r3, r2
	b .LB553
.LB558:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r2, r7, #1
	cmp r2, #0
	bne .LB556
	b .LB557
.LB556:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r2, r0
	lsl r2, r2, #2
	add r2, r4, r2
	ldr r2, [r2]	@ 
	lsl r2, r2, #0

	add r1, r1, r2
	b .LB557
.LB555:
	cmp r1, #0
	bne .LB559
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #220]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #164]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@@ phi to mov
	mov r1, r0
	ldr r0, [sp, #112]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
@@ phi to mov
	mov r3, r8
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB560
.LB559:
	mov r3, r8
	mov r8, r9
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r1, r0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
@@ phi to mov
	mov r0, r3
	str r0, [sp, #136]	@ str-all2mem 1
	b .LB561
.LB561:
	cmp r8, #0
	bne .LB562
	b .LB563
.LB562:
	mov r1, #0
	mov r2, #0
	mov r3, r8
	mov r0, #1
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB564
.LB564:
	cmp r2, #16
	blt .LB565
	b .LB566
.LB565:
	and r6, r3, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB568
	b .LB569
.LB568:
	asr r3, r3, #1

	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #20]	@ str-all2mem 1
	add r2, r2, #1
	b .LB564
.LB569:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB567
	b .LB568
.LB567:
	mov r6, r2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r1, r1, r6
	b .LB568
.LB566:
	cmp r1, #0
	bne .LB570
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r3, r0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #212]	@ str-all2mem 1
@@ phi to mov
	mov r1, r2
	b .LB571
.LB570:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r1, r7
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r3, r0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r0, r3
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB572
.LB572:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB573
	b .LB574
.LB573:
	mov r2, #0
	mov r3, #0
	mov r7, r1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	b .LB575
.LB575:
	cmp r3, #16
	blt .LB576
	b .LB577
.LB576:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB578
	b .LB579
.LB578:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB581
@@ phi to mov
	mov r0, r2
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB582
.LB581:
	mov r0, r3
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r2, r2, r0
@@ phi to mov
	mov r0, r2
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB582
.LB582:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
	b .LB580
.LB580:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #120]	@ str-all2mem 1
	add r3, r3, #1
	b .LB575
.LB579:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB583
@@ phi to mov
	mov r0, r2
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB584
.LB583:
	mov r0, r3
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r2, r2, r0
@@ phi to mov
	mov r0, r2
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB584
.LB584:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
	b .LB580
.LB577:
	mov r7, r2
	str r7, [sp, #16]	@ str-all2mem 1
	mov r2, #0
	mov r3, #0
	b .LB585
.LB585:
	cmp r3, #16
	blt .LB586
	b .LB587
.LB586:
	and r6, r1, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	beq .LB589
	b .LB590
.LB589:
	asr r1, r1, #1

	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #20]	@ str-all2mem 1
	add r3, r3, #1
	b .LB585
.LB590:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r6, r0, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB588
	b .LB589
.LB588:
	mov r6, r3
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r6, r4, r6
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	ldr r6, [r6]	@ 
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	lsl r6, r6, #0

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r2, r2, r6
	b .LB589
.LB587:
	mov r1, r2
	mov r2, #1
	cmp r2, #15
	bgt .LB591
	b .LB592
.LB591:
	mov r1, #0
@@ phi to mov
	mov r2, r3
	b .LB593
.LB593:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r3, r7
@@ phi to mov
	mov r0, r1
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r1, r3
	b .LB572
.LB592:
	mov r2, #0
	mov r3, #0
	lsl r1, r1, #1

	mov32 , r0, 65535
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r6, r3
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r3, r2
	b .LB594
.LB594:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #16
	blt .LB595
	b .LB596
.LB595:
	and r2, r1, #1
	cmp r2, #0
@@ phi to mov
	mov r0, r3
	str r0, [sp, #12]	@ str-all2mem 1
	beq .LB598
	b .LB599
.LB598:
	asr r1, r1, #1

	mov r3, r1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r1, r0, #1

	ldr r6, [sp, #120]	@ ldr-all2mem 1
	add r2, r6, #1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r1, r3
@@ phi to mov
	mov r6, r2
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r3, r0
	b .LB594
.LB599:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r2, r0, #1
	cmp r2, #0
	bne .LB597
	b .LB598
.LB597:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	mov r2, r6
	lsl r2, r2, #2
	add r2, r4, r2
	ldr r2, [r2]	@ 
	lsl r2, r2, #0

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r2, r0, r2
@@ phi to mov
	mov r0, r2
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB598
.LB596:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r6
@@ phi to mov
	mov r1, r3
	b .LB593
.LB574:
	mov r3, r1
	mov r6, r3
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r3, r7
@@ phi to mov
	mov r6, r1
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #212]	@ str-all2mem 1
@@ phi to mov
	mov r1, r2
	b .LB571
.LB571:
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r2, r0
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	mov r6, #0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
@@ phi to mov
	mov r0, r2
	str r0, [sp, #100]	@ str-all2mem 1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #216]	@ str-all2mem 1
	b .LB600
.LB600:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB601
	b .LB602
.LB601:
	mov r1, #0
	mov r2, #0
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB603
.LB603:
	cmp r2, #16
	blt .LB604
	b .LB605
.LB604:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r1, r7, #1
	cmp r1, #0
	bne .LB606
	b .LB607
.LB606:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r1, r6, #1
	cmp r1, #0
	beq .LB609
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r1, r0
	b .LB610
.LB609:
	mov r1, r2
	lsl r1, r1, #2
	add r1, r4, r1
	ldr r1, [r1]	@ 
	lsl r1, r1, #0

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r1, r0, r1
	b .LB610
.LB610:
	b .LB608
.LB608:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #120]	@ str-all2mem 1
	add r2, r2, #1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB603
.LB607:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r1, r6, #1
	cmp r1, #0
	bne .LB611
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r1, r0
	b .LB612
.LB611:
	mov r1, r2
	lsl r1, r1, #2
	add r1, r4, r1
	ldr r1, [r1]	@ 
	lsl r1, r1, #0

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r1, r0, r1
	b .LB612
.LB612:
	b .LB608
.LB605:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r1, r0
	mov r2, #0
	mov r7, #0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB613
.LB613:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB614
	b .LB615
.LB614:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB617
	b .LB618
.LB617:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB613
.LB618:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB616
	b .LB617
.LB616:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r2, r2, r0
	b .LB617
.LB615:
	mov r6, #1
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #15
	bgt .LB619
	b .LB620
.LB619:
	mov r2, #0
	b .LB621
.LB621:
	mov r6, r1
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #216]	@ str-all2mem 1
	b .LB600
.LB620:
	mov r6, #0
	str r6, [sp, #120]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	lsl r2, r2, #1

	mov32 , r7, 65535
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB622
.LB622:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB623
	b .LB624
.LB623:
	and r0, r2, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB626
	b .LB627
.LB626:
	asr r2, r2, #1

	ldr r7, [sp, #16]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB622
.LB627:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	and r0, r7, #1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB625
	b .LB626
.LB625:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #28]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r6, r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
	b .LB626
.LB624:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r6
	b .LB621
.LB602:
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	mov r1, r0
	mov r0, r1
	str r0, [sp, #136]	@ str-all2mem 1
	mov r1, r8
	mov r2, #1
	cmp r2, #15
	bge .LB628
	b .LB629
.LB628:
	cmp r1, #0
	blt .LB631
	b .LB632
.LB631:
	mov32 , r1, 65535
	b .LB633
.LB633:
	b .LB630
.LB632:
	mov r1, #0
	b .LB633
.LB630:
	mov r8, r1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r1, r0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
	ldr r0, [sp, #100]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r0, r3
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB561
.LB629:
	cmp r2, #0
	bgt .LB634
	b .LB635
.LB634:
	movw r8, #32767
	cmp r1, r8
	bgt .LB637
	b .LB638
.LB637:
	mov r8, r2
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	sdiv r1, r1, r8
	add r1, r1, #65536
	rsb r2, r2, #15
	add r2, r2, #1
	lsl r2, r2, #2
	add r2, r4, r2
	ldr r2, [r2]	@ 
	sub r1, r1, r2
	b .LB639
.LB639:
	b .LB636
.LB638:
	lsl r2, r2, #2
	add r2, r4, r2
	ldr r2, [r2]	@ 
	sdiv r1, r1, r2
	b .LB639
.LB636:
	b .LB630
.LB635:
	b .LB636
.LB563:
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	mov r3, r7
@@ phi to mov
	mov r6, r1
	str r6, [sp, #60]	@ str-all2mem 1
@@ phi to mov
	mov r0, r2
	str r0, [sp, #220]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #164]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
	str r6, [sp, #32]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #100]	@ str-all2mem 1
@@ phi to mov
	mov r1, r8
	ldr r0, [sp, #136]	@ ldr-all2mem 1
@@ phi to mov
	mov r2, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB560
.LB560:
	mov r8, r9
	mov r0, #0
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r9, r8
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #44]	@ str-all2mem 1
	b .LB640
.LB640:
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	cmp r6, #0
	bne .LB641
	b .LB642
.LB641:
	mov r8, #0
	mov r10, #0
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	mov r7, r6
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB643
.LB643:
	cmp r10, #16
	blt .LB644
	b .LB645
.LB644:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	beq .LB647
	b .LB648
.LB647:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #128]	@ str-all2mem 1
	add r10, r10, #1
	b .LB643
.LB648:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r7, r0, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB646
	b .LB647
.LB646:
	mov r7, r10
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	lsl r7, r7, #2
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r4, r7
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r7, [r7]	@ 
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	lsl r7, r7, #0

	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r8, r8, r7
	b .LB647
.LB645:
	cmp r8, #0
	bne .LB649
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r8, r10
	b .LB650
.LB649:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r8, r0
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #116]	@ str-all2mem 1
@@ phi to mov
	mov r8, r10
	b .LB651
.LB651:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB652
	b .LB653
.LB652:
	mov r8, #0
	mov r10, #0
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r6, r7
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB654
.LB654:
	cmp r10, #16
	blt .LB655
	b .LB656
.LB655:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	and r0, r0, #1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB657
	b .LB658
.LB657:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #0
	beq .LB660
@@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB661
.LB660:
	mov r0, r10
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r8, r8, r0
@@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB661
.LB661:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
	b .LB659
.LB659:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	asr r0, r0, #1

	str r0, [sp, #128]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #104]	@ str-all2mem 1
	add r10, r10, #1
	b .LB654
.LB658:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r0, r6, #1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB662
@@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB663
.LB662:
	mov r0, r10
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	lsl r0, r0, #2
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r0, r4, r0
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	ldr r0, [r0]	@ 
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	lsl r0, r0, #0

	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r8, r8, r0
@@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB663
.LB663:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r0
	b .LB659
.LB656:
	mov r0, r8
	str r0, [sp, #128]	@ str-all2mem 1
	mov r8, #0
	mov r10, #0
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB664
.LB664:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB665
	b .LB666
.LB665:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r10, r6, #1
	cmp r10, #0
@@ phi to mov
	mov r10, r8
	beq .LB668
	b .LB669
.LB668:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r8, r6, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r7, r7, #1

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	add r6, r0, #1
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	mov r0, r6
	str r0, [sp, #224]	@ str-all2mem 1
@@ phi to mov
	mov r6, r8
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r8, r10
	b .LB664
.LB669:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r8, r7, #1
	cmp r8, #0
	bne .LB667
	b .LB668
.LB667:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r8, r0
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	lsl r8, r8, #0

	add r8, r10, r8
@@ phi to mov
	mov r10, r8
	b .LB668
.LB666:
	mov r10, #1
	cmp r10, #15
	bgt .LB670
	b .LB671
.LB670:
	mov r8, #0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	b .LB672
.LB672:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r10, r0
@@ phi to mov
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r6
	b .LB651
.LB671:
	mov r10, #0
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	lsl r8, r8, #1

	mov32 , r6, 65535
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
	b .LB673
.LB673:
	cmp r8, #16
	blt .LB674
	b .LB675
.LB674:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	and r7, r0, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	beq .LB677
	b .LB678
.LB677:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	asr r7, r0, #1

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	asr r6, r6, #1

	str r6, [sp, #104]	@ str-all2mem 1
	add r8, r8, #1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #224]	@ str-all2mem 1
	b .LB673
.LB678:
	ldr r6, [sp, #104]	@ ldr-all2mem 1
	and r7, r6, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB676
	b .LB677
.LB676:
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	lsl r7, r7, #2
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r4, r7
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	ldr r7, [r7]	@ 
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	lsl r7, r7, #0

	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r10, r10, r7
	b .LB677
.LB675:
@@ phi to mov
	mov r6, r8
	str r6, [sp, #104]	@ str-all2mem 1
@@ phi to mov
	mov r8, r10
	b .LB672
.LB653:
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #224]	@ str-all2mem 1
@@ phi to mov
	mov r7, r10
	str r7, [sp, #16]	@ str-all2mem 1
	b .LB650
.LB650:
	mov r10, r9
	mov r7, #0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #128]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB679
.LB679:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB680
	b .LB681
.LB680:
	mov r9, #0
	mov r8, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB682
.LB682:
	cmp r8, #16
	blt .LB683
	b .LB684
.LB683:
	and r9, r10, #1
	cmp r9, #0
	bne .LB685
	b .LB686
.LB685:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r9, r7, #1
	cmp r9, #0
	beq .LB688
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB689
.LB688:
	mov r9, r8
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	lsl r9, r9, #0

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r9, r0, r9
	b .LB689
.LB689:
@@ phi to mov
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB687
.LB687:
	asr r9, r10, #1

	mov r10, r9
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r9, r7, #1

	add r8, r8, #1
@@ phi to mov
	mov r7, r9
	str r7, [sp, #144]	@ str-all2mem 1
	b .LB682
.LB686:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r9, r7, #1
	cmp r9, #0
	bne .LB690
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB691
.LB690:
	mov r9, r8
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	lsl r9, r9, #0

	ldr r0, [sp, #128]	@ ldr-all2mem 1
	add r9, r0, r9
	b .LB691
.LB691:
@@ phi to mov
	mov r0, r9
	str r0, [sp, #128]	@ str-all2mem 1
	b .LB687
.LB684:
	mov r9, #0
	mov r8, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r10, r8
	b .LB692
.LB692:
	cmp r10, #16
	blt .LB693
	b .LB694
.LB693:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r8, r0, #1
	cmp r8, #0
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	beq .LB696
	b .LB697
.LB696:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r9, r0, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	asr r8, r7, #1

	add r10, r10, #1
@@ phi to mov
	mov r7, r8
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB692
.LB697:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	and r9, r7, #1
	cmp r9, #0
	bne .LB695
	b .LB696
.LB695:
	mov r9, r10
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	lsl r9, r9, #0

	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r9, r0, r9
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	b .LB696
.LB694:
	mov r8, #1
	cmp r8, #15
	bgt .LB698
	b .LB699
.LB698:
	mov r9, #0
@@ phi to mov
	mov r8, r10
	b .LB700
.LB700:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	mov r10, r0
@@ phi to mov
	mov r0, r9
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB679
.LB699:
	mov r8, #0
	mov r10, #0
	lsl r9, r9, #1

	mov32 , r7, 65535
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r7, r10
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r10, r8
	b .LB701
.LB701:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB702
	b .LB703
.LB702:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	and r9, r0, #1
	cmp r9, #0
@@ phi to mov
	mov r9, r10
	beq .LB705
	b .LB706
.LB705:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	asr r8, r0, #1

	ldr r0, [sp, #20]	@ ldr-all2mem 1
	asr r10, r0, #1

	ldr r7, [sp, #144]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r0, r8
	str r0, [sp, #12]	@ str-all2mem 1
@@ phi to mov
	mov r10, r9
	b .LB701
.LB706:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	and r8, r0, #1
	cmp r8, #0
	bne .LB704
	b .LB705
.LB704:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r8, r7
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	lsl r8, r8, #0

	add r9, r9, r8
	b .LB705
.LB703:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
@@ phi to mov
	mov r9, r10
	b .LB700
.LB681:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r9, r0
	mov r8, r9
	ldr r6, [sp, #120]	@ ldr-all2mem 1
	mov r10, r6
	mov r7, #1
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #15
	bge .LB707
	b .LB708
.LB707:
	cmp r10, #0
	blt .LB710
	b .LB711
.LB710:
	mov32 , r9, 65535
	b .LB712
.LB712:
	b .LB709
.LB711:
	mov r9, #0
	b .LB712
.LB709:
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@@ phi to mov
	mov r10, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #120]	@ str-all2mem 1
@@ phi to mov
	mov r9, r8
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
	b .LB640
.LB708:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	cmp r7, #0
	bgt .LB713
	b .LB714
.LB713:
	movw r9, #32767
	cmp r10, r9
	bgt .LB716
	b .LB717
.LB716:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r9, r7
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	sdiv r9, r10, r9
	add r9, r9, #65536
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	rsb r10, r7, #15
	add r10, r10, #1
	lsl r10, r10, #2
	add r10, r4, r10
	ldr r10, [r10]	@ 
	sub r9, r9, r10
	b .LB718
.LB718:
	b .LB715
.LB717:
	ldr r7, [sp, #144]	@ ldr-all2mem 1
	mov r9, r7
	lsl r9, r9, #2
	add r9, r4, r9
	ldr r9, [r9]	@ 
	sdiv r9, r10, r9
	b .LB718
.LB715:
	b .LB709
.LB714:
	mov r9, r10
	b .LB715
.LB642:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r8, r0
	mov r0, r8
	str r0, [sp, #208]	@ str-all2mem 1
	mov r8, r5
	mov r0, #1
	str r0, [sp, #204]	@ str-all2mem 1
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	cmp r0, #15
	bge .LB719
	b .LB720
.LB719:
	cmp r8, #0
	blt .LB722
	b .LB723
.LB722:
	mov32 , r5, 65535
	b .LB724
.LB724:
@@ phi to mov
	mov r6, r8
	str r6, [sp, #8]	@ str-all2mem 1
	b .LB721
.LB723:
	mov r5, #0
	b .LB724
.LB721:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@@ phi to mov
	mov r7, r0
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
@@ phi to mov
	mov r6, r9
	str r6, [sp, #120]	@ str-all2mem 1
	ldr r6, [sp, #60]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #220]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #132]	@ ldr-all2mem 1
@@ phi to mov
	mov r6, r0
	str r6, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #164]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #160]	@ ldr-all2mem 1
	str r0, [sp, #212]	@ str-all2mem 1
	ldr r6, [sp, #32]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #216]	@ str-all2mem 1
@@ phi to mov
	mov r0, r1
	str r0, [sp, #108]	@ str-all2mem 1
@@ phi to mov
	mov r0, r2
	str r0, [sp, #112]	@ str-all2mem 1
@@ phi to mov
	mov r8, r3
	ldr r0, [sp, #208]	@ ldr-all2mem 1
@@ phi to mov
	mov r9, r0
	b .LB550
.LB720:
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB725
	b .LB726
.LB725:
	movw r5, #32767
	cmp r8, r5
	bgt .LB728
	b .LB729
.LB728:
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	mov r5, r0
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	sdiv r5, r8, r5
	add r8, r5, #65536
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	rsb r7, r0, #15
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r7, #1
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	lsl r7, r7, #2
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	add r7, r4, r7
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	ldr r7, [r7]	@ 
	str r7, [sp, #16]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
	sub r8, r8, r7
	b .LB730
.LB730:
	b .LB727
.LB729:
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	mov r5, r0
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	sdiv r5, r8, r5
	mov r7, r5
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r5, r8
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
	b .LB730
.LB727:
@@ phi to mov
	mov r6, r5
	str r6, [sp, #8]	@ str-all2mem 1
@@ phi to mov
	mov r5, r8
	b .LB721
.LB726:
	mov r7, r8
	str r7, [sp, #16]	@ str-all2mem 1
@@ phi to mov
	mov r5, r8
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r8, r7
	b .LB727
.LB552:
	mov r9, r8
	mov r5, r11
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	cmp r5, r9
	bne .LB731
	b .LB732
.LB731:
@ this is a ret
	add sp, sp, #300
	mov r0, #1
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB732
.LB732:
	add r11, r11, #1
@@ phi to mov
	mov r0, r10
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r7, [sp, #144]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #232]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
	str r0, [sp, #236]	@ str-all2mem 1
	ldr r6, [sp, #104]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #240]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	str r0, [sp, #244]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #248]	@ str-all2mem 1
	ldr r7, [sp, #16]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r7
	str r0, [sp, #252]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #256]	@ str-all2mem 1
	ldr r6, [sp, #120]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #260]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #264]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #268]	@ str-all2mem 1
	ldr r6, [sp, #88]	@ ldr-all2mem 1
@@ phi to mov
	mov r0, r6
	str r0, [sp, #272]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #276]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
	str r0, [sp, #280]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #284]	@ str-all2mem 1
	ldr r0, [sp, #100]	@ ldr-all2mem 1
	str r0, [sp, #288]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
	str r0, [sp, #292]	@ str-all2mem 1
	ldr r0, [sp, #112]	@ ldr-all2mem 1
	str r0, [sp, #296]	@ str-all2mem 1
	b .LB547
.LB549:
@ this is a ret
	add sp, sp, #300
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #300
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
.LB733:
@ jmp
	bl long_func
@ this is a ret
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	pop {r4-r12, lr}
	bx lr
	.fnend
