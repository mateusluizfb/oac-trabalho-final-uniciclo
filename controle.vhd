library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- aluop:
--	0000: tipo-R
--  0001: add
--  0010: addu
--  0011: sub
--  0100: and
--  0101: or
--  0110: slt
--	0111: lui
--  1000: xori


entity controle is
	port (
		opcode						    : in std_logic_vector(5 downto 0);
		regdst, jump, beq, bne, jal     : out std_logic;
		memread, memtoreg, memwrite 	: out std_logic;
		alusrc, regwrite, eret       	: out std_logic;
		aluop							: out std_logic_vector(3 downto 0)
	);
end entity;

architecture controle_architeture of controle is
begin
	init: process (opcode)
	begin
		case opcode	is
			when "000000"  => -- TIPO R
				aluop 	<= "0000";
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread  <= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001100"	=> -- ANDI
				aluop 	<= "0100"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread  <= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001101"	=> -- ORI
				aluop 	<= "0101"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001000"	=> -- ADDI
				aluop 	<= "0001"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001110"	=> -- XORI
				aluop 	<= "1000"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001001"	=> -- ADDIU
				aluop 	<= "0010"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "000100"	=> -- BEQ
				aluop 	<= "0011"; -- branch: sub
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '1';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "000101"	=> -- BNE
				aluop 	<= "0011"; -- branch: sub
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '1';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "000010"	=> -- J
				aluop 	<= "0010"; -- jump: don't care
				regdst 	<= '0';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '1';
			when "000011"	=> -- JAL
				aluop 	<= "0010"; -- jump: don't care
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '1';
				jump <= '0';
			when "001111"	=> -- LUI
				aluop 	<= "0111"; -- lui
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "100011"	=> -- LW
				aluop 	<= "0010"; -- load word: add
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '1';
				regwrite <= '1';
				memread 	<= '1';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "001010"	=> -- SLTI
				aluop 	<= "0110"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "101011"	=> -- SW
				aluop 	<= "0010";
				regdst 	<= '1';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '1';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '0';
				jal 	 <= '0';
				jump <= '0';
			when "100001"	=> -- ERET
				aluop 	<= "0010";
				regdst 	<= '0';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';
				eret 	 <= '1';
				jal 	 <= '0';
				jump <= '0';
			when others =>  		-- Operacao nao implementada
				aluop 	 <= "----";
				regdst 	 <= '-';
				alusrc 	 <= '-';
				memtoreg <= '-';
				regwrite <= '-';
				memread  <= '-';
				memwrite <= '-';
				beq		 <= '-';
				bne		 <= '-';
				eret 	 <= '-';
				jal 	 <= '-';
				jump <= '-';
		end case;
	end process;

end architecture;
