.data

start: .asciiz "Enter angle for sin:"

sin: .asciiz "SIN:"

newline: .asciiz "\n"

pi: .double 3.142



half: .double 180

i: .double -1
j: .double 1
.text


la	$a0, start
li	$v0, 4
syscall


li	$v0, 7
syscall

li $t1, 1
li $t2, 1
li $t5, 1
l.d $f16, pi
l.d $f8, half
l.d $f4, i

mov.d $f2, $f0

mul.d $f2,$f2,$f16

div.d $f2,$f2,$f8
add.d $f6,$f6,$f2
add.d $f20,$f20,$f2
taylor:

jal factorial
div.d $f6,$f6,$f0
jal exponent
mul.d $f6,$f6,$f0
mul.d $f6,$f6,$f4


add.d $f2,$f2, $f6
addi $t1,$t1,1
beq $t1,10,Exit
j taylor

factorial:


addi $t5,$zero,1
add $t3, $t2, $t1

addi $t4,$t3,1
mul $t5,$t5,$t3
mul $t5,$t5,$t4
addi $t2,$t2,1

mtc1.d $t5,$f0
cvt.d.w $f0,$f0

jr $ra

exponent:
mul.d $f0,$f20,$f20

jr $ra


Exit:

li	$v0, 4
la	$a0, newline
	syscall

li	$v0, 4
la	$a0, sin
	syscall


mov.d	$f12, $f2
li	$v0, 3
syscall
		

li	$v0, 10			
	syscall



