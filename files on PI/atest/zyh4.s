	.arch armv7a
	.data
a:
	.word 1
	.text
@ this is a start of function.
	.global func
	.type func, %function
func:
	.fnstart
	push {r4-r12, lr}
.LB0:
	mov r3, r1
	mov r2, r0
	ldr r0, =a	@ 
	ldr r0, [r0]
	add r0, r0, #1
	ldr r1, =a	@ 
	str r0, [r1]	@ 
	ldr r1, [r1]	@ 
	add r0, r2, r3
@ this is a ret
	mov r0, r0
	pop {r4-r12, lr}
	bx lr
@ end of return 
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
.LB1:
	ldr r0, =a	@ 
@@mov trans to ldr to get it's value
	ldr r4, [r0]	@ rs 是个地址
	mov r0, #0
	mov r1, #1
@ jmp
	bl func
	mov r0, r0
	mov r0, r0
	mov r1, r4
@ jmp
	bl func
	mov r0, r0
	mov r0, r0
@ jmp
	bl putint
	mov r0, #32
@ jmp
	bl putch
	mov r0, r4
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
@ this is a ret
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
	.fnend

