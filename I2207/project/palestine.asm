# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
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
li $t2,0x00ff00
li $t3,0xffffff

# $t5 is a counter to decide what pixel should draw on next
# increment by 4 on every loop
li $t5,0
drawTop:
	sw $t1, 0($t0)
	addi $t5,$t5,4
	beq $t5,1028,drawMiddle
	addi $t0,$t5,BASE_ADDRESS
	j drawTop
drawMiddle:
	sw $t2, 0($t0)
	addi $t0,$t5,BASE_ADDRESS
	addi $t5,$t5,4
	beq $t5,2052,end
	j drawMiddle

end:
	li $v0, 10 # gracefully shutdown
	syscall
