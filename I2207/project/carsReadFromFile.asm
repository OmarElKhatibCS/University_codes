# Copyright (c) 
# Author : Omar ElKhatib

# sturct size is
# 16*16+4*4 = 32+16 = 48
# lets say we can read up to 100 car , so 100*48 = 4800 byte
.data:
	str0:	.asciiz "Enter Number of cars : "
	str1:	.asciiz "name : "
	str2:	.asciiz "model : "
	str3:	.asciiz "yearOfFabrication : "
	str4:	.asciiz "cylindre : "
	str5:	.asciiz "horsePower : "
	str6:	.asciiz "convertible (0=No , 1=Yes) : "
	# path should be Full path to where I want to save my data
	#fileName: .asciiz "C:\\Users\\Administrator\\Documents\\University_codes\\I2207\\project\\cars.dat"
	fileName: .asciiz "/home/omarlap/Documents/University_codes/I2207/project/cars.dump"
	newLine: .asciiz "\n"
	
	carP1: .asciiz "                     _______\n"
	carP2: .asciiz "                    //  ||\\ \\\n"
	carP3: .asciiz "              _____//___||_\\ \\___\n"
	carP4: .asciiz "              )  _          _    \\\n"
	carP5: .asciiz "              |_/ \\________/ \\___|\n"
	carP6: .asciiz "________________\\_/________\\_/___________________\n"
	
	headerMessage: .asciiz "\n******** Cars DATA ********\n"
.text:
main:
# Dynamically allocate space for a car
#carStructAllocator:
#	li      $v0, 9      # sbrk code = 9
#    	li      $a0, 48     # 16*2*char + 2*int = 48 bytes
#    	syscall
#	move $t0,$v0

# $s0 : BASE_ADDRESS of array
# $t1 : Number of cars N
carsArrayAllocator:    	
	li   $v0, 9      # sbrk code = 9
    	li $a0,4800 # can read maximum of 100 car
    	syscall
    	move $s0,$v0 # s0 contain start index of array
readCarsFromFile:
	# Open (for read) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fileName     # output file name
	li   $a1, 0       # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	# read from file just opened
	li   $v0, 14       # system call for reading to file
	move $a0, $s6      # file descriptor 
	move $a1, $s0      # address of buffer from which to read
	li $a2,4800	   # Buffer size is N*48 , 48 is size of car struct
	syscall            # read from file
	move $s1,$v0 	   # s1 contain place of EOF

	# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
	
printCarsData:
	move $t0,$s0 # store BASE_ADDRESS of the struct Array
	printCar:
		li $v0, 4
		la $a0, carP1
		syscall
		li $v0, 4
		la $a0, carP2
		syscall
		li $v0, 4
		la $a0, carP3
		syscall
		li $v0, 4
		la $a0, carP4
		syscall
		li $v0, 4
		la $a0, carP5
		syscall
		li $v0, 4
		la $a0, carP6
		syscall
	printHeader:
		li $v0, 4
		la $a0, headerMessage
		syscall
	iterateOverCars:
		beq  $s1,$zero,end # reach end of file
		
		printName:
		li $v0, 4
		la $a0, str1
		syscall
		
		li $v0, 4
		la $a0, 0($t0)
		syscall
		
		printModel:
		li $v0, 4
		la $a0, str2
		syscall
		
		li $v0, 4
		la $a0, 16($t0)
		syscall
		
		printYear:
		li $v0, 4
		la $a0, str3
		syscall
		
		li $v0, 1
		lw $a0, 32($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		printCylinder:
		li $v0, 4
		la $a0, str4
		syscall
		
		li $v0, 1
		lw $a0, 36($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		printPower:
		li $v0, 4
		la $a0, str5
		syscall
		
		li $v0, 1
		lw $a0, 40($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		printConvertible:
		li $v0, 4
		la $a0, str6
		syscall
		
		li $v0, 1
		lw $a0, 44($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		printNewLine:
		li $v0, 4
		la $a0, newLine
		syscall
   	
	addi $t0,$t0,48 # struct size is 48 , so each time I fill a struct I move to next location
	subi $s1,$s1,48 # each time I read a struct deacrese EOF
	j iterateOverCars
end:
	li $v0,10
	syscall
