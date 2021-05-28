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

	# path should be Full path to where I want to save my data
	#fileName: .asciiz "C:\\Users\\Administrator\\Documents\\University_codes\\I2207\\project\\cars.dump"
	fileName: .asciiz "/home/omarlap/Documents/University_codes/I2207/project/cars.dump"
	
	out_str1:	.asciiz "name : "
	out_str2:	.asciiz "model : "
	out_str3:	.asciiz "yearOfFabrication : "
	out_str4:	.asciiz "cylindre : "
	out_str5:	.asciiz "horsePower : "
	out_str6:	.asciiz "convertible (0=No , 1=Yes) : "
	
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
	li $v0, 4
	la $a0, in_str0
   	syscall
   	li $v0, 5
	syscall
	
	move $s3 , $v0 # N=$s3= number of cars
    	
   	mul $a0,$v0,48 # v0 contain number of cars
	li   $v0, 9      # sbrk code = 9
	syscall
	move $s0,$v0 # s0 contain start index of array
	move $s1,$s0 # in allocation start and end of array is 0
    	
	jr $ra

carsMenu:
	# printNewLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	# print car logo
	la $a0, carLogoP1
	syscall
	la $a0, carLogoP2
	syscall
	la $a0, carLogoP3
	syscall
	la $a0, carLogoP4
	syscall
	la $a0, carLogoP5
	syscall
	la $a0, carLogoP6
	syscall
	
	# printNewLine
	la $a0, newLine
	syscall

	# print menu options
	la $a0, menu_msg0
	syscall
	la $a0, menu_msg1
	syscall
	la $a0, menu_msg2
	syscall
	la $a0, menu_msg3
	syscall
	la $a0, menu_msg4
	syscall
	# printNewLine
	la $a0, newLine
	syscall
	la $a0, menu_msg5
	syscall
	
	li $v0, 5
	syscall
	blt $v0, 1 , carsMenu
	bgt $v0, 5 , carsMenu
	beq $v0, 5 , end
	move $s2 , $v0
	
	jr $ra

addCar:
	# readName
	li $v0, 4
	la $a0, in_str1
	syscall

	li $v0, 8
	la $a0,0($s1)
	li $a1, 16 # string max size
	syscall
	# readModel
	li $v0, 4
	la $a0, in_str2
	syscall

	li $v0, 8
	la $a0,16($s1)
	li $a1, 16 # string max size
	syscall
	# readYear
	li $v0, 4
	la $a0, in_str3
	syscall
	li $v0, 5
	syscall
	sw $v0,32($s1)
	# readCylindre
	li $v0, 4
	la $a0, in_str4
	syscall
	li $v0, 5
	syscall
	sw $v0,36($s1)
	# readHorsePower
	li $v0, 4
	la $a0, in_str5
	syscall
	li $v0, 5
	syscall
	sw $v0,40($s1)
	# readConvertible
	li $v0, 4
	la $a0, in_str6
	syscall
	li $v0, 5
	syscall
	sw $v0,44($s1)
	   	
	addi $s1,$s1,48 # struct size is 48 , so each time I fill a struct I move to next location
	
	b main_loop
	
saveCarsInFile:
	# Open (for writing) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fileName # output file name
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
	# Open (for read) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fileName     # output file name
	li   $a1, 0       # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall            # open a file (file descriptor returned in $v0)
	blt $v0,0,failedToOpenFile # if we failed to open file
	move $s6, $v0      # save the file descriptor 

	# read from file just opened
	li   $v0, 14       # system call for reading to file
	move $a0, $s6      # file descriptor 
	move $a1, $s1      # append to current cars
	mul $a2,$s3,48	   # Buffer size is N*48 , 48 is size of car struct
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
	li $v0, 4
	la $a0, headerMessage
	syscall
	
	iterateOverCars_print:
		beq  $t0,$s1,end_iteration_print # reach end of array
		
		# printName
		li $v0, 4
		la $a0, out_str1
		syscall
		
		li $v0, 4
		la $a0, 0($t0)
		syscall
		
		# printModel
		li $v0, 4
		la $a0, out_str2
		syscall
		
		li $v0, 4
		la $a0, 16($t0)
		syscall
		
		# printYear
		li $v0, 4
		la $a0, out_str3
		syscall
		
		li $v0, 1
		lw $a0, 32($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		# printCylinder
		li $v0, 4
		la $a0, out_str4
		syscall
		
		li $v0, 1
		lw $a0, 36($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		# printPower
		li $v0, 4
		la $a0, out_str5
		syscall
		
		li $v0, 1
		lw $a0, 40($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		# printConvertible
		li $v0, 4
		la $a0, out_str6
		syscall
		
		li $v0, 1
		lw $a0, 44($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		# printNewLine
		li $v0, 4
		la $a0, newLine
		syscall
   	
	addi $t0,$t0,48 # struct size is 48 , so each time I fill a struct I move to next location
	j iterateOverCars_print
	end_iteration_print:
		b main_loop
failedToOpenFile:
	li $v0, 4
	la $a0, error_msg0
	syscall
	
	b main_loop
noCarsData:
	li $v0, 4
	la $a0, error_msg1
	syscall
	
	b main_loop
end:
	li $v0,10
	syscall
