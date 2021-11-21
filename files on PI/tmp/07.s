	.arch armv7
	.data
	.text
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
	sub sp, sp, #128
.LB0:
	add r0, r13, #4
	push {r0-r12}
@ mov params
	mov r1, #0
	mov r2, #8
@ jmp
	bl memset
	pop {r0-r12}
	add r2, r13, #36
	push {r0-r12}
@ mov params
	mov r7, r2
	mov r0, r7
	mov r1, #0
	mov r2, #8
@ jmp
	bl memset
	pop {r0-r12}
	mov r0, #1
	str r0, [r2, #4]	@ this is array....
	mov r0, #2
	str r0, [r2, #8]	@ this is array....
	mov r0, #3
	str r0, [r2, #12]	@ this is array....
	mov r0, #4
	str r0, [r2, #16]	@ this is array....
	mov r0, #5
	str r0, [r2, #20]	@ this is array....
	mov r0, #6
	str r0, [r2, #24]	@ this is array....
	mov r0, #7
	str r0, [r2, #28]	@ this is array....
	mov r0, #8
	str r0, [r2, #32]	@ this is array....
	add r0, r13, #68
	push {r0-r12}
@ mov params
	mov r1, #0
	mov r2, #8
@ jmp
	bl memset
	pop {r0-r12}
	mov r1, #1
	str r1, [r0, #4]	@ this is array....
	mov r1, #2
	str r1, [r0, #8]	@ this is array....
	mov r1, #3
	str r1, [r0, #12]	@ this is array....
	mov r1, #5
	str r1, [r0, #20]	@ this is array....
	mov r1, #7
	str r1, [r0, #28]	@ this is array....
	mov r1, #8
	str r1, [r0, #32]	@ this is array....
	ldr r1, [r0, #8]	@ this is array....
	ldr r2, [r2, #8]	@ this is array....
	add r3, r13, #100
	push {r0-r12}
@ mov params
	mov r7, r3
	mov r0, r7
	mov r1, #0
	mov r2, #8
@ jmp
	bl memset
	pop {r0-r12}
	str r1, [r3, #4]	@ this is array....
	str r2, [r3, #8]	@ this is array....
	mov r1, #3
	str r1, [r3, #12]	@ this is array....
	mov r1, #4
	str r1, [r3, #16]	@ this is array....
	mov r1, #5
	str r1, [r3, #20]	@ this is array....
	mov r1, #6
	str r1, [r3, #24]	@ this is array....
	mov r1, #7
	str r1, [r3, #28]	@ this is array....
	mov r1, #8
	str r1, [r3, #32]	@ this is array....
	ldr r2, [r3, #4]	@ this is array....
	ldr r1, [r3, #4]	@ this is array....
	add r2, r2, r1
	ldr r1, [r3, #4]	@ this is array....
	add r1, r2, r1
	ldr r0, [r0, #4]	@ this is array....
	add r0, r1, r0
@ this is a ret
	add sp, sp, #128
	pop {lr}
	mov r0, r0
	bx lr
@ end of return 
	.fnend

