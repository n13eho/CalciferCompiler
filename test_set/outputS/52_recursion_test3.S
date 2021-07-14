	.data
a:
	.word 0
r:
	.word 0
	.text
	.global main
	.type main, %function
main:
	.fnstart
	sub sp, sp, #0
	push lr
.lb0:
@alloc 13
@ass 14
