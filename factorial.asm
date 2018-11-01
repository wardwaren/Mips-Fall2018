.data

start: .asciiz "Enter double to compute: "

answer: .asciiz "Factorial is: "

newline: .asciiz "\n"

j: .double 1.0
zero: .double 0.0
.text

la	$a0, start
li	$v0, 4
syscall

li	$v0, 7
syscall

mov.d $f10,$f0

l.d $f4,j
l.d $f6,j
l.d $f8,zero


factorial:

mul.d $f6,$f10,$f6

sub.d $f10, $f10, $f4

c.lt.d $f10,$f8
bc1t exit
j factorial



exit:


li	$v0, 4
la	$a0, newline
	syscall

li	$v0, 4
la	$a0, answer
	syscall


mov.d	$f12, $f6
li	$v0, 3
syscall
		

li	$v0, 10			
	syscall