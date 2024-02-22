.data
	msg1: .asciiz "Digite o 1o numero: "
	msg2: .asciiz "Digite o 2o numero: "
	msg3: .asciiz "O resultado eh: "

.text
	#IMPRIMIR UMA STRING
	li $v0, 4
	la $a0, msg1
	syscall
	
	#RECEBER UM INTEIRO (FICA GUARDADO NO REGISTRADOR v0)
	li $v0, 5
	syscall
	
	#MOVER O CONTEÚDO DE v0 PARA UM REGISTRADOR TEMPORÁRIO t0
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	#SOMAR t0 E t1 E MOVER O RESULTADO PARA O REGISTRADOR t2
	add $t2, $t0, $t1
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	#IMPRIMIR UM INTEIRO (FICA GUARDADO EM a0)
	li $v0, 1
	move $a0, $t2
	syscall
	
	#FINALIZAR O PROGRAMA
	li $v0, 10
	syscall
