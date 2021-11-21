	.data
rtyu:
	.word 1
a:
	.word 1
	.text
	.global main
	.type main, %function
main:
	.fnstart
.LB0:
	mov r2, #2
	mov r1, #12
	mov r2, #0
	mov r3, #0
	mov r3, #4
	mul r2, r2, r3
	sub r1, r1, r2
	mov r1, r1
	mov r2, #2
	sub r2, r1, r2
	mov r2, r2
	add r1, r1, r2
	mov r0, r1
	bx lr
	.fnend
