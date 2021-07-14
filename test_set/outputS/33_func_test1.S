	.data
a:
	.word 0
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@ass 17
	ldr r0, =a
	ldr r0, [r0]
	mov r0, #3
@alloc 18
@ass 19
