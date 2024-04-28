.data
	prompt: .asciiz "Digite a quantidade de nós a serem criados: "
	promptInputNode: .asciiz "Digite o valor do nó "
	twoPoints: .asciiz ": "

.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 1
	
	li $v0, 9
	li $a0, 8
	syscall
	
	move $s1, $v0
	move $s0, $s1
	
	addi $s1, $s1, 4
	
	loopRecebeDados:
		li $v0, 4
		la $a0, promptInputNode
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0, twoPoints
		syscall
		
		li $v0, 5
		syscall
		move $t3, $v0
		
		li $v0, 9
		li $a0, 8
		syscall
		
		move $s2, $v0
		sw $t2, 0($s2)
				
		sw $s2, 0($s1)
		
		addi $s1, $s1, 4				
		addi $t1, $t1, 1
		
		bgt $t1, $t0, loopImprim
		
		j loopRecebeDados
		
	fimLoopRecebeDados:
	
	loopImprime
	
	li $v0, 10
	syscall