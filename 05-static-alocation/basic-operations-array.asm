.data
	array: .space 40
	size: .word 10
	menu: .asciiz "****MENU INTERATIVO****\n1. Preencher o vetor (array)\n2. Informações sobre o vetor\n3. Sair\nOpção: "
	msg_error: .asciiz "Opção inválida! Por favor selecione uma das opções do menu.\n\n"
	msg_prompt_elem_p1: .asciiz "Digite o valor de vetor["
	msg_prompt_elem_p2: .asciiz "]: "
	msg_unpopulated_array: .asciiz "Vetor ainda vazio!\n\n"
	msg_print_array_p1: .asciiz "\nConteúdo armazenado no vetor: ["
	msg_max_elem: .asciiz "O maior elemento do vetor é: "
	msg_min_elem: .asciiz "O menor elemento do vetor é: "
	msg_odd_elem: .asciiz "A quantidade de números pares: "
	msg_even_elem: .asciiz "A quantidade de números ímpares: "
	msg_print_array_p2: "]\n"
	line_feed: .asciiz "\n"
	comma: .asciiz ", "	
	
.text

j main
	
print_menu:
	li $v0, 4
	la $a0, menu
	syscall
		
	jr $ra
	
populate_array:
	li $t1, 0	# Contador
	li $s2, 0
	
	populate_array_loop:
	
	li $v0, 4
	la $a0, msg_prompt_elem_p1
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, msg_prompt_elem_p2
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	sw $t2, 0($s1)
		
	addi $t1, $t1, 1
	addi $s2, $s2, 1
	addi $s1, $s1, 4
	
	blt $t1, $s3, populate_array_loop
	
	subi $s1, $s1, 40
	
	li $v0, 4
	la $a0, line_feed
	syscall

	jr $ra

print_array:
	li $v0, 4
	la $a0, msg_print_array_p1
	syscall
	
	li $t1, 0
	lw $t2, size
	
	print_array_loop:
		lw $t0, 0($s1)
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		addi $t1, $t1, 1
		addi $s1, $s1, 4
		
		beq $t1, $t2, end_print_array_loop
		
		li $v0, 4
		la $a0, comma
		syscall
		
		j print_array_loop
		
	end_print_array_loop:
		li $v0, 4
		la $a0, msg_print_array_p2
		syscall
		
	subi $s1, $s1, 40

	jr $ra
	
find_max_value:
	li $t1, 0		# CONTADOR
	lw $t2, size
	lw $t3, 0($s1)		# MENOR
		
	loop_find_max_value:
		lw $t0, 0($s1)
			
		bgt $t3, $t0, next_value
			
		move $t3, $t0
			
		next_value:
		addi $t1, $t1, 1
		addi $s1, $s1, 4
			
		beq $t1, $t2, end_find_max
			
		j loop_find_max_value
			
	end_find_max:
			
	subi $s1, $s1, 40
	
	move $v0, $t3
		
	jr $ra
					
find_min_value:
	li $t1, 0		# CONTADOR
	lw $t2, size
	lw $t3, 0($s1)		# MAIOR
		
	loop_find_min_value:
		lw $t0, 0($s1)
			
		blt $t3, $t0, next_value_min
			
		move $t3, $t0
			
		next_value_min:
		addi $t1, $t1, 1
		addi $s1, $s1, 4
			
		beq $t1, $t2, end_find_min
			
		j loop_find_min_value
			
	end_find_min:
		
	subi $s1, $s1, 40
	
	move $v0, $t3
		
	jr $ra
	
find_even_and_odd_values:
	li $t1, 0		# CONTADOR
	lw $t2, size
	li $t3, 0		# PARES
	li $t4, 0		# IMPARES
	
	loop_find_parity:
		lw $t0, 0($s1)
		
		addi $s1, $s1, 4
		addi $t1, $t1, 1
		
		andi $t5, $t0, 1
		
		beq $t5, 1, odd	

		addi $t3, $t3, 1
		j even
			
		odd:
		addi $t4, $t4, 1
		
		even:
		beq $t1, $t2, end_find_parity
			
		j loop_find_parity
			
	end_find_parity:		
	subi $s1, $s1, 40
	
	move $v0, $t3
	move $v1, $t4
	
	jr $ra

print_error_msg:
	li $v0, 4
	la $a0, msg_error
	syscall

	jr $ra
		
main:
	li $s2, 0	# Contador de elementos preenchidos no array
	li $s3, 10	# Tamanho do array

	menu_loop:
		
	jal print_menu
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	beq $s0, 1, case1
	beq $s0, 2, case2
	beq $s0, 3, case3
	blt $s0, 1, default
	bgt $s0, 3, default
	
	case1:
		la $s1, array
		jal populate_array

		j fim_switch
	case2:
		bne $s2, $s3, error_case2
		
		jal print_array
		jal find_max_value
		
		move $a1, $v0
		
		li $v0, 4
		la $a0, msg_max_elem
		syscall
		
		li $v0, 1
		move $a0, $a1
		syscall
			
		li $v0, 4
		la $a0, line_feed
		syscall
		
		jal find_min_value
		
		move $a1, $v0
		
		li $v0, 4
		la $a0, msg_min_elem
		syscall
	
		li $v0, 1
		move $a0, $a1
		syscall
			
		li $v0, 4
		la $a0, line_feed
		syscall

		jal find_even_and_odd_values
		
		move $a1, $v0
		move $a2, $v1
		
		li $v0, 4
		la $a0, msg_odd_elem
		syscall
		
		li $v0, 1
		move $a0, $a1
		syscall

		li $v0, 4
		la $a0, line_feed
		syscall
	
		li $v0, 4
		la $a0, msg_even_elem
		syscall
		
		li $v0, 1
		move $a0, $a2
		syscall
			
		li $v0, 4
		la $a0, line_feed
		syscall
		
		li $v0, 4
		la $a0, line_feed
		syscall		
		
		j end_case2
		
		error_case2:
			li $v0, 4
			la $a0, msg_unpopulated_array
			syscall
		
		end_case2:
		
		j fim_switch
	case3:
		j fim_loop
	
	default:
		jal print_error_msg
		j fim_switch
	
	fim_switch:
	
	j menu_loop
	
	fim_loop:
	
	li $v0, 10
	syscall