library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- aluop:
--	000: tipo-R
--  001: add
--  010: addu
--  011: sub
--  100: and
--  101: or
--  110: slt
--	111: lui


entity controle is
	port (
		opcode						    : in std_logic_vector(5 downto 0);
		regdst, jump, beq, bne		    : out std_logic;
		memread, memtoreg, memwrite 	: out std_logic;
		alusrc, regwrite            	: out std_logic;
		aluop							: out std_logic_vector(2 downto 0)
	);
end entity;

architecture controle_architeture of controle is
begin
	init: process (opcode)
	begin
		case opcode	is
			when "000000"  => -- TIPO R
				aluop 	<= "000";
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread  <= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "001100"	=> -- ANDI
				aluop 	<= "100"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread  <= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "001101"	=> -- ORI	
				aluop 	<= "101"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "001000"	=> -- ADDI
				aluop 	<= "001"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "001001"	=> -- ADDIU
				aluop 	<= "010"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "000100"	=> -- BEQ
				aluop 	<= "011"; -- branch: sub
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '1';
				bne		<= '0';	
				jump <= '0';
			when "000101"	=> -- BNE
				aluop 	<= "011"; -- branch: sub
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '1';	
				jump <= '0';
			when "000010"	=> -- J
				aluop 	<= "010"; -- jump: don't care
				regdst 	<= '0';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '1';
			when "000011"	=> -- JAL
				aluop 	<= "010"; -- jump: don't care
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '1';
			when "001111"	=> -- LUI
				aluop 	<= "111"; -- lui
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "100011"	=> -- LW
				aluop 	<= "010"; -- load word: add
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '1';
				regwrite <= '1';
				memread 	<= '1';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "001010"	=> -- SLTI
				aluop 	<= "110"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when "101011"	=> -- SW
				aluop 	<= "010";
				regdst 	<= '1';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '1';
				beq 		<= '0';
				bne		<= '0';	
				jump <= '0';
			when others =>  		-- Operacao nao implementada
				aluop 	 <= "---";
				regdst 	 <= '-';
				alusrc 	 <= '-';
				memtoreg <= '-';
				regwrite <= '-';
				memread  <= '-';
				memwrite <= '-';
				beq		 <= '-';
				bne		 <= '-';	
				jump <= '-';
		end case;			
	end process;

end architecture; 