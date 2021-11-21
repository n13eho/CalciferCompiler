	.arch armv7ve
	.arm

.macro mov32, cond, reg, val
    movw\cond \reg, #:lower16:\val
    movt\cond \reg, #:upper16:\val
.endm
    
	.data
	.text
@ this is a start of function.
	.global relu_reg
	.type relu_reg, %function
relu_reg:
	.fnstart
	push {r4-r12, lr}
.LB0:
	mov r1, r0
	cmp r1, #127
	bgt .LB1
	b .LB2
.LB1:
@ this is a ret
	mov r0, #127
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB2
.LB2:
	cmp r1, #0
	blt .LB3
	b .LB4
.LB3:
@ this is a ret
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB4
.LB4:
@ this is a ret
	mov r0, r1
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global model
	.type model, %function
model:
	.fnstart
	push {r4-r12, lr}
.LB5:
	mov r4, r0
	mov r5, #0
	mov r0, #0
	add r0, r0, r5
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r5, #85
	mul r0, r0, r5
	mov r6, #1
	mov r5, #0
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #23
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #2
	mov r5, #0
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #3
	mov r5, #0
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #4
	mov r5, #0
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #0
	mov r5, #5
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #6

	add r0, r0, r5
	mov r6, #1
	mov r5, #5
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #2
	mov r5, #5
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #50
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #3
	mov r5, #5
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #4
	mov r5, #5
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #47
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #0
	mov r5, #10
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #1
	mov r5, #10
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #2
	mov r5, #10
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #3
	mov r5, #10
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #4
	mov r5, #10
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #0
	mov r5, #15
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #34
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #1
	mov r5, #15
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #2
	mov r5, #15
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #65
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #3
	mov r5, #15
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #47
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #4
	mov r5, #15
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #113
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #0
	mov r5, #20
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #110
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #1
	mov r5, #20
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #47
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #2
	mov r5, #20
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r6, #3
	mov r5, #20
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #80
	mul r5, r5, r6
	add r0, r0, r5
	mov r6, #4
	mov r5, #20
	add r5, r5, r6
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #46
	mul r5, r5, r6
	add r0, r0, r5

@ jmp
	bl relu_reg
	mov r5, #39
	mul r7, r0, r5
	mov r5, #0
	mov r0, #0
	add r0, r0, r5
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	lsl r0, r0, #0

	mov r5, #1
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #126
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #47
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #2
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #67
	mul r5, r5, r6
	add r5, r0, r5
	mov r0, #3
	mov r6, #5
	add r0, r6, r0
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	lsl r0, r0, #0

	add r0, r5, r0
	mov r5, #4
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #7
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #2
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #105
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #0
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #1
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #87
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #29
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #3
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #1
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #2
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5

@ jmp
	bl relu_reg
	mov r5, #77
	mul r0, r0, r5
	add r7, r7, r0
	mov r5, #0
	mov r0, #0
	add r0, r0, r5
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r5, #26
	mul r0, r0, r5
	mov r5, #1
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #76
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #29
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #4
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #96
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #52
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #34
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #0
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #1
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #102
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #6
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #3
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #27
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #0
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #110
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #116
	mul r5, r5, r6
	add r5, r0, r5
	mov r0, #2
	mov r6, #15
	add r0, r6, r0
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r6, [r0]	@ 
	mov r0, #39
	mul r0, r6, r0
	add r0, r5, r0
	mov r5, #3
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #65
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #120
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #94
	mul r5, r5, r6
	add r0, r0, r5

@ jmp
	bl relu_reg
	mov r5, #127
	mul r0, r0, r5
	add r5, r7, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	lsl r0, r0, #0

	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #49
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #50
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #72
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #85
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #12
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #125
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #125
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #110
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #83
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #122
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #11
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #95
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #118
	mul r6, r6, r7
	add r0, r0, r6

@ jmp
	bl relu_reg
	lsl r0, r0, #0

	add r5, r5, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	lsl r0, r0, #3

	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #82
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #101
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #125
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #75
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #66
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #59
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #12
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #5
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #116
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #15
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #79
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #3
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #49
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6

@ jmp
	bl relu_reg
	lsl r0, r0, #0

	add r7, r5, r0
	mov r5, #0
	mov r0, #0
	add r0, r0, r5
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r5, #81
	mul r0, r0, r5
	mov r5, #1
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #68
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #0
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #121
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #0
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #1
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #55
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #101
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #3
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #5
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #6

	add r0, r0, r5
	mov r5, #1
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #114
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #38
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #3
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #10
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #112
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #0
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #114
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #1
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #112
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #2
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #4
	mov r6, #15
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #0
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #1
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #2
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5
	mov r5, #3
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	mov r6, #82
	mul r5, r5, r6
	add r0, r0, r5
	mov r5, #4
	mov r6, #20
	add r5, r6, r5
	lsl r5, r5, #2
	add r5, r4, r5
	ldr r5, [r5]	@ 
	lsl r5, r5, #0

	add r0, r0, r5

@ jmp
	bl relu_reg
	lsl r0, r0, #5

	add r5, r7, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r6, #15
	mul r0, r0, r6
	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #66
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #81
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #1

	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #59
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #52
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #15
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #55
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #14
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #58
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #67
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #86
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #48
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #66
	mul r6, r6, r7
	add r0, r0, r6

@ jmp
	bl relu_reg
	lsl r0, r0, #0

	add r5, r5, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r6, #33
	mul r0, r0, r6
	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #82
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #67
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #30
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #65
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #120
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #18
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #5
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #104
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #71
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #107
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #24
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #82
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #65
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #97
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #83
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #46
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6

@ jmp
	bl relu_reg
	lsl r0, r0, #0

	add r5, r5, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	lsl r0, r0, #0

	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #7
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #38
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #37
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #36
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #37
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #71
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #53
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #37
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6

@ jmp
	bl relu_reg
	lsl r0, r0, #0

	add r5, r5, r0
	mov r6, #0
	mov r0, #0
	add r0, r0, r6
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	mov r6, #67
	mul r0, r0, r6
	mov r6, #1
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #42
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #41
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #0
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #10
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #75
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #96
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #5
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #0
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #109
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #10
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #67
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #47
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #22
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #2
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #3
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #38
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #4
	mov r7, #15
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #29
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #0
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #115
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #1
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #2
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	mov r7, #36
	mul r6, r6, r7
	add r0, r0, r6
	mov r6, #3
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	lsl r6, r6, #0

	add r0, r0, r6
	mov r6, #4
	mov r7, #20
	add r6, r7, r6
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r4, [r6]	@ 
	mov r6, #85
	mul r4, r4, r6
	add r0, r0, r4

@ jmp
	bl relu_reg
	mov r1, #46
	mul r0, r0, r1
	add r0, r5, r0
	cmp r0, #0
	bgt .LB6
	b .LB7
.LB6:
@ this is a ret
	mov r0, #1
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB7
.LB7:
@ this is a ret
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #100
.LB8:
@ jmp
	bl getint
	mov r4, r0
	mov r5, r4
	add r4, r13, #0
@@ phi to mov
	mov r9, r5
	b .LB9
.LB9:
	cmp r9, #0
	bgt .LB10
	b .LB11
.LB10:
	mov r5, #0
@@ phi to mov
	mov r7, r6
@@ phi to mov
	mov r6, r5
	b .LB12
.LB12:
	cmp r6, #5
	blt .LB13
	b .LB14
.LB13:
	mov r5, #0
@@ phi to mov
	mov r8, r5
	b .LB15
.LB15:
	cmp r8, #5
	blt .LB16
	b .LB17
.LB16:
	mov r7, r8
	mov r5, #5
	mul r5, r5, r6
	add r5, r5, r7
@ jmp
	bl getint
	mov r7, r0
	lsl r5, r5, #2
	add r5, r4, r5
	str r7, [r5]	@ 
	add r5, r8, #1
@@ phi to mov
	mov r8, r5
	b .LB15
.LB17:
	add r5, r6, #1
@@ phi to mov
	mov r7, r8
@@ phi to mov
	mov r6, r5
	b .LB12
.LB14:
@@address is exactly what i want
	mov r0, r4
@ jmp
	bl model
	cmp r0, #0
	bne .LB18
	b .LB19
.LB18:
	mov r0, #99
@ jmp
	bl putch
	mov r0, #97
@ jmp
	bl putch
	mov r0, #116
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	b .LB20
.LB20:
	sub r5, r9, #1
@@ phi to mov
	mov r6, r7
@@ phi to mov
	mov r9, r5
	b .LB9
.LB19:
	mov r0, #100
@ jmp
	bl putch
	mov r0, #111
@ jmp
	bl putch
	mov r0, #103
@ jmp
	bl putch
	mov r0, #10
@ jmp
	bl putch
	b .LB20
.LB11:
@ this is a ret
	add sp, sp, #100
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #100
	pop {r4-r12, lr}
	bx lr
	.fnend
