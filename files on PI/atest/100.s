	.arch armv7ve
	.arm

.macro mov32, cond, reg, val
    movw\cond \reg, #:lower16:\val
    movt\cond \reg, #:upper16:\val
.endm
    
	.data
	.text
@ this is a start of function.
	.global sort
	.type sort, %function
sort:
	.fnstart
	push {r4-r12, lr}
.LB0:
	mov r3, r1
	mov r2, r0
	mov r0, #0
@@ phi to mov
	mov r5, r0
	b .LB1
.LB1:
	sub r0, r3, #1
	cmp r5, r0
	blt .LB2
	b .LB3
.LB2:
	add r0, r5, #1
@@ phi to mov
	mov r1, r0
	b .LB4
.LB4:
	cmp r1, r3
	blt .LB5
	b .LB6
.LB5:
	mov r0, r5
	lsl r0, r0, #2
	add r0, r2, r0
	ldr r0, [r0]	@ 
	mov r6, r1
	lsl r6, r6, #2
	add r6, r2, r6
	ldr r6, [r6]	@ 
	cmp r0, r6
	blt .LB7
@@ phi to mov
	mov r0, r4
	b .LB8
.LB7:
	mov r0, r5
	lsl r0, r0, #2
	add r0, r2, r0
	ldr r0, [r0]	@ 
	mov r6, r5
	mov r4, r1
	lsl r4, r4, #2
	add r4, r2, r4
	ldr r4, [r4]	@ 
	lsl r6, r6, #2
	add r6, r2, r6
	str r4, [r6]	@ 
	mov r4, r1
	lsl r4, r4, #2
	add r4, r2, r4
	str r0, [r4]	@ 
	b .LB8
.LB8:
	add r1, r1, #1
@@ phi to mov
	mov r4, r0
	b .LB4
.LB6:
	add r0, r5, #1
@@ phi to mov
	mov r5, r0
	b .LB1
.LB3:
@ this is a ret
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global param32_rec
	.type param32_rec, %function
param32_rec:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #208
.LB9:
	mov r9, r3
	mov r8, r2
	mov r7, r1
	mov r4, r0
	ldr r0, [sp, #108]	@ 
	ldr r6, [sp, #104]	@ 
	ldr r2, [sp, #100]	@ 
	ldr r1, [sp, #96]	@ 
	ldr r5, [sp, #92]	@ 
	ldr r3, [sp, #88]	@ 
	str r3, [sp, #112]	@ str-all2mem 1
	ldr r3, [sp, #84]	@ 
	str r3, [sp, #116]	@ str-all2mem 1
	ldr r3, [sp, #80]	@ 
	str r3, [sp, #120]	@ str-all2mem 1
	ldr r3, [sp, #76]	@ 
	str r3, [sp, #124]	@ str-all2mem 1
	ldr r3, [sp, #72]	@ 
	str r3, [sp, #128]	@ str-all2mem 1
	ldr r3, [sp, #68]	@ 
	str r3, [sp, #132]	@ str-all2mem 1
	ldr r3, [sp, #64]	@ 
	str r3, [sp, #136]	@ str-all2mem 1
	ldr r3, [sp, #60]	@ 
	str r3, [sp, #140]	@ str-all2mem 1
	ldr r3, [sp, #56]	@ 
	str r3, [sp, #144]	@ str-all2mem 1
	ldr r3, [sp, #52]	@ 
	str r3, [sp, #148]	@ str-all2mem 1
	ldr r3, [sp, #48]	@ 
	str r3, [sp, #152]	@ str-all2mem 1
	ldr r3, [sp, #44]	@ 
	str r3, [sp, #156]	@ str-all2mem 1
	ldr r3, [sp, #40]	@ 
	str r3, [sp, #160]	@ str-all2mem 1
	ldr r3, [sp, #36]	@ 
	str r3, [sp, #164]	@ str-all2mem 1
	ldr r3, [sp, #32]	@ 
	str r3, [sp, #168]	@ str-all2mem 1
	ldr r3, [sp, #28]	@ 
	str r3, [sp, #172]	@ str-all2mem 1
	ldr r3, [sp, #24]	@ 
	str r3, [sp, #176]	@ str-all2mem 1
	ldr r3, [sp, #20]	@ 
	str r3, [sp, #180]	@ str-all2mem 1
	ldr r3, [sp, #16]	@ 
	str r3, [sp, #184]	@ str-all2mem 1
	ldr r3, [sp, #12]	@ 
	str r3, [sp, #188]	@ str-all2mem 1
	ldr r3, [sp, #8]	@ 
	str r3, [sp, #192]	@ str-all2mem 1
	ldr r3, [sp, #4]	@ 
	str r3, [sp, #196]	@ str-all2mem 1
	ldr r3, [sp, #0]	@ 
	str r3, [sp, #200]	@ str-all2mem 1
	cmp r4, #0
	beq .LB10
	b .LB11
.LB10:
@ this is a ret
	add sp, sp, #208
	mov r0, r7
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB12
.LB12:
@ this is a ret
	add sp, sp, #208
	pop {r4-r12, lr}
	bx lr
@ end of return 
.LB11:
	sub r3, r4, #1
	str r3, [sp, #204]	@ str-all2mem 1
	add r8, r7, r8
	mov32 , r7, 998244353
	sdiv r4, r8, r7
	mul r4, r4, r7
	sub r4, r8, r4
	ldr r3, [sp, #196]	@ ldr-all2mem 1
	str r3, [sp, #-248]	@ 
	ldr r3, [sp, #192]	@ ldr-all2mem 1
	str r3, [sp, #-244]	@ 
	ldr r3, [sp, #188]	@ ldr-all2mem 1
	str r3, [sp, #-240]	@ 
	ldr r3, [sp, #184]	@ ldr-all2mem 1
	str r3, [sp, #-236]	@ 
	ldr r3, [sp, #180]	@ ldr-all2mem 1
	str r3, [sp, #-232]	@ 
	ldr r3, [sp, #176]	@ ldr-all2mem 1
	str r3, [sp, #-228]	@ 
	ldr r3, [sp, #172]	@ ldr-all2mem 1
	str r3, [sp, #-224]	@ 
	ldr r3, [sp, #168]	@ ldr-all2mem 1
	str r3, [sp, #-220]	@ 
	ldr r3, [sp, #164]	@ ldr-all2mem 1
	str r3, [sp, #-216]	@ 
	ldr r3, [sp, #160]	@ ldr-all2mem 1
	str r3, [sp, #-212]	@ 
	ldr r3, [sp, #156]	@ ldr-all2mem 1
	str r3, [sp, #-208]	@ 
	ldr r3, [sp, #152]	@ ldr-all2mem 1
	str r3, [sp, #-204]	@ 
	ldr r3, [sp, #148]	@ ldr-all2mem 1
	str r3, [sp, #-200]	@ 
	ldr r3, [sp, #144]	@ ldr-all2mem 1
	str r3, [sp, #-196]	@ 
	ldr r3, [sp, #140]	@ ldr-all2mem 1
	str r3, [sp, #-192]	@ 
	ldr r3, [sp, #136]	@ ldr-all2mem 1
	str r3, [sp, #-188]	@ 
	ldr r3, [sp, #132]	@ ldr-all2mem 1
	str r3, [sp, #-184]	@ 
	ldr r3, [sp, #128]	@ ldr-all2mem 1
	str r3, [sp, #-180]	@ 
	ldr r3, [sp, #124]	@ ldr-all2mem 1
	str r3, [sp, #-176]	@ 
	ldr r3, [sp, #120]	@ ldr-all2mem 1
	str r3, [sp, #-172]	@ 
	ldr r3, [sp, #116]	@ ldr-all2mem 1
	str r3, [sp, #-168]	@ 
	ldr r3, [sp, #112]	@ ldr-all2mem 1
	str r3, [sp, #-164]	@ 
	str r5, [sp, #-160]	@ 
	str r1, [sp, #-156]	@ 
	str r2, [sp, #-152]	@ 
	str r6, [sp, #-148]	@ 
	str r0, [sp, #-144]	@ 
	mov r0, #0
	str r0, [sp, #-140]	@ 
	ldr r3, [sp, #204]	@ ldr-all2mem 1
	mov r0, r3
	mov r1, r4
	mov r2, r9
	ldr r3, [sp, #200]	@ ldr-all2mem 1

@ jmp
	bl param32_rec
@ this is a ret
	add sp, sp, #208
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB12
@function without return!
	add sp, sp, #208
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global param32_arr
	.type param32_arr, %function
param32_arr:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #212
.LB13:
	mov r7, r3
	mov r5, r2
	mov r4, r1
	mov r8, r0
	ldr r3, [sp, #108]	@ 
	ldr r2, [sp, #104]	@ 
	ldr r9, [sp, #100]	@ 
	ldr r1, [sp, #96]	@ 
	ldr r6, [sp, #92]	@ 
	ldr r0, [sp, #88]	@ 
	str r0, [sp, #112]	@ str-all2mem 2
	ldr r0, [sp, #84]	@ 
	str r0, [sp, #116]	@ str-all2mem 2
	ldr r0, [sp, #80]	@ 
	str r0, [sp, #120]	@ str-all2mem 2
	ldr r0, [sp, #76]	@ 
	str r0, [sp, #124]	@ str-all2mem 2
	ldr r0, [sp, #72]	@ 
	str r0, [sp, #128]	@ str-all2mem 2
	ldr r0, [sp, #68]	@ 
	str r0, [sp, #132]	@ str-all2mem 2
	ldr r0, [sp, #64]	@ 
	str r0, [sp, #136]	@ str-all2mem 2
	ldr r0, [sp, #60]	@ 
	str r0, [sp, #140]	@ str-all2mem 2
	ldr r0, [sp, #56]	@ 
	str r0, [sp, #144]	@ str-all2mem 2
	ldr r0, [sp, #52]	@ 
	str r0, [sp, #148]	@ str-all2mem 2
	ldr r0, [sp, #48]	@ 
	str r0, [sp, #152]	@ str-all2mem 2
	ldr r0, [sp, #44]	@ 
	str r0, [sp, #156]	@ str-all2mem 2
	ldr r0, [sp, #40]	@ 
	str r0, [sp, #160]	@ str-all2mem 2
	ldr r0, [sp, #36]	@ 
	str r0, [sp, #164]	@ str-all2mem 2
	ldr r0, [sp, #32]	@ 
	str r0, [sp, #168]	@ str-all2mem 2
	ldr r0, [sp, #28]	@ 
	str r0, [sp, #172]	@ str-all2mem 2
	ldr r0, [sp, #24]	@ 
	str r0, [sp, #176]	@ str-all2mem 2
	ldr r0, [sp, #20]	@ 
	str r0, [sp, #180]	@ str-all2mem 2
	ldr r0, [sp, #16]	@ 
	str r0, [sp, #184]	@ str-all2mem 2
	ldr r0, [sp, #12]	@ 
	str r0, [sp, #188]	@ str-all2mem 2
	ldr r0, [sp, #8]	@ 
	str r0, [sp, #192]	@ str-all2mem 2
	ldr r0, [sp, #4]	@ 
	str r0, [sp, #196]	@ str-all2mem 2
	ldr r0, [sp, #0]	@ 
	str r0, [sp, #200]	@ str-all2mem 2
	mov r0, #0
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	lsl r0, r0, #2
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	add r0, r8, r0
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	ldr r0, [r0]	@ 
	str r0, [sp, #208]	@ str-all2mem 2
	mov r0, #1
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	lsl r0, r0, #2
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	add r0, r8, r0
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	ldr r8, [r0]	@ 
	ldr r0, [sp, #208]	@ ldr-all2mem 2
	add r8, r0, r8
	mov r0, r8
	str r0, [sp, #204]	@ str-all2mem 2
	mov r8, #0
	lsl r8, r8, #2
	add r8, r4, r8
	ldr r8, [r8]	@ 
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	add r8, r0, r8
	mov r0, #1
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	lsl r0, r0, #2
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	add r0, r4, r0
	str r0, [sp, #204]	@ str-all2mem 2
	ldr r0, [sp, #204]	@ ldr-all2mem 2
	ldr r4, [r0]	@ 
	add r4, r8, r4
	mov r8, #0
	lsl r8, r8, #2
	add r8, r5, r8
	ldr r8, [r8]	@ 
	add r4, r4, r8
	mov r8, #1
	lsl r8, r8, #2
	add r8, r5, r8
	ldr r5, [r8]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	add r5, r7, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	add r5, r7, r5
	ldr r7, [r5]	@ 
	add r7, r4, r7
	mov r4, r7
	mov r7, #0
	lsl r7, r7, #2
	ldr r0, [sp, #200]	@ ldr-all2mem 2
	add r7, r0, r7
	ldr r7, [r7]	@ 
	add r7, r4, r7
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #200]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #196]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #196]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #192]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #192]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #188]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #188]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #184]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #184]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #180]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #180]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #176]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #176]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, r7
	mov r7, #0
	lsl r7, r7, #2
	ldr r0, [sp, #172]	@ ldr-all2mem 2
	add r7, r0, r7
	ldr r7, [r7]	@ 
	add r7, r4, r7
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #172]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #168]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #168]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #160]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #160]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #156]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #156]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #152]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #152]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #148]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #148]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #144]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #144]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #140]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #140]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #136]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #136]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #132]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #132]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #128]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #128]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #124]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #124]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #120]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r4, r7, r4
	mov r7, #1
	lsl r7, r7, #2
	ldr r0, [sp, #120]	@ ldr-all2mem 2
	add r7, r0, r7
	ldr r7, [r7]	@ 
	add r7, r4, r7
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #116]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r4, r7, r4
	mov r7, #1
	lsl r7, r7, #2
	ldr r0, [sp, #116]	@ ldr-all2mem 2
	add r7, r0, r7
	ldr r7, [r7]	@ 
	add r7, r4, r7
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #112]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #112]	@ ldr-all2mem 2
	add r4, r0, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	add r4, r6, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	add r4, r6, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #0
	lsl r4, r4, #2
	add r4, r1, r4
	ldr r4, [r4]	@ 
	add r7, r7, r4
	mov r4, #1
	lsl r4, r4, #2
	add r4, r1, r4
	ldr r1, [r4]	@ 
	add r1, r7, r1
	mov r7, #0
	lsl r7, r7, #2
	add r7, r9, r7
	ldr r7, [r7]	@ 
	add r1, r1, r7
	mov r7, #1
	lsl r7, r7, #2
	add r7, r9, r7
	ldr r9, [r7]	@ 
	add r1, r1, r9
	mov r9, #0
	lsl r9, r9, #2
	add r9, r2, r9
	ldr r9, [r9]	@ 
	add r1, r1, r9
	mov r9, #1
	lsl r9, r9, #2
	add r9, r2, r9
	ldr r2, [r9]	@ 
	add r2, r1, r2
	mov r1, #0
	lsl r1, r1, #2
	add r1, r3, r1
	ldr r1, [r1]	@ 
	add r2, r2, r1
	mov r1, #1
	lsl r1, r1, #2
	add r1, r3, r1
	ldr r3, [r1]	@ 
	add r3, r2, r3
@ this is a ret
	add sp, sp, #212
	mov r0, r3
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #212
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global param16
	.type param16, %function
param16:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #208
.LB14:
	mov r5, r3
	mov r4, r2
	str r4, [sp, #112]	@ str-all2mem 3
	mov r7, r1
	mov r6, r0
	ldr r1, [sp, #44]	@ 
	str r1, [sp, #116]	@ str-all2mem 3
	ldr r1, [sp, #40]	@ 
	str r1, [sp, #120]	@ str-all2mem 3
	ldr r1, [sp, #36]	@ 
	str r1, [sp, #124]	@ str-all2mem 3
	ldr r1, [sp, #32]	@ 
	str r1, [sp, #128]	@ str-all2mem 3
	ldr r1, [sp, #28]	@ 
	str r1, [sp, #132]	@ str-all2mem 3
	ldr r1, [sp, #24]	@ 
	str r1, [sp, #136]	@ str-all2mem 3
	ldr r1, [sp, #20]	@ 
	str r1, [sp, #140]	@ str-all2mem 3
	ldr r1, [sp, #16]	@ 
	str r1, [sp, #144]	@ str-all2mem 3
	ldr r1, [sp, #12]	@ 
	str r1, [sp, #148]	@ str-all2mem 3
	ldr r1, [sp, #8]	@ 
	str r1, [sp, #152]	@ str-all2mem 3
	ldr r1, [sp, #4]	@ 
	str r1, [sp, #156]	@ str-all2mem 3
	ldr r1, [sp, #0]	@ 
	str r1, [sp, #160]	@ str-all2mem 3
	add r0, r13, #48
	str r0, [sp, #164]	@ str-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
@@address is exactly what i want
	mov r0, r0
	mov r1, #0
	mov r2, #64
@ jmp
	bl memset
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r6, [r0]	@ 
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r7, [r0, #4]	@ this is array....	@ 
	ldr r4, [sp, #112]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r4, [r0, #8]	@ this is array....	@ 
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r5, [r0, #12]	@ this is array....	@ 
	ldr r1, [sp, #160]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #16]	@ this is array....	@ 
	ldr r1, [sp, #156]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #20]	@ this is array....	@ 
	ldr r1, [sp, #152]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #24]	@ this is array....	@ 
	ldr r1, [sp, #148]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #28]	@ this is array....	@ 
	ldr r1, [sp, #144]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #32]	@ this is array....	@ 
	ldr r1, [sp, #140]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #36]	@ this is array....	@ 
	ldr r1, [sp, #136]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #40]	@ this is array....	@ 
	ldr r1, [sp, #132]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #44]	@ this is array....	@ 
	ldr r1, [sp, #128]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #48]	@ this is array....	@ 
	ldr r1, [sp, #124]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #52]	@ this is array....	@ 
	ldr r1, [sp, #120]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #56]	@ this is array....	@ 
	ldr r1, [sp, #116]	@ ldr-all2mem 3
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	str r1, [r0, #60]	@ this is array....	@ 
	ldr r0, [sp, #164]	@ ldr-all2mem 3
@@address is exactly what i want
	mov r0, r0
	mov r1, #16
@ jmp
	bl sort
	mov r4, #0
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #168]	@ str-all2mem 3
	mov r4, #1
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r3, [r4]	@ 
	mov r4, #2
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r2, [r4]	@ 
	str r2, [sp, #172]	@ str-all2mem 3
	mov r4, #3
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r8, [r4]	@ 
	mov r4, #4
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #176]	@ str-all2mem 3
	mov r4, #5
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r9, [r4]	@ 
	mov r4, #6
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #180]	@ str-all2mem 3
	mov r4, #7
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #184]	@ str-all2mem 3
	mov r4, #8
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #188]	@ str-all2mem 3
	mov r4, #9
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #192]	@ str-all2mem 3
	mov r4, #10
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #196]	@ str-all2mem 3
	mov r4, #11
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #200]	@ str-all2mem 3
	mov r4, #12
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r0, [r4]	@ 
	str r0, [sp, #204]	@ str-all2mem 3
	mov r4, #13
	lsl r4, r4, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r4, r0, r4
	ldr r4, [r4]	@ 
	mov r2, #14
	lsl r2, r2, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r2, r0, r2
	ldr r1, [r2]	@ 
	mov r2, #15
	lsl r2, r2, #2
	ldr r0, [sp, #164]	@ ldr-all2mem 3
	add r2, r0, r2
	ldr r2, [r2]	@ 
	ldr r0, [sp, #176]	@ ldr-all2mem 3
	str r0, [sp, #-248]	@ 
	str r9, [sp, #-244]	@ 
	ldr r0, [sp, #180]	@ ldr-all2mem 3
	str r0, [sp, #-240]	@ 
	ldr r0, [sp, #184]	@ ldr-all2mem 3
	str r0, [sp, #-236]	@ 
	ldr r0, [sp, #188]	@ ldr-all2mem 3
	str r0, [sp, #-232]	@ 
	ldr r0, [sp, #192]	@ ldr-all2mem 3
	str r0, [sp, #-228]	@ 
	ldr r0, [sp, #196]	@ ldr-all2mem 3
	str r0, [sp, #-224]	@ 
	ldr r0, [sp, #200]	@ ldr-all2mem 3
	str r0, [sp, #-220]	@ 
	ldr r0, [sp, #204]	@ ldr-all2mem 3
	str r0, [sp, #-216]	@ 
	str r4, [sp, #-212]	@ 
	str r1, [sp, #-208]	@ 
	str r2, [sp, #-204]	@ 
	str r6, [sp, #-200]	@ 
	str r7, [sp, #-196]	@ 
	ldr r4, [sp, #112]	@ ldr-all2mem 3
	str r4, [sp, #-192]	@ 
	str r5, [sp, #-188]	@ 
	ldr r1, [sp, #160]	@ ldr-all2mem 3
	str r1, [sp, #-184]	@ 
	ldr r1, [sp, #156]	@ ldr-all2mem 3
	str r1, [sp, #-180]	@ 
	ldr r1, [sp, #152]	@ ldr-all2mem 3
	str r1, [sp, #-176]	@ 
	ldr r1, [sp, #148]	@ ldr-all2mem 3
	str r1, [sp, #-172]	@ 
	ldr r1, [sp, #144]	@ ldr-all2mem 3
	str r1, [sp, #-168]	@ 
	ldr r1, [sp, #140]	@ ldr-all2mem 3
	str r1, [sp, #-164]	@ 
	ldr r1, [sp, #136]	@ ldr-all2mem 3
	str r1, [sp, #-160]	@ 
	ldr r1, [sp, #132]	@ ldr-all2mem 3
	str r1, [sp, #-156]	@ 
	ldr r1, [sp, #128]	@ ldr-all2mem 3
	str r1, [sp, #-152]	@ 
	ldr r1, [sp, #124]	@ ldr-all2mem 3
	str r1, [sp, #-148]	@ 
	ldr r1, [sp, #120]	@ ldr-all2mem 3
	str r1, [sp, #-144]	@ 
	ldr r1, [sp, #116]	@ ldr-all2mem 3
	str r1, [sp, #-140]	@ 
	ldr r0, [sp, #168]	@ ldr-all2mem 3

	mov r1, r3
	ldr r2, [sp, #172]	@ ldr-all2mem 3

	mov r3, r8
@ jmp
	bl param32_rec
	mov r4, r0
@ this is a ret
	add sp, sp, #208
	mov r0, r4
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #208
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #348
.LB15:
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #256]	@ str-all2mem 4
@ jmp
	bl getint
	mov r6, r0
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #260]	@ str-all2mem 4
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #264]	@ str-all2mem 4
@ jmp
	bl getint
	mov r10, r0
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #268]	@ str-all2mem 4
@ jmp
	bl getint
	mov r7, r0
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #272]	@ str-all2mem 4
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #276]	@ str-all2mem 4
@ jmp
	bl getint
	mov r5, r0
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #280]	@ str-all2mem 4
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #284]	@ str-all2mem 4
@ jmp
	bl getint
	mov r9, r0
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #288]	@ str-all2mem 4
@ jmp
	bl getint
	mov r4, r0
	str r4, [sp, #292]	@ str-all2mem 4
@ jmp
	bl getint
	mov r8, r0
	str r10, [sp, #-248]	@ 
	ldr r4, [sp, #268]	@ ldr-all2mem 4
	str r4, [sp, #-244]	@ 
	str r7, [sp, #-240]	@ 
	ldr r4, [sp, #272]	@ ldr-all2mem 4
	str r4, [sp, #-236]	@ 
	ldr r4, [sp, #276]	@ ldr-all2mem 4
	str r4, [sp, #-232]	@ 
	str r5, [sp, #-228]	@ 
	ldr r4, [sp, #280]	@ ldr-all2mem 4
	str r4, [sp, #-224]	@ 
	ldr r4, [sp, #284]	@ ldr-all2mem 4
	str r4, [sp, #-220]	@ 
	str r9, [sp, #-216]	@ 
	ldr r4, [sp, #288]	@ ldr-all2mem 4
	str r4, [sp, #-212]	@ 
	ldr r4, [sp, #292]	@ ldr-all2mem 4
	str r4, [sp, #-208]	@ 
	str r8, [sp, #-204]	@ 
	ldr r4, [sp, #256]	@ ldr-all2mem 4
	mov r0, r4
	mov r1, r6
	ldr r4, [sp, #260]	@ ldr-all2mem 4
	mov r2, r4
	ldr r4, [sp, #264]	@ ldr-all2mem 4
	mov r3, r4
@ jmp
	bl param16
	mov r7, r0
	add r9, r13, #0
@@address is exactly what i want
	mov r0, r9
	mov r1, #0
	mov r2, #256
@ jmp
	bl memset
	str r7, [r9]	@ 
	movw r8, #8848
	str r8, [r9, #4]	@ this is array....	@ 
	mov r8, #1
@@ phi to mov
	mov r2, r8
	b .LB16
.LB16:
	cmp r2, #32
	blt .LB17
	b .LB18
.LB17:
	mov r0, #0
	lsl r8, r2, #1

	add r1, r8, r0
	mov r0, #1
	sub r8, r2, #1
	lsl r8, r8, #1

	add r8, r8, r0
	lsl r8, r8, #2
	add r8, r9, r8
	ldr r8, [r8]	@ 
	sub r8, r8, #1
	lsl r0, r1, #2
	add r0, r9, r0
	str r8, [r0]	@ 
	mov r8, #1
	lsl r0, r2, #1

	add r0, r0, r8
	mov r1, #0
	sub r8, r2, #1
	lsl r8, r8, #1

	add r8, r8, r1
	lsl r8, r8, #2
	add r8, r9, r8
	ldr r8, [r8]	@ 
	sub r1, r8, #2
	lsl r8, r0, #2
	add r8, r9, r8
	str r1, [r8]	@ 
	add r8, r2, #1
@@ phi to mov
	mov r2, r8
	b .LB16
.LB18:
	mov r8, #0
	lsl r8, r8, #2

	add r0, r8, r9
	str r0, [sp, #164]	@ str-all2mem 4
	mov r8, #2
	lsl r8, r8, #2

	add r1, r8, r9
	str r1, [sp, #296]	@ str-all2mem 4
	mov r8, #4
	lsl r8, r8, #2

	add r7, r8, r9
	mov r8, #6
	lsl r8, r8, #2

	add r6, r8, r9
	mov r8, #8
	lsl r8, r8, #2

	add r10, r8, r9
	mov r8, #10
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #268]	@ str-all2mem 4
	mov r8, #12
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #256]	@ str-all2mem 4
	mov r8, #14
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #272]	@ str-all2mem 4
	mov r8, #16
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #260]	@ str-all2mem 4
	mov r8, #18
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #300]	@ str-all2mem 4
	mov r8, #20
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #304]	@ str-all2mem 4
	mov r8, #22
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #308]	@ str-all2mem 4
	mov r8, #24
	lsl r8, r8, #2

	add r2, r8, r9
	mov r8, #26
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #292]	@ str-all2mem 4
	mov r8, #28
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #312]	@ str-all2mem 4
	mov r8, #30
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #284]	@ str-all2mem 4
	mov r8, #32
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #316]	@ str-all2mem 4
	mov r8, #34
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #320]	@ str-all2mem 4
	mov r8, #36
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #324]	@ str-all2mem 4
	mov r8, #38
	lsl r8, r8, #2

	add r5, r8, r9
	mov r8, #40
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #328]	@ str-all2mem 4
	mov r8, #42
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #332]	@ str-all2mem 4
	mov r8, #44
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #336]	@ str-all2mem 4
	mov r8, #46
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #340]	@ str-all2mem 4
	mov r8, #48
	lsl r8, r8, #2

	add r3, r8, r9
	str r3, [sp, #344]	@ str-all2mem 4
	mov r8, #50
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #276]	@ str-all2mem 4
	mov r8, #52
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #288]	@ str-all2mem 4
	mov r8, #54
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #264]	@ str-all2mem 4
	mov r8, #56
	lsl r8, r8, #2

	add r4, r8, r9
	str r4, [sp, #280]	@ str-all2mem 4
	mov r8, #58
	lsl r8, r8, #2

	add r1, r8, r9
	mov r8, #60
	lsl r8, r8, #2

	add r0, r8, r9
	mov r8, #62
	lsl r8, r8, #2

	add r8, r8, r9
	str r10, [sp, #-252]	@ 
	ldr r4, [sp, #268]	@ ldr-all2mem 4
	str r4, [sp, #-248]	@ 
	ldr r4, [sp, #256]	@ ldr-all2mem 4
	str r4, [sp, #-244]	@ 
	ldr r4, [sp, #272]	@ ldr-all2mem 4
	str r4, [sp, #-240]	@ 
	ldr r4, [sp, #260]	@ ldr-all2mem 4
	str r4, [sp, #-236]	@ 
	ldr r3, [sp, #300]	@ ldr-all2mem 4
	str r3, [sp, #-232]	@ 
	ldr r3, [sp, #304]	@ ldr-all2mem 4
	str r3, [sp, #-228]	@ 
	ldr r3, [sp, #308]	@ ldr-all2mem 4
	str r3, [sp, #-224]	@ 
	str r2, [sp, #-220]	@ 
	ldr r4, [sp, #292]	@ ldr-all2mem 4
	str r4, [sp, #-216]	@ 
	ldr r3, [sp, #312]	@ ldr-all2mem 4
	str r3, [sp, #-212]	@ 
	ldr r4, [sp, #284]	@ ldr-all2mem 4
	str r4, [sp, #-208]	@ 
	ldr r3, [sp, #316]	@ ldr-all2mem 4
	str r3, [sp, #-204]	@ 
	ldr r3, [sp, #320]	@ ldr-all2mem 4
	str r3, [sp, #-200]	@ 
	ldr r3, [sp, #324]	@ ldr-all2mem 4
	str r3, [sp, #-196]	@ 
	str r5, [sp, #-192]	@ 
	ldr r3, [sp, #328]	@ ldr-all2mem 4
	str r3, [sp, #-188]	@ 
	ldr r3, [sp, #332]	@ ldr-all2mem 4
	str r3, [sp, #-184]	@ 
	ldr r3, [sp, #336]	@ ldr-all2mem 4
	str r3, [sp, #-180]	@ 
	ldr r3, [sp, #340]	@ ldr-all2mem 4
	str r3, [sp, #-176]	@ 
	ldr r3, [sp, #344]	@ ldr-all2mem 4
	str r3, [sp, #-172]	@ 
	ldr r4, [sp, #276]	@ ldr-all2mem 4
	str r4, [sp, #-168]	@ 
	ldr r4, [sp, #288]	@ ldr-all2mem 4
	str r4, [sp, #-164]	@ 
	ldr r4, [sp, #264]	@ ldr-all2mem 4
	str r4, [sp, #-160]	@ 
	ldr r4, [sp, #280]	@ ldr-all2mem 4
	str r4, [sp, #-156]	@ 
	str r1, [sp, #-152]	@ 
	str r0, [sp, #-148]	@ 
	str r8, [sp, #-144]	@ 
	ldr r0, [sp, #164]	@ ldr-all2mem 4

	ldr r1, [sp, #296]	@ ldr-all2mem 4

	mov r2, r7
	mov r3, r6
@ jmp
	bl param32_arr
	mov r8, r0
	mov r0, r8
@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
@ this is a ret
	add sp, sp, #348
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #348
	pop {r4-r12, lr}
	bx lr
	.fnend
