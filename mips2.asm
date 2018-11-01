.data
Fib:.word 0 1


.text
la $s0,Fib

lw $t0,0($s0)
lw $t1,4($s0)
add $t2,$t1,$t0
sw $t2,8($s0)
add $t3,$t2,$t1
sw $t3,12($s0)
add $t4,$t3,$t2
sw $t4,16($s0)
add $t5,$t4,$t3
sw $t5,20($s0)
add $t6,$t5,$t4
sw $t6,24($s0)
add $t6,$t5,$t4
sw $t6,28($s0)