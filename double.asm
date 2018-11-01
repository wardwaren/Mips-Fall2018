.data
array: .double 1.0

.text
.globl main

main:
andi $sp, 0xfffffff8

addi $sp, $sp, -8

l.d $f0, array
s.d $f0, 0($sp)

li $v0, 10
syscall  	# exit