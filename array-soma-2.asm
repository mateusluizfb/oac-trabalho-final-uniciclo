.data

	A: .word 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	g: .word 2
	i: .word 1

.text

	la $s0, A # Le o endereço array A
	lw $s1, g # Le o valor de g
	lw $s2, i # Le o valor de i

	sll $t0, $s2, 2 # Multiplica o valor de 'i' por 4, para obter a quantidade de bytes que é necessário para chegar na posição desejada
	add $t1, $t0, $s0 # Soma o valor de $t0 mais o endereço base de A para obter a posição desejada

	lw $t3, ($t1) # lê o valor de A[i]
	lw $t4, 0($s0) # Lê o valor em A[0]

	add $t1, $s1, $t3 # g + A[i]
	sub $t1, $t1, $t4 # (g + A[i]) - A[0]

	add $t4, $s1, $s2 # soma i + g
	sll $t4, $t4, 2   # multiplica por 4 para obter a quantidade de bytes que precisa andar

	add $t5, $s0, $t4 # vai até a posição A[i + g]

	sw $t1, ($t5) # guarda a valor da expressão em A[i + g]
	lw $a0, ($t5) # Guarda o valor da expressão para mostrar na tela
