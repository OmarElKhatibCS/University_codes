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
.text:
main:
# Dynamically allocate space for a car
#carStructAllocator:
#	li      $v0, 9      # sbrk code = 9
#    	li      $a0, 48     # 16*2*char + 2*int = 48 bytes
#    	syscall
#	move $t0,$v0

# $t0 : BASE_ADDRESS of array
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
    	syscall
    	move $t0,$v0 # t0 contain start index of array
fillCars:
	move $t2,$0 # i = 0
	iterateOverCars:
	beq  $t2,$t1,end # if i == N end
	readName:
		li $v0, 4
		la $a0, str1
	   	syscall
	
		li $v0, 8
		la $a0,0($t0)
	        li $a1, 16 # string max size
	        syscall
	readModel:
		li $v0, 4
		la $a0, str2
	   	syscall
	
		li $v0, 8
		la $a0,16($t0)
	        li $a1, 16 # string max size
	        syscall
	readYear:
		li $v0, 4
		la $a0, str3
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,32($t0)
	readCylindre:
		li $v0, 4
		la $a0, str4
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,36($t0)
	readHorsePower:
		li $v0, 4
		la $a0, str5
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,40($t0)
	readConvertible:
		li $v0, 4
		la $a0, str6
	   	syscall
	   	li $v0, 5
	    	syscall
	   	sw $v0,44($t0)
	   	
	addi $t0,$t0,48 # struct size is 48 , so each time I fill a struct I move to next location
	addi $t2,$t2,1 # i++
	j iterateOverCars
end:
	li $v0,10
	syscall