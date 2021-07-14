	.data
a:
	.word 0
b:
	.word 0
c:
	.word 0
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@ass 6
	ldr r0, =a
	ldr r0, [r0]
	mov r0, #3
@ass 7
	ldr r1, =b
	ldr r1, [r1]
	mov r1, #2
@call 8
	ldr r2, =a
	str r0, [r2, #0]
	ldr r0, =b
	str r1, [r0, #0]
	ldr r0, =a
	ldr r0, [r0]
	mov r0, r0
	bl add
	pop {lr}
	mov sp, r11
	mov r1, r0
	bx lr
	.fnend
