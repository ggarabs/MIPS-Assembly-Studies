.data
	decimalMsg: .asciiz "Digite um número na base decimal: "
	binarioMsg: .asciiz "O número em binário é: "
	binario: .space 32
	valorInvalido: .asciiz "Valor inválido!"
	
.text
	j main

decimal_para_binario:
	# Movo o argumento para uma outra variável de argumento, para utilizar o a0 para as operações de I/O
	move $a1, $a0

	# Imprime a mensagem para exibir um binário
	li $v0, 4
	la $a0, binarioMsg
	syscall

	li $t1, 0	# Carrego o iterador com o valor 0
	li $t2, 2	# Carrego a base 2
	
	beqz $t1, guarda_bit
	
	armazena:
	#Enquanto a1 não for dividido até chegar a zero,
	beqz $a1, imprime_binario
	
	guarda_bit:

	li $t3, 0
	li $t4, 0
			
	divu $a1, $t2
	mflo $a1	# Quociente
	mfhi $t0	# Resto
		
	sb $t0, binario($t1)	# O valor do resto é guardado na posição t1 do array
	addi $t1, $t1, 1	# Incremento o contador
	
	j armazena
	
	imprime_binario:
	# Ajusta o contador para começar a iterar de trás pra frente, tal como uma pilha
	subi $t1, $t1, 1
		
	lb $t0, binario($t1)	# Armazena em t0 o conteúdo de binario[t1]
	
	#Imprimo o valor de t0
	li $v0, 1
	move $a0, $t0
	syscall
	
	beqz $t1, fimFuncao	# se t1 = 0, encerro a função
		
	j imprime_binario
	
	fimFuncao:
	jr $ra
	
main:
	# Imprime a mensagem para receber um decimal
	li $v0, 4
	la $a0, decimalMsg
	syscall
	
	# Recebe um inteiro decimal
	li $v0, 5
	syscall
	
	# O inteiro lido é armazenado como argumento da função
	move $a0, $v0
	
	blt $a0, $zero, valor_invalido
		
	# Chamada de função
	jal decimal_para_binario
	
	j fim
	
	valor_invalido:
	li $v0, 4
	la $a0, valorInvalido
	syscall
	
	fim:
	li $v0, 10
	syscall