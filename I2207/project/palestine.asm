# Copyright (c) 
# Author : Omar ElKhatib

# Bitmap Display Configuration:
# - Unit width in pixels: 16
# - Unit height in pixels: 16
# - Display width in pixels: 512
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)

.eqv BASE_ADDRESS 0x10008000

.text
# $t0 stores the base address for display
# $t1 stores the red colour code
# $t2 stores the green colour code
# $t3 stores the white colour code
li $t0,BASE_ADDRESS
li $t1,0xce1126
li $t2,0x007a3d
li $t3,0xffffff

# $t5 is a counter to decide what pixel should draw on next
# increment by 4 on every loop
li $t5,640
drawMiddle:
	addi $t0,$t5,BASE_ADDRESS
	sw $t3 0($t0)
	addi $t5,$t5,4
	beq $t5,1408,drawBottom
	j drawMiddle
drawBottom:
	addi $t0,$t5,BASE_ADDRESS
	addi $t5,$t5,4
	sw $t2, 0($t0)
	beq $t5,2048,drawFlagTop
	j drawBottom
drawFlagTop:
	li $t6, 0        # i=0
	li $t0,BASE_ADDRESS
	li $t5,0
	start_loop_1:  
  		beq $t6, 8, end_loop_1 # i == 8
		######################## Inner loop  
 		li $t7, 0        # j=0
		start_loop_2: 
			sw $t1, 0($t0) 
			addi $t0,$t0,4
  			beq $t7, $t6, end_loop_2  
  			addi $t7, $t7, 1    # j++ 
  			b start_loop_2  
		end_loop_2:  
		######################## Inner loop  
		addi $t6, $t6, 1    # i++ 
		addi $t5,$t5,128 # move to a new line
		li $t0, BASE_ADDRESS
		add $t0,$t0,$t5
  		b start_loop_1  
	end_loop_1:  
drawFlagBottom:
	li $t6, 8        # i=8
	start_loop_3:  
  		beq $t6, 0, end_loop_3 # i == 0
		######################## Inner loop  
 		li $t7, 1 # j = 1
		start_loop_4: 
			sw $t1, 0($t0) 
			addi $t0,$t0,4
  			beq $t7, $t6, end_loop_4 
  			addi $t7, $t7, 1    # j++
  			b start_loop_4  
		end_loop_4:  
		######################## Inner loop  
		subi $t6, $t6, 1    # i--
		addi $t5,$t5,128 # move to a new line
		li $t0, BASE_ADDRESS
		add $t0,$t0,$t5
  		b start_loop_3  
	end_loop_3: 
end:
	li $v0, 10 # gracefully shutdown
	syscall
