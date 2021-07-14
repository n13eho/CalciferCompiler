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
@alloc 4
@ass 5
