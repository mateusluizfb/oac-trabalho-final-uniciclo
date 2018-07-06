.data
vetor:	.word 1 2 3 4 5 6 7 8 9
tam:	.word 9

.text
main:	la $a0, vetor
	la $a1, tam
	lw $a1, 0($a1)

pr_vet:	
	move $t0, $a0	#inicializacao de variaveis
L1:	
	lw $a0, 0($t0)
    lw $a0, 4($t0)
    lw $a0, 8($t0)
	lw $a0, 12($t0)
	addi $t0, $t0, 4
	addi $a1, $a1, -1
	li $v0, 1
	la $t0, vetor
	li $s0, 1
	li $s1, 2
	li $s2, 3
	sw $s2, 0($t0)
	sw $s1, 4($t0)
	sw $s0, 8($t0)