.data
	var1: .word 3				# int var1 = 3
	list: .space 1000			# Reserva de bloco de 1000 bytes consecutivos na memória
	array: .byte 'a','b'			# char array[2] = {'a', 'b')
	vowels: .byte 'a','e','i','o','u'	# char vowels[5] = {'a','b','c','d','e'}
	pow2: .word 1,2,4,8,16,32,64,128	# int pow2[8] = {1,2,4,8,16,32,64,128}
	vowels2: .asciiz "aeiou"		# string volwels2 = "aeiou"

.text
	lw $t0, 8($s0)				# transfere dados (memória -> registradores)
						# int t1 = v[2];
	sw $t0, 8($s0)				# transfere dados (registradores -> memória)
						# v[2] = t1;