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
	mov r4, r1
	mov r2, r0
	mov r0, #0
@@ phi to mov
	mov r5, r0
	b .LB1
.LB1:
	sub r0, r4, #1
	cmp r5, r0
	blt .LB2
	b .LB3
.LB2:
	add r0, r5, #1
@@ phi to mov
	mov r1, r0
	b .LB4
.LB4:
	cmp r1, r4
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
	mov r0, r3
	b .LB8
.LB7:
	mov r0, r5
	lsl r0, r0, #2
	add r0, r2, r0
	ldr r0, [r0]	@ 
	mov r6, r5
	mov r3, r1
	lsl r3, r3, #2
	add r3, r2, r3
	ldr r3, [r3]	@ 
	lsl r6, r6, #2
	add r6, r2, r6
	str r3, [r6]	@ 
	mov r3, r1
	lsl r3, r3, #2
	add r3, r2, r3
	str r0, [r3]	@ 
	b .LB8
.LB8:
	add r1, r1, #1
@@ phi to mov
	mov r3, r0
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
	sub sp, sp, #196
.LB9:
	mov r4, r3
	mov r6, r2
	mov r7, r1
	mov r5, r0
	ldr r0, [sp, #108]	@ 
	ldr r1, [sp, #104]	@ 
	ldr r2, [sp, #100]	@ 
	ldr r3, [sp, #96]	@ 
	ldr r8, [sp, #92]	@ 
	ldr r9, [sp, #88]	@ 
	ldr r10, [sp, #84]	@ 
	ldr r12, [sp, #80]	@ 
	str r12, [sp, #112]	@ str-all2mem 1
	ldr r12, [sp, #76]	@ 
	str r12, [sp, #116]	@ str-all2mem 1
	ldr r12, [sp, #72]	@ 
	str r12, [sp, #120]	@ str-all2mem 1
	ldr r12, [sp, #68]	@ 
	str r12, [sp, #124]	@ str-all2mem 1
	ldr r12, [sp, #64]	@ 
	str r12, [sp, #128]	@ str-all2mem 1
	ldr r12, [sp, #60]	@ 
	str r12, [sp, #132]	@ str-all2mem 1
	ldr r12, [sp, #56]	@ 
	str r12, [sp, #136]	@ str-all2mem 1
	ldr r12, [sp, #52]	@ 
	str r12, [sp, #140]	@ str-all2mem 1
	ldr r11, [sp, #48]	@ 
	ldr r12, [sp, #44]	@ 
	str r12, [sp, #144]	@ str-all2mem 1
	ldr r12, [sp, #40]	@ 
	str r12, [sp, #148]	@ str-all2mem 1
	ldr r12, [sp, #36]	@ 
	str r12, [sp, #152]	@ str-all2mem 1
	ldr r12, [sp, #32]	@ 
	str r12, [sp, #156]	@ str-all2mem 1
	ldr r12, [sp, #28]	@ 
	str r12, [sp, #160]	@ str-all2mem 1
	ldr r12, [sp, #24]	@ 
	str r12, [sp, #164]	@ str-all2mem 1
	ldr r12, [sp, #20]	@ 
	str r12, [sp, #168]	@ str-all2mem 1
	ldr r12, [sp, #16]	@ 
	str r12, [sp, #172]	@ str-all2mem 1
	ldr r12, [sp, #12]	@ 
	str r12, [sp, #176]	@ str-all2mem 1
	ldr r12, [sp, #8]	@ 
	str r12, [sp, #180]	@ str-all2mem 1
	ldr r12, [sp, #4]	@ 
	str r12, [sp, #184]	@ str-all2mem 1
	ldr r12, [sp, #0]	@ 
	str r12, [sp, #188]	@ str-all2mem 1
	cmp r5, #0
	beq .LB10
	b .LB11
.LB10:
@ this is a ret
	add sp, sp, #196
	mov r0, r7
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB12
.LB12:
@ this is a ret
	add sp, sp, #196
	pop {r4-r12, lr}
	bx lr
@ end of return 
.LB11:
	sub r12, r5, #1
	str r12, [sp, #192]	@ str-all2mem 1
	add r6, r7, r6
	mov32 , r7, 998244353
	sdiv r5, r6, r7
	mul r5, r5, r7
	sub r5, r6, r5
	ldr r12, [sp, #184]	@ ldr-all2mem 1
	str r12, [sp, #-236]	@ 
	ldr r12, [sp, #180]	@ ldr-all2mem 1
	str r12, [sp, #-232]	@ 
	ldr r12, [sp, #176]	@ ldr-all2mem 1
	str r12, [sp, #-228]	@ 
	ldr r12, [sp, #172]	@ ldr-all2mem 1
	str r12, [sp, #-224]	@ 
	ldr r12, [sp, #168]	@ ldr-all2mem 1
	str r12, [sp, #-220]	@ 
	ldr r12, [sp, #164]	@ ldr-all2mem 1
	str r12, [sp, #-216]	@ 
	ldr r12, [sp, #160]	@ ldr-all2mem 1
	str r12, [sp, #-212]	@ 
	ldr r12, [sp, #156]	@ ldr-all2mem 1
	str r12, [sp, #-208]	@ 
	ldr r12, [sp, #152]	@ ldr-all2mem 1
	str r12, [sp, #-204]	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [sp, #-200]	@ 
	ldr r12, [sp, #144]	@ ldr-all2mem 1
	str r12, [sp, #-196]	@ 
	str r11, [sp, #-192]	@ 
	ldr r12, [sp, #140]	@ ldr-all2mem 1
	str r12, [sp, #-188]	@ 
	ldr r12, [sp, #136]	@ ldr-all2mem 1
	str r12, [sp, #-184]	@ 
	ldr r12, [sp, #132]	@ ldr-all2mem 1
	str r12, [sp, #-180]	@ 
	ldr r12, [sp, #128]	@ ldr-all2mem 1
	str r12, [sp, #-176]	@ 
	ldr r12, [sp, #124]	@ ldr-all2mem 1
	str r12, [sp, #-172]	@ 
	ldr r12, [sp, #120]	@ ldr-all2mem 1
	str r12, [sp, #-168]	@ 
	ldr r12, [sp, #116]	@ ldr-all2mem 1
	str r12, [sp, #-164]	@ 
	ldr r12, [sp, #112]	@ ldr-all2mem 1
	str r12, [sp, #-160]	@ 
	str r10, [sp, #-156]	@ 
	str r9, [sp, #-152]	@ 
	str r8, [sp, #-148]	@ 
	str r3, [sp, #-144]	@ 
	str r2, [sp, #-140]	@ 
	str r1, [sp, #-136]	@ 
	str r0, [sp, #-132]	@ 
	mov r0, #0
	str r0, [sp, #-128]	@ 
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	mov r0, r12
	mov r1, r5
	mov r2, r4
	ldr r12, [sp, #188]	@ ldr-all2mem 1
	mov r3, r12
@ jmp
	bl param32_rec
@ this is a ret
	add sp, sp, #196
	pop {r4-r12, lr}
	bx lr
@ end of return 
	b .LB12
@function without return!
	add sp, sp, #196
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global param32_arr
	.type param32_arr, %function
param32_arr:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #200
.LB13:
	mov r4, r3
	mov r6, r2
	mov r5, r1
	mov r7, r0
	ldr r0, [sp, #108]	@ 
	ldr r2, [sp, #104]	@ 
	ldr r8, [sp, #100]	@ 
	ldr r3, [sp, #96]	@ 
	ldr r9, [sp, #92]	@ 
	ldr r10, [sp, #88]	@ 
	ldr r11, [sp, #84]	@ 
	ldr r12, [sp, #80]	@ 
	str r12, [sp, #112]	@ str-all2mem 1
	ldr r12, [sp, #76]	@ 
	str r12, [sp, #116]	@ str-all2mem 1
	ldr r12, [sp, #72]	@ 
	str r12, [sp, #120]	@ str-all2mem 1
	ldr r12, [sp, #68]	@ 
	str r12, [sp, #124]	@ str-all2mem 1
	ldr r12, [sp, #64]	@ 
	str r12, [sp, #128]	@ str-all2mem 1
	ldr r12, [sp, #60]	@ 
	str r12, [sp, #132]	@ str-all2mem 1
	ldr r12, [sp, #56]	@ 
	str r12, [sp, #136]	@ str-all2mem 1
	ldr r12, [sp, #52]	@ 
	str r12, [sp, #140]	@ str-all2mem 1
	ldr r1, [sp, #48]	@ 
	ldr r12, [sp, #44]	@ 
	str r12, [sp, #144]	@ str-all2mem 1
	ldr r12, [sp, #40]	@ 
	str r12, [sp, #148]	@ str-all2mem 1
	ldr r12, [sp, #36]	@ 
	str r12, [sp, #152]	@ str-all2mem 1
	ldr r12, [sp, #32]	@ 
	str r12, [sp, #156]	@ str-all2mem 1
	ldr r12, [sp, #28]	@ 
	str r12, [sp, #160]	@ str-all2mem 1
	ldr r12, [sp, #24]	@ 
	str r12, [sp, #164]	@ str-all2mem 1
	ldr r12, [sp, #20]	@ 
	str r12, [sp, #168]	@ str-all2mem 1
	ldr r12, [sp, #16]	@ 
	str r12, [sp, #172]	@ str-all2mem 1
	ldr r12, [sp, #12]	@ 
	str r12, [sp, #176]	@ str-all2mem 1
	ldr r12, [sp, #8]	@ 
	str r12, [sp, #180]	@ str-all2mem 1
	ldr r12, [sp, #4]	@ 
	str r12, [sp, #184]	@ str-all2mem 1
	ldr r12, [sp, #0]	@ 
	str r12, [sp, #188]	@ str-all2mem 1
	mov r12, #0
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	lsl r12, r12, #2
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	add r12, r7, r12
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	ldr r12, [r12]	@ 
	str r12, [sp, #196]	@ str-all2mem 1
	mov r12, #1
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	lsl r12, r12, #2
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	add r12, r7, r12
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	ldr r7, [r12]	@ 
	ldr r12, [sp, #196]	@ ldr-all2mem 1
	add r7, r12, r7
	mov r12, r7
	str r12, [sp, #192]	@ str-all2mem 1
	mov r7, #0
	lsl r7, r7, #2
	add r7, r5, r7
	ldr r7, [r7]	@ 
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	add r7, r12, r7
	mov r12, #1
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	lsl r12, r12, #2
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	add r12, r5, r12
	str r12, [sp, #192]	@ str-all2mem 1
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	ldr r5, [r12]	@ 
	add r5, r7, r5
	mov r7, #0
	lsl r7, r7, #2
	add r7, r6, r7
	ldr r7, [r7]	@ 
	add r5, r5, r7
	mov r7, #1
	lsl r7, r7, #2
	add r7, r6, r7
	ldr r6, [r7]	@ 
	add r5, r5, r6
	mov r6, #0
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r6, [r6]	@ 
	add r5, r5, r6
	mov r6, #1
	lsl r6, r6, #2
	add r6, r4, r6
	ldr r4, [r6]	@ 
	add r4, r5, r4
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #188]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #188]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #184]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #184]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #180]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #180]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #176]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #176]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #172]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #172]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #168]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #168]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #164]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #164]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #160]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r4, r5, r4
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #160]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #156]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #156]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #152]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #152]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	ldr r12, [sp, #144]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	ldr r12, [sp, #144]	@ ldr-all2mem 1
	add r5, r12, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #0
	lsl r5, r5, #2
	add r5, r1, r5
	ldr r5, [r5]	@ 
	add r4, r4, r5
	mov r5, #1
	lsl r5, r5, #2
	add r5, r1, r5
	ldr r1, [r5]	@ 
	add r1, r4, r1
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #140]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #140]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #136]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #136]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #132]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #132]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #128]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #128]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #124]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #124]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #120]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #120]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #116]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	ldr r12, [sp, #116]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	ldr r12, [sp, #112]	@ ldr-all2mem 1
	add r4, r12, r4
	ldr r4, [r4]	@ 
	add r4, r1, r4
	mov r1, #1
	lsl r1, r1, #2
	ldr r12, [sp, #112]	@ ldr-all2mem 1
	add r1, r12, r1
	ldr r1, [r1]	@ 
	add r1, r4, r1
	mov r4, #0
	lsl r4, r4, #2
	add r4, r11, r4
	ldr r4, [r4]	@ 
	add r4, r1, r4
	mov r1, #1
	lsl r1, r1, #2
	add r1, r11, r1
	ldr r1, [r1]	@ 
	add r1, r4, r1
	mov r4, #0
	lsl r4, r4, #2
	add r4, r10, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	add r4, r10, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	add r4, r9, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	add r4, r9, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #0
	lsl r4, r4, #2
	add r4, r3, r4
	ldr r4, [r4]	@ 
	add r1, r1, r4
	mov r4, #1
	lsl r4, r4, #2
	add r4, r3, r4
	ldr r3, [r4]	@ 
	add r1, r1, r3
	mov r3, #0
	lsl r3, r3, #2
	add r3, r8, r3
	ldr r3, [r3]	@ 
	add r1, r1, r3
	mov r3, #1
	lsl r3, r3, #2
	add r3, r8, r3
	ldr r3, [r3]	@ 
	add r1, r1, r3
	mov r3, #0
	lsl r3, r3, #2
	add r3, r2, r3
	ldr r3, [r3]	@ 
	add r1, r1, r3
	mov r3, #1
	lsl r3, r3, #2
	add r3, r2, r3
	ldr r2, [r3]	@ 
	add r1, r1, r2
	mov r2, #0
	lsl r2, r2, #2
	add r2, r0, r2
	ldr r2, [r2]	@ 
	add r1, r1, r2
	mov r2, #1
	lsl r2, r2, #2
	add r2, r0, r2
	ldr r0, [r2]	@ 
	add r0, r1, r0
@ this is a ret
	add sp, sp, #200
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #200
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global param16
	.type param16, %function
param16:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #196
.LB14:
	mov r12, r3
	str r12, [sp, #112]	@ str-all2mem 1
	mov r12, r2
	str r12, [sp, #116]	@ str-all2mem 1
	mov r9, r1
	mov r4, r0
	ldr r7, [sp, #44]	@ 
	ldr r12, [sp, #40]	@ 
	str r12, [sp, #120]	@ str-all2mem 1
	ldr r12, [sp, #36]	@ 
	str r12, [sp, #124]	@ str-all2mem 1
	ldr r12, [sp, #32]	@ 
	str r12, [sp, #128]	@ str-all2mem 1
	ldr r12, [sp, #28]	@ 
	str r12, [sp, #132]	@ str-all2mem 1
	ldr r12, [sp, #24]	@ 
	str r12, [sp, #136]	@ str-all2mem 1
	ldr r12, [sp, #20]	@ 
	str r12, [sp, #140]	@ str-all2mem 1
	ldr r11, [sp, #16]	@ 
	ldr r8, [sp, #12]	@ 
	ldr r12, [sp, #8]	@ 
	str r12, [sp, #144]	@ str-all2mem 1
	ldr r10, [sp, #4]	@ 
	ldr r6, [sp, #0]	@ 
	add r12, r13, #48
	str r12, [sp, #148]	@ str-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
@@address is exactly what i want
	mov r0, r12
	mov r1, #0
	mov r2, #64
@ jmp
	bl memset
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r4, [r12]	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r9, [r12, #4]	@ this is array....	@ 
	ldr r12, [sp, #116]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #8]	@ this is array....	@ 
	ldr r12, [sp, #112]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #12]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r6, [r12, #16]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r10, [r12, #20]	@ this is array....	@ 
	ldr r12, [sp, #144]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #24]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r8, [r12, #28]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r11, [r12, #32]	@ this is array....	@ 
	ldr r12, [sp, #140]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #36]	@ this is array....	@ 
	ldr r12, [sp, #136]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #40]	@ this is array....	@ 
	ldr r12, [sp, #132]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #44]	@ this is array....	@ 
	ldr r12, [sp, #128]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #48]	@ this is array....	@ 
	ldr r12, [sp, #124]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #52]	@ this is array....	@ 
	ldr r12, [sp, #120]	@ ldr-all2mem 1
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r12, [r12, #56]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	str r7, [r12, #60]	@ this is array....	@ 
	ldr r12, [sp, #148]	@ ldr-all2mem 1
@@address is exactly what i want
	mov r0, r12
	mov r1, #16
@ jmp
	bl sort
	mov r0, #0
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #152]	@ str-all2mem 1
	mov r0, #1
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #156]	@ str-all2mem 1
	mov r0, #2
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #160]	@ str-all2mem 1
	mov r0, #3
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #164]	@ str-all2mem 1
	mov r0, #4
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #168]	@ str-all2mem 1
	mov r0, #5
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r1, [r0]	@ 
	mov r0, #6
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #172]	@ str-all2mem 1
	mov r0, #7
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r5, [r0]	@ 
	mov r0, #8
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r3, [r0]	@ 
	mov r0, #9
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r2, [r0]	@ 
	mov r0, #10
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #176]	@ str-all2mem 1
	mov r0, #11
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #180]	@ str-all2mem 1
	mov r0, #12
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #184]	@ str-all2mem 1
	mov r0, #13
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #188]	@ str-all2mem 1
	mov r0, #14
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r12, [r0]	@ 
	str r12, [sp, #192]	@ str-all2mem 1
	mov r0, #15
	lsl r0, r0, #2
	ldr r12, [sp, #148]	@ ldr-all2mem 1
	add r0, r12, r0
	ldr r0, [r0]	@ 
	ldr r12, [sp, #168]	@ ldr-all2mem 1
	str r12, [sp, #-236]	@ 
	str r1, [sp, #-232]	@ 
	ldr r12, [sp, #172]	@ ldr-all2mem 1
	str r12, [sp, #-228]	@ 
	str r5, [sp, #-224]	@ 
	str r3, [sp, #-220]	@ 
	str r2, [sp, #-216]	@ 
	ldr r12, [sp, #176]	@ ldr-all2mem 1
	str r12, [sp, #-212]	@ 
	ldr r12, [sp, #180]	@ ldr-all2mem 1
	str r12, [sp, #-208]	@ 
	ldr r12, [sp, #184]	@ ldr-all2mem 1
	str r12, [sp, #-204]	@ 
	ldr r12, [sp, #188]	@ ldr-all2mem 1
	str r12, [sp, #-200]	@ 
	ldr r12, [sp, #192]	@ ldr-all2mem 1
	str r12, [sp, #-196]	@ 
	str r0, [sp, #-192]	@ 
	str r4, [sp, #-188]	@ 
	str r9, [sp, #-184]	@ 
	ldr r12, [sp, #116]	@ ldr-all2mem 1
	str r12, [sp, #-180]	@ 
	ldr r12, [sp, #112]	@ ldr-all2mem 1
	str r12, [sp, #-176]	@ 
	str r6, [sp, #-172]	@ 
	str r10, [sp, #-168]	@ 
	ldr r12, [sp, #144]	@ ldr-all2mem 1
	str r12, [sp, #-164]	@ 
	str r8, [sp, #-160]	@ 
	str r11, [sp, #-156]	@ 
	ldr r12, [sp, #140]	@ ldr-all2mem 1
	str r12, [sp, #-152]	@ 
	ldr r12, [sp, #136]	@ ldr-all2mem 1
	str r12, [sp, #-148]	@ 
	ldr r12, [sp, #132]	@ ldr-all2mem 1
	str r12, [sp, #-144]	@ 
	ldr r12, [sp, #128]	@ ldr-all2mem 1
	str r12, [sp, #-140]	@ 
	ldr r12, [sp, #124]	@ ldr-all2mem 1
	str r12, [sp, #-136]	@ 
	ldr r12, [sp, #120]	@ ldr-all2mem 1
	str r12, [sp, #-132]	@ 
	str r7, [sp, #-128]	@ 
	ldr r12, [sp, #152]	@ ldr-all2mem 1
	mov r0, r12
	ldr r12, [sp, #156]	@ ldr-all2mem 1
	mov r1, r12
	ldr r12, [sp, #160]	@ ldr-all2mem 1
	mov r2, r12
	ldr r12, [sp, #164]	@ ldr-all2mem 1
	mov r3, r12
@ jmp
	bl param32_rec
@ this is a ret
	add sp, sp, #196
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #196
	pop {r4-r12, lr}
	bx lr
	.fnend
@ this is a start of function.
	.global main
	.type main, %function
main:
	.fnstart
	push {r4-r12, lr}
	sub sp, sp, #340
.LB15:
@ jmp
	bl getint
	mov r5, r0
@ jmp
	bl getint
	mov r8, r0
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #256]	@ str-all2mem 1
@ jmp
	bl getint
	mov r6, r0
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #260]	@ str-all2mem 1
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #264]	@ str-all2mem 1
@ jmp
	bl getint
	mov r4, r0
@ jmp
	bl getint
	mov r10, r0
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #268]	@ str-all2mem 1
@ jmp
	bl getint
	mov r7, r0
@ jmp
	bl getint
	mov r9, r0
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #272]	@ str-all2mem 1
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #276]	@ str-all2mem 1
@ jmp
	bl getint
	mov r11, r0
@ jmp
	bl getint
	mov r12, r0
	str r12, [sp, #280]	@ str-all2mem 1
@ jmp
	bl getint
	ldr r12, [sp, #260]	@ ldr-all2mem 1
	str r12, [sp, #-236]	@ 
	ldr r12, [sp, #264]	@ ldr-all2mem 1
	str r12, [sp, #-232]	@ 
	str r4, [sp, #-228]	@ 
	str r10, [sp, #-224]	@ 
	ldr r12, [sp, #268]	@ ldr-all2mem 1
	str r12, [sp, #-220]	@ 
	str r7, [sp, #-216]	@ 
	str r9, [sp, #-212]	@ 
	ldr r12, [sp, #272]	@ ldr-all2mem 1
	str r12, [sp, #-208]	@ 
	ldr r12, [sp, #276]	@ ldr-all2mem 1
	str r12, [sp, #-204]	@ 
	str r11, [sp, #-200]	@ 
	ldr r12, [sp, #280]	@ ldr-all2mem 1
	str r12, [sp, #-196]	@ 
	str r0, [sp, #-192]	@ 
	mov r0, r5
	mov r1, r8
	ldr r12, [sp, #256]	@ ldr-all2mem 1
	mov r2, r12
	mov r3, r6
@ jmp
	bl param16
	mov r5, r0
	add r4, r13, #0
@@address is exactly what i want
	mov r0, r4
	mov r1, #0
	mov r2, #256
@ jmp
	bl memset
	str r5, [r4]	@ 
	movw r0, #8848
	str r0, [r4, #4]	@ this is array....	@ 
	mov r0, #1
@@ phi to mov
	mov r2, r0
	b .LB16
.LB16:
	cmp r2, #32
	blt .LB17
	b .LB18
.LB17:
	mov r0, #0
	lsl r1, r2, #1

	add r1, r1, r0
	mov r3, #1
	sub r0, r2, #1
	lsl r0, r0, #1

	add r0, r0, r3
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r0, [r0]	@ 
	sub r0, r0, #1
	lsl r1, r1, #2
	add r1, r4, r1
	str r0, [r1]	@ 
	mov r1, #1
	lsl r0, r2, #1

	add r0, r0, r1
	mov r3, #0
	sub r1, r2, #1
	lsl r1, r1, #1

	add r1, r1, r3
	lsl r1, r1, #2
	add r1, r4, r1
	ldr r1, [r1]	@ 
	sub r1, r1, #2
	lsl r0, r0, #2
	add r0, r4, r0
	str r1, [r0]	@ 
	add r0, r2, #1
@@ phi to mov
	mov r2, r0
	b .LB16
.LB18:
	mov r0, #0
	lsl r0, r0, #2

	add r2, r0, r4
	mov r0, #2
	lsl r0, r0, #2

	add r3, r0, r4
	mov r0, #4
	lsl r0, r0, #2

	add r5, r0, r4
	mov r0, #6
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #260]	@ str-all2mem 1
	mov r0, #8
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #284]	@ str-all2mem 1
	mov r0, #10
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #288]	@ str-all2mem 1
	mov r0, #12
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #292]	@ str-all2mem 1
	mov r0, #14
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #296]	@ str-all2mem 1
	mov r0, #16
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #272]	@ str-all2mem 1
	mov r0, #18
	lsl r0, r0, #2

	add r7, r0, r4
	mov r0, #20
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #300]	@ str-all2mem 1
	mov r0, #22
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #256]	@ str-all2mem 1
	mov r0, #24
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #304]	@ str-all2mem 1
	mov r0, #26
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #308]	@ str-all2mem 1
	mov r0, #28
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #264]	@ str-all2mem 1
	mov r0, #30
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #268]	@ str-all2mem 1
	mov r0, #32
	lsl r0, r0, #2

	add r9, r0, r4
	mov r0, #34
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #312]	@ str-all2mem 1
	mov r0, #36
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #316]	@ str-all2mem 1
	mov r0, #38
	lsl r0, r0, #2

	add r10, r0, r4
	mov r0, #40
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #320]	@ str-all2mem 1
	mov r0, #42
	lsl r0, r0, #2

	add r1, r0, r4
	mov r0, #44
	lsl r0, r0, #2

	add r8, r0, r4
	mov r0, #46
	lsl r0, r0, #2

	add r11, r0, r4
	mov r0, #48
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #324]	@ str-all2mem 1
	mov r0, #50
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #328]	@ str-all2mem 1
	mov r0, #52
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #280]	@ str-all2mem 1
	mov r0, #54
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #332]	@ str-all2mem 1
	mov r0, #56
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #276]	@ str-all2mem 1
	mov r0, #58
	lsl r0, r0, #2

	add r12, r0, r4
	str r12, [sp, #336]	@ str-all2mem 1
	mov r0, #60
	lsl r0, r0, #2

	add r6, r0, r4
	mov r0, #62
	lsl r0, r0, #2

	add r0, r0, r4
	ldr r12, [sp, #284]	@ ldr-all2mem 1
	str r12, [sp, #-240]	@ 
	ldr r12, [sp, #288]	@ ldr-all2mem 1
	str r12, [sp, #-236]	@ 
	ldr r12, [sp, #292]	@ ldr-all2mem 1
	str r12, [sp, #-232]	@ 
	ldr r12, [sp, #296]	@ ldr-all2mem 1
	str r12, [sp, #-228]	@ 
	ldr r12, [sp, #272]	@ ldr-all2mem 1
	str r12, [sp, #-224]	@ 
	str r7, [sp, #-220]	@ 
	ldr r12, [sp, #300]	@ ldr-all2mem 1
	str r12, [sp, #-216]	@ 
	ldr r12, [sp, #256]	@ ldr-all2mem 1
	str r12, [sp, #-212]	@ 
	ldr r12, [sp, #304]	@ ldr-all2mem 1
	str r12, [sp, #-208]	@ 
	ldr r12, [sp, #308]	@ ldr-all2mem 1
	str r12, [sp, #-204]	@ 
	ldr r12, [sp, #264]	@ ldr-all2mem 1
	str r12, [sp, #-200]	@ 
	ldr r12, [sp, #268]	@ ldr-all2mem 1
	str r12, [sp, #-196]	@ 
	str r9, [sp, #-192]	@ 
	ldr r12, [sp, #312]	@ ldr-all2mem 1
	str r12, [sp, #-188]	@ 
	ldr r12, [sp, #316]	@ ldr-all2mem 1
	str r12, [sp, #-184]	@ 
	str r10, [sp, #-180]	@ 
	ldr r12, [sp, #320]	@ ldr-all2mem 1
	str r12, [sp, #-176]	@ 
	str r1, [sp, #-172]	@ 
	str r8, [sp, #-168]	@ 
	str r11, [sp, #-164]	@ 
	ldr r12, [sp, #324]	@ ldr-all2mem 1
	str r12, [sp, #-160]	@ 
	ldr r12, [sp, #328]	@ ldr-all2mem 1
	str r12, [sp, #-156]	@ 
	ldr r12, [sp, #280]	@ ldr-all2mem 1
	str r12, [sp, #-152]	@ 
	ldr r12, [sp, #332]	@ ldr-all2mem 1
	str r12, [sp, #-148]	@ 
	ldr r12, [sp, #276]	@ ldr-all2mem 1
	str r12, [sp, #-144]	@ 
	ldr r12, [sp, #336]	@ ldr-all2mem 1
	str r12, [sp, #-140]	@ 
	str r6, [sp, #-136]	@ 
	str r0, [sp, #-132]	@ 
	mov r0, r2
	mov r1, r3
	mov r2, r5
	ldr r12, [sp, #260]	@ ldr-all2mem 1
	mov r3, r12
@ jmp
	bl param32_arr

@ jmp
	bl putint
	mov r0, #10
@ jmp
	bl putch
@ this is a ret
	add sp, sp, #340
	mov r0, #0
	pop {r4-r12, lr}
	bx lr
@ end of return 
@function without return!
	add sp, sp, #340
	pop {r4-r12, lr}
	bx lr
	.fnend
