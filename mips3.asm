.data
Arr:.word 21 20 51 83 20 20
y: .word 5
x: .word 20
length: .word 6
i: .word 0
space: .asciiz " "
.text

la $s0,Arr
lw $s1 i
lw $a1 length
lw $a2 x
lw $a3 y
replace:
sll $t1, $s1, 2
add $t1, $t1, $s0
lw $t0, 0($t1)

bne $t0,$a2,L1
add $t0, $a3, $zero
sw $t0, 0($t1)

L1:

addi $s1, $s1, 1
beq $a1,$s1,Print

j replace

Print:
add $s1, $zero,$zero
add $t0, $zero,$zero
add $t1, $zero,$zero
PrintLoop:

sll $t1, $s1, 2
add $t1, $t1, $s0
lw $t0, 0($t1)

li $v0,1
move $a0,$t0
syscall

li $v0,4
la $a0,space
syscall

addi $s1, $s1, 1

bne $s1,$a1, PrintLoop

