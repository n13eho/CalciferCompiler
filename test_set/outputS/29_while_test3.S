	.data
g:
	.word 0
h:
	.word 0
f:
	.word 0
e:
	.word 0
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@ass 86
	ldr r0, =g
	ldr r0, [r0]
	mov r0, #1
@ass 87
	ldr r1, =h
	ldr r1, [r1]
	mov r1, #2
@ass 88
	ldr r2, =e
	ldr r2, [r2]
	mov r2, #4
@ass 89
	ldr r3, =f
	ldr r3, [r3]
	mov r3, #6
@call 90
	ldr r4, =g
	str r0, [r4, #0]
	ldr r0, =h
	str r1, [r0, #0]
	ldr r0, =e
	str r2, [r0, #0]
	ldr r0, =f
	str r3, [r0, #0]
	bl EightWhile
	pop {lr}
	mov sp, r11
	mov r0, r0
	bx lr
	.fnend
