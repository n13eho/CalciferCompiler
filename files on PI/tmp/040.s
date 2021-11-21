	.arch armv7
	.data
	.text
@ this is a start of function.
	.global ifWhile
	.type ifWhile, %function
ifWhile:
	.fnstart
	push {lr}
.LB0:
	mov r3, #0
	cmp r3, #5
	beq .LB1
	b .LB2
.LB1:
	b .LB4
.LB4:
	cmp r1, #2
	beq .LB5
	b .LB6
.LB5:
	add r1, r1, #2
	b .LB4
.LB6:
	b .LB3
.LB3:
@ this is a ret
	pop {lr}
	mov r0, r0
	bx lr
@ end of return 
.LB2:
	b .LB7
.LB7:
	cmp r2, #5
	blt .LB8
	b .LB9
.LB8:
	mov r1, #2
	mul r0, r0, r1
	add r1, r2, #1
	mov r2, r1
	b .LB7
.LB9:
	b .LB3
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
.LB10:
	push {r1-r12}
@ mov params
@ jmp
	bl ifWhile
	mov r0, r0
	pop {r1-r12}
@ this is a ret
	pop {lr}
	mov r0, r0
	bx lr
@ end of return 
	.fnend

