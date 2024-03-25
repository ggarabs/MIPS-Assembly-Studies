.data
    menu: .asciiz "Menu:\n1. Soma\n2. Subtração\n3. Multiplicação\n4. Divisão\n5. Sair\nEscolha a operação (1/2/3/4/5): "
    valor1: .asciiz "Digite o primeiro número: "
    valor2: .asciiz "Digite o segundo número: "
    resultado: .asciiz "Resultado: "
    divisor_zero: .asciiz "O divisor não pode ser zero. Digite o número novamente.\n"
    error_msg: .asciiz "Opção incorreta!\n"
    line_feed: .asciiz "\n"
    quocient: .asciiz "Quociente: "
    mod: .asciiz "Resto: "

.text
main:
    # Exibir o menu
    li $v0, 4
    la $a0, menu
    syscall

    # Ler a opção selecionada
    li $v0, 5
    syscall
    move $t0, $v0

    # Verificar a opção
    beq $t0, 5, sair
    bgt $t0, 5, erro_opcao
    blez $t0, erro_opcao

    # Ler os números
    li $v0, 4
    la $a0, valor1
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, valor2
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0

    # Realizar a operação
    beq $t0, 1, soma
    beq $t0, 2, subtracao
    beq $t0, 3, multiplicacao
    beq $t0, 4, divisao

soma:
    add $t3, $t1, $t2
    j mostrar_resultado

subtracao:
    sub $t3, $t1, $t2
    j mostrar_resultado

multiplicacao:
    mul $t3, $t1, $t2
    j mostrar_resultado

divisao:
    # Verificar se o divisor é zero
    beqz $t2, divisor_0

    div $t1, $t2
    mflo $t3
    mfhi $t4
    j mostrar_resultado_divisao

mostrar_resultado:
    li $v0, 4
    la $a0, resultado
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, line_feed
    syscall
    
    li $v0, 4
    la $a0, line_feed
    syscall
    
    j main

mostrar_resultado_divisao:
    li $v0, 4
    la $a0, quocient
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, line_feed
    syscall

    li $v0, 4
    la $a0, mod
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
        
    li $v0, 4
    la $a0, line_feed
    syscall
    
    li $v0, 4
    la $a0, line_feed
    syscall
    
    j main

erro_opcao:
    # Tratar erro de opção inválida
    # (por exemplo, se o usuário digitar uma opção fora do intervalo 1-5)
    li $v0, 4
    la $a0, error_msg
    syscall
    
    li $v0, 4
    la $a0, line_feed
    syscall
    
    j main

divisor_0:
    # Exibir mensagem de erro para divisor igual a zero
    li $v0, 4
    la $a0, divisor_zero
    syscall
    j main

sair:
    # Encerrar o programa
    li $v0, 10
    syscall
