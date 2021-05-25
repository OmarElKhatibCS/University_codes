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
	beq $t5,2048,end
	j drawBottom
end:
	li $v0, 10 # gracefully shutdown
	syscall
