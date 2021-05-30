# Copyright (c) 
# Author : Omar ElKhatib

# accept maximum of 3 args
# $s0 contain $a0 - string
# $s1 contain $a1 - argument 1
# $s2 contain $a2 - argument 2
# $s3 contain $a3 - argument 3
# to call it from external file use jal printf
.text
.globl printf
printf:
	b printf_backup_registers
	printf_main:	# process chars in formated string
		lb	$s5, 0($s0)	# get first char in string
	
		beq 	$s5, '%', printf_formated # branch to printf_formated if next char equals '%'
		beq 	$0, $s5, printf_end # branch to end if end of string reached
		li 	$v0, 11 # print character
		addi 	$s0, $s0, 1 # move to next character in string
		move 	$a0,$s5
		syscall
		b	printf_main	
printf_formated:
	addi 	$s0, $s0, 1 # move to next character after %
	lb	$s5, 0($s0)	# we have here the type to print either d or s
	addi 	$s0, $s0, 1 # move to next character in string
	
	beq 	$s4, 3, printf_main # if I reached maximum of args dont do anything
	beq 	$s5,'d', printf_int
	beq 	$s5,'s', printf_str
	b	printf_main	
printf_int:	#print decimal integer
	li 	$v0, 1
	move 	$a0,$s1
	syscall
	b	printf_load_next_arg #branch to printf_shift_args to process next arg

printf_str:
	li	$v0, 4
	move 	$a0, $s1	
	syscall
	b	printf_load_next_arg	# branch to shift_arg loop
printf_load_next_arg: # put next arg in s1 , so printf_int and printf_str can read it
	move 	$s1,$s2
	move 	$s2,$s3
	add 	$s4,$s4,1
	b 	printf_main
printf_end:	# restore all the registers from stack
	lw 	$ra, 28($sp)
	lw 	$fp, 24($sp)
	lw	$s0, 20($sp)
	lw	$s1, 16($sp)
	lw	$s2, 12($sp)
	lw	$s3, 8($sp)
	lw	$s4, 4($sp)
	lw	$s5, 0($sp)
	addu 	$sp, $sp, 32	# release the stack frame
	jr	$ra	# jump to the return address

printf_backup_registers:
	subu 	$sp, $sp, 32	# setup stack frame
	sw	$ra, 28($sp)	# backup all used registers by printf
	sw	$fp, 24($sp)
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$s5, 0($sp)
	addu 	$fp, $sp, 32
	# grab the args and move into $s0..$s3 registers
	move 	$s0, $a0	# formated string
	move 	$s1, $a1	# arg1 (optional)
	move 	$s2, $a2	# arg2 (optional)
	move 	$s3, $a3	# arg3 (optional)
	li	$s4, 0	# set argument counter to zero
	
	j printf_main
