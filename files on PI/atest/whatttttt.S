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
	sub sp, sp, #304
.LB0:
	mov r0, #0
	str r0, [sp, #0]	@ str-all2mem 1
	mov r4, #0
	mov r11, #0
	mov r5, #2
	mov r7, #0
	str r7, [sp, #4]	@ str-all2mem 1
	mov r0, #1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #16]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB1
.LB1:
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB2
	b .LB3
.LB2:
	mov r7, #0
	str r7, [sp, #4]	@ str-all2mem 1
	mov r11, #0
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, #1
@ phi to mov
	mov r5, r4
@ phi to mov
	mov r0, r11
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	b .LB4
.LB4:
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB5
	b .LB6
.LB5:
	mov r7, #2
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	sdiv r4, r0, r7
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	mul r4, r4, r7
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
@ phi to mov
	mov r7, r11
	str r7, [sp, #4]	@ str-all2mem 1
	beq .LB8
	b .LB9
.LB8:
	mov r4, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r0, r4
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, #2
	sdiv r4, r5, r4
	mov r11, r4
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r5, r11
@ phi to mov
	mov r0, r4
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	b .LB4
.LB9:
	mov r4, #2
	sdiv r11, r5, r4
	mul r4, r11, r4
	sub r4, r5, r4
	cmp r4, #0
	bne .LB7
	b .LB8
.LB7:
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	add r4, r7, #1
@ phi to mov
	mov r7, r4
	str r7, [sp, #4]	@ str-all2mem 1
	b .LB8
.LB6:
	cmp r11, #0
	bne .LB10
	ldr r0, [sp, #32]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #40]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #48]	@ ldr-all2mem 1
	str r0, [sp, #52]	@ str-all2mem 1
	ldr r0, [sp, #56]	@ ldr-all2mem 1
	str r0, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB11
.LB10:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #32]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	ldr r0, [sp, #36]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #48]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #56]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB12
.LB12:
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB13
	b .LB14
.LB13:
	mov r4, #0
	mov r6, #0
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	mov r11, #1
@ phi to mov
	mov r5, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
	b .LB15
.LB15:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB16
	b .LB17
.LB16:
	mov r6, #2
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	sdiv r4, r0, r6
	mul r6, r4, r6
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
@ phi to mov
	mov r4, r11
	beq .LB19
	b .LB20
.LB19:
	mov r6, #2
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	mov r6, #2
	sdiv r6, r5, r6
	mov r5, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #0]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
	b .LB15
.LB20:
	mov r11, #2
	sdiv r6, r5, r11
	mul r6, r6, r11
	sub r6, r5, r6
	cmp r6, #0
	bne .LB18
	b .LB19
.LB18:
	add r6, r4, #1
@ phi to mov
	mov r4, r6
	b .LB19
.LB17:
	cmp r11, #0
	bne .LB21
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #60]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB22
.LB21:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	mov r6, r0
	mov r4, #0
@ phi to mov
	mov r7, r6
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB23
.LB23:
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB24
	b .LB25
.LB24:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r5, #0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r4, r7
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	mov r6, r7
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB26
.LB26:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB27
	b .LB28
.LB27:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
	bne .LB29
	b .LB30
.LB29:
	mov r6, #2
	sdiv r0, r11, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r0, r6
	sub r6, r11, r6
	cmp r6, #0
	beq .LB32
@ phi to mov
	mov r6, r5
	b .LB33
.LB32:
	add r6, r5, #1
	b .LB33
.LB33:
@ phi to mov
	mov r5, r6
	b .LB31
.LB31:
	mov r6, #2
	sdiv r6, r4, r6
	mov r4, r6
	mov r6, #2
	sdiv r6, r11, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r11, r0, #1
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	b .LB26
.LB30:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r11, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r11, r6
	cmp r6, #0
	bne .LB34
@ phi to mov
	mov r6, r5
	b .LB35
.LB34:
	add r6, r5, #1
	b .LB35
.LB35:
@ phi to mov
	mov r5, r6
	b .LB31
.LB28:
	mov r11, r5
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r5, #0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r4, r7
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	mov r6, r7
@ phi to mov
	mov r7, r4
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB36
.LB36:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB37
	b .LB38
.LB37:
	mov r4, #2
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	sdiv r5, r7, r4
	mul r4, r5, r4
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	beq .LB40
	b .LB41
.LB40:
	mov r4, #2
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, #2
	sdiv r6, r6, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB36
.LB41:
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r6, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r4, r4, r0
	sub r4, r6, r4
	cmp r4, #0
	bne .LB39
	b .LB40
.LB39:
	add r4, r5, #1
@ phi to mov
	mov r5, r4
	b .LB40
.LB38:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r5, r0
	mov r6, #1
	cmp r6, #15
	bgt .LB42
	b .LB43
.LB42:
	mov r4, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB44
.LB44:
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	mov r5, r11
@ phi to mov
	mov r4, r11
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	b .LB23
.LB43:
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, #0
	mov r6, #2
	mul r6, r5, r6
	mov32 , r5, 65535
@ phi to mov
	mov r7, r4
	str r7, [sp, #4]	@ str-all2mem 1
	b .LB45
.LB45:
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB46
	b .LB47
.LB46:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r4, r6, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r4, r4, r0
	sub r4, r6, r4
	cmp r4, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB49
	b .LB50
.LB49:
	mov r4, #2
	sdiv r6, r6, r4
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #2
	sdiv r6, r5, r6
	ldr r7, [sp, #4]	@ ldr-all2mem 1
	add r4, r7, #1
@ phi to mov
	mov r5, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
@ phi to mov
	mov r7, r4
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB45
.LB50:
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r5, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r4, r4, r0
	sub r4, r5, r4
	cmp r4, #0
	bne .LB48
	b .LB49
.LB48:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB49
.LB47:
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB44
.LB25:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r6, r7
	mov r5, r6
@ phi to mov
	mov r6, r4
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #0]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
	b .LB22
.LB22:
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	mov r11, #0
@ phi to mov
	mov r5, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB51
.LB51:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB52
	b .LB53
.LB52:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r11, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r4, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r5, r0
@ phi to mov
	mov r0, r5
	str r0, [sp, #64]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB54
.LB54:
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB55
	b .LB56
.LB55:
	mov r11, #2
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r4, r7, r11
	mul r4, r4, r11
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	bne .LB57
	b .LB58
.LB57:
	mov r11, #2
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	sdiv r4, r0, r11
	mul r4, r4, r11
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	beq .LB60
@ phi to mov
	mov r4, r5
	b .LB61
.LB60:
	add r4, r5, #1
	b .LB61
.LB61:
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB59
.LB59:
	mov r4, #2
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	mov r11, #2
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	sdiv r11, r0, r11
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	add r5, r0, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #64]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB54
.LB58:
	mov r11, #2
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	sdiv r4, r0, r11
	mul r4, r4, r11
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	bne .LB62
@ phi to mov
	mov r4, r5
	b .LB63
.LB62:
	add r4, r5, #1
	b .LB63
.LB63:
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB59
.LB56:
	mov r4, #0
	mov r11, #0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB64
.LB64:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB65
	b .LB66
.LB65:
	mov r11, #2
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	sdiv r4, r0, r11
	mul r4, r4, r11
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	beq .LB68
	b .LB69
.LB68:
	mov r4, #2
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	sdiv r4, r0, r4
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r0, r7, r0
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB64
.LB69:
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r7, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r4, r4, r0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	bne .LB67
	b .LB68
.LB67:
	add r4, r11, #1
@ phi to mov
	mov r11, r4
	b .LB68
.LB66:
	mov r4, #1
	cmp r4, #15
	bgt .LB70
	b .LB71
.LB70:
	mov r4, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB72
.LB72:
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, r5
@ phi to mov
	mov r0, r4
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB51
.LB71:
	mov r0, #0
	str r0, [sp, #72]	@ str-all2mem 1
	mov r11, #0
	mov r4, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r4, r0, r4
	mov32 , r0, 65535
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB73
.LB73:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB74
	b .LB75
.LB74:
	mov r4, #2
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r11, r7, r4
	mul r4, r11, r4
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	beq .LB77
	b .LB78
.LB77:
	mov r4, #2
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	mov r11, r4
	mov r4, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r4, r0, r4
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	add r0, r0, #1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
	b .LB73
.LB78:
	mov r4, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r11, r0, r4
	mul r4, r11, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	bne .LB76
	b .LB77
.LB76:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB77
.LB75:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB72
.LB53:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r4, r0
	mov r11, r4
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
	mov r4, #1
	cmp r4, #15
	bge .LB79
	b .LB80
.LB79:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	cmp r7, #0
	blt .LB82
	b .LB83
.LB82:
	mov32 , r4, 65535
	b .LB84
.LB84:
	b .LB81
.LB83:
	mov r4, #0
	b .LB84
.LB81:
	mov r0, r4
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #60]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB12
.LB80:
	cmp r4, #0
	bgt .LB85
	b .LB86
.LB85:
	movw r4, #32767
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	cmp r7, r4
	bgt .LB88
	b .LB89
.LB88:
	mov r4, #1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	add r4, r4, #65536
	sub r4, r4, #1
	b .LB90
.LB90:
	b .LB87
.LB89:
	mov r4, #1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	b .LB90
.LB87:
	b .LB81
.LB86:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r4, r7
	b .LB87
.LB14:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r11, r0
@ phi to mov
	mov r0, r4
	str r0, [sp, #40]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	str r0, [sp, #44]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #52]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	b .LB11
.LB11:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r11, r0
	mov r6, #0
	ldr r0, [sp, #80]	@ ldr-all2mem 1
	str r0, [sp, #48]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #84]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #88]	@ ldr-all2mem 1
	str r0, [sp, #36]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #92]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #84]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #88]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #96]	@ str-all2mem 1
	b .LB91
.LB91:
	ldr r0, [sp, #84]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB92
	b .LB93
.LB92:
	mov r6, #0
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #84]	@ ldr-all2mem 1
	mov r11, r0
	mov r4, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	b .LB94
.LB94:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB95
	b .LB96
.LB95:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
	beq .LB98
	b .LB99
.LB98:
	mov r6, #2
	sdiv r6, r4, r6
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r4, r6
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB94
.LB99:
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r0, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB97
	b .LB98
.LB97:
	add r6, r11, #1
@ phi to mov
	mov r11, r6
	b .LB98
.LB96:
	cmp r11, #0
	bne .LB100
@ phi to mov
	mov r0, r10
	str r0, [sp, #80]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB101
.LB100:
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #88]	@ ldr-all2mem 1
	mov r10, r0
	mov r6, #0
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r0, r10
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB102
.LB102:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB103
	b .LB104
.LB103:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r10, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r4, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB105
.LB105:
	cmp r10, #16
	blt .LB106
	b .LB107
.LB106:
	mov r6, #2
	sdiv r0, r11, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r0, r6
	sub r6, r11, r6
	cmp r6, #0
	bne .LB108
	b .LB109
.LB108:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
	beq .LB111
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB112
.LB111:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
	b .LB112
.LB112:
	b .LB110
.LB110:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r11, r11, r0
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	mov r11, #2
	sdiv r4, r4, r11
	mov r11, r4
	add r4, r10, #1
	mov r10, r4
@ phi to mov
	mov r4, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB105
.LB109:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
	bne .LB113
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB114
.LB113:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
	b .LB114
.LB114:
	b .LB110
.LB107:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #24]	@ str-all2mem 1
	mov r6, #0
	mov r11, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r4, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB115
.LB115:
	cmp r11, #16
	blt .LB116
	b .LB117
.LB116:
	mov r7, #2
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r6, r10, r7
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mul r6, r6, r7
	sub r6, r10, r6
	cmp r6, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	beq .LB119
	b .LB120
.LB119:
	mov r6, #2
	sdiv r6, r10, r6
	mov r10, r6
	mov r6, #2
	sdiv r6, r4, r6
	add r4, r11, #1
	mov r11, r4
@ phi to mov
	mov r4, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB115
.LB120:
	mov r0, #2
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
	bne .LB118
	b .LB119
.LB118:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB119
.LB117:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r6, #1
	cmp r6, #15
	bgt .LB121
	b .LB122
.LB121:
	mov r6, #0
	b .LB123
.LB123:
	mov r10, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
@ phi to mov
	mov r0, r10
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB102
.LB122:
	mov r10, #0
	mov r6, #0
	mov r4, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mul r4, r7, r4
	mov r11, r4
	mov32 , r4, 65535
@ phi to mov
	mov r0, r11
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	b .LB124
.LB124:
	cmp r11, #16
	blt .LB125
	b .LB126
.LB125:
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r7, r0, r6
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mul r6, r7, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB128
	b .LB129
.LB128:
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	mov r6, #2
	sdiv r6, r4, r6
	add r4, r11, #1
	mov r11, r4
@ phi to mov
	mov r4, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB124
.LB129:
	mov r6, #2
	sdiv r7, r4, r6
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mul r6, r7, r6
	sub r6, r4, r6
	cmp r6, #0
	bne .LB127
	b .LB128
.LB127:
	add r6, r10, #1
@ phi to mov
	mov r10, r6
	b .LB128
.LB126:
@ phi to mov
	mov r6, r10
	b .LB123
.LB104:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r4
	str r0, [sp, #80]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #68]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB101
.LB101:
	ldr r0, [sp, #88]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #88]	@ ldr-all2mem 1
	mov r4, r0
	mov r6, #0
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB130
.LB130:
	cmp r11, #0
	bne .LB131
	b .LB132
.LB131:
	mov r7, #0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r6, #0
	mov r4, r10
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB133
.LB133:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB134
	b .LB135
.LB134:
	mov r4, #2
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sdiv r6, r0, r4
	mul r6, r6, r4
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB136
	b .LB137
.LB136:
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r4, r0, r6
	mul r6, r4, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB139
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB140
.LB139:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
	b .LB140
.LB140:
@ phi to mov
	mov r4, r6
	b .LB138
.LB138:
	mov r6, #2
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
	mov r6, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB133
.LB137:
	mov r4, #2
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sdiv r6, r0, r4
	mul r6, r6, r4
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB141
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB142
.LB141:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
	b .LB142
.LB142:
@ phi to mov
	mov r4, r6
	b .LB138
.LB135:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #12]	@ str-all2mem 1
	mov r6, #0
	mov r4, #0
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB143
.LB143:
	cmp r4, #16
	blt .LB144
	b .LB145
.LB144:
	mov r6, #2
	sdiv r11, r10, r6
	mul r6, r11, r6
	sub r6, r10, r6
	cmp r6, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	beq .LB147
	b .LB148
.LB147:
	mov r11, #2
	sdiv r11, r10, r11
	mov r10, r11
	mov r11, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r11, r7, r11
	add r4, r4, #1
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB143
.LB148:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r11, r7, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r11, r11, r0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sub r11, r7, r11
	cmp r11, #0
	bne .LB146
	b .LB147
.LB146:
	add r6, r6, #1
	b .LB147
.LB145:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r11, r0
	mov r6, #1
	cmp r6, #15
	bgt .LB149
	b .LB150
.LB149:
	mov r6, #0
	b .LB151
.LB151:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r0, r4
	str r0, [sp, #28]	@ str-all2mem 1
	b .LB130
.LB150:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r10, #0
	mov r6, #2
	mul r6, r11, r6
	mov32 , r4, 65535
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB152
.LB152:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB153
	b .LB154
.LB153:
	mov r11, #2
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sdiv r4, r0, r11
	mul r4, r4, r11
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
@ phi to mov
	mov r4, r6
	beq .LB156
	b .LB157
.LB156:
	mov r6, #2
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r10, r6
	mov r6, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	add r11, r0, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r6, r4
	b .LB152
.LB157:
	mov r6, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r11, r7, r6
	mul r6, r11, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB155
	b .LB156
.LB155:
	add r6, r4, #1
@ phi to mov
	mov r4, r6
	b .LB156
.LB154:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB151
.LB132:
	mov r6, r10
	mov r4, r6
	ldr r0, [sp, #84]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r6, #1
	cmp r6, #15
	bge .LB158
	b .LB159
.LB158:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #0
	blt .LB161
	b .LB162
.LB161:
	mov32 , r6, 65535
	b .LB163
.LB163:
	b .LB160
.LB162:
	mov r6, #0
	b .LB163
.LB160:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #48]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #80]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #92]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #84]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #88]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #96]	@ str-all2mem 1
	b .LB91
.LB159:
	cmp r6, #0
	bgt .LB164
	b .LB165
.LB164:
	movw r6, #32767
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, r6
	bgt .LB167
	b .LB168
.LB167:
	mov r6, #1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	add r6, r6, #65536
	sub r6, r6, #1
	b .LB169
.LB169:
	b .LB166
.LB168:
	mov r6, #1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	b .LB169
.LB166:
	b .LB160
.LB165:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r6, r7
	b .LB166
.LB93:
	ldr r0, [sp, #92]	@ ldr-all2mem 1
	mov r6, r0
	mov r11, r6
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	mov r4, r0
	mov r0, #1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	cmp r0, #15
	bge .LB170
	b .LB171
.LB170:
	cmp r4, #0
	blt .LB173
	b .LB174
.LB173:
	mov32 , r6, 65535
	b .LB175
.LB175:
@ phi to mov
	mov r0, r4
	str r0, [sp, #92]	@ str-all2mem 1
	b .LB172
.LB174:
	mov r6, #0
	b .LB175
.LB172:
	mov r4, r6
	ldr r0, [sp, #48]	@ ldr-all2mem 1
	str r0, [sp, #80]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #84]	@ str-all2mem 1
	ldr r0, [sp, #36]	@ ldr-all2mem 1
	str r0, [sp, #88]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #32]	@ str-all2mem 1
	ldr r0, [sp, #40]	@ ldr-all2mem 1
	str r0, [sp, #36]	@ str-all2mem 1
	ldr r0, [sp, #44]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	ldr r0, [sp, #52]	@ ldr-all2mem 1
	str r0, [sp, #48]	@ str-all2mem 1
	ldr r0, [sp, #60]	@ ldr-all2mem 1
	str r0, [sp, #56]	@ str-all2mem 1
	ldr r0, [sp, #64]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #16]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	ldr r0, [sp, #92]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #96]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB1
.LB171:
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB176
	b .LB177
.LB176:
	movw r6, #32767
	cmp r4, r6
	bgt .LB179
	b .LB180
.LB179:
	mov r6, #1
	sdiv r6, r4, r6
	mov r4, r6
	add r6, r4, #65536
	sub r6, r6, #1
	b .LB181
.LB181:
	b .LB178
.LB180:
	mov r6, #1
	sdiv r6, r4, r6
	b .LB181
.LB178:
@ phi to mov
	mov r0, r4
	str r0, [sp, #92]	@ str-all2mem 1
	b .LB172
.LB177:
	mov r6, r4
	b .LB178
.LB3:
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	mov r6, r0
	mov r0, r6
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	mov r10, #2
	mov r6, #1
	mov r0, #1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r10, r4
@ phi to mov
	mov r4, r5
	b .LB182
.LB182:
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB183
	b .LB184
.LB183:
	mov r0, #74
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	mov r4, #0
	mov r11, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r10, r0
	mov r6, #1
@ phi to mov
	mov r5, r6
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
	b .LB185
.LB185:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB186
	b .LB187
.LB186:
	mov r11, #2
	sdiv r6, r10, r11
	mul r6, r6, r11
	sub r6, r10, r6
	cmp r6, #0
@ phi to mov
	mov r11, r4
	beq .LB189
	b .LB190
.LB189:
	mov r6, #2
	sdiv r6, r10, r6
	mov r10, r6
	mov r6, #2
	sdiv r6, r5, r6
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	add r4, r7, #1
@ phi to mov
	mov r5, r6
@ phi to mov
	mov r7, r4
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
	b .LB185
.LB190:
	mov r6, #2
	sdiv r4, r5, r6
	mul r6, r4, r6
	sub r6, r5, r6
	cmp r6, #0
	bne .LB188
	b .LB189
.LB188:
	add r6, r11, #1
@ phi to mov
	mov r11, r6
	b .LB189
.LB187:
	cmp r4, #0
	bne .LB191
	ldr r0, [sp, #104]	@ ldr-all2mem 1
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #116]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #124]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #128]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r0, [sp, #136]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #60]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB192
.LB191:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r5, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r11, r0
	mov r6, #0
	ldr r0, [sp, #104]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #108]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	ldr r0, [sp, #116]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #124]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r0, r11
	str r0, [sp, #68]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	b .LB193
.LB193:
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB194
	b .LB195
.LB194:
	mov r0, #75
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	mov r10, #0
	mov r11, #0
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	mov r5, r0
	mov r6, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r9, r5
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
	b .LB196
.LB196:
	cmp r11, #16
	blt .LB197
	b .LB198
.LB197:
	mov r0, #76
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	mov r10, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r10
	mul r6, r6, r10
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r6, r9, r6
	cmp r6, #0
@ phi to mov
	mov r7, r5
	str r7, [sp, #132]	@ str-all2mem 1
	beq .LB200
	b .LB201
.LB200:
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r6
	mov r10, r6
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r5, r6
	add r6, r11, #1
@ phi to mov
	mov r7, r5
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r9, r10
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r7
	b .LB196
.LB201:
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r10, r7, r6
	mul r6, r10, r6
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB199
	b .LB200
.LB199:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB200
.LB198:
	cmp r5, #0
	bne .LB202
	ldr r0, [sp, #104]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
	b .LB203
.LB202:
	mov r6, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r10, r0
	mov r4, #0
@ phi to mov
	mov r5, r6
	b .LB204
.LB204:
	cmp r10, #0
	bne .LB205
	b .LB206
.LB205:
	mov r6, #0
	mov r4, #0
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
	mov r11, r10
@ phi to mov
	mov r9, r11
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB207
.LB207:
	cmp r11, #16
	blt .LB208
	b .LB209
.LB208:
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r4, r7, r6
	mul r6, r4, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB210
	b .LB211
.LB210:
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r4, r9, r6
	mul r6, r4, r6
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r6, r9, r6
	cmp r6, #0
	beq .LB213
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB214
.LB213:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r6, r0, #1
	b .LB214
.LB214:
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB212
.LB212:
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r6
	mov r4, r6
	add r6, r11, #1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB207
.LB211:
	mov r4, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r4
	mul r6, r6, r4
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r6, r9, r6
	cmp r6, #0
	bne .LB215
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB216
.LB215:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r6, r0, #1
	b .LB216
.LB216:
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB212
.LB209:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r6, #0
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r11, r5
	mov r4, r10
@ phi to mov
	mov r7, r11
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
@ phi to mov
	mov r10, r6
	b .LB217
.LB217:
	cmp r5, #16
	blt .LB218
	b .LB219
.LB218:
	mov r0, #64
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r11, r7, r6
	mul r6, r11, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	beq .LB221
	b .LB222
.LB221:
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r11, r6
	mov r6, #2
	sdiv r6, r4, r6
	add r4, r5, #1
	mov r5, r4
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r7, r11
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB217
.LB222:
	mov r11, #2
	sdiv r6, r4, r11
	mul r6, r6, r11
	sub r6, r4, r6
	cmp r6, #0
	bne .LB220
	b .LB221
.LB220:
	add r6, r10, #1
@ phi to mov
	mov r10, r6
	b .LB221
.LB219:
	mov r6, #1
	cmp r6, #15
	bgt .LB223
	b .LB224
.LB223:
	mov r6, #0
@ phi to mov
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB225
.LB225:
	mov r11, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r6, r7
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r7
@ phi to mov
	mov r10, r11
@ phi to mov
	mov r5, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB204
.LB224:
	mov r11, #0
	mov r6, #0
	mov r4, #2
	mul r4, r10, r4
	mov r10, r4
	mov32 , r4, 65535
@ phi to mov
	mov r5, r4
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
	b .LB226
.LB226:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB227
	b .LB228
.LB227:
	mov r11, #2
	sdiv r6, r10, r11
	mul r6, r6, r11
	sub r6, r10, r6
	cmp r6, #0
	beq .LB230
	b .LB231
.LB230:
	mov r6, #2
	sdiv r6, r10, r6
	mov r10, r6
	mov r6, #2
	sdiv r6, r5, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r11, r0, #1
@ phi to mov
	mov r5, r6
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB226
.LB231:
	mov r11, #2
	sdiv r6, r5, r11
	mul r6, r6, r11
	sub r6, r5, r6
	cmp r6, #0
	bne .LB229
	b .LB230
.LB229:
	add r6, r4, #1
@ phi to mov
	mov r4, r6
	b .LB230
.LB228:
@ phi to mov
	mov r6, r4
	b .LB225
.LB206:
	mov r6, r5
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
	b .LB203
.LB203:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r4, r0
	mov r6, #0
@ phi to mov
	mov r9, r6
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r6, r4
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
	b .LB232
.LB232:
	cmp r6, #0
	bne .LB233
	b .LB234
.LB233:
	mov r5, #0
	mov r4, #0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r10, r7
	mov r11, r6
@ phi to mov
	mov r9, r11
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r11, r10
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB235
.LB235:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB236
	b .LB237
.LB236:
	mov r10, #2
	sdiv r4, r11, r10
	mul r4, r4, r10
	sub r4, r11, r4
	cmp r4, #0
	bne .LB238
	b .LB239
.LB238:
	mov r10, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r4, r9, r10
	mul r4, r4, r10
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r4, r9, r4
	cmp r4, #0
	beq .LB241
@ phi to mov
	mov r4, r5
	b .LB242
.LB241:
	add r4, r5, #1
	b .LB242
.LB242:
@ phi to mov
	mov r10, r4
	b .LB240
.LB240:
	mov r4, #2
	sdiv r4, r11, r4
	mov r11, r4
	mov r4, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r4, r9, r4
	mov r5, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r9, r5
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
	b .LB235
.LB239:
	mov r4, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r10, r9, r4
	mul r4, r10, r4
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r4, r9, r4
	cmp r4, #0
	bne .LB243
@ phi to mov
	mov r4, r5
	b .LB244
.LB243:
	add r4, r5, #1
	b .LB244
.LB244:
@ phi to mov
	mov r10, r4
	b .LB240
.LB237:
	mov r9, r5
	str r9, [sp, #112]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r10, #0
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r11, r7
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r5, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB245
.LB245:
	cmp r10, #16
	blt .LB246
	b .LB247
.LB246:
	mov r6, #2
	sdiv r0, r5, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r0, r6
	sub r6, r5, r6
	cmp r6, #0
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB249
	b .LB250
.LB249:
	mov r6, #2
	sdiv r6, r5, r6
	mov r11, r6
	mov r6, #2
	sdiv r6, r4, r6
	add r4, r10, #1
	mov r10, r4
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r5, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB245
.LB250:
	mov r6, #2
	sdiv r11, r4, r6
	mul r6, r11, r6
	sub r6, r4, r6
	cmp r6, #0
	bne .LB248
	b .LB249
.LB248:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB249
.LB247:
	mov r6, #1
	cmp r6, #15
	bgt .LB251
	b .LB252
.LB251:
	mov r6, #0
@ phi to mov
	mov r4, r10
	b .LB253
.LB253:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r11, r9
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r5, r4
	b .LB232
.LB252:
	mov r10, #0
	mov r6, #0
	mov r4, #2
	mul r4, r11, r4
	mov32 , r11, 65535
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
	b .LB254
.LB254:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB255
	b .LB256
.LB255:
	mov r6, #2
	sdiv r10, r4, r6
	mul r6, r10, r6
	sub r6, r4, r6
	cmp r6, #0
@ phi to mov
	mov r10, r5
	beq .LB258
	b .LB259
.LB258:
	mov r6, #2
	sdiv r6, r4, r6
	mov r4, #2
	sdiv r4, r11, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r11, r0, #1
	mov r5, r11
@ phi to mov
	mov r11, r4
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
	b .LB254
.LB259:
	mov r5, #2
	sdiv r6, r11, r5
	mul r6, r6, r5
	sub r6, r11, r6
	cmp r6, #0
	bne .LB257
	b .LB258
.LB257:
	add r6, r10, #1
@ phi to mov
	mov r10, r6
	b .LB258
.LB256:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
@ phi to mov
	mov r6, r5
	b .LB253
.LB234:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r4, r7
	mov r11, r4
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	mov r4, r0
	mov r10, #1
	cmp r10, #15
	bge .LB260
	b .LB261
.LB260:
	cmp r4, #0
	blt .LB263
	b .LB264
.LB263:
	mov32 , r4, 65535
	b .LB265
.LB265:
	b .LB262
.LB264:
	mov r4, #0
	b .LB265
.LB262:
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r9
	str r7, [sp, #4]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r7
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r7
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r5
	b .LB193
.LB261:
	cmp r10, #0
	bgt .LB266
	b .LB267
.LB266:
	movw r10, #32767
	cmp r4, r10
	bgt .LB269
	b .LB270
.LB269:
	mov r10, #1
	sdiv r4, r4, r10
	add r4, r4, #65536
	sub r4, r4, #1
	b .LB271
.LB271:
	b .LB268
.LB270:
	mov r10, #1
	sdiv r4, r4, r10
	b .LB271
.LB268:
	b .LB262
.LB267:
	b .LB268
.LB195:
	mov r6, r4
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #16]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
	ldr r0, [sp, #104]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r5, r4
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #64]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #60]	@ str-all2mem 1
@ phi to mov
	mov r6, r11
	b .LB192
.LB192:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	mov r4, r0
	mov r10, #0
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #144]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #152]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #140]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #76]	@ str-all2mem 1
	b .LB272
.LB272:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB273
	b .LB274
.LB273:
	mov r7, #0
	str r7, [sp, #132]	@ str-all2mem 1
	mov r11, #0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r4, r7
	mov r6, #1
@ phi to mov
	mov r10, r6
@ phi to mov
	mov r0, r11
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB275
.LB275:
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB276
	b .LB277
.LB276:
	mov r6, #2
	sdiv r11, r4, r6
	mul r6, r11, r6
	sub r6, r4, r6
	cmp r6, #0
	beq .LB279
	b .LB280
.LB279:
	mov r6, #2
	sdiv r6, r4, r6
	mov r11, r6
	mov r6, #2
	sdiv r6, r10, r6
	mov r4, r6
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r10, r4
@ phi to mov
	mov r4, r11
@ phi to mov
	mov r0, r6
	str r0, [sp, #20]	@ str-all2mem 1
	b .LB275
.LB280:
	mov r6, #2
	sdiv r11, r10, r6
	mul r6, r11, r6
	sub r6, r10, r6
	cmp r6, #0
	bne .LB278
	b .LB279
.LB278:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB279
.LB277:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB281
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB282
.LB281:
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	mov r11, r7
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	mov r4, r0
	mov r6, #0
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r9, r11
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB283
.LB283:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB284
	b .LB285
.LB284:
	mov r10, #0
	mov r11, #0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r4, r9
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r7, r6
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB286
.LB286:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB287
	b .LB288
.LB287:
	mov r11, #2
	sdiv r6, r4, r11
	mul r6, r6, r11
	sub r6, r4, r6
	cmp r6, #0
	bne .LB289
	b .LB290
.LB289:
	mov r11, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r11
	mul r6, r6, r11
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	beq .LB292
@ phi to mov
	mov r6, r10
	b .LB293
.LB292:
	add r6, r10, #1
	b .LB293
.LB293:
@ phi to mov
	mov r11, r6
	b .LB291
.LB291:
	mov r6, #2
	sdiv r6, r4, r6
	mov r4, r6
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r10, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
	b .LB286
.LB290:
	mov r11, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r11
	mul r6, r6, r11
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB294
@ phi to mov
	mov r6, r10
	b .LB295
.LB294:
	add r6, r10, #1
	b .LB295
.LB295:
@ phi to mov
	mov r11, r6
	b .LB291
.LB288:
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
	mov r4, #0
	mov r10, #0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r11, r9
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB296
.LB296:
	cmp r10, #16
	blt .LB297
	b .LB298
.LB297:
	mov r4, #2
	sdiv r6, r11, r4
	mul r6, r6, r4
	sub r6, r11, r6
	cmp r6, #0
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	beq .LB300
	b .LB301
.LB300:
	mov r4, #2
	sdiv r4, r11, r4
	mov r11, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r11, r0, r11
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	add r11, r10, #1
	mov r10, r11
@ phi to mov
	mov r11, r4
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB296
.LB301:
	mov r4, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r7, r0, r4
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mul r4, r7, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	bne .LB299
	b .LB300
.LB299:
	add r6, r6, #1
	b .LB300
.LB298:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r4, r7
	mov r6, #1
	cmp r6, #15
	bgt .LB302
	b .LB303
.LB302:
	mov r6, #0
@ phi to mov
	mov r11, r10
	b .LB304
.LB304:
	mov r4, r6
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	mov r10, r7
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r9, r10
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
	b .LB283
.LB303:
	mov r9, #0
	str r9, [sp, #112]	@ str-all2mem 1
	mov r11, #0
	mov r6, #2
	mul r6, r4, r6
	mov r4, r6
	mov32 , r6, 65535
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r9
	b .LB305
.LB305:
	cmp r10, #16
	blt .LB306
	b .LB307
.LB306:
	mov r11, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r11
	mul r6, r6, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
	beq .LB309
	b .LB310
.LB309:
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r4, r6
	add r6, r10, #1
@ phi to mov
	mov r7, r4
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r9
	b .LB305
.LB310:
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r4, r7, r6
	mul r6, r4, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB308
	b .LB309
.LB308:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	add r6, r9, #1
@ phi to mov
	mov r9, r6
	str r9, [sp, #112]	@ str-all2mem 1
	b .LB309
.LB307:
@ phi to mov
	mov r11, r10
@ phi to mov
	mov r6, r4
	b .LB304
.LB285:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r11, r9
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r6, r4
	b .LB282
.LB282:
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	mov r10, r0
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	mov r4, r0
	mov r11, #0
@ phi to mov
	mov r7, r11
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB311
.LB311:
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB312
	b .LB313
.LB312:
	mov r4, #0
	mov r10, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #140]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r10, r4
	b .LB314
.LB314:
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB315
	b .LB316
.LB315:
	mov r6, #2
	sdiv r4, r11, r6
	mul r6, r4, r6
	sub r6, r11, r6
	cmp r6, #0
	bne .LB317
	b .LB318
.LB317:
	mov r6, #2
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	sdiv r4, r0, r6
	mul r6, r4, r6
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB320
@ phi to mov
	mov r6, r10
	b .LB321
.LB320:
	add r6, r10, #1
	b .LB321
.LB321:
@ phi to mov
	mov r10, r6
	b .LB319
.LB319:
	mov r6, #2
	sdiv r6, r11, r6
	mov r11, r6
	mov r6, #2
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r4, r6
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #140]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #120]	@ str-all2mem 1
	b .LB314
.LB318:
	mov r4, #2
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	sdiv r6, r0, r4
	mul r6, r6, r4
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB322
@ phi to mov
	mov r6, r10
	b .LB323
.LB322:
	add r6, r10, #1
	b .LB323
.LB323:
@ phi to mov
	mov r10, r6
	b .LB319
.LB316:
	mov r0, r10
	str r0, [sp, #140]	@ str-all2mem 1
	mov r4, #0
	mov r7, #0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	mov r11, r0
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	b .LB324
.LB324:
	cmp r11, #16
	blt .LB325
	b .LB326
.LB325:
	mov r7, #2
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r10, r7
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	mul r6, r6, r7
	sub r6, r10, r6
	cmp r6, #0
	beq .LB328
	b .LB329
.LB328:
	mov r6, #2
	sdiv r6, r10, r6
	mov r10, r6
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	add r11, r11, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB324
.LB329:
	mov r7, #2
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r0, r7
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	mul r6, r6, r7
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB327
	b .LB328
.LB327:
	add r6, r4, #1
@ phi to mov
	mov r4, r6
	b .LB328
.LB326:
	mov r6, #1
	cmp r6, #15
	bgt .LB330
	b .LB331
.LB330:
	mov r4, #0
@ phi to mov
	mov r6, r11
	b .LB332
.LB332:
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #140]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB311
.LB331:
	mov r6, #0
	mov r10, #0
	mov r11, #2
	mul r4, r4, r11
	mov32 , r11, 65535
@ phi to mov
	mov r7, r11
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r4, r10
@ phi to mov
	mov r11, r6
	b .LB333
.LB333:
	cmp r4, #16
	blt .LB334
	b .LB335
.LB334:
	mov r10, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r10
	mul r6, r6, r10
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB337
	b .LB338
.LB337:
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r10, r6
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	add r6, r4, #1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	b .LB333
.LB338:
	mov r10, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r10
	mul r6, r6, r10
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB336
	b .LB337
.LB336:
	add r6, r11, #1
@ phi to mov
	mov r11, r6
	b .LB337
.LB335:
@ phi to mov
	mov r6, r4
@ phi to mov
	mov r4, r11
	b .LB332
.LB313:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
	mov r11, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r4, r7
	mov r6, #1
	cmp r6, #15
	bge .LB339
	b .LB340
.LB339:
	cmp r4, #0
	blt .LB342
	b .LB343
.LB342:
	mov32 , r6, 65535
	b .LB344
.LB344:
	b .LB341
.LB343:
	mov r6, #0
	b .LB344
.LB341:
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #140]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #76]	@ str-all2mem 1
	b .LB272
.LB340:
	cmp r6, #0
	bgt .LB345
	b .LB346
.LB345:
	movw r6, #32767
	cmp r4, r6
	bgt .LB348
	b .LB349
.LB348:
	mov r6, #1
	sdiv r6, r4, r6
	add r6, r6, #65536
	sub r6, r6, #1
	b .LB350
.LB350:
	b .LB347
.LB349:
	mov r6, #1
	sdiv r6, r4, r6
	b .LB350
.LB347:
	b .LB341
.LB346:
	mov r6, r4
	b .LB347
.LB274:
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	mov r6, r7
	mov r11, r6
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	mov r10, r0
	mov r4, #1
	cmp r4, #15
	bge .LB351
	b .LB352
.LB351:
	cmp r10, #0
	blt .LB354
	b .LB355
.LB354:
	mov32 , r6, 65535
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB356
.LB356:
@ phi to mov
	mov r6, r10
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r7
	b .LB353
.LB355:
	mov r6, #0
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB356
.LB353:
	ldr r0, [sp, #104]	@ ldr-all2mem 1
	str r0, [sp, #140]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #152]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #108]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #116]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #124]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #128]	@ str-all2mem 1
	ldr r0, [sp, #64]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #136]	@ str-all2mem 1
	ldr r0, [sp, #60]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
@ phi to mov
	mov r10, r6
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r7
	b .LB182
.LB352:
	cmp r4, #0
	bgt .LB357
	b .LB358
.LB357:
	movw r6, #32767
	cmp r10, r6
	bgt .LB360
	b .LB361
.LB360:
	mov r6, #1
	sdiv r6, r10, r6
	mov r10, r6
	add r6, r10, #65536
	sub r6, r6, #1
	b .LB362
.LB362:
@ phi to mov
	mov r7, r10
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB359
.LB361:
	mov r6, #1
	sdiv r6, r10, r6
	b .LB362
.LB359:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB353
.LB358:
	mov r6, r10
@ phi to mov
	mov r7, r10
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB359
.LB184:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r6, r0
	mov r0, r6
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	mov r6, #2
@ phi to mov
	mov r7, r6
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r5, r11
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r4
	b .LB363
.LB363:
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB364
	b .LB365
.LB364:
	mov r10, #2
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	mov r6, r7
	mov r4, #1
	ldr r0, [sp, #164]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #172]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #176]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r0, [sp, #180]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r0, [sp, #184]	@ ldr-all2mem 1
	str r0, [sp, #152]	@ str-all2mem 1
	ldr r0, [sp, #188]	@ ldr-all2mem 1
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #192]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r0, [sp, #196]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #200]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r0, [sp, #204]	@ ldr-all2mem 1
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #212]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #216]	@ ldr-all2mem 1
	str r0, [sp, #72]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #140]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #208]	@ str-all2mem 1
@ phi to mov
	mov r10, r5
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB366
.LB366:
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB367
	b .LB368
.LB367:
	mov r11, #0
	mov r10, #0
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	mov r4, r0
	mov r6, #1
@ phi to mov
	mov r5, r6
	b .LB369
.LB369:
	cmp r10, #16
	blt .LB370
	b .LB371
.LB370:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r4, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r4, r6
	cmp r6, #0
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB373
	b .LB374
.LB373:
	mov r6, #2
	sdiv r6, r4, r6
	mov r4, #2
	sdiv r4, r5, r4
	mov r5, r4
	add r4, r10, #1
	mov r11, r4
@ phi to mov
	mov r4, r6
@ phi to mov
	mov r10, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB369
.LB374:
	mov r11, #2
	sdiv r6, r5, r11
	mul r6, r6, r11
	sub r6, r5, r6
	cmp r6, #0
	bne .LB372
	b .LB373
.LB372:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB373
.LB371:
	cmp r11, #0
	bne .LB375
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #184]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r7
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #192]	@ str-all2mem 1
	ldr r0, [sp, #160]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #144]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r7
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	str r0, [sp, #196]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	str r0, [sp, #200]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #68]	@ str-all2mem 1
@ phi to mov
	mov r6, r10
	b .LB376
.LB375:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r6, r0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	mov r11, r0
	mov r5, #0
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r7
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #160]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r5, r11
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r6, r10
	b .LB377
.LB377:
	cmp r5, #0
	bne .LB378
	b .LB379
.LB378:
	mov r4, #0
	mov r6, #0
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
	mov r10, #1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
	b .LB380
.LB380:
	cmp r6, #16
	blt .LB381
	b .LB382
.LB381:
	mov r0, #2
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r4, r7, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r4, r4, r0
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB384
	b .LB385
.LB384:
	mov r4, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
	mov r4, #2
	sdiv r4, r10, r4
	add r6, r6, #1
@ phi to mov
	mov r10, r4
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r9
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
	b .LB380
.LB385:
	mov r4, #2
	sdiv r9, r10, r4
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mul r4, r9, r4
	sub r4, r10, r4
	cmp r4, #0
	bne .LB383
	b .LB384
.LB383:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB384
.LB382:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	cmp r9, #0
	bne .LB386
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r7
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #228]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB387
.LB386:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	mov r4, #0
@ phi to mov
	mov r10, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	b .LB388
.LB388:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB389
	b .LB390
.LB389:
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r10, #0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r4, r9
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r6, r7
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB391
.LB391:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB392
	b .LB393
.LB392:
	mov r10, #2
	sdiv r6, r4, r10
	mul r6, r6, r10
	sub r6, r4, r6
	cmp r6, #0
	bne .LB394
	b .LB395
.LB394:
	mov r6, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r10, r7, r6
	mul r6, r10, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	beq .LB397
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB398
.LB397:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r6, r0, #1
	b .LB398
.LB398:
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB396
.LB396:
	mov r6, #2
	sdiv r6, r4, r6
	mov r10, r6
	mov r6, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r4, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r4, r10
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB391
.LB395:
	mov r6, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r10, r7, r6
	mul r6, r10, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB399
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB400
.LB399:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r6, r0, #1
	b .LB400
.LB400:
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB396
.LB393:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r10, r0
	mov r6, #0
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r4, r9
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	b .LB401
.LB401:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB402
	b .LB403
.LB402:
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r9, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r6, r6, r0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r6, r9, r6
	cmp r6, #0
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB405
	b .LB406
.LB405:
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r6
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r4, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB401
.LB406:
	mov r4, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r4
	mul r6, r6, r4
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB404
	b .LB405
.LB404:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB405
.LB403:
	mov r6, #1
	cmp r6, #15
	bgt .LB407
	b .LB408
.LB407:
	mov r4, #0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB409
.LB409:
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	mov r4, r10
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	b .LB388
.LB408:
	mov r9, #0
	str r9, [sp, #112]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r6, #2
	mul r6, r4, r6
	mov32 , r4, 65535
@ phi to mov
	mov r7, r4
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r9
	b .LB410
.LB410:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB411
	b .LB412
.LB411:
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r0, r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r6, r0, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	beq .LB414
	b .LB415
.LB414:
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r4, r6
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r0, r7, #1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB410
.LB415:
	mov r4, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r4
	mul r6, r6, r4
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB413
	b .LB414
.LB413:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB414
.LB412:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB409
.LB390:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mov r6, r9
@ phi to mov
	mov r0, r10
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r7
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #148]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #228]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB387
.LB387:
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	mov r4, r11
	mov r6, #0
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r6, r4
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB416
.LB416:
	cmp r6, #0
	bne .LB417
	b .LB418
.LB417:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r4, #0
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r11, r6
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB419
.LB419:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB420
	b .LB421
.LB420:
	mov r11, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r4, r7, r11
	mul r4, r4, r11
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r4, r7, r4
	cmp r4, #0
	bne .LB422
	b .LB423
.LB422:
	mov r4, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r11, r0, r4
	mul r4, r11, r4
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	beq .LB425
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB426
.LB425:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
	b .LB426
.LB426:
@ phi to mov
	mov r11, r4
	b .LB424
.LB424:
	mov r4, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r4, r7, r4
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	mov r4, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r0, r4
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r4, r7, #1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB419
.LB423:
	mov r11, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r4, r0, r11
	mul r4, r4, r11
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r4, r0, r4
	cmp r4, #0
	bne .LB427
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	b .LB428
.LB427:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
	b .LB428
.LB428:
@ phi to mov
	mov r11, r4
	b .LB424
.LB421:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r7, #0
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r4, r0
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r7
	b .LB429
.LB429:
	cmp r4, #16
	blt .LB430
	b .LB431
.LB430:
	mov r7, #2
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r0, r7
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mul r6, r6, r7
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
	beq .LB433
	b .LB434
.LB433:
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #2
	sdiv r6, r11, r6
	mov r11, r6
	add r6, r4, #1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r4, r6
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB429
.LB434:
	mov r0, #2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r11, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mul r6, r6, r0
	sub r6, r11, r6
	cmp r6, #0
	bne .LB432
	b .LB433
.LB432:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	b .LB433
.LB431:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r11, r0
	mov r6, #1
	cmp r6, #15
	bgt .LB435
	b .LB436
.LB435:
	mov r6, #0
@ phi to mov
	mov r0, r4
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB437
.LB437:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r4, r7
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
@ phi to mov
	mov r0, r4
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB416
.LB436:
	mov r0, #0
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #0
	mov r4, #2
	mul r4, r11, r4
	mov r11, r4
	mov32 , r4, 65535
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB438
.LB438:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB439
	b .LB440
.LB439:
	mov r4, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r4
	mul r6, r6, r4
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
	beq .LB442
	b .LB443
.LB442:
	mov r6, #2
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r11, r6
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r6, r9, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r4, r0, #1
@ phi to mov
	mov r9, r6
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB438
.LB443:
	mov r6, #2
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r4, r9, r6
	mul r6, r4, r6
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sub r6, r9, r6
	cmp r6, #0
	bne .LB441
	b .LB442
.LB441:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB442
.LB440:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r6, r11
	b .LB437
.LB418:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r4, r0
	mov r7, r4
	str r7, [sp, #120]	@ str-all2mem 1
	mov r4, #1
	cmp r4, #15
	bge .LB444
	b .LB445
.LB444:
	cmp r5, #0
	blt .LB447
	b .LB448
.LB447:
	mov32 , r4, 65535
	b .LB449
.LB449:
	b .LB446
.LB448:
	mov r4, #0
	b .LB449
.LB446:
	mov r5, r4
@ phi to mov
	mov r0, r11
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r9, r6
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB377
.LB445:
	cmp r4, #0
	bgt .LB450
	b .LB451
.LB450:
	movw r4, #32767
	cmp r5, r4
	bgt .LB453
	b .LB454
.LB453:
	mov r4, #1
	sdiv r4, r5, r4
	add r4, r4, #65536
	sub r4, r4, #1
	b .LB455
.LB455:
	b .LB452
.LB454:
	mov r4, #1
	sdiv r4, r5, r4
	b .LB455
.LB452:
	b .LB446
.LB451:
	mov r4, r5
	b .LB452
.LB379:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r10, r7
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	str r0, [sp, #184]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #192]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #144]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #72]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #196]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #200]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #68]	@ str-all2mem 1
	b .LB376
.LB376:
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	mov r5, #0
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #220]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #232]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
@ phi to mov
	mov r0, r5
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r11, r6
	b .LB456
.LB456:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB457
	b .LB458
.LB457:
	mov r5, #0
	mov r6, #0
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r0, r7
	str r0, [sp, #24]	@ str-all2mem 1
	mov r11, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB459
.LB459:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB460
	b .LB461
.LB460:
	mov r6, #2
	sdiv r5, r11, r6
	mul r6, r5, r6
	sub r6, r11, r6
	cmp r6, #0
	beq .LB463
	b .LB464
.LB463:
	mov r6, #2
	sdiv r6, r11, r6
	mov r11, r6
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r5, r0, #1
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB459
.LB464:
	mov r5, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r5
	mul r6, r6, r5
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB462
	b .LB463
.LB462:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB463
.LB461:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB465
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	b .LB466
.LB465:
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	mov r6, r0
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	mov r11, r0
	mov r10, #0
@ phi to mov
	mov r5, r10
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB467
.LB467:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB468
	b .LB469
.LB468:
	mov r10, #0
	mov r5, #0
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB470
.LB470:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB471
	b .LB472
.LB471:
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r11, r7, r6
	mul r6, r11, r6
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r6, r7, r6
	cmp r6, #0
	bne .LB473
	b .LB474
.LB473:
	mov r11, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r11
	mul r6, r6, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB476
@ phi to mov
	mov r6, r10
	b .LB477
.LB476:
	add r6, r10, #1
	b .LB477
.LB477:
@ phi to mov
	mov r5, r6
	b .LB475
.LB475:
	mov r6, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r6, r7, r6
	mov r10, r6
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r10, r5
	b .LB470
.LB474:
	mov r11, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r11
	mul r6, r6, r11
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB478
@ phi to mov
	mov r6, r10
	b .LB479
.LB478:
	add r6, r10, #1
	b .LB479
.LB479:
@ phi to mov
	mov r5, r6
	b .LB475
.LB472:
	mov r7, r10
	str r7, [sp, #100]	@ str-all2mem 1
	mov r10, #0
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r5, r11
@ phi to mov
	mov r11, r10
	b .LB480
.LB480:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB481
	b .LB482
.LB481:
	mov r10, #2
	sdiv r6, r5, r10
	mul r6, r6, r10
	sub r6, r5, r6
	cmp r6, #0
@ phi to mov
	mov r10, r11
	beq .LB484
	b .LB485
.LB484:
	mov r6, #2
	sdiv r6, r5, r6
	mov r5, r6
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r10
	b .LB480
.LB485:
	mov r11, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r11
	mul r6, r6, r11
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB483
	b .LB484
.LB483:
	add r6, r10, #1
@ phi to mov
	mov r10, r6
	b .LB484
.LB482:
	mov r6, #1
	cmp r6, #15
	bgt .LB486
	b .LB487
.LB486:
	mov r6, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB488
.LB488:
	mov r10, r6
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r6, r7
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r7
@ phi to mov
	mov r0, r10
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r6, r11
	b .LB467
.LB487:
	mov r6, #0
	mov r10, #0
	mov r5, #2
	mul r11, r11, r5
	mov32 , r5, 65535
@ phi to mov
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB489
.LB489:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB490
	b .LB491
.LB490:
	mov r5, #2
	sdiv r6, r11, r5
	mul r6, r6, r5
	sub r6, r11, r6
	cmp r6, #0
	beq .LB493
	b .LB494
.LB493:
	mov r6, #2
	sdiv r6, r11, r6
	mov r5, r6
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r11, r5
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB489
.LB494:
	mov r5, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r5
	mul r6, r6, r5
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB492
	b .LB493
.LB492:
	add r6, r10, #1
@ phi to mov
	mov r10, r6
	b .LB493
.LB491:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
@ phi to mov
	mov r6, r10
	b .LB488
.LB469:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r11, r0
@ phi to mov
	mov r0, r5
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #228]	@ str-all2mem 1
@ phi to mov
	mov r10, r6
	b .LB466
.LB466:
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	mov r5, r0
	mov r6, #0
@ phi to mov
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r11, r10
	b .LB495
.LB495:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB496
	b .LB497
.LB496:
	mov r10, #0
	mov r5, #0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r11, r7
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r11, r10
	b .LB498
.LB498:
	cmp r5, #16
	blt .LB499
	b .LB500
.LB499:
	mov r10, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r10
	mul r6, r6, r10
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB501
	b .LB502
.LB501:
	mov r10, #2
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	sdiv r6, r0, r10
	mul r6, r6, r10
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB504
@ phi to mov
	mov r6, r11
	b .LB505
.LB504:
	add r6, r11, #1
	b .LB505
.LB505:
@ phi to mov
	mov r0, r6
	str r0, [sp, #168]	@ str-all2mem 1
	b .LB503
.LB503:
	mov r6, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	mov r6, #2
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r10, r6
	add r6, r5, #1
@ phi to mov
	mov r0, r10
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r5, r6
	ldr r0, [sp, #168]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB498
.LB502:
	mov r6, #2
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	sdiv r10, r0, r6
	mul r6, r10, r6
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB506
@ phi to mov
	mov r6, r11
	b .LB507
.LB506:
	add r6, r11, #1
	b .LB507
.LB507:
@ phi to mov
	mov r0, r6
	str r0, [sp, #168]	@ str-all2mem 1
	b .LB503
.LB500:
	mov r0, r11
	str r0, [sp, #168]	@ str-all2mem 1
	mov r11, #0
	mov r5, #0
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r10, r7
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r6, r11
	b .LB508
.LB508:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB509
	b .LB510
.LB509:
	mov r5, #2
	sdiv r11, r10, r5
	mul r11, r11, r5
	sub r11, r10, r11
	cmp r11, #0
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	beq .LB512
	b .LB513
.LB512:
	mov r6, #2
	sdiv r6, r10, r6
	mov r11, r6
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r10, r0, #1
	mov r5, r10
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
@ phi to mov
	mov r0, r5
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r7
	b .LB508
.LB513:
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r11, r0, r6
	mul r6, r11, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	bne .LB511
	b .LB512
.LB511:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB512
.LB510:
	mov r5, r6
	mov r6, #1
	cmp r6, #15
	bgt .LB514
	b .LB515
.LB514:
	mov r6, #0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB516
.LB516:
	mov r10, r6
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r11, r0
	ldr r0, [sp, #168]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
@ phi to mov
	mov r0, r10
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r11, r5
	b .LB495
.LB515:
	mov r10, #0
	mov r11, #0
	mov r6, #2
	mul r6, r5, r6
	mov32 , r5, 65535
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB517
.LB517:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB518
	b .LB519
.LB518:
	mov r11, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r11
	mul r6, r6, r11
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
@ phi to mov
	mov r7, r10
	str r7, [sp, #100]	@ str-all2mem 1
	beq .LB521
	b .LB522
.LB521:
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r11, r6
	mov r6, #2
	sdiv r6, r5, r6
	mov r10, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r6, r0, #1
@ phi to mov
	mov r5, r10
@ phi to mov
	mov r0, r11
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r7
	b .LB517
.LB522:
	mov r6, #2
	sdiv r11, r5, r6
	mul r6, r11, r6
	sub r6, r5, r6
	cmp r6, #0
	bne .LB520
	b .LB521
.LB520:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB521
.LB519:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
@ phi to mov
	mov r6, r10
	b .LB516
.LB497:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	mov r10, r7
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r5, r7
	mov r10, #1
	cmp r10, #15
	bge .LB523
	b .LB524
.LB523:
	cmp r5, #0
	blt .LB526
	b .LB527
.LB526:
	mov32 , r10, 65535
	b .LB528
.LB528:
	b .LB525
.LB527:
	mov r10, #0
	b .LB528
.LB525:
	mov r5, r10
@ phi to mov
	mov r7, r6
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	str r0, [sp, #16]	@ str-all2mem 1
@ phi to mov
	mov r7, r5
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	b .LB456
.LB524:
	cmp r10, #0
	bgt .LB529
	b .LB530
.LB529:
	movw r10, #32767
	cmp r5, r10
	bgt .LB532
	b .LB533
.LB532:
	mov r10, #1
	sdiv r10, r5, r10
	add r10, r10, #65536
	sub r10, r10, #1
	b .LB534
.LB534:
	b .LB531
.LB533:
	mov r10, #1
	sdiv r10, r5, r10
	b .LB534
.LB531:
	b .LB525
.LB530:
	mov r10, r5
	b .LB531
.LB458:
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	mov r6, r0
	mov r0, r6
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	mov r7, #1
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #15
	bge .LB535
	b .LB536
.LB535:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, #0
	blt .LB538
	b .LB539
.LB538:
	mov32 , r6, 65535
@ phi to mov
	mov r5, r6
	b .LB540
.LB540:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB537
.LB539:
	mov r6, #0
@ phi to mov
	mov r5, r6
	b .LB540
.LB537:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #220]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #232]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	str r0, [sp, #104]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #152]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #184]	@ ldr-all2mem 1
	str r0, [sp, #0]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r9
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r0, [sp, #192]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
	str r0, [sp, #160]	@ str-all2mem 1
	ldr r0, [sp, #144]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #196]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #200]	@ ldr-all2mem 1
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r0, [sp, #68]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #140]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r7
@ phi to mov
	mov r4, r6
	b .LB366
.LB536:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #0
	bgt .LB541
	b .LB542
.LB541:
	movw r6, #32767
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	cmp r0, r6
	bgt .LB544
	b .LB545
.LB544:
	mov r6, #1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	add r5, r6, #65536
	sub r5, r5, #1
	mov r0, r5
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r5, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB546
.LB546:
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB543
.LB545:
	mov r6, #1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB546
.LB543:
@ phi to mov
	mov r6, r5
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	b .LB537
.LB542:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB543
.LB368:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r6, r0
	mov r0, r6
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
	ldr r7, [sp, #76]	@ ldr-all2mem 1
	add r6, r7, #1
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #164]	@ str-all2mem 1
	ldr r0, [sp, #20]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #12]	@ ldr-all2mem 1
	str r0, [sp, #172]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
	str r0, [sp, #176]	@ str-all2mem 1
	ldr r0, [sp, #104]	@ ldr-all2mem 1
	str r0, [sp, #180]	@ str-all2mem 1
	ldr r0, [sp, #152]	@ ldr-all2mem 1
	str r0, [sp, #184]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	str r0, [sp, #188]	@ str-all2mem 1
	ldr r0, [sp, #0]	@ ldr-all2mem 1
	str r0, [sp, #192]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #196]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #200]	@ str-all2mem 1
	ldr r0, [sp, #160]	@ ldr-all2mem 1
	str r0, [sp, #204]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #212]	@ str-all2mem 1
	ldr r0, [sp, #72]	@ ldr-all2mem 1
	str r0, [sp, #216]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r5, r10
@ phi to mov
	mov r0, r4
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB363
.LB365:
	mov r6, #0
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
@ phi to mov
	mov r0, r5
	str r0, [sp, #220]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #168]	@ str-all2mem 1
	b .LB547
.LB547:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB548
	b .LB549
.LB548:
	mov r0, #2
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	mov r6, r7
	mov r9, #1
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #236]	@ ldr-all2mem 1
@ phi to mov
	mov r5, r0
	ldr r0, [sp, #240]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #244]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #248]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #252]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #256]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	ldr r0, [sp, #260]	@ ldr-all2mem 1
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r0, [sp, #264]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r0, [sp, #268]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #272]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	ldr r0, [sp, #276]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	ldr r0, [sp, #280]	@ ldr-all2mem 1
@ phi to mov
	mov r3, r0
	ldr r0, [sp, #284]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	ldr r0, [sp, #288]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #284]	@ str-all2mem 1
@ phi to mov
	mov r0, r6
	str r0, [sp, #248]	@ str-all2mem 1
	ldr r0, [sp, #148]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
@ phi to mov
	mov r0, r8
	str r0, [sp, #232]	@ str-all2mem 1
	ldr r0, [sp, #292]	@ ldr-all2mem 1
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r0, [sp, #296]	@ ldr-all2mem 1
	str r0, [sp, #140]	@ str-all2mem 1
	ldr r0, [sp, #220]	@ ldr-all2mem 1
@ phi to mov
	mov r9, r0
	str r9, [sp, #112]	@ str-all2mem 1
	b .LB550
.LB550:
	ldr r0, [sp, #248]	@ ldr-all2mem 1
	cmp r0, #0
	bgt .LB551
	b .LB552
.LB551:
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r9, #0
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #248]	@ ldr-all2mem 1
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r8, #1
@ phi to mov
	mov r0, r8
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
	b .LB553
.LB553:
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB554
	b .LB555
.LB554:
	mov r9, #2
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	sdiv r0, r7, r9
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	mul r0, r0, r9
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r0, r7, r0
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #0
@ phi to mov
	mov r9, r8
	str r9, [sp, #112]	@ str-all2mem 1
	beq .LB557
	b .LB558
.LB557:
	mov r8, #2
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	sdiv r8, r7, r8
	mov r0, r8
	str r0, [sp, #24]	@ str-all2mem 1
	mov r8, #2
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	sdiv r8, r0, r8
	mov r7, r8
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
	add r8, r0, #1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r8
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r9
	b .LB553
.LB558:
	mov r8, #2
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	sdiv r0, r0, r8
	str r0, [sp, #24]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mul r8, r0, r8
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	sub r8, r0, r8
	cmp r8, #0
	bne .LB556
	b .LB557
.LB556:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	add r8, r9, #1
@ phi to mov
	mov r9, r8
	str r9, [sp, #112]	@ str-all2mem 1
	b .LB557
.LB555:
	cmp r8, #0
	bne .LB559
@ phi to mov
	mov r0, r10
	str r0, [sp, #220]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	str r0, [sp, #272]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #76]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #252]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #20]	@ str-all2mem 1
@ phi to mov
	mov r0, r3
	str r0, [sp, #12]	@ str-all2mem 1
@ phi to mov
	mov r7, r2
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #284]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	b .LB560
.LB559:
	ldr r0, [sp, #284]	@ ldr-all2mem 1
	mov r3, r0
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r10
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
@ phi to mov
	mov r0, r4
	str r0, [sp, #208]	@ str-all2mem 1
@ phi to mov
	mov r4, r11
@ phi to mov
	mov r11, r1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r0, r3
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	b .LB561
.LB561:
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB562
	b .LB563
.LB562:
	mov r8, #0
	mov r3, #0
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r2, r0
	mov r1, #1
@ phi to mov
	mov r10, r1
@ phi to mov
	mov r7, r3
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r1, r8
	b .LB564
.LB564:
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	cmp r7, #16
	blt .LB565
	b .LB566
.LB565:
	mov r8, #2
	sdiv r3, r2, r8
	mul r3, r3, r8
	sub r3, r2, r3
	cmp r3, #0
@ phi to mov
	mov r8, r1
	beq .LB568
	b .LB569
.LB568:
	mov r3, #2
	sdiv r3, r2, r3
	mov r2, r3
	mov r3, #2
	sdiv r3, r10, r3
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	add r1, r7, #1
@ phi to mov
	mov r10, r3
@ phi to mov
	mov r7, r1
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r1, r8
	b .LB564
.LB569:
	mov r3, #2
	sdiv r1, r10, r3
	mul r3, r1, r3
	sub r3, r10, r3
	cmp r3, #0
	bne .LB567
	b .LB568
.LB567:
	add r3, r8, #1
@ phi to mov
	mov r8, r3
	b .LB568
.LB566:
	cmp r1, #0
	bne .LB570
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
	ldr r0, [sp, #228]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r7
	b .LB571
.LB570:
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	mov r2, r0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r1, r0
	mov r3, #0
@ phi to mov
	mov r8, r3
@ phi to mov
	mov r4, r1
@ phi to mov
	mov r11, r2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r3, r7
	b .LB572
.LB572:
	cmp r4, #0
	bne .LB573
	b .LB574
.LB573:
	mov r1, #0
	mov r10, #0
	mov r3, r11
	mov r2, r4
@ phi to mov
	mov r8, r2
@ phi to mov
	mov r0, r3
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r2, r1
	b .LB575
.LB575:
	cmp r10, #16
	blt .LB576
	b .LB577
.LB576:
	mov r1, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r3, r0, r1
	mul r3, r3, r1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sub r3, r0, r3
	cmp r3, #0
	bne .LB578
	b .LB579
.LB578:
	mov r3, #2
	sdiv r1, r8, r3
	mul r3, r1, r3
	sub r3, r8, r3
	cmp r3, #0
	beq .LB581
@ phi to mov
	mov r3, r2
	b .LB582
.LB581:
	add r3, r2, #1
	b .LB582
.LB582:
@ phi to mov
	mov r1, r3
	b .LB580
.LB580:
	mov r3, #2
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r3, r0, r3
	mov r2, r3
	mov r3, #2
	sdiv r3, r8, r3
	mov r8, r3
	add r3, r10, #1
@ phi to mov
	mov r0, r2
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r10, r3
@ phi to mov
	mov r2, r1
	b .LB575
.LB579:
	mov r1, #2
	sdiv r3, r8, r1
	mul r3, r3, r1
	sub r3, r8, r3
	cmp r3, #0
	bne .LB583
@ phi to mov
	mov r3, r2
	b .LB584
.LB583:
	add r3, r2, #1
	b .LB584
.LB584:
@ phi to mov
	mov r1, r3
	b .LB580
.LB577:
	mov r0, r2
	str r0, [sp, #24]	@ str-all2mem 1
	mov r8, #0
	mov r1, #0
	mov r3, r11
	mov r2, r4
@ phi to mov
	mov r4, r2
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r10, r1
@ phi to mov
	mov r2, r8
	b .LB585
.LB585:
	cmp r10, #16
	blt .LB586
	b .LB587
.LB586:
	mov r3, #2
	sdiv r1, r11, r3
	mul r3, r1, r3
	sub r3, r11, r3
	cmp r3, #0
@ phi to mov
	mov r8, r2
	beq .LB589
	b .LB590
.LB589:
	mov r3, #2
	sdiv r3, r11, r3
	mov r1, #2
	sdiv r1, r4, r1
	mov r2, r1
	add r1, r10, #1
@ phi to mov
	mov r4, r2
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r10, r1
@ phi to mov
	mov r2, r8
	b .LB585
.LB590:
	mov r3, #2
	sdiv r1, r4, r3
	mul r3, r1, r3
	sub r3, r4, r3
	cmp r3, #0
	bne .LB588
	b .LB589
.LB588:
	add r3, r8, #1
@ phi to mov
	mov r8, r3
	b .LB589
.LB587:
	mov r3, #1
	cmp r3, #15
	bgt .LB591
	b .LB592
.LB591:
	mov r3, #0
@ phi to mov
	mov r2, r10
	b .LB593
.LB593:
	mov r1, r3
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	mov r3, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
@ phi to mov
	mov r4, r1
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r3, r2
	b .LB572
.LB592:
	mov r4, #0
	mov r3, #0
	mov r1, #2
	mul r1, r2, r1
	mov r2, r1
	mov32 , r1, 65535
@ phi to mov
	mov r8, r1
@ phi to mov
	mov r11, r2
@ phi to mov
	mov r10, r3
	b .LB594
.LB594:
	cmp r10, #16
	blt .LB595
	b .LB596
.LB595:
	mov r3, #2
	sdiv r1, r11, r3
	mul r3, r1, r3
	sub r3, r11, r3
	cmp r3, #0
@ phi to mov
	mov r2, r4
	beq .LB598
	b .LB599
.LB598:
	mov r3, #2
	sdiv r3, r11, r3
	mov r1, r3
	mov r3, #2
	sdiv r3, r8, r3
	mov r8, r3
	add r3, r10, #1
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r10, r3
@ phi to mov
	mov r4, r2
	b .LB594
.LB599:
	mov r3, #2
	sdiv r1, r8, r3
	mul r3, r1, r3
	sub r3, r8, r3
	cmp r3, #0
	bne .LB597
	b .LB598
.LB597:
	add r3, r2, #1
@ phi to mov
	mov r2, r3
	b .LB598
.LB596:
@ phi to mov
	mov r2, r10
@ phi to mov
	mov r3, r4
	b .LB593
.LB574:
	mov r1, r11
@ phi to mov
	mov r0, r8
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r9, r4
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r10, r11
@ phi to mov
	mov r7, r1
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r1, r3
	b .LB571
.LB571:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r2, r0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r8, r0
	mov r3, #0
@ phi to mov
	mov r4, r3
@ phi to mov
	mov r0, r8
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r0, r2
	str r0, [sp, #208]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #284]	@ str-all2mem 1
	b .LB600
.LB600:
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	cmp r0, #0
	bne .LB601
	b .LB602
.LB601:
	mov r4, #0
	mov r1, #0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	mov r2, r0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r3, r0
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r8, r2
@ phi to mov
	mov r2, r1
	b .LB603
.LB603:
	cmp r2, #16
	blt .LB604
	b .LB605
.LB604:
	mov r1, #2
	sdiv r3, r8, r1
	mul r3, r3, r1
	sub r3, r8, r3
	cmp r3, #0
	bne .LB606
	b .LB607
.LB606:
	mov r3, #2
	sdiv r1, r11, r3
	mul r3, r1, r3
	sub r3, r11, r3
	cmp r3, #0
	beq .LB609
@ phi to mov
	mov r3, r4
	b .LB610
.LB609:
	add r3, r4, #1
	b .LB610
.LB610:
@ phi to mov
	mov r4, r3
	b .LB608
.LB608:
	mov r3, #2
	sdiv r3, r8, r3
	mov r1, r3
	mov r3, #2
	sdiv r3, r11, r3
	add r2, r2, #1
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r8, r1
	b .LB603
.LB607:
	mov r1, #2
	sdiv r3, r11, r1
	mul r3, r3, r1
	sub r3, r11, r3
	cmp r3, #0
	bne .LB611
@ phi to mov
	mov r3, r4
	b .LB612
.LB611:
	add r3, r4, #1
	b .LB612
.LB612:
@ phi to mov
	mov r4, r3
	b .LB608
.LB605:
	mov r11, r4
	mov r1, #0
	mov r2, #0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	mov r8, r0
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	mov r3, r0
@ phi to mov
	mov r4, r3
@ phi to mov
	mov r7, r8
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r8, r2
	b .LB613
.LB613:
	cmp r8, #16
	blt .LB614
	b .LB615
.LB614:
	mov r3, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r2, r7, r3
	mul r3, r2, r3
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r3, r7, r3
	cmp r3, #0
@ phi to mov
	mov r3, r1
	beq .LB617
	b .LB618
.LB617:
	mov r1, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r1, r7, r1
	mov r7, r1
	str r7, [sp, #120]	@ str-all2mem 1
	mov r1, #2
	sdiv r1, r4, r1
	add r2, r8, #1
@ phi to mov
	mov r4, r1
@ phi to mov
	mov r8, r2
@ phi to mov
	mov r1, r3
	b .LB613
.LB618:
	mov r2, #2
	sdiv r1, r4, r2
	mul r1, r1, r2
	sub r1, r4, r1
	cmp r1, #0
	bne .LB616
	b .LB617
.LB616:
	add r3, r3, #1
	b .LB617
.LB615:
	mov r2, r1
	mov r3, #1
	cmp r3, #15
	bgt .LB619
	b .LB620
.LB619:
	mov r3, #0
@ phi to mov
	mov r2, r8
	b .LB621
.LB621:
	mov r1, r11
@ phi to mov
	mov r4, r11
@ phi to mov
	mov r0, r3
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #208]	@ str-all2mem 1
@ phi to mov
	mov r0, r2
	str r0, [sp, #284]	@ str-all2mem 1
	b .LB600
.LB620:
	mov r8, #0
	mov r3, #0
	mov r1, #2
	mul r1, r2, r1
	mov r4, r1
	mov32 , r1, 65535
@ phi to mov
	mov r2, r1
@ phi to mov
	mov r7, r4
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r4, r3
	b .LB622
.LB622:
	cmp r4, #16
	blt .LB623
	b .LB624
.LB623:
	mov r3, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r1, r7, r3
	mul r3, r1, r3
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sub r3, r7, r3
	cmp r3, #0
	beq .LB626
	b .LB627
.LB626:
	mov r3, #2
	ldr r7, [sp, #120]	@ ldr-all2mem 1
	sdiv r3, r7, r3
	mov r1, r3
	mov r3, #2
	sdiv r3, r2, r3
	add r2, r4, #1
	mov r4, r2
@ phi to mov
	mov r2, r3
@ phi to mov
	mov r7, r1
	str r7, [sp, #120]	@ str-all2mem 1
	b .LB622
.LB627:
	mov r1, #2
	sdiv r3, r2, r1
	mul r3, r3, r1
	sub r3, r2, r3
	cmp r3, #0
	bne .LB625
	b .LB626
.LB625:
	add r3, r8, #1
@ phi to mov
	mov r8, r3
	b .LB626
.LB624:
@ phi to mov
	mov r2, r4
@ phi to mov
	mov r3, r8
	b .LB621
.LB602:
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	mov r3, r0
	mov r1, r3
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	mov r2, r0
	mov r3, #1
	cmp r3, #15
	bge .LB628
	b .LB629
.LB628:
	cmp r2, #0
	blt .LB631
	b .LB632
.LB631:
	mov32 , r3, 65535
	b .LB633
.LB633:
	b .LB630
.LB632:
	mov r3, #0
	b .LB633
.LB630:
@ phi to mov
	mov r7, r4
	str r7, [sp, #120]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	ldr r0, [sp, #208]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r9
@ phi to mov
	mov r11, r10
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #228]	@ str-all2mem 1
@ phi to mov
	mov r0, r3
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #284]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	b .LB561
.LB629:
	cmp r3, #0
	bgt .LB634
	b .LB635
.LB634:
	movw r3, #32767
	cmp r2, r3
	bgt .LB637
	b .LB638
.LB637:
	mov r3, #1
	sdiv r3, r2, r3
	add r3, r3, #65536
	sub r3, r3, #1
	b .LB639
.LB639:
	b .LB636
.LB638:
	mov r3, #1
	sdiv r3, r2, r3
	b .LB639
.LB636:
	b .LB630
.LB635:
	mov r3, r2
	b .LB636
.LB563:
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	mov r3, r0
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #220]	@ str-all2mem 1
@ phi to mov
	mov r0, r2
	str r0, [sp, #272]	@ str-all2mem 1
@ phi to mov
	mov r7, r8
	str r7, [sp, #76]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #28]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #252]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #20]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	str r0, [sp, #12]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #4]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	str r0, [sp, #156]	@ str-all2mem 1
@ phi to mov
	mov r7, r3
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r2, r1
	b .LB560
.LB560:
	mov r3, r6
	mov r8, #0
	ldr r0, [sp, #300]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
@ phi to mov
	mov r10, r8
@ phi to mov
	mov r4, r6
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
@ phi to mov
	mov r8, r2
	b .LB640
.LB640:
	cmp r4, #0
	bne .LB641
	b .LB642
.LB641:
	mov r7, #0
	str r7, [sp, #100]	@ str-all2mem 1
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r6, r4
	mov r2, #1
@ phi to mov
	mov r8, r2
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB643
.LB643:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #16
	blt .LB644
	b .LB645
.LB644:
	mov r2, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r2
	mul r6, r6, r2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r6, r0, r6
	cmp r6, #0
	beq .LB647
	b .LB648
.LB647:
	mov r6, #2
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sdiv r6, r0, r6
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	mov r6, #2
	sdiv r6, r8, r6
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	add r2, r0, #1
@ phi to mov
	mov r8, r6
@ phi to mov
	mov r0, r2
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB643
.LB648:
	mov r2, #2
	sdiv r6, r8, r2
	mul r6, r6, r2
	sub r6, r8, r6
	cmp r6, #0
	bne .LB646
	b .LB647
.LB646:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r7, r6
	str r7, [sp, #100]	@ str-all2mem 1
	b .LB647
.LB645:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
	cmp r7, #0
	bne .LB649
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r9, r10
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	b .LB650
.LB649:
	mov r8, r10
	mov r1, r3
	mov r6, #0
@ phi to mov
	mov r2, r6
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r0, r8
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	b .LB651
.LB651:
	cmp r11, #0
	bne .LB652
	b .LB653
.LB652:
	mov r6, #0
	mov r10, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r1, r0
	mov r2, r11
@ phi to mov
	mov r8, r2
@ phi to mov
	mov r2, r1
@ phi to mov
	mov r5, r6
	b .LB654
.LB654:
	cmp r10, #16
	blt .LB655
	b .LB656
.LB655:
	mov r1, #2
	sdiv r6, r2, r1
	mul r6, r6, r1
	sub r6, r2, r6
	cmp r6, #0
	bne .LB657
	b .LB658
.LB657:
	mov r1, #2
	sdiv r6, r8, r1
	mul r6, r6, r1
	sub r6, r8, r6
	cmp r6, #0
	beq .LB660
@ phi to mov
	mov r6, r5
	b .LB661
.LB660:
	add r6, r5, #1
	b .LB661
.LB661:
	b .LB659
.LB659:
	mov r1, #2
	sdiv r1, r2, r1
	mov r2, r1
	mov r1, #2
	sdiv r1, r8, r1
	mov r8, r1
	add r1, r10, #1
@ phi to mov
	mov r10, r1
@ phi to mov
	mov r5, r6
	b .LB654
.LB658:
	mov r6, #2
	sdiv r1, r8, r6
	mul r6, r1, r6
	sub r6, r8, r6
	cmp r6, #0
	bne .LB662
@ phi to mov
	mov r6, r5
	b .LB663
.LB662:
	add r6, r5, #1
	b .LB663
.LB663:
	b .LB659
.LB656:
	mov r10, #0
	mov r8, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r2, r0
	mov r6, r11
@ phi to mov
	mov r1, r6
@ phi to mov
	mov r11, r8
@ phi to mov
	mov r8, r10
	b .LB664
.LB664:
	cmp r11, #16
	blt .LB665
	b .LB666
.LB665:
	mov r10, #2
	sdiv r6, r2, r10
	mul r6, r6, r10
	sub r6, r2, r6
	cmp r6, #0
	beq .LB668
	b .LB669
.LB668:
	mov r6, #2
	sdiv r6, r2, r6
	mov r2, #2
	sdiv r1, r1, r2
	add r2, r11, #1
	mov r11, r2
@ phi to mov
	mov r2, r6
	b .LB664
.LB669:
	mov r6, #2
	sdiv r10, r1, r6
	mul r6, r10, r6
	sub r6, r1, r6
	cmp r6, #0
	bne .LB667
	b .LB668
.LB667:
	add r6, r8, #1
@ phi to mov
	mov r8, r6
	b .LB668
.LB666:
	mov r6, r8
	mov r1, #1
	cmp r1, #15
	bgt .LB670
	b .LB671
.LB670:
	mov r1, #0
@ phi to mov
	mov r6, r11
	b .LB672
.LB672:
	mov r8, r5
@ phi to mov
	mov r2, r5
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r0, r8
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r1, r6
	b .LB651
.LB671:
	mov r8, #0
	mov r1, #0
	mov r2, #2
	mul r6, r6, r2
	mov r2, r6
	mov32 , r6, 65535
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r10, r1
@ phi to mov
	mov r1, r8
	b .LB673
.LB673:
	cmp r10, #16
	blt .LB674
	b .LB675
.LB674:
	mov r6, #2
	sdiv r8, r2, r6
	mul r6, r8, r6
	sub r6, r2, r6
	cmp r6, #0
@ phi to mov
	mov r8, r1
	beq .LB677
	b .LB678
.LB677:
	mov r6, #2
	sdiv r6, r2, r6
	mov r2, r6
	mov r6, #2
	sdiv r6, r11, r6
	mov r1, r6
	add r6, r10, #1
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r10, r6
@ phi to mov
	mov r1, r8
	b .LB673
.LB678:
	mov r1, #2
	sdiv r6, r11, r1
	mul r6, r6, r1
	sub r6, r11, r6
	cmp r6, #0
	bne .LB676
	b .LB677
.LB676:
	add r6, r8, #1
@ phi to mov
	mov r8, r6
	b .LB677
.LB675:
@ phi to mov
	mov r6, r10
	b .LB672
.LB653:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
@ phi to mov
	mov r5, r2
@ phi to mov
	mov r7, r11
	str r7, [sp, #100]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #224]	@ str-all2mem 1
@ phi to mov
	mov r9, r6
	str r9, [sp, #112]	@ str-all2mem 1
@ phi to mov
	mov r11, r1
	b .LB650
.LB650:
	mov r1, r3
	mov r6, r3
	mov r3, #0
@ phi to mov
	mov r2, r3
@ phi to mov
	mov r8, r6
@ phi to mov
	mov r0, r1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB679
.LB679:
	cmp r8, #0
	bne .LB680
	b .LB681
.LB680:
	mov r6, #0
	mov r2, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r3, r0
	mov r1, r8
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r1, r3
@ phi to mov
	mov r10, r2
@ phi to mov
	mov r3, r6
	b .LB682
.LB682:
	cmp r10, #16
	blt .LB683
	b .LB684
.LB683:
	mov r6, #2
	sdiv r2, r1, r6
	mul r6, r2, r6
	sub r6, r1, r6
	cmp r6, #0
	bne .LB685
	b .LB686
.LB685:
	mov r6, #2
	sdiv r2, r11, r6
	mul r6, r2, r6
	sub r6, r11, r6
	cmp r6, #0
	beq .LB688
@ phi to mov
	mov r6, r3
	b .LB689
.LB688:
	add r6, r3, #1
	b .LB689
.LB689:
	b .LB687
.LB687:
	mov r3, #2
	sdiv r3, r1, r3
	mov r1, r3
	mov r3, #2
	sdiv r3, r11, r3
	mov r2, r3
	add r3, r10, #1
@ phi to mov
	mov r11, r2
@ phi to mov
	mov r10, r3
@ phi to mov
	mov r3, r6
	b .LB682
.LB686:
	mov r2, #2
	sdiv r6, r11, r2
	mul r6, r6, r2
	sub r6, r11, r6
	cmp r6, #0
	bne .LB690
@ phi to mov
	mov r6, r3
	b .LB691
.LB690:
	add r6, r3, #1
	b .LB691
.LB691:
	b .LB687
.LB684:
	mov r10, r3
	mov r0, #0
	str r0, [sp, #24]	@ str-all2mem 1
	mov r1, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r2, r0
	mov r6, r8
@ phi to mov
	mov r3, r6
@ phi to mov
	mov r11, r2
@ phi to mov
	mov r2, r1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	b .LB692
.LB692:
	cmp r2, #16
	blt .LB693
	b .LB694
.LB693:
	mov r8, #2
	sdiv r6, r11, r8
	mul r6, r6, r8
	sub r6, r11, r6
	cmp r6, #0
	beq .LB696
	b .LB697
.LB696:
	mov r6, #2
	sdiv r6, r11, r6
	mov r8, #2
	sdiv r3, r3, r8
	mov r8, r3
	add r3, r2, #1
	mov r2, r3
@ phi to mov
	mov r3, r8
@ phi to mov
	mov r11, r6
	b .LB692
.LB697:
	mov r6, #2
	sdiv r8, r3, r6
	mul r6, r8, r6
	sub r6, r3, r6
	cmp r6, #0
	bne .LB695
	b .LB696
.LB695:
	add r6, r1, #1
@ phi to mov
	mov r1, r6
	b .LB696
.LB694:
	mov r6, #1
	cmp r6, #15
	bgt .LB698
	b .LB699
.LB698:
	mov r6, #0
@ phi to mov
	mov r1, r2
	b .LB700
.LB700:
	mov r3, r6
	mov r6, r10
@ phi to mov
	mov r2, r10
@ phi to mov
	mov r8, r3
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #24]	@ str-all2mem 1
	b .LB679
.LB699:
	mov r6, #0
	mov r3, #0
	mov r2, #2
	mul r1, r1, r2
	mov r2, r1
	mov32 , r1, 65535
@ phi to mov
	mov r11, r1
@ phi to mov
	mov r8, r3
@ phi to mov
	mov r0, r6
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB701
.LB701:
	cmp r8, #16
	blt .LB702
	b .LB703
.LB702:
	mov r3, #2
	sdiv r6, r2, r3
	mul r6, r6, r3
	sub r6, r2, r6
	cmp r6, #0
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	beq .LB705
	b .LB706
.LB705:
	mov r6, #2
	sdiv r6, r2, r6
	mov r2, r6
	mov r6, #2
	sdiv r6, r11, r6
	mov r3, r6
	add r6, r8, #1
@ phi to mov
	mov r11, r3
@ phi to mov
	mov r8, r6
@ phi to mov
	mov r0, r1
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB701
.LB706:
	mov r3, #2
	sdiv r6, r11, r3
	mul r6, r6, r3
	sub r6, r11, r6
	cmp r6, #0
	bne .LB704
	b .LB705
.LB704:
	add r6, r1, #1
@ phi to mov
	mov r1, r6
	b .LB705
.LB703:
@ phi to mov
	mov r1, r8
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r6, r0
	b .LB700
.LB681:
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	mov r6, r0
	mov r0, r6
	str r0, [sp, #168]	@ str-all2mem 1
	mov r3, r4
	mov r6, #1
	cmp r6, #15
	bge .LB707
	b .LB708
.LB707:
	cmp r3, #0
	blt .LB710
	b .LB711
.LB710:
	mov32 , r6, 65535
	b .LB712
.LB712:
	b .LB709
.LB711:
	mov r6, #0
	b .LB712
.LB709:
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r7
	ldr r0, [sp, #224]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r9
@ phi to mov
	mov r4, r6
	ldr r0, [sp, #168]	@ ldr-all2mem 1
@ phi to mov
	mov r3, r0
@ phi to mov
	mov r0, r2
	str r0, [sp, #232]	@ str-all2mem 1
@ phi to mov
	mov r0, r8
	str r0, [sp, #148]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #168]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
	b .LB640
.LB708:
	cmp r6, #0
	bgt .LB713
	b .LB714
.LB713:
	movw r6, #32767
	cmp r3, r6
	bgt .LB716
	b .LB717
.LB716:
	mov r6, #1
	sdiv r6, r3, r6
	add r6, r6, #65536
	sub r6, r6, #1
	b .LB718
.LB718:
	b .LB715
.LB717:
	mov r6, #1
	sdiv r6, r3, r6
	b .LB718
.LB715:
	b .LB709
.LB714:
	mov r6, r3
	b .LB715
.LB642:
	mov r6, r10
	ldr r0, [sp, #248]	@ ldr-all2mem 1
	str r0, [sp, #24]	@ str-all2mem 1
	mov r9, #1
	str r9, [sp, #112]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	cmp r9, #15
	bge .LB719
	b .LB720
.LB719:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, #0
	blt .LB722
	b .LB723
.LB722:
	mov32 , r2, 65535
	b .LB724
.LB724:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #16]	@ str-all2mem 1
	b .LB721
.LB723:
	mov r2, #0
	b .LB724
.LB721:
	mov r0, r2
	str r0, [sp, #248]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #300]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #8]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #24]	@ str-all2mem 1
@ phi to mov
	mov r7, r4
	str r7, [sp, #100]	@ str-all2mem 1
@ phi to mov
	mov r0, r3
	str r0, [sp, #224]	@ str-all2mem 1
	ldr r0, [sp, #220]	@ ldr-all2mem 1
@ phi to mov
	mov r10, r0
	ldr r0, [sp, #272]	@ ldr-all2mem 1
	str r0, [sp, #228]	@ str-all2mem 1
	ldr r7, [sp, #76]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #208]	@ str-all2mem 1
	ldr r0, [sp, #28]	@ ldr-all2mem 1
@ phi to mov
	mov r4, r0
	ldr r0, [sp, #252]	@ ldr-all2mem 1
@ phi to mov
	mov r11, r0
	ldr r0, [sp, #20]	@ ldr-all2mem 1
@ phi to mov
	mov r1, r0
	ldr r0, [sp, #12]	@ ldr-all2mem 1
@ phi to mov
	mov r3, r0
	ldr r7, [sp, #4]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r7
	ldr r7, [sp, #120]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #284]	@ str-all2mem 1
	ldr r0, [sp, #168]	@ ldr-all2mem 1
	str r0, [sp, #140]	@ str-all2mem 1
	ldr r0, [sp, #16]	@ ldr-all2mem 1
@ phi to mov
	mov r7, r0
	str r7, [sp, #120]	@ str-all2mem 1
@ phi to mov
	mov r0, r8
	str r0, [sp, #168]	@ str-all2mem 1
	b .LB550
.LB720:
	ldr r9, [sp, #112]	@ ldr-all2mem 1
	cmp r9, #0
	bgt .LB725
	b .LB726
.LB725:
	movw r2, #32767
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	cmp r0, r2
	bgt .LB728
	b .LB729
.LB728:
	mov r2, #1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r2, r0, r2
	add r0, r2, #65536
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	sub r0, r0, #1
	str r0, [sp, #8]	@ str-all2mem 1
	b .LB730
.LB730:
	b .LB727
.LB729:
	mov r2, #1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	sdiv r2, r0, r2
	mov r0, r2
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	b .LB730
.LB727:
@ phi to mov
	mov r0, r2
	str r0, [sp, #16]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	b .LB721
.LB726:
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #8]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
@ phi to mov
	mov r2, r0
	b .LB727
.LB552:
	ldr r0, [sp, #284]	@ ldr-all2mem 1
	mov r8, r0
	mov r6, #1
	cmp r6, r8
	bne .LB731
	b .LB732
.LB731:
@ this is a ret
	add sp, sp, #304
	mov r0, #1
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB732
.LB732:
	ldr r7, [sp, #132]	@ ldr-all2mem 1
	add r6, r7, #1
@ phi to mov
	mov r0, r5
	str r0, [sp, #236]	@ str-all2mem 1
	ldr r0, [sp, #8]	@ ldr-all2mem 1
	str r0, [sp, #240]	@ str-all2mem 1
	ldr r0, [sp, #24]	@ ldr-all2mem 1
	str r0, [sp, #244]	@ str-all2mem 1
	ldr r7, [sp, #100]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r7
	str r0, [sp, #248]	@ str-all2mem 1
	ldr r0, [sp, #224]	@ ldr-all2mem 1
	str r0, [sp, #252]	@ str-all2mem 1
@ phi to mov
	mov r0, r10
	str r0, [sp, #256]	@ str-all2mem 1
	ldr r0, [sp, #228]	@ ldr-all2mem 1
	str r0, [sp, #260]	@ str-all2mem 1
	ldr r0, [sp, #208]	@ ldr-all2mem 1
	str r0, [sp, #264]	@ str-all2mem 1
@ phi to mov
	mov r0, r4
	str r0, [sp, #268]	@ str-all2mem 1
@ phi to mov
	mov r0, r11
	str r0, [sp, #272]	@ str-all2mem 1
@ phi to mov
	mov r0, r1
	str r0, [sp, #276]	@ str-all2mem 1
@ phi to mov
	mov r0, r3
	str r0, [sp, #280]	@ str-all2mem 1
@ phi to mov
	mov r0, r2
	str r0, [sp, #284]	@ str-all2mem 1
	ldr r0, [sp, #156]	@ ldr-all2mem 1
	str r0, [sp, #288]	@ str-all2mem 1
	ldr r0, [sp, #232]	@ ldr-all2mem 1
@ phi to mov
	mov r8, r0
	ldr r0, [sp, #148]	@ ldr-all2mem 1
	str r0, [sp, #292]	@ str-all2mem 1
	ldr r0, [sp, #140]	@ ldr-all2mem 1
	str r0, [sp, #296]	@ str-all2mem 1
@ phi to mov
	mov r7, r6
	str r7, [sp, #132]	@ str-all2mem 1
	ldr r9, [sp, #112]	@ ldr-all2mem 1
@ phi to mov
	mov r0, r9
	str r0, [sp, #220]	@ str-all2mem 1
	b .LB547
.LB549:
@ this is a ret
	add sp, sp, #304
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #304
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
