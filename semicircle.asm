.data
	DISPLAY: .space 16384#65536 #0x00100 # 8*8*4, we need to reserve this space at the beginning of .data segment
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	numbers: .float 0.0 1.0 2.0 4.0 8.0 16.0 32.0 64.0 128.0 256.0
	COLOR: .word 0xff24000 0xffA500 0xffff240 0x00ff240 0x00A5ff 0x0000ff 0xA500ff
	radius: .float 15.0
	nine: .float 9.0
	dotone: .float 0.1
.text
j main

set_pixel_color:
# Assume a display of width DISPLAYWIDTH and height DISPLAYHEIGHT
# Pixels are numbered from 0,0 at the top left
# a0: x-coordinate
# a1: y-coordinate
# a2: color
# address of pixel = DISPLAY + (y*DISPLAYWIDTH + x)*4
#			y rows down and x pixels across
# write color (a2) at arrayposition
	
	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1 	# y*DISPLAYWIDTH
	add $t0,$t0, $a0 	# +x
	sll $t0, $t0, 2 	# *4
	la $t1, DISPLAY 	# get address of display: DISPLAY
	add $t1, $t1, $t0	# add the calculated address of the pixel
	sw $a2, ($t1) 		# write color to that pixel
	jr $ra 			# return
	



main:
	la $s3,numbers
	la $s4,COLOR
	l.s $f22,4($s3)
	l.s $f21,20($s3)
	l.s $f24, 24($s3) # x of centre
	l.s $f15, 24($s3) #y of centre
	l.s $f25, 24($s3) # x coordinate
	l.s $f26, 0($s3) # y coordinate
	add.s $f8, $f26,$f4 # x coordinate for symmetry
	l.s $f29,radius	  # x radius
	l.s $f4, 4($s3) #one
	lw $a2, 0($s4) #color
	l.s $f5,dotone
	l.s $f30, nine
	add.s $f20,$f21,$f21
	sub.s $f25,$f25,$f29
	add.s $f6,$f25,$f26
	add.s $f13,$f6,$f29
	add.s $f13,$f13,$f29
loop:
	add.s $f6,$f31,$f25
	j drawRainbow

loop2:
	addi $s4,$s4,4
	lw $a2, 0($s4)
	add.s $f25,$f25,$f22 #x coordinate
	
	sub.s $f29,$f29,$f4 #radius change
	add.s $f13,$f29,$f25 
	add.s $f13,$f13,$f29
	c.lt.s $f29,$f30
	bc1t exit
	j loop
	
drawRainbow:
	
	add.s $f6,$f6,$f5
	jal findy
	cvt.w.s $f14,$f6
	mfc1 $a0,$f14
	cvt.w.s $f7,$f7
	mfc1 $a1,$f7
	
	jal set_pixel_color
	sub.s $f13,$f13,$f5	
	cvt.w.s $f16,$f13
	mfc1 $a0,$f16
	jal set_pixel_color
	c.lt.s $f6,$f20
	bc1t drawRainbow
	j loop2
	
exit:
	
li	$v0, 10			
	syscall
	
	
findy:	
	sub.s $f10,$f24,$f6 # x-x0
	
	mul.s $f11,$f10,$f10 # x^2
	mul.s $f12,$f29,$f29 # r^2 
	sub.s $f12,$f12,$f11 #r^2 - x^2
	sqrt.s $f7, $f12 # y
	sub.s $f7,$f15,$f7 # y - y0
	jr $ra
