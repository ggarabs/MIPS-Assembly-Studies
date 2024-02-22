.data
	msg1: .asciiz "Digite o primeiro número: "
	msg2: .asciiz "Digite o segundo número: "
	msg_soma: .asciiz "Soma = "
	msg_sub: .asciiz "\nSubtração = "
	msg_prod: .asciiz "\nMultiplicação = "
	msg_div: .asciiz "\nQuociente = "
	msg_mod: .asciiz "\nResto = "

.text
	#Imprimir uma String constante
	li $v0, 4
	la $a0, msg1
	syscall
	
	#Ler um inteiro
	li $v0, 5
	syscall
	
	#Guardar o valor do inteiro lido
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	li $v0, 4
	la $a0, msg_soma
	syscall
	
	#Imprimir um inteiro
	li $v0, 1
	add $a0, $t0, $t1
	syscall
	
	li $v0, 4
	la $a0, msg_sub
	syscall
	
	li $v0, 1
	sub $a0, $t0, $t1
	syscall
	
	li $v0, 4
	la $a0, msg_prod
	syscall
	
	li $v0, 1
	mul $a0, $t0, $t1
	syscall
	
	#DIVISÃO: HI é resto e LO é quociente
	div $t0, $t1
	mflo $t2
	mfhi $t3
	
	li $v0, 4
	la $a0, msg_div
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, msg_mod
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
		
	#Finalizar o programa
	li $v0, 10
	syscall
