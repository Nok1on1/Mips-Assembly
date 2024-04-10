.data	# This is where all the data such as `int` and `string` is stored
# For printing
	myMessage: 	.asciiz "Hello ASSembly\n" 	# string
	myMessage: 	.byte 'H' 					# char
	int: 			.word 6869					# int
	pi: 			.float 3.14					# float
	myDouble: 		.double 68.69420 			# double
	zeroDouble: 	.double 0.0					# double
	
	
# For addition
	num1: .word 5
	num2: .word 10


# For substraction
	num1: .word 20
	num2: .word 12
			

# For input
	# general
		prompt: .asciiz "Enter your age: "
		message: .asciiz "\nYour age is "
		
	# string
		name: .asciiz "Enter your ugly ahh name: "
		hello: .asciiz "\nHello, "
		userInput: .space 20		# Allocates 20 spaces for `userInput`
		
	# float
		zeroAsFloat: .float 0.0 # We will use it like $zero
		
			
			
.text
# Printing different types of data
	li $v0, 4   				# prints string/char
	la $a0, myMessage 			# string/char
	
	li $v0, 1 					# for printing an integer
	lw $a0, int 				# load stored int variable called `int`
	
	li $v0, 2 					# float
	lwc1 $f12, pi				# float
	
	ldc1 $f2, myDouble			# double
	ldc1 $f0, zeroDouble		# double
	li $v0, 3					# double
	add.d $f12, $f2, $f0 		# double
	
	
# Addition
	lw $t0, num1
	lw $t1, num2
	add $t2, $t0, $t1
	
	li $v0, 1
	add $a0, $zero, $t2
	syscall
	
	
# Substraction
	lw $s0, num1
	lw $s1, num2
	
	sub $t0, $s0, $s1
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	
# Multiplication with mul (for 32-bit answer after multiplication)
	addi $s0, $zero, 10
	addi $s1, $zero, 4
	
	mul $t0, $s0, $s1
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	
# Multiplication with mult (for 64-bit answer after multiplication)
	addi $t0, $zero, 2000
	addi $t1, $zero, 10
	
	mult $t0, $t1
	
	mflo $s0 # move a number from lo to $s0
	
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	
# Multiplication with sll (efficient, but less practical)
	addi $s0, $zero, 4
	
	sll $t0, $s0, 3 # $t0 = $s0 * 2^3 = 4 * 2^3 = 4 * 8 = 32
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	
# Division
	addi $t0, $zero, 30
	addi $t1, $zero, 6
	
	# normal division
		div $s0, $t0, $t1 			# $s0 = $t0 / $t1
	
	# division with overflow
		div $t0, $t1
	
		mflo $s0 # Quotient (ganayofi)
		mfhi $s1 # Remainder
		
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	
# Getting an input
	# int
		# Prompt the user to enter age.
		li $v0, 4
		la $a0, prompt
		syscall
		
		# Get the user's age
		li $v0, 5		# `5` is for getting an `int` type
		syscall			# Wait for the input
		
		# Store the result in $t0
		move $t0, $v0
		
		# Display the message
		li $v0, 4
		la $a0, message
		syscall
		
		# Print the age
		li $v0, 1
		move $a0, $t0
		syscall
		
		
	# float
		lwc1 $f4, zeroAsFloat		# Load the value of `zeroAsFloat` (0.0) to $f4
	
		# Prompt the user to enter age.
		li $v0, 4
		la $a0, prompt
		syscall
	
		# Get the user's age as `float`
		li $v0, 6		# `6` is for getting a `float` type
		syscall			# Wait for the input
	
		# Display value
		li $v0, 2
	
		add.s $f12, $f0, $f4	# $f12 is responsible for displaying a `float` type, so ve move the value of $f4 to it
		syscall
		
		
	# double
		# Prompt the user to enter age.
		li $v0, 4
		la $a0, prompt
		syscall
		
		# Get the user's age
		li $v0, 7		# `7` is for getting a `double` type
		syscall			# Wait for the input
		
		# Display the user's input
		li $v0, 3
		add.d $f12, $f0, $f10	# $f0 is the number we want to display, so we store it in $f12 to display, $f10 is some empty register with 0.0 as its default value
		syscall
		
	
	# string (text)
		# Prompt the user to enter an input.
		li $v0, 4
		la $a0, name
		syscall
		
		# Getting user's input as text
		li $v0, 8
		la $a0, userInput
		li $a1, 20
		syscall 
		
		# Displays "Hello, "
		li $v0, 4
		la $a0, hello
		syscall
		
		# Displays the name
		li $v0, 4
		la $a0, userInput
		syscall