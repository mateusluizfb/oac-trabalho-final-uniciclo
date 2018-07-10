.data 
vetx:	.word 15 63

# observacao: os botoes da DE2 estao ativos ('1') quando soltos. Quando pressionados
# passam para zero. Para alterar esse comportamento, o clock poderia ser utilizado
# negado. Assim, ao soltar o botao, teriamos a transicao de descida, que carrega
# os registradores internos das memorias

# os valores ao lado sao tomados da saida dos modulos:
# PC - saida do PC
# MI - saida do módulo de memoria (e nao de IF/ID)
# ULA - saida direta da ULA
# MD - saida direta da memoria de dados

.text                                # PC        MI         ULA       MD

	ori  $t0, $zero, 0xFF        # 00000000  340800FF   000000FF  00000000
	andi $t0, $t0, 0xF0          # 00000004  310800F0   000000F0  00000000
	xori $t0, $t0, 0x55          # 00000008  39080055   000000A5  00000000
	lw   $t1, 0x2000($zero)      # 0000000c  8C092000   00002000  0000000F
	lw   $t2, 0x2004($zero)      # 00000010  8C0A2004   00002004  0000003F
	add  $t3, $t1, $t2     	     # 00000014  012A5820   0000004E  00000000
	sw   $t3, 0x2008($zero)      # 00000018  AC0B2008   00002008  0000004E
	addi $t4, $zero, 0x70F0      # 0000001C  200c70F0   000070F0  00000000
	addi $t5, $zero, 0x00FF      # 00000020  200D00FF   000000FF  00000000
	and  $t6, $t5, $t4           # 00000024  01AC7024   000000F0  00000000
	or   $t7, $t5, $t4           # 00000028  01AC7825   000070FF  00000000
	xor  $t8, $t5, $t4           # 0000002C  01ACC026   0000700F  00000000
	nor  $t0, $t5, $t4           # 00000030  01AC4027   FFFF8F00  00000000
	sll  $t1, $t5, 4             # 00000034  000D4900   00000FF0  00000000
	lui  $t2, 0xFF00             # 00000038  3C0AFF00   FF000000  00000000
	srl  $t3, $t2, 4             # 0000003C  000A5902   0FF00000  00000000 
	sra  $t4, $t2, 4             # 00000040  000A6103   FFF00000  00000000
	addiu $t0, $zero, -1         # 00000044  2408FFFF   FFFFFFFF  00000000
	addiu $t1, $zero,  1         # 00000048  24090001   00000001  00000000
	slt  $s0, $t0, $t1           # 0000004c  0109802A   00000001  00000000
	slt  $s1, $t1, $t0           # 00000050  0128882A   00000000  00000000
	sltu $s3, $zero, $t0         # 00000054  0008982B   00000001  00000000
	sltu $s4, $t0, $zero         # 00000058  0100A02B   00000000  00000000
	
	jal  testasub                # 0000005c  0C000019   00000000  00000000

	j next                       # 00000060  0800001C   00000000  00000000
testasub:
	sub $t3, $t0, $t1            # 00000064  01095822   FFFFFFFE  00000000
	subu $t4, $t1, $t0           # 00000068  01286023   00000002  00000000
	jr $ra                       # 0000006c  03E00008   00000000  00000000
next:
beqsim: 
	addi $t0, $t0, 1             # 00000070  21080001   00000000  00000000
	beq  $t0, $zero, beqsim      # 00000074  1100FFFE   00000000|0x01  00000000
bnesim:
	addi $t0, $t0, -1            # 00000078  2108FFFF   00000000  00000000
	bne  $t0, $zero, bnesim      # 0000007c  1500FFFE   00000000  00000000
	
	# Exceptions
	lui  $s0, 0x8000             # 00000080  3C108000   00000000  00000000
	lui  $s1, 0x8000             # 00000084  3C118000   00000000  00000000
	# No overflow exception
	addu $s3, $s0, $s1           # 00000088  02119221   00000000  00000000
	# Overflow exception
	add  $s4, $s0, $s1           # 0000008c  0211A020   00000000  00000000

.ktext 0x00004380
	eret
