	.data
c:
	.word 0
	.word 0
	.word 2
	.word 0
	.text
	.global main
	.type main, %function
main:
	.fnstart
	push {r11,lr}
.lb0:
@call 3
	mov r11, sp
	mov r0, #10
	mov r0, r0
	mov r1, #12
	mov r1, r1
	bl func
	mov sp, r11
	mov r2, r0
.lb1:
@ret 4
	mov r3, #0
	mov r0, r3
@ end of one func
	pop {r11,lr}
	bx lr
	.fnend
	.global func
	.type func, %function
func:
	.fnstart
	push {r11,lr}
.lb2:
@add 1
	add r3, r0, r1
@ret 2
	mov r0, r3
@ end of one func
	pop {r11,lr}
	bx lr
	.fnend
