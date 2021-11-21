	.arch armv7a
	.data
n:
	.word 0
	.text
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {lr}
	sub sp, sp, #180
.LB0:
	push {r0-r7, r9-r12}
@ mov params
@ jmp
	bl getint
	mov r8, r0
	pop {r0-r7, r9-r12}
	b .LB1
.LB1:
	cmp r8, #5
	beq .LB2
	b .LB3
.LB2:
	add r8, r8, #1
	b .LB1
.LB3:
	mov r9, #0
	str r9, [sp, #4]
	ldr r9, [sp, #4]
	add r7, r9, #1
	mov r9, r7
	str r9, [sp, #124]
	ldr r9, [sp, #124]
	add r7, r9, #1
	mov r12, r7
	add r7, r12, #1
	mov r9, r7
	str r9, [sp, #44]
	ldr r9, [sp, #44]
	add r7, r9, #1
	mov r9, r7
	str r9, [sp, #68]
	ldr r9, [sp, #68]
	add r7, r9, #1
	mov r9, r7
	str r9, [sp, #148]
	ldr r9, [sp, #148]
	add r7, r9, #1
	mov r9, r7
	str r9, [sp, #140]
	ldr r9, [sp, #140]
	add r7, r9, #1
	mov r9, r7
	str r9, [sp, #84]
	ldr r9, [sp, #84]
	add r7, r9, #1
	add r6, r7, #1
	mov r9, r6
	str r9, [sp, #132]
	ldr r9, [sp, #132]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #156]
	ldr r9, [sp, #156]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #12]
	ldr r9, [sp, #12]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #28]
	ldr r9, [sp, #28]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #116]
	ldr r9, [sp, #116]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #20]
	ldr r9, [sp, #20]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #100]
	ldr r9, [sp, #100]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #92]
	ldr r9, [sp, #92]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #52]
	ldr r9, [sp, #52]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #36]
	ldr r9, [sp, #36]
	add r6, r9, #1
	mov r9, r6
	str r9, [sp, #172]
	ldr r9, [sp, #172]
	add r6, r9, #1
	add r11, r6, #1
	mov r9, r11
	str r9, [sp, #76]
	ldr r9, [sp, #76]
	add r11, r9, #1
	mov r9, r11
	str r9, [sp, #108]
	ldr r9, [sp, #108]
	add r11, r9, #1
	mov r9, r11
	str r9, [sp, #164]
	ldr r9, [sp, #164]
	add r11, r9, #1
	mov r9, r11
	str r9, [sp, #60]
	ldr r9, [sp, #60]
	add r11, r9, #1
	mov r10, r11
	add r11, r10, #1
	add r5, r11, #1
	mov r4, r5
	add r5, r4, #1
	add r9, r5, #1
	str r9, [sp, #0]
	push {r0-r12}
	ldr r9, [sp, #4]
	mov r0, r9
	ldr r9, [sp, #4]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #124]
	mov r0, r9
	ldr r9, [sp, #124]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r12
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #44]
	mov r0, r9
	ldr r9, [sp, #44]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #68]
	mov r0, r9
	ldr r9, [sp, #68]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #148]
	mov r0, r9
	ldr r9, [sp, #148]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #140]
	mov r0, r9
	ldr r9, [sp, #140]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #84]
	mov r0, r9
	ldr r9, [sp, #84]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r7
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #132]
	mov r0, r9
	ldr r9, [sp, #132]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #156]
	mov r0, r9
	ldr r9, [sp, #156]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #12]
	mov r0, r9
	ldr r9, [sp, #12]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #28]
	mov r0, r9
	ldr r9, [sp, #28]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #116]
	mov r0, r9
	ldr r9, [sp, #116]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #20]
	mov r0, r9
	ldr r9, [sp, #20]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #100]
	mov r0, r9
	ldr r9, [sp, #100]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #92]
	mov r0, r9
	ldr r9, [sp, #92]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #52]
	mov r0, r9
	ldr r9, [sp, #52]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #36]
	mov r0, r9
	ldr r9, [sp, #36]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #172]
	mov r0, r9
	ldr r9, [sp, #172]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r6
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #76]
	mov r0, r9
	ldr r9, [sp, #76]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #108]
	mov r0, r9
	ldr r9, [sp, #108]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #164]
	mov r0, r9
	ldr r9, [sp, #164]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #60]
	mov r0, r9
	ldr r9, [sp, #60]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r10
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r11
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r4
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r5
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	ldr r9, [sp, #0]
	mov r0, r9
	ldr r9, [sp, #0]
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	mov r7, #10
	push {r0-r12}
	mov r0, r7
@ mov params
@ jmp
	bl putch
	pop {r0-r12}
	push {r0-r12}
	mov r0, r8
@ mov params
@ jmp
	bl putint
	pop {r0-r12}
	push {r0-r12}
	mov r0, r7
@ mov params
@ jmp
	bl putch
	pop {r0-r12}
@ this is a ret
	add sp, sp, #180
	pop {lr}
	mov r0, r10
	bx lr
@ end of return 
	.fnend

