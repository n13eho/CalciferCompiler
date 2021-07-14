	.data
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@alloc 256
@ass 257
