.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"c.c"
	.text
	.global	arraySize
	.section	.rodata
	.align	2
	.type	arraySize, %object
	.size	arraySize, 4
arraySize:
	.word	3
	.text
	.align	1
	.global	sum_array
	.syntax unified
	.thumb
	.thumb_func
	.type	sum_array, %function
sum_array:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #8]
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L2
.L3:
	ldr	r3, [r7, #12]
	lsls	r3, r3, #2
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldr	r3, [r3]
	ldr	r2, [r7, #8]
	add	r3, r3, r2
	str	r3, [r7, #8]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L2:
	movs	r2, #3
	ldr	r3, [r7, #12]
	cmp	r3, r2
	blt	.L3
	ldr	r3, [r7, #8]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	sum_array, .-sum_array
	.align	1
	.global	charToInt
	.syntax unified
	.thumb
	.thumb_func
	.type	charToInt, %function
charToInt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	mov	r3, r0
	strb	r3, [r7, #7]
	ldrb	r3, [r7, #7]	@ zero_extendqisi2
	subs	r3, r3, #48
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	charToInt, .-charToInt
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #36
	add	r7, sp, #0
	ldr	r3, .L12
	ldr	r3, [r3]
	str	r3, [r7, #28]
	mov	r3, #0
	mov	r3, sp
	mov	r6, r3
	movs	r3, #3
	subs	r3, r3, #1
	str	r3, [r7, #12]
	movs	r3, #3
	mov	r2, r3
	movs	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsls	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsls	r2, r4, #5
	movs	r3, #3
	mov	r2, r3
	movs	r3, #0
	mov	r0, r2
	mov	r1, r3
	mov	r2, #0
	mov	r3, #0
	lsls	r3, r1, #5
	orr	r3, r3, r0, lsr #27
	lsls	r2, r0, #5
	movs	r3, #3
	lsls	r3, r3, #2
	adds	r3, r3, #7
	lsrs	r3, r3, #3
	lsls	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	adds	r3, r3, #3
	lsrs	r3, r3, #2
	lsls	r3, r3, #2
	str	r3, [r7, #16]
	movs	r3, #0
	str	r3, [r7, #8]
	b	.L8
.L9:
	ldrb	r3, [r7, #7]	@ zero_extendqisi2
	mov	r0, r3
	bl	charToInt
	str	r0, [r7, #24]
	ldr	r3, [r7, #16]
	ldr	r2, [r7, #8]
	ldr	r1, [r7, #24]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [r7, #8]
	adds	r3, r3, #1
	str	r3, [r7, #8]
.L8:
	movs	r2, #3
	ldr	r3, [r7, #8]
	cmp	r3, r2
	blt	.L9
	ldr	r0, [r7, #16]
	bl	sum_array
	str	r0, [r7, #20]
	movs	r3, #0
	mov	sp, r6
	ldr	r2, .L12
	ldr	r1, [r2]
	ldr	r2, [r7, #28]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L11
	bl	__stack_chk_fail
.L11:
	mov	r0, r3
	adds	r7, r7, #36
	mov	sp, r7
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L13:
	.align	2
.L12:
	.word	__stack_chk_guard
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",%progbits