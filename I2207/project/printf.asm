# printf.asm
# purpose: MIPS assembly implementation of a C-like printf procedure
# supports %s, %d, and %c formats up to 3 formats in one call to printf 
# all arguments passed in registers (args past 3 are ignored)
# Register Usage:
#	$a0,$s0 - pointer to format string
#	$a1,$s1 - format arg1 (optional)
#	$a2,$s2 - format arg2 (optional)
#	$a3,$s3 - format arg3 (optional)
#	$s4 - count of format strings processed so far
#	$s5 - holds the format string (%s,%d)
#	$s6 - pointer to printf buffer
#
.data
	printf_buf:	.space 2
.text
.globl printf
printf:
	subu $sp, $sp, 36	# setup stack frame
	sw	$ra, 32($sp)	# backup all registers
	sw	$fp, 28($sp)
	sw	$s0, 24($sp)
	sw	$s1, 20($sp)
	sw	$s2, 16($sp)
	sw	$s3, 12($sp)
	sw	$s4, 8($sp)
	sw	$s5, 4($sp)
	sw	$s6, 0($sp)
	addu $fp, $sp, 36
	# grab the args and move into $s0..$s3 registers
	move $s0, $a0	# formated string
	move $s1, $a1	# arg1 (optional)
	move $s2, $a2	# arg2 (optional)
	move $s3, $a3	# arg3 (optional)
	li	$s4, 0	# set argument counter to zero
	la	$s6, printf_buf	# set s6 to base of printf buffer
main_loop:	# process chars in formated string
	lb	$s5, 0($s0)	# get next format flag
	addu $s0, $s0, 1	# increment $s0 to point to next char
	
	beq $s5, '%', printf_formated # branch to printf_formated if next char equals '%'
	beq $0, $s5, printf_end # branch to end if end of string reached
	
	sb	$s5, 0($s6)	# if here we can store the char(byte) in buffer
	sb	$0, 1($s6)	# store a null byte in the buffer
	move $a0, $s6	# prepare to make printf_str(4) syscall
	li	$v0, 4
	syscall
	b	main_loop	
printf_formated:
	lb	$s5, 0($s0)	# load the byte to see what formated char we have
	addu $s0, $s0, 1	
	beq $s4, 3, main_loop # if I reached maximum of args dont process anymore	
	beq $s5,'d', printf_int
	beq $s5,'s', printf_str
	b	main_loop	
printf_shift_args: # code to shift to next formated argument 
	move $s1,$s2
	move $s2,$s3
	add $s4,$s4,1
	b main_loop
printf_int:	#print decimal integer
	li $v0, 1
	move $a0,$s1
	syscall
	b	printf_shift_args #branch to printf_shift_args to process next arg

printf_str:
	li	$v0, 4
	move $a0, $s1	
	syscall
	b	printf_shift_args	# branch to shift_arg loop
printf_end:	# restore all the registers from stack
	lw $ra, 32($sp)
	lw $fp, 28($sp)
	lw	$s0, 24($sp)
	lw	$s1, 20($sp)
	lw	$s2, 16($sp)
	lw	$s3, 12($sp)
	lw	$s4, 8($sp)
	lw	$s5, 4($sp)
	lw	$s6, 0($sp)
	addu $sp, $sp, 36	# release the stack frame
	jr	$ra	# jump to the return address
