	.data
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@call 17
	bl if_if_Else
	pop {lr}
	mov sp, r11
	mov r0, r0
	bx lr
	.fnend
