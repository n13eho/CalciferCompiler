	.arch armv7
	.data
	.text
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
.LB0:
	mov r1, #0
	mov r0, #0
.LB1:
	cmp r1, #100
	blt .LB2
	b .LB3
.LB2:
	cmp r1, #50
	beq .LB4
	b .LB5
.LB4:
.LB6:
	b .LB1
.LB5:
	add r0, r0, r1
	add r1, r1, #1
	b .LB1
.LB3:
@ this is a ret
	pop {lr}
	mov r0, r0
	bx lr
@ end of return 
	.fnend

