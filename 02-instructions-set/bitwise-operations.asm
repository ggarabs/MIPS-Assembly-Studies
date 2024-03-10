.data
	msgNum1: .asciiz "Digite o primeiro número: "
	msgNum2: .asciiz "Digite o segundo número: "
	msgAnd: .asciiz "Resultado do bitwise AND: "
	msgOr: .asciiz "Resultado do bitwise OR: "
	msgXor: .asciiz "Resultado do bitwise XOR: "
	endl: .asciiz "\n"
	
.text
	li $v0, 4
	la $a0, msgNum1
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	li $v0, 4
	la $a0, msgNum2
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0
	
	li $v0, 4
	la $a0, msgAnd
	syscall
	
	li $v0, 1
	and $a0, $s0, $s1
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall
	
	li $v0, 4
	la $a0, msgOr
	syscall
	
	li $v0, 1
	or $a0, $s0, $s1
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall
	
	li $v0, 4
	la $a0, msgXor
	syscall
	
	li $v0, 1
	xor $a0, $s0, $s1
	syscall
	
	li $v0, 10
	syscall