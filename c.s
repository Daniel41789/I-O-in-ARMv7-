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
	.align	1
	.global	read_user_input
	.syntax unified
	.thumb
	.thumb_func
	.type	read_user_input, %function
read_user_input:
	# prologue starts here
	push {r7} 				@ Prologue
	sub sp, sp, #12
	add r7, sp, #0			@ End of prologue
	str r0, [r7] 			@ backs buffers base address up 
	str r1, [r7, #4] 		@ backs buffer size up

	# Function body
	ldr r2, [r7, #8] 		@ loads buffer size 
	ldr r1, [r7, #4] 		@ loads buffer's base address 
	mov r0, #0х0 @ file descritor kind ( STDIN)
	mov r7, #3 @ sets the kind of function call
	svc 0x0 @ performs system call
	mov r3, r0
	add r7, sp, #0
	# Epilogue
	move r0, r3 
	adds r7, r7, #12
	mov sp, r7
	pop {r7}
	bx lr
	
	.size	read_user_input, .-read_user_input

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

.global main

main: 
	@ Prólogo
	push {r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	@ Fin del Prólogo
	mov r0, #0					@ int i = 0;
	str r0, [r7]				@ stores r0 in i
	b F0						@ branch to F0
F1: ldr r1, =#0x6
	ldr r0, =first
    bl read_user_input
	mov r2, r0
	// calls charToInt
	ldr r0, r2
	bl charToInt
	mov r2, r0
	ldr r0, [r7]				@ loads i into r0
	add r1, r7, #4				@ base (a)
	str r2, [r1, r0, lsl #2]	@ adress a[i] = base (a) + size * i 
	ldr r0, [r7]				@ r0 <- i
	add r0, #1					@ i++
	str r0, [r7]				@ stores r0 in i
F0: ldr r0, [r7]				@ r0 <- i
	cmp r0, #3					@ compares
	blt F1						@ i < 3

	// Llamar suma 

	mov	r0, #0
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}





	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",%progbits

first: 
	.skip 8