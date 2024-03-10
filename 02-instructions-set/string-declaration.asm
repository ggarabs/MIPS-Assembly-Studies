.data
	input:		.space 81	# 81 bytes de memória contíguos
	inputSize:	.word 80
	prompt:		.asciiz "Digite uma string: "
	output:		.asciiz "A string digitada foi: "

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Ler uma string
	li $v0, 8
	la $a0, input		# Endereço de memória onde vai ser guardada a string
	lw $a1, inputSize	# Tamanho da string
	syscall
	
	li $v0, 4
	la $a0, output
	syscall
	
	la $a0, input
	syscall
	
	li $v0, 10
	syscall