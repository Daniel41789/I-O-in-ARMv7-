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
	.file	"prueba.c"
	.text
	.align	1
	.global	read_user_input
	.syntax unified
	.thumb
	.thumb_func
	.type	read_user_input, %function
read_user_input:
	# prologue starts here
	push {r7} 
	sub sp, sp, #12
	add r7, sp, #0
	str r0, [r7] @ backs buffer's base address up 
	str r1, [r7, #4] @ backs buffer size up
	# Function body
	ldr r2, [r7, #8] @ loads buffer size 
	ldr r1, [r7, #4] @ loads buffer's base address 
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
	ldr	r3, [r7, #12]
	cmp	r3, #2
	ble	.L3
	ldr	r3, [r7, #8]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	sum_array, .-sum_array
	.align	1
	.global	ascii_to_int
	.syntax unified
	.thumb
	.thumb_func
	.type	ascii_to_int, %function
ascii_to_int:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L6
.L9:
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #47
	bls	.L7
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #57
	bhi	.L7
	ldr	r2, [r7, #12]
	mov	r3, r2
	lsls	r3, r3, #2
	add	r3, r3, r2
	lsls	r3, r3, #1
	mov	r2, r3
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r3, r3, #48
	add	r3, r3, r2
	str	r3, [r7, #12]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	b	.L6
.L7:
	movs	r3, #0
	b	.L8
.L6:
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L9
	ldr	r3, [r7, #12]
.L8:
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	ascii_to_int, .-ascii_to_int
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}		@ Inicio del prólogo 
	sub	sp, sp, #16		
	add	r7, sp, #0
	ldr	r3, .L13
	ldr	r3, [r3]
	str	r3, [r7, #12]		@ Fin del prólogo
	mov	r3, #0
	add	r3, r7, #8
	mov	r0, r3
	add r4, r4, #0		@ i <- 0 
	str r4, [r7, #20]   @
	add r5, r5, #3		@  Size of array
	add r6, r6, #0		@ r6 = 0
	str r6, [r7, #24]	@ stores r6 in com 
	b .L15
.L16: 			
	ldr r0, =first
    ldr r1, =#0x6
    bl read_user_input
	mov r8, r0 
	ldr r6, [r7, #24] 
	add r9, r9, #4 	@
	add r4, r4, #1		@ 
.L15: 	  
	cmp r4, r5
	bge .L16


	bl	ascii_to_int
	str	r0, [r7, #4]
	movs	r3, #0
	ldr	r2, .L13
	ldr	r1, [r2]
	ldr	r2, [r7, #12]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L12
	bl	__stack_chk_fail
.L12:
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L14:
	.align	2
.L13:
	.word	__stack_chk_guard
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",%progbits
@ test
