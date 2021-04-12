# Student : Omar ElKhatib
# TP 1 - Exercice 2
.data
	inputMsg : .asciiz "Enter a number baliz: "
	lessMsg : .asciiz "The Number you enter is less than what is in my head :)\n"
	moreMsg : .asciiz "The Number you enter is bigger than what is in my head :)\n"
	winMsg  : .asciiz "Congrats you guess the number!\n"
	newLine : .asciiz "\n"
.text
main:
	# BEGIN OF GENERATE A RANDOM INT
	li $v0, 42 # Asking to generate RANDOM Value
	li $a1, 40 # FROM 0 to 40
	syscall # Will return RANDOM in the register a0
	
	move $t0 , $a0 # store random INT in $t3
	# END OF GENERATE RANDOM INT

	# Printing NUMBER for Debugging ONLY
	# Comment in case you dont want to see the generated NUMBER
	li $v0, 1
	syscall
	li $v0, 4
    	la $a0, newLine
    	syscall
	
	loop:
		# Begin OF printing INPUT MSG
    		li $v0, 4
    		la $a0, inputMsg
    		syscall
		# END OF printing INPUT MSG
		
		# BEGIN OF READ INT
    		li $v0, 5
    		syscall
    		# END OF READ INT
		move $t1, $v0 # Saving answer into $t1
		
		li $v0, 32 # sleep $a0 seconds
		li $a0, 3  # sleep for 3 seconds
		syscall
		
		blt  $t1 , $t0 , printLess
		bgt  $t1 , $t0 , printMore
		beq  $t1 , $t0 , printWIN
		
	printWIN:
		# Begin OF printing WIN MSG
    		li $v0, 4
    		la $a0, winMsg
    		syscall
		# END OF printing WIN MSG
		j done
	printLess:
		# Begin OF printing LESS MSG
    		li $v0, 4
    		la $a0, lessMsg
    		syscall
		# END OF printing  LESS MSG
		
		j loop
	printMore:
		# Begin OF printing MORE MSG
    		li $v0, 4
    		la $a0, moreMsg
    		syscall
		# END OF printing MORE MSG
		
		j loop
	done:
