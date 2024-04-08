.data
	vetor: .word 2, -5, 12, 7, -3, 99, 8, 54, 21, -45, 67, 61, 55
	tamanho: .word 13
	msgMostraVetor: .asciiz "O vetor original é: ["
	fechaColchetes: .asciiz "]"
	virgula: .asciiz ", "
	quebraLinha: .asciiz "\n"
	msgMostraMaior: .asciiz "O maior elemento do vetor é: "
	msgMostraMenor: .asciiz "O menor elemento do vetor é: "
	msgMostraMedia: .asciiz "A média dos elementos do vetor é: "
	promptBuscaValor: .asciiz "Digite um número: "
	msgEncontrou: .asciiz "Número encontrado no vetor!"
	msgNaoEncontrou: .asciiz "Número não encontrado no vetor!"

.text
	j main
	
	mostra_vetor:
		li $v0, 4
		la $a0, msgMostraVetor
		syscall
	
		li $t1, 0		# CONTADOR
		lw $t2, tamanho
	
		loop_mostra_vetor:
			lw $t0, 0($a1)
	
			li $v0, 1
			move $a0, $t0
			syscall
	
			addi $t1, $t1, 1
			addi $a1, $a1, 4
		
			beq $t1, $t2, fim_mostra_vetor
	
			li $v0, 4
			la $a0, virgula
			syscall
		
			j loop_mostra_vetor
	
		fim_mostra_vetor:
			li $v0, 4
			la $a0, fechaColchetes
			syscall
	
			li $v0, 4
			la $a0, quebraLinha
			syscall
	
		jr $ra
	
	busca_maior:
		li $v0, 4
		la $a0, msgMostraMaior
		syscall
		
		li $t1, 0		# CONTADOR
		lw $t2, tamanho
		lw $t3, 0($a1)		# MAIOR
		
		loop_busca_maior:
			lw $t0, 0($a1)
			
			bgt $t3, $t0, analisa_proximo_maior
			
			move $t3, $t0
			
			analisa_proximo_maior:
			addi $t1, $t1, 1
			addi $a1, $a1, 4
			
			beq $t1, $t2, fim_busca_maior
			
			j loop_busca_maior
			
		fim_busca_maior:
			li $v0, 1
			move $a0, $t3
			syscall
			
			li $v0, 4
			la $a0, quebraLinha
			syscall
					
		jr $ra
		
	busca_menor:
		li $v0, 4
		la $a0, msgMostraMaior
		syscall
		
		li $t1, 0		# CONTADOR
		lw $t2, tamanho
		lw $t3, 0($a1)		# MENOR
		
		loop_busca_menor:
			lw $t0, 0($a1)
			
			blt $t3, $t0, analisa_proximo_menor
			
			move $t3, $t0
			
			analisa_proximo_menor:
			addi $t1, $t1, 1
			addi $a1, $a1, 4
			
			beq $t1, $t2, fim_busca_menor
			
			j loop_busca_menor
			
		fim_busca_menor:
			li $v0, 1
			move $a0, $t3
			syscall
			
			li $v0, 4
			la $a0, quebraLinha
			syscall
		
		jr $ra
		
	calcula_media:
		li $v0, 4
		la $a0, msgMostraMedia
		syscall
		
		li $t1, 0		# CONTADOR
		lw $t2, tamanho
		mtc1 $t1, $f0
		cvt.s.w $f0, $f0	# SOMA
		
		loop_calcula_media:
			lw $t0, 0($a1)
			mtc1 $t0, $f1
			cvt.s.w $f1, $f1
			
			add.s $f0, $f0, $f1
			addi $t1, $t1, 1
			addi $a1, $a1, 4
			
			beq $t1, $t2, fim_calcula_media
			
			j loop_calcula_media
			
		fim_calcula_media:
			mtc1 $t2, $f1
			cvt.s.w $f1, $f1
			div.s $f0, $f0, $f1
		
			li $v0, 2
			mov.s $f12, $f0
			syscall
			
			li $v0, 4
			la $a0, quebraLinha
			syscall
		
		jr $ra
		
	busca_valor:
		li $v0, 4
		la $a0, promptBuscaValor
		syscall
		
		li $v0, 5
		syscall
		move $a0, $v0
	
		li $t1, 0
		lw $t2, tamanho
		
		loop_busca_valor:
			lw $t0, 0($a1)
			
			beq $a0, $t0, encontrou
		
			addi $t1, $t1, 1
			addi $a1, $a1, 4
			
			beq $t1, $t2, nao_encontrou
			
			j loop_busca_valor
			
		encontrou:
			li $v0, 4
			la $a0, msgEncontrou
			syscall
			
			j fim_busca
		
		nao_encontrou:
			li $v0, 4
			la $a0, msgNaoEncontrou
			syscall
		
		fim_busca:
			li $v0, 4
			la $a0, quebraLinha
			syscall
			
		jr $ra
		
	main:
		la $a1, vetor
		lw $s0, tamanho
		mul $s0, $s0, 4
	
		jal mostra_vetor
		sub $a1, $a1, $s0
		
		jal busca_maior
		sub $a1, $a1, $s0
		
		jal busca_menor
		sub $a1, $a1, $s0
		
		jal calcula_media
		sub $a1, $a1, $s0
				
		jal busca_valor

		li $v0, 10
		syscall