# Copyright (c) 
# Author : Omar ElKhatib

# sturct size is
# 16*16+4*4 = 32+16 = 48
# lets say we can read up to 100 car , so 100*48 = 4800 byte
.data:
	str0:	.asciiz "Enter Number of cars : "
	str1:	.asciiz "Enter name : "
	str2:	.asciiz "Enter model : "
	str3:	.asciiz "Enter yearOfFabrication : "
	str4:	.asciiz "Enter cylindre : "
	str5:	.asciiz "Enter horsePower : "
	str6:	.asciiz "Enter convertible (0=No , 1=Yes) : "
	# path should be Full path to where I want to save my data
	#fileName: .asciiz "C:\\Users\\Administrator\\Documents\\University_codes\\I2207\\project\\cars.dump"
	fileName: .asciiz "/home/omarlap/Documents/University_codes/I2207/project/cars.dump"
	newLine: .asciiz "\n"
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
# $t2 : Counter i
carsArrayAllocator:
	li $v0, 4
	la $a0, str0
   	syscall
   	li $v0, 5
    	syscall
    	
   	move $t1,$v0 # N = Number of cars
	li   $v0, 9      # sbrk code = 9
    	move $a0,$t1
    	mul $a0,$a0,48
    	syscall
    	move $s0,$v0 # s0 contain start index of array
fillCars:
	move $t2,$0 # i = 0
	move $t0,$s0 # $t0 will be modified each love , so $s0 will still the same
	iterateOverCars:
	beq  $t2,$t1,saveCarsInFile # if i == N end
	# readName
		li $v0, 4
		la $a0, str1
	   	syscall
	
		li $v0, 8
		la $a0,0($t0)
	        li $a1, 16 # string max size
	        syscall
	# readModel
		li $v0, 4
		la $a0, str2
	   	syscall
	
		li $v0, 8
		la $a0,16($t0)
	        li $a1, 16 # string max size
	        syscall
	# readYear
		li $v0, 4
		la $a0, str3
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,32($t0)
	# readCylindre
		li $v0, 4
		la $a0, str4
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,36($t0)
	# readHorsePower
		li $v0, 4
		la $a0, str5
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,40($t0)
	# readConvertible
		li $v0, 4
		la $a0, str6
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,44($t0)
	   	
	addi $t0,$t0,48 # struct size is 48 , so each time I fill a struct I move to next location
	addi $t2,$t2,1 # i++
	j iterateOverCars
saveCarsInFile:
	# Open (for writing) a file that does not exist
	li   $v0, 13       # system call for open file
	la   $a0, fileName # output file name
	li   $a1, 1       # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	# Write to file just opened
	li   $v0, 15       # system call for write to file
	move $a0, $s6      # file descriptor 
	move $a1, $s0      # address of buffer from which to write
	mul $a2,$t1,48	   # Buffer size is N*48 , 48 is size of car struct
	syscall            # write to file

	# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
end:
	li $v0,10
	syscall
