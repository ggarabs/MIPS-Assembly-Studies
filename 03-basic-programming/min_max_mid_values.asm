.data
	msg1: .asciiz "Digite o 1º número: "
	msg2: .asciiz "Digite o 2º número: "
	msg3: .asciiz "Digite o 3º número: "
	msgMaior: .asciiz "Maior valor: "
	msgIntermediario: .asciiz "Valor intermediário: "
	msgMenor: .asciiz "Menor valor: "
	linebreak: .asciiz "\n"

.text
	j main
	
	print_integer:
	li $v0, 1
	syscall
	jr $ra

	print_string:
	li $v0, 4
	syscall
	jr $ra
	
	read_integer:
	li $v0, 5
	syscall
	jr $ra
	
	swap:			# função que troca os valores de duas variáveis
	move $t0, $a0		# t0 é um registrador auxiliar para realizar a troca
	move $a0, $a1
	move $a1, $t0
	jr $ra
	
	exit:
	li $v0, 10
	syscall

	main:
	
	la $a0, msg1		# imprimo a msg1
	jal print_string
	
	jal read_integer	
	move $s0, $v0		# o primeiro número digitado pelo usuário é movido para s0
	
	la $a0, msg2		# imprimo a msg2
	jal print_string
	
	jal read_integer
	move $s1, $v0		# o segundo número digitado pelo usuário é movido para s1
	
	la $a0, msg3		# imprimo a msg3
	jal print_string
	
	jal read_integer
	move $s2, $v0		# o terceiro número digitado pelo usuário é movido para s2
	
	bgt $s0, $s1, s0_maior_s1	# se s0 > s1, não é preciso fazer o swap e pulo para a próxima comparação
	
	move $a0, $s0
	move $a1, $s1
	jal swap
	move $s0, $a0		# movo os argumentos para os registradores que guardam os números
	move $s1, $a1
	
	s0_maior_s1:
	
	bgt $s0, $s2, s0_maior_s2	# se s0 > s2, não é preciso fazer o swap e pulo para a próxima comparação
	
	move $a0, $s0
	move $a1, $s2
	jal swap
	move $s0, $a0		# movo os argumentos para os registradores que guardam os números
	move $s2, $a1
	
	s0_maior_s2:
	
	bgt $s1, $s2, s1_maior_s2	# se s1 > s2, não é preciso fazer o swap e pulo para a próxima comparação
	
	move $a0, $s1
	move $a1, $s2
	jal swap
	move $s1, $a0		# movo os argumentos para os registradores que guardam os números
	move $s2, $a1
	
	s1_maior_s2:
	
	# feitas as trocas, s0 > s1 > s2.
	
	la $a0, msgMaior
	jal print_string
	
	move $a0, $s0		# imprimo o maior valor
	jal print_integer
	
	la $a0, linebreak	# quebra de linha
	jal print_string

	la $a0, msgIntermediario
	jal print_string
	
	move $a0, $s1		# imprimo o valor intermediário
	jal print_integer
	
	la $a0, linebreak	# quebra de linha
	jal print_string
	
	la $a0 , msgMenor
	jal print_string
	
	move $a0, $s2		# imprimo o menor valor
	jal print_integer
	
	la $a0 , linebreak	# quebra de linha
	jal print_string
	
	jal exit
