.data
	msg_recebe_n: .asciiz "Digite o número de termos: "
	msg_termos: .asciiz "Sequencia: "
	msg_valor_invalido: .asciiz "Valor inválido!\n"
	comma: .asciiz ", "

.text
	j main

fibonacci:
	blez $a1, valor_invalido	# SE O VALOR FOR MENOR OU IGUAL A ZERO, IMPRIMO UMA MSG E SAIO
	
	li $v0, 4			# IMPRIME A MSG "Sequencia: "
	la $a0, msg_termos
	syscall
	
	li $t0, 0			# Termo F(x-1)
	li $t1, 1			# Termo F(x)
	li $t2, 0			# Contador
	
	li $v0, 1			# IMPRIME F(0)
	move $a0, $t0
	syscall
	
	addi $t2, $t2, 1

	beq $a1, $t2, fim_fibonacci	# SE N = 1, SAI

	li $v0, 4
	la $a0, comma
	syscall

	li $v0, 1			# IMPRIME F(1)
	move $a0, $t1
	syscall
	
	addi $t2, $t2, 1
	
	beq $a1, $t2, fim_fibonacci	# SE N = 2, SAI
			
	loop:
	li $v0, 4
	la $a0, comma
	syscall
	
	move $t3, $t0			# GUARDO O ANTIGO VALOR DE t0 EM t3 PRA UTILIZAR NA SOMA DE F(x)
	move $t0, $t1			# F(x-1) = F(x)
	add $t1, $t1, $t3		# F(x) = F(x-1) + F(x-2)
	
	li $v0, 1			# IMPRIMO F(x)
	move $a0, $t1
	syscall
	
	addi $t2, $t2, 1
	
	blt $t2, $a1, loop		# SE CHEGUEI NO NÚMERO DESEJADO DE TERMOS, SAIO
	
	j fim_fibonacci
	
	valor_invalido:
	li $v0, 4
	la $a0, msg_valor_invalido
	syscall
	
	fim_fibonacci:
	jr $ra

main:
	li $v0, 4
	la $a0, msg_recebe_n
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0	# a1 GUARDA O NUMERO DE TERMOS DESEJADOS DA SEQUENCIA
	
	jal fibonacci
	
	li $v0, 10	# FIM DO PROGRAMA
	syscall