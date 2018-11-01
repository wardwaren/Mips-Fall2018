# Start .data segment
.data
x: .word 5
msg1: .asciiz "x="
nl: .asciiz "\n"


.text
main:
# Register assignments
# $s0 = x
# Initialize registers
lw $s0, x # Reg $s0 = x
# Print msg1
li $v0, 4 # print_string syscall code = 4
la $a0, msg1
syscall
# Print result (x)
li $v0,1 # print_int syscall code = 1
move $a0, $s0 # Load integer to print in $a0
syscall
# Print newline
li $v0,4 # print_string syscall code = 4
la $a0, nl
syscall
# Exit
li $v0,10 # exit
syscall
