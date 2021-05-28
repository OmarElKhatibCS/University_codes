.data:
	header: .asciiz "****** Cars Information ******\n"
	str: .asciiz "Car name : %s\nCar Model : %s\nYear : %d\n"
	str2: .asciiz "Power : %d\nCylinder : %d\nConven : %d\n"
	carName: .asciiz "Porshe"
	carModel: .asciiz "Paka"
	carYear: .word 50
	carPower: .word 100
	carCylinder: .word 50
	carConv: .word 1
.text
main:
	la $a0 , header
	
	jal printf
	
	la $a0,str
	la $a1,carName
	la $a2,carModel
	lw $a3,carYear
	
	jal printf
	
	la $a0,str2
	lw $a1,carPower
	lw $a2,carCylinder
	lw $a3,carConv
	
	jal printf
	
	li $v0,10
	syscall
	
.include "printf.asm"