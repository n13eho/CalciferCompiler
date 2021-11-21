	.arch armv7a
	.data
	.text
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
	sub sp, sp, #40
.LB0:
	add r4, r13, #4
	mov r5, #0
@ phi to mov
	mov r6, r5
	b .LB1
.LB1:
	cmp r6, #10
	blt .LB2
	b .LB3
.LB2:
	add r5, r6, #1
	lsl r7, r6, #2
	ldr r4, [r4]
	ldr r7, [r7]
	add r7, r4, r7
	str r5, [r7, #4]	@ this is array....
	add r5, r6, #1
@ phi to mov
	mov r6, r5
	b .LB1
.LB3:
	mov r5, #10
	push {r0-r5, r7-r12}
@ mov params
@ jmp
	bl getint
	mov r6, r0
	pop {r0-r5, r7-r12}
	mov r7, r6
	sub r5, r5, #1
	mov r6, r5
	mov r5, #0
	add r9, r6, r5
	mov r10, #2
	push {r0-r8, r10-r12}
	mov r0, r9
	mov r1, r10
@ mov params
@ jmp
	bl __aeabi_idiv
	mov r9, r0
	pop {r0-r8, r10-r12}
@ phi to mov
	mov r12, r9
@ phi to mov
	mov r9, r5
@ phi to mov
	mov r10, r6
	b .LB4
.LB4:
	lsl r5, r12, #2
	add r5, r4, r5
	ldr r5, [r5, #4]	@ this is array....
	cmp r5, r7
	beq .LB7
	b .LB5
.LB7:
	lsl r5, r12, #2
	add r5, r4, r5
	ldr r4, [r5, #4]	@ this is array....
	cmp r7, r4
	beq .LB11
	b .LB12
.LB11:
	push {r0-r12}
	mov r0, r7
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	b .LB13
.LB13:
	mov r4, #10
	push {r0-r12}
	mov r0, r4
@ mov params
@ jmp
	bl putch
	pop {r0-r12}
@ this is a ret
	add sp, sp, #40
	pop {lr}
	mov r0, #0
	bx lr
@ end of return 
.LB12:
	mov r4, #0
	push {r0-r12}
	mov r0, r4
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	b .LB13
.LB5:
	cmp r9, r10
	blt .LB6
	b .LB7
.LB6:
	add r6, r10, r9
	mov r5, #2
	push {r0-r4, r6-r12}
	mov r0, r6
	mov r1, r5
@ mov params
@ jmp
	bl __aeabi_idiv
	mov r5, r0
	pop {r0-r4, r6-r12}
	mov r12, r5
	lsl r5, r12, #2
	add r5, r4, r5
	ldr r5, [r5, #4]	@ this is array....
	cmp r7, r5
	blt .LB8
	b .LB9
.LB8:
	sub r5, r12, #1
	mov r10, r5
@ phi to mov
	mov r6, r11
@ phi to mov
	mov r8, r5
@ phi to mov
	mov r5, r10
	b .LB10
.LB10:
@ phi to mov
	mov r11, r6
@ phi to mov
	mov r10, r5
	b .LB4
.LB9:
	add r5, r12, #1
	mov r9, r5
@ phi to mov
	mov r6, r5
@ phi to mov
	mov r5, r10
	b .LB10
	.fnend

