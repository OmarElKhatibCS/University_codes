# Student : Omar ElKhatib
# TP 1 - Exercice 1

.data:
	inputMsg:  .asciiz "Enter String baliz : "
	outputMsg: .asciiz "Length of your string is : "
	theString: .space 64	# theString can contain at MAX 64 character

.text:
main:	
	# Begin OF printing MSG
    	li $v0, 4
    	la $a0, inputMsg
    	syscall
	# END OF printing MSG
	
	# BEGIN OF READING STRING
	li      $v0, 8	
	la      $t0, theString	# store pointer to theString in $t0
	move	$a0 , $t0	# moving $t0 to $a0 becayse syscall require it
	li      $a1, 64		# Maximum length that we can read	
	syscall
	# END OF READING STRING

	loop:
    		lb   $t1 0($t0)		# LOAD current character into $t1
    		beqz $t1 done		# Check if the current character is equal to \0 , if yes it will end programm
    		addi $t0 $t0 1		# Increment $t0 by 1 (size of character) so it can be accesed in next loop
    		addi $t2 $t2 1		# Increment $t2 (initialy 0) by 1 , so it behave like a counter
    		j loop			# Continue looping
	done:
	
	subi $t2 , $t2 , 1 # SUB 1 because the programm counting also the \n 
	
	# Begin OF printing MSG
    	li $v0, 4
    	la $a0, outputMsg
    	syscall
	# END OF printing MSG
	
	# BEGIN OF PRINTING INTEGER
	li $v0, 1
	move $a0, $t2	# The length is stored in $t2
	syscall
	# END OF PRINTING INTEGER