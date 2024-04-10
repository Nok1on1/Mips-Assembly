#Creating strings to print later on
.data
print_if_not_prime: .asciiz "The number is composed\n" 
print_if_prime: .asciiz "The number is prime\n"
print_if_neither: .asciiz "This is neither prime nor composed\n"
prompt: .asciiz "Enter your number\n"

.text
main:
    li $v0, 4
    la $a0, prompt 
    syscall #prints promp_string
    
    li $v0, 5 #input
    syscall
    move $s0, $v0 #store input in $s0
    
    ble $s0, 1, print_neither #jumps to print_neither if the number is less or equal to 1
    ble $s0, 3 ,print_prime #jumps to print_prime if the number is less or equal to 3
    beq $s0, 4, print_composed #jumps to print_composed if the number is 4
    
    #check the remainder when dividing by 2
    li $t1, 2
    div $s0, $t1
    mfhi $t1
    beqz $t1, print_composed
    
    #check the remainder when dividing by 3
    li $t1, 3
    div $s0, $t1
    mfhi $t1
    beqz $t1, print_composed
    
    li $t0, 5 #initialize loop variable, which I will be calling 'i' from now, to 5
    jal loop_with_algorithm
    
    
    j exit_program
    
print_neither:
    #only executes if a number is neither prime nor composed
    li $v0, 4
    la $a0, print_if_neither
    syscall
    
    j exit_program
    
print_prime:
    #executes if number is prime
    li $v0, 4
    la $a0, print_if_prime
    syscall
    
    j exit_program
    
print_composed:
    #executes if a number is composed
    li $v0, 4
    la $a0, print_if_not_prime
    syscall
    
    j exit_program
    
loop_with_algorithm:
    # The algorithm for finding out if a number is prime or composed is written here
    mul $t1, $t0, $t0 
    bgt $t1, $s0, print_prime #check if i*i is more than input, if so, it breaks the loop, and prints prime
    
    div $s0, $t0
    mfhi $t1 #divides input by i, and stores in $t1 register
    
    beqz $t1, print_composed #breaks the loop if the remainder after division is 0
    
    addi $t1, $t0, 2
    div $s0, $t1
    mfhi $t1
    beqz $t1, print_composed
    
    addi $t0, $t0, 6 #adds 6 to i, and repeats the process
    j loop_with_algorithm
    
    

exit_program:
    # Exit the program
    li $v0, 10          # syscall code for exit
    syscall
    
