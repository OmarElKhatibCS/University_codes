# Copyright (c) 
# Author : Omar ElKhatib

# sturct size is
# 16*16+4*4 = 32+16 = 48
# lets say we can read up to 100 car , so 100*48 = 4800 byte
.data:
	menu_msg0 : .asciiz "enter 1 to add new car\n"
	menu_msg1 : .asciiz "enter 2 to load cars from file\n"
	menu_msg2 : .asciiz "enter 3 to save cars into a file\n"
	menu_msg3 : .asciiz "enter 4 to display cars from file\n"
	menu_msg4 : .asciiz "enter 5 to exit\n"
	menu_msg5 : .asciiz "your option : "
	
	in_str0:	.asciiz "Enter Number of cars : "
	in_str1:	.asciiz "Enter name : "
	in_str2:	.asciiz "Enter model : "
	in_str3:	.asciiz "Enter yearOfFabrication : "
	in_str4:	.asciiz "Enter cylindre : "
	in_str5:	.asciiz "Enter horsePower : "
	in_str6:	.asciiz "Enter convertible (0=No , 1=Yes) : "
	in_str7:	.asciiz "Enter fullPath/filename.extention : "

	# path should be Full path to the file
	fullFilePath: .space 125
	
	out_str1:	.asciiz "name : %smodel : %syearOfFabrication : %d\n"
	out_str2:	.asciiz "cylindre : %d\nhorsePower : %d\nconvertible (0=No , 1=Yes) : %d\n\n"
	
	carLogoP1: .asciiz "                     _______\n"
	carLogoP2: .asciiz "                    //  ||\\ \\\n"
	carLogoP3: .asciiz "              _____//___||_\\ \\___\n"
	carLogoP4: .asciiz "              )  _          _    \\\n"
	carLogoP5: .asciiz "              |_/ \\________/ \\___|\n"
	carLogoP6: .asciiz "________________\\_/________\\_/___________________\n"
	
	headerMessage: .asciiz "\n******** Cars DATA ********\n"
	newLine: .asciiz "\n"
	
	error_msg0: .asciiz "Failed to open file\n"
	error_msg1: .asciiz "No cars data found!\n"
	error_msg2: .asciiz "Table is Full , maybe save file and start new project with bigger size!\n"

.text:
main:
	jal carsArrayAllocator
	main_loop:
		jal carsMenu
		beq $s2,1,addCar
		beq $s2,2,loadCarsFromFile
		beq $s2,3,saveCarsInFile
		beq $s2,4,displayCarsData
		j main_loop

# $s0 : BASE_ADDRESS of array
# $s1 : pointer to next free address in array
# $s2 : menu option
# $s3 : contain number of cars
carsArrayAllocator:
	move $t0 , $ra # printf call will override it
	
	la $a0, in_str0
   	jal printf
   	
   	li $v0, 5
	syscall
	
	move $s3 , $v0 # N=$s3= number of cars
    	
   	mul $a0,$v0,48 # v0 contain number of cars
	li   $v0, 9      # sbrk code = 9
	syscall
	move $s0,$v0 # s0 contain start index of array
	move $s1,$s0 # in allocation start and end of array is 0
    	
	jr $t0

carsMenu:
	move $t0 , $ra # printf call will override it
	
	# printNewLine
	la $a0, newLine
	jal printf
	
	# print car logo
	la $a0, carLogoP1
	jal printf
	la $a0, carLogoP2
	jal printf
	la $a0, carLogoP3
	jal printf
	la $a0, carLogoP4
	jal printf
	la $a0, carLogoP5
	jal printf
	la $a0, carLogoP6
	jal printf
	
	# printNewLine
	la $a0, newLine
	jal printf

	# print menu options
	la $a0, menu_msg0
	jal printf
	la $a0, menu_msg1
	jal printf
	la $a0, menu_msg2
	jal printf
	la $a0, menu_msg3
	jal printf
	la $a0, menu_msg4
	jal printf
	# printNewLine
	la $a0, newLine
	jal printf
	la $a0, menu_msg5
	jal printf
	
	li $v0, 5
	syscall
	blt $v0, 1 , carsMenu
	bgt $v0, 5 , carsMenu
	beq $v0, 5 , end
	move $s2 , $v0
	
	jr $t0

addCar:
	jal isFullArray
	# readName
	la $a0, in_str1
	jal printf

	li $v0, 8
	la $a0,0($s1)
	li $a1, 16 # string max size
	syscall
	# readModel
	la $a0, in_str2
	jal printf

	li $v0, 8
	la $a0,16($s1)
	li $a1, 16 # string max size
	syscall
	# readYear
	la $a0, in_str3
	jal printf
	li $v0, 5
	syscall
	sw $v0,32($s1)
	# readCylindre
	la $a0, in_str4
	jal printf
	li $v0, 5
	syscall
	sw $v0,36($s1)
	# readHorsePower
	la $a0, in_str5
	jal printf
	li $v0, 5
	syscall
	sw $v0,40($s1)
	# readConvertible
	la $a0, in_str6
	jal printf
	li $v0, 5
	syscall
	sw $v0,44($s1)
	   	
	addi $s1,$s1,48 # struct size is 48 , so each time I fill a struct I move to next location
	
	b main_loop
	
saveCarsInFile:
	jal readFileName
	
	# Open (for writing) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fullFilePath # output file name
	li   $a1, 1       # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall            # open a file (file descriptor returned in $v0)
	blt $v0,0,failedToOpenFile # if we failed to open file
	move $s6, $v0      # save the file descriptor 

	# Write to file just opened
	li   $v0, 15       # system call for write to file
	move $a0, $s6      # file descriptor 
	move $a1, $s0      # address of buffer from which to write
	sub $a2,$s1,$s0	   # Buffer size is $s1-$s0 (end-start)
	syscall            # write to file

	# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
	
	b main_loop

loadCarsFromFile:
	jal isFullArray
	jal readFileName
	
	# Open (for read) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fullFilePath     # output file name
	li   $a1, 0       # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall            # open a file (file descriptor returned in $v0)
	blt $v0,0,failedToOpenFile # if we failed to open file
	move $s6, $v0      # save the file descriptor 

	# read from file just opened
	li   $v0, 14       # system call for reading to file
	move $a0, $s6      # file descriptor 
	move $a1, $s1      # append to current cars
	
	# calculate remaining size in array
	# left space in the array is N*48-(s1-s0)
	mul $t0,$s3,48
	sub $t1 , $s1 , $s0
	sub $t0,$t0,$t1
	
	move $a2, $t0	   # Buffer size is N*48 , 48 is size of car struct
	syscall            # read from file
	add $s1,$s1,$v0 # $v0 contain end of file

	# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
	
	b main_loop
	
displayCarsData:
	beq $s0,$s1,noCarsData
	move $t0,$s0 # store BASE_ADDRESS of the struct Array
	#print header message
	la $a0, headerMessage
	jal printf
	
	iterateOverCars_print:
		beq  $t0,$s1,end_iteration_print # reach end of array
		
		# display using fmt string
		la $a0, out_str1
		la $a1,  0($t0)
		la $a2, 16($t0)
		lw $a3, 32($t0)
		jal printf
		
		# display using fmt string
		la $a0, out_str2
		lw $a1, 36($t0)
		lw $a2, 40($t0)
		lw $a3, 44($t0)
		jal printf
   	
	addi $t0,$t0,48 # struct size is 48 , so each time I fill a struct I move to next location
	j iterateOverCars_print
	end_iteration_print:
		b main_loop

readFileName:
	move $t0 , $ra # printf call will override it
	move $a2, $0
	# readName
	la $a0, in_str7
	jal printf

	li $v0, 8
	la $a0,fullFilePath
	li $a1, 125 # string max size
	syscall
	
	# This method will remove new Line when reading file path
	removeNewLineFromString:
    		lbu $a3, fullFilePath($a2)  
    		addiu $a2, $a2, 1
    		bnez $a3, removeNewLineFromString       # Search the NULL char code
    		beq $a1, $a2, end_removeNewLineFromString   # Check whether the buffer was fully loaded
    		subiu $a2, $a2, 2    # Otherwise 'remove' the last character
    		sb $0, fullFilePath($a2)     # and put a NULL instead
    	
	end_removeNewLineFromString:
	jr $t0

isFullArray:
	sub $t0,$s1,$s0 # Number of cars in the array is (s1-s0)/48
	div $t0,$t0,48
	beq $t0,$s3,fullTable # in array length same as cars dont add
	jr $ra
	
fullTable:
	la $a0, error_msg2
	jal printf
	
	b main_loop
	
failedToOpenFile:
	la $a0, error_msg0
	jal printf
	
	b main_loop
noCarsData:
	la $a0, error_msg1
	jal printf
	
	b main_loop
end:
	li $v0,10
	syscall

.include "printf.asm"