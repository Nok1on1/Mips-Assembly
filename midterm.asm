.data

prompt1 : .ascizz "Z = 3x+y-2, enter x:"
prompt2 : .ascizz "Z = 3x+y-2, enter y:"
prompt3 : .ascizz "Z ="
.text

li $v0, 4
la $a0, prompt1
syscall

li $v0, 5
syscall
move $t0, $v0

li $v0, 4
la $a0, prompt2
syscall

li $v0, 5
syscall
move $t1, $v0

addi $s0, $zero, 3
mul $t0, $t0, $s0

add $t2, $t0, $t1
sub $t3, $t2, 2

li $v0, 4
la $a0, prompt3
syscall
li $v0, 1
move $a0, $t3
syscall


