	.arch armv7a
	.data
arr:
	.word 1
	.word 2
	.word 33
	.word 4
	.word 5
	.word 6
	.text
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
.LB0:
	ldr r4, =arr
	mov r6, #0
	mov r5, #0
	b .LB1
.LB1:
	cmp r6, #6
	blt .LB2
	b .LB3
.LB2:
	ldr r7, [r4, #8]	@ this is array....
	add r5, r5, r7
	mov r7, r5
	add r5, r6, #1
	mov r6, r5
	mov r5, r7
	b .LB1
.LB3:
@ this is a ret
	pop {lr}
	mov r0, r5
	bx lr
@ end of return 
	.fnend

