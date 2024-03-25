.data
prompt: .asciiz "Digite um número inteiro não negativo: "
result_msg: .asciiz "O fatorial é: "
error_msg: .asciiz "Valor inválido!"

.text
    j main

# Função fatorial
fatorial:
    # Argumento: $a0 (número para calcular o fatorial)
    # Resultado: $v0 (fatorial)

    # Inicializa o resultado com 1
    li $v0, 1

    # Verifica se o número é zero
    beqz $a0, return_one

    # Loop para calcular o fatorial
    loop:
        mul $v0, $v0, $a0   # fatorial *= n
        subi $a0, $a0, 1    # n -= 1
        bgtz $a0, loop     # Se n > 0, continue o loop
        
    return_one:
        jr $ra

# Função para lidar com erros de entrada
handle_error:
    # Exibe mensagem de erro
    li $v0, 4
    la $a0, error_msg
    syscall
    
    j fim

main:
    # Solicita ao usuário que insira um número
    li $v0, 4
    la $a0, prompt
    syscall

    # Lê o número digitado pelo usuário
    li $v0, 5
    syscall
    # Armazena o número em $t0
    move $t0, $v0  

    # Verifica se o número é não negativo
    bltz $t0, handle_error

    # Chama a função fatorial
    move $a0, $t0
    jal fatorial
    
    # Move o resultado da função para um registrador temporário
    move $t0, $v0

    # Imprime o resultado
    li $v0, 4
    la $a0, result_msg
    syscall

    # Imprime o fatorial
    li $v0, 1
    move $a0, $t0
    syscall
    
    fim:
    # Encerra o programa
    li $v0, 10
    syscall