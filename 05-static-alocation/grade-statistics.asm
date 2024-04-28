.data
	notas: .space 40
	tamanho: .word 10
	msgRecebeNotasIni: .asciiz "Digite a nota do "
	msgRecebeNotasFim: .asciiz "º aluno: "
	quebraLinha: .asciiz "\n"
.text
	j main
	
	calcula_aprovados:
		li $t0, 0
		l.s $f0, 6.0
		li $s0, 0
		la $s2, notas
		
		loop_calcula_aprovados:
			l.s $f1, 0($s2)
			
			li $v0, 2
			mov.s $f12, $f1
			syscall
			
			li $v0, 4
			la $a0, quebraLinha
			syscall
			
			c.lt.s 
			blt $
			
			addi $s2, $s2, 4
			addi $t0, $t0, 1
			
			beq $t0, $s1, fim_loop_calcula_aprovados
			
			j loop_calcula_aprovados
			
		fim_loop_calcula_aprovados:
		
		jr $ra

	main:
		li $s0, 1
		lw $s1, tamanho
		la $s2, notas
		
		loop_recebe_notas:
			li $v0, 4
			la $a0, msgRecebeNotasIni
			syscall
			
			li $v0, 1
			move $a0, $s0
			syscall
			
			li $v0, 4
			la $a0, msgRecebeNotasFim
			syscall
			
			li $v0, 6
			syscall
			
			subi $s0, $s0, 1
			s.s $f0, 0($s2)
			addi $s0, $s0, 1

			addi $s0, $s0, 1
			addi $s2, $s2, 4
			
			bgt $s0, $s1, fim_loop_recebe_notas
			
			j loop_recebe_notas
			
		fim_loop_recebe_notas:
				
			jal calcula_aprovados
		
			li $v0, 10
			syscall
