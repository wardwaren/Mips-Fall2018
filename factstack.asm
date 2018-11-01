.data

start: .asciiz "Enter double to compute: "

answer: .asciiz "Factorial is: "

newline: .asciiz "\n"

one: .double 1.0
zero: .double 0.0

.text

l.d $f4,one
l.d $f6,one
l.d $f8,zero

la	$a0, start
li	$v0, 4
syscall

li	$v0, 7
syscall

mov.d $f10,$f0

jal fact

exit:



li	$v0, 4
la	$a0, newline
	syscall

li	$v0, 4
la	$a0, answer
	syscall


mov.d	$f12, $f0
li	$v0, 3
syscall
		

li	$v0, 10			
	syscall


fact:  
addi $sp, $sp, -16     # adjust stack for 2 items   
sw   $ra, 0($sp)      # save return address    
sdc1 $f10, 4($sp)      # save argument
c.lt.d $f10,$f8     # test for n < 0 
bc1f L1    	
add.d $f0, $f8, $f6    # if so, result is 1   
addi $sp, $sp, 16      #   pop 2 items from stack    
jr   $ra              #   and return
L1: 
 sub.d $f10, $f10,$f4     # else decrement n   
 jal  fact             # recursive call    
 lw   $ra, 0($sp)      #   and return address  
 ldc1 $f10, 4($sp)      # restore original n   
 addi $sp, $sp, 16    # pop 2 items from stack  
  mul.d  $f0, $f10, $f0    # multiply to get result   
  jr   $ra     

          
                              
