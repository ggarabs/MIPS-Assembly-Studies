.data
	passwordPrompt: .asciiz "Please enter your password: " 
	successMsg: .asciiz "Congratulations! Correct password!\n"
	failureMsg: .asciiz "Incorrect password. Please try again.\n\n"
	
.text
	li $s0, 123456789	# Inicialização da senha
	
	while:
	li $v0, 4
	la $a0, passwordPrompt
	syscall			# Impressão da mensagem para receber a tentativa do usuário
	
	li $v0, 5
	syscall			# Leitura da senha
	
	move $t1, $v0		# A senha digitada é armazenada no registrador $t1
	
	# Verificar se duas senhas são iguais: Bitwise XOR
	# Se dois bits são iguais, o bit resultante será 0
	# Logo, ao fim do caĺculo bit a bit, obtemos o valor 0 se as senhas coincidem
	xor $t1, $t1, $s0	# Armazeno o resultado do bitwise XOR entre a senha correta e a tentativa em $t1
	
	beqz $t1, fimWhile	# Se $t1 == 0, o laço se encerra
	
	li $v0, 4		# Caso contrário, imprime-se uma mensagem de erro
	la $a0, failureMsg
	syscall
	
	j while			# e pulamos para o início do bloco do laço
	
	fimWhile:
	
	# Se chegarmos nesse bloco, acertamos a senha e vamos imprimir uma mensagem apropriada
	li $v0, 4
	la $a0, successMsg
	syscall
	
	li $v0, 10		# Encerramento do programa
	syscall
