	.arch armv7a
	.data
	.text
@ this is a start of function.
	.global add
	.type add, %function
add:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #56
.LB0:
	ldr r0, [sp, #8]	@ 
	str r0, [sp, #8]	@ ttt
	ldr r0, [sp, #4]	@ 
	str r0, [sp, #12]	@ ttt
	ldr r0, [sp, #16]	@ ttt
	ldr r1, [sp, #20]	@ ttt
	add r0, r0, r1
	str r0, [sp, #24]	@ ttt
	ldr r0, [sp, #24]	@ ttt
	ldr r2, [sp, #28]	@ ttt
	add r0, r0, r2
	str r0, [sp, #32]	@ ttt
	ldr r0, [sp, #32]	@ ttt
	ldr r3, [sp, #36]	@ ttt
	add r1, r0, r3
	str r1, [sp, #40]	@ ttt
	ldr r1, [sp, #40]	@ ttt
	ldr r0, [sp, #12]	@ ttt
	add r1, r1, r0
	str r1, [sp, #44]	@ ttt
	ldr r1, [sp, #44]	@ ttt
	ldr r0, [sp, #8]	@ ttt
	add r0, r1, r0
	str r0, [sp, #48]	@ ttt
	ldr r0, [sp, #48]	@ ttt
@ this is a ret
	add sp, sp, #56
	pop {r4-r12, lr}
	mov r0, r0
	bx lr
@ end of return 
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #20
.LB1:
	mov r2, #10
	str r2, [sp, #0]	@ ttt
	mov r0, #2
	str r0, [sp, #4]	@ ttt
	ldr r0, [sp, #4]	@ ttt
	str r0, [sp, #-92]	@ 
	mov r0, #3
	str r0, [sp, #8]	@ ttt
	ldr r0, [sp, #8]	@ ttt
	str r0, [sp, #-88]	@ 
	ldr r2, [sp, #0]	@ ttt
	mov t0, r2
	ldr r2, [sp, #0]	@ ttt
	mov t1, r2
	ldr r2, [sp, #0]	@ ttt
	mov t2, r2
	mov t3, #1
@ jmp
	bl add
	mov r0, r0
	str r0, [sp, #12]	@ ttt
	ldr r0, [sp, #12]	@ ttt
@ this is a ret
	add sp, sp, #20
	pop {r4-r12, lr}
	mov r0, r0
	bx lr
@ end of return 
	.fnend
