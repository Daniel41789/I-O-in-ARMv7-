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
	.align  1
	.global display
	.syntax unified
	.thumb
	.thumb_func
	.type   display, %function



int_to_string:
    push {lr}
    push {r4-r11}
    mov r2, #0x0
    mov r3, #1000
    mov r7, #10

_loop:
    mov r4, #0x0
    udiv r4, r0, r3
    add r4, r4, #0x30

    ldr r5, =sum
    add r5, r5, r2
    strb r4, [r5]
    add r2, r2, #1

    sub r4, r4, #0x30
    mul r6, r4, r3
    sub r0, r0, r6

    udiv r6, r3, r7
    mov r3, r6
    cmp r3, #0
    beq _leave_int
    b _loop

_leave_int:
    mov r4, #0xa
    ldr r5, =sum
    add r5, r5, r2
    add r5, r5, #1
    strb r4, [r5]
    pop {r4-r11}
    pop {pc}

display:
    push {r7}
	sub sp, sp, #12
	add r7, sp, #0			@ End of prologue
	str r0, [r7] 		@ sum_array result backups 

	# Function body
	ldr r1, [r7]
	mov r9, r7
	mov r0, #0x1            @ exit	
    mov r7, #0x4            @ write
	mov r2, #0x8			@ creat
    svc 0x0
	mov r7, r9
	mov r3, r0

	# Epilogue
	mov r0, r3 
	adds r7, r7, #12
	mov sp, r7
	pop {r7}
	bx lr

    .size   display, .-display

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
	ldr r2, [r7, #4] 		@ loads buffer size 
	ldr r1, [r7] 			@ loads buffers base address 
	mov r9, r7
	mov r0, #0x0 			@ file descritor kind ( STDIN)
	mov r7, #0x3 			@ sets the kind of function call
	svc 0x0 				@ performs system call
	mov r7, r9
	mov r3, r0
	add r7, sp, #0
	# Epilogue
	mov r0, r3 
	adds r7, r7, #12
	mov sp, r7
	pop {r7}
	bx lr
	
	.size	read_user_input, .-read_user_input

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
	str	r1, [r7]
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
	ldr	r2, [r7, #12]
	ldr	r3, [r7]
	cmp	r2, r3
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
    push {lr}
    push {r4-r11}
    mov r2, #0x0
    mov r5, #0x0
    mov r6, #1
    mov r7, #10

_string_lenght_loop:
    ldrb r8, [r0]
    cmp r8, #0xa
    beq _count
    add r0, r0, #1
    add r2, r2, #1
    b _string_lenght_loop

_count:
    sub r0, r0, #1
    ldrb r8, [r0] 
    sub r8, r8, #0x30
    mul r4, r8, r6
    mov r8, r4
    mul r4, r6, r7
    mov r6, r4
    add r5, r5, r8
    sub r2, r2, #1
    cmp r2, #0x0
    beq _leave
    b _count

_leave:
    mov r0, r5
    pop {r4-r11}
    bx lr
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

main: 
	// Prólogo
	push {r7, lr}
	sub	sp, sp, #24
	add	r7, sp, #0
	// Fin del Prólogo
	mov r3, #0				@ r3 <- 0
	str r3, [r7, #4]			@ stores r3 in i
	b F0					@ branch to F0
F1: 
	ldr r0, =first				@ buffer
	ldr r1, =#0x6				@ size of buffer
    bl read_user_input			@ branch to read_user_input

	// calls charToInt
	ldr r0, =first				@ buffer
	bl charToInt				@ branch to charToInt							
	ldr r3, [r7, #4]			@ r3 <- i
	lsls r3, r3, #2				@ i*4
	adds r3, r3, #24			@ r2 <- base
	add r3, r3, r7				@ base + i * 4
	mov r2, r0 				@ r2 <- user input
	str r2, [r3, #-16]			
	ldr r3, [r7, #4]			@ r3 <- i
	adds r3, r3, #1				@ i++
	str r3, [r7, #4]			@ stores i++
F0: 
	ldr r3, [r7, #4]			@ r0 <- i
	cmp r3, #2				@ compares i with 2
	ble F1					@ branch less equal (1 <= 2) to F1

	// calls sum_array
	add r3, r7, #8				@ base (array)
	mov r1, #3				@ r1 <- 3
	mov r0, r3				@ r0 <- base (array)
	bl sum_array				@ branch to sum_array
	
	//int to string
	ldr r1, =sum				@ buffer 
	bl int_to_string			@ branch to int_to_string

	// Llamado de la función de impresión 
	ldr r1, =sum				@ buffer
	mov r0, r1				@ r0 <- buffer
	bl display				@ branch to display

	@ epilogo de main
	mov	r0, #0				@ return 0
	adds r7, r7, #24			
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}

	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",%progbits
	
	.section .data
	first: 
		.skip 8

	sum: 
		.skip 8
	
