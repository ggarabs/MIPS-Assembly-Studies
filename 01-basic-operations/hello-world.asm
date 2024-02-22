.data
	msg: .asciiz "Hello World!"
	
.text
	#IMPRIMIR UMA STRING NA TELA
	li $v0, 4
	la $a0, msg
	syscall
	
	#FINALIZAR O PROGRAMA
	li $v0, 10
	syscall

