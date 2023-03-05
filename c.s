/* This code receives 3 numbers entered by the user, 
 * converts them from ASCII to integers, and stores 
 * the integer value in an array. It adds the values 
 * in the array, converts the result from integer to 
 * ASCII, and prints it to the terminal.
 * 
 * Authors: 
 * - Jhoan Daniel Arenas Reyes
 * - Karina Alcantara Segura
 * - Brandon Chávez Salaverría
 *
 * Some of the functions were taken from the following video:
 * https://youtu.be/VbtMCP8s5f4
 */
	
	# Compiler attributes and definitions of the screen display function.
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


/* Converts an integer number to a character string that is stored in an array.
*  @param: integer to convert.
*  @return: void 
*/

int_to_string:
    push {lr}				@Prologue
    push {r4-r11}
    mov r2, #0x0			@ array index
    mov r3, #1000			@ Initialize the divisor
    mov r7, #10				@ r7 = 10

_loop:
    mov r4, #0x0			@ r4 = 0
    udiv r4, r0, r3			@ r4 = int / divisor
    add r4, r4, #0x30		@ Convert the digit to an ASCII character by adding 48, which is the ASCII value of '0'

    ldr r5, =sum			@ r5 = base array
    add r5, r5, r2			@ r5 = base + i
    strb r4, [r5]			@ Load r4 in sum
    add r2, r2, #1			@ i++
    sub r4, r4, #0x30		@ Convert the ASCII digit to an integer value
    mul r6, r4, r3			@ r3 = r4 * divisor
    sub r0, r0, r6			@ Subtract the result from r0

    udiv r6, r3, r7			@ r6 = divisor / 10
    mov r3, r6				@ r3 = update divisor 
    cmp r3, #0				@ Compare divisor with 0
    beq _leave_int			@ Branch to _leave_int
    b _loop					@ Branch _loop

_leave_int:
    mov r4, #0xa			@ /n
    ldr r5, =sum			@ r5 = base array
    add r5, r5, r2			@ r5 + i
    add r5, r5, #1			@ Space for the final digit of the array
    strb r4, [r5]			@ Load r4 in sum
    pop {r4-r11}			@Epilogue
    pop {pc}

/*To print to the terminal the result of the sum of the three numbers entered by the user
*  @param: ASCII value
*  @return: void 
*/
display:
    push {r7}				@Prologue
	sub sp, sp, #12
	add r7, sp, #0			
	str r0, [r7] 			@ sum_array result backups 

	# Function body
	ldr r1, [r7]
	mov r9, r7				@ r9 = ASCII value
	mov r0, #0x1            @ exit	
    mov r7, #0x4            @ write
	mov r2, #0x8			@ creat
    svc 0x0					@ system call
	mov r7, r9
	mov r3, r0

	mov r0, r3 				@ Epilogue
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

/* Read the user input from the terminal.
* @param: base array and size
* @return: value that the user enters
*/
read_user_input:
	
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
	
	mov r0, r3 				@ Epilogue
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

/* Add up the values of an array.
* @param: 
* @return: 
*/

sum_array:
	push	{r7}			@Prologue
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]		@ r0 = base array
	str	r1, [r7]			@ r1 = size array
	movs	r3, #0			@ r3 = 0
	str	r3, [r7, #8]		@ load r3
	movs	r3, #0			@ i = 0
	str	r3, [r7, #12]		@ load r3
	b	.L2					@ Branch of .L2
.L3:
	ldr	r3, [r7, #12]		@ r3 = i
	lsls	r3, r3, #2		@ i * 4
	ldr	r2, [r7, #4]		@ r2 = base array
	add	r3, r3, r2			@ array[i] = base + i * 4
	ldr	r3, [r3]			@ r3 = array[i]
	ldr	r2, [r7, #8]		@ r2 = i
	add	r3, r3, r2			@ r3 + i
	str	r3, [r7, #8]		@ store result
	ldr	r3, [r7, #12]		@ r3 = i
	adds	r3, r3, #1		@ i++
	str	r3, [r7, #12]		@ store i	
.L2:
	ldr	r2, [r7, #12]		
	ldr	r3, [r7]			@ r3 = size
	cmp	r2, r3				@ compare i with size
	blt	.L3					@ branch of .L3
	ldr	r3, [r7, #8]		@ r3 = result
	mov	r0, r3				@ Epilogue
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

/* Converts an character string to a integer number
* @param: ASCII value
* @return: integer value
*/
charToInt:
    push {lr}				@ Prologue
    push {r4-r11}
    mov r2, #0x0			@ count = 0
    mov r5, #0x0			@ i = 0
    mov r6, #1				@ multi = 1
    mov r7, #10				@ convert

_string_lenght_loop:		@ Loop that traverses the array.
    ldrb r8, [r0]			@ r8 = r0
    cmp r8, #0xa			@ compare r8 with end of the array
    beq _count				@ Branch of _count
    add r0, r0, #1			@ i++
    add r2, r2, #1			@ count ++
    b _string_lenght_loop	@ Branch to _string_length_loop

_count:
    sub r0, r0, #1			@ i--
    ldrb r8, [r0] 			@ r8 = r0
    sub r8, r8, #0x30		@ r8 = r8 - 0x30 //decimal value of the digit
    mul r4, r8, r6			@ r8 * r6	//decimal value of the digit in the corresponding position
    mov r8, r4				@ r8 = int 
    mul r4, r6, r7			@ r4 = r6 * r7 //Update multi
    mov r6, r4				@ r6 = r4
    add r5, r5, r8			@ r5 = r5 + r8
    sub r2, r2, #1			@ count--
    cmp r2, #0x0			@ compare count = 0
    beq _leave				@ branch to _leave
    b _count				@ branch to _count

_leave:
    mov r0, r5			@ Epilogue
    pop {r4-r11}
    bx lr
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

main: 
	push {r7, lr}				@ Prologue
	sub	sp, sp, #24
	add	r7, sp, #0
	mov r3, #0					@ r3 <- 0
	str r3, [r7, #4]			@ stores r3 in i
	b F0						@ branch to F0
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
	mov r2, r0 					@ r2 <- user input
	str r2, [r3, #-16]			
	ldr r3, [r7, #4]			@ r3 <- i
	adds r3, r3, #1				@ i++
	str r3, [r7, #4]			@ stores i++
F0: 
	ldr r3, [r7, #4]			@ r0 <- i
	cmp r3, #2					@ compares i with 2
	ble F1						@ branch less equal (1 <= 2) to F1

	// calls sum_array
	add r3, r7, #8				@ base (array)
	mov r1, #3					@ r1 <- 3
	mov r0, r3					@ r0 <- base (array)
	bl sum_array				@ branch to sum_array
	
	//int to string
	ldr r1, =sum				@ buffer 
	bl int_to_string			@ branch to int_to_string

	// Llamado de la función de impresión 
	ldr r1, =sum				@ buffer
	mov r0, r1					@ r0 <- buffer
	bl display					@ branch to display

	mov	r0, #0					@ Epilogue
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
	