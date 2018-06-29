library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ula_package.all;

entity controle is
	port (
		opcode						    :	in std_logic_vector(5 downto 0);
		regdst, jump, branch		    :	out std_logic;
		memread, memtoreg, memwrite : out std_logic;
		alusrc, regwrite            : out std_logic;
		aluop								 : out std_logic_vector(1 downto 0)
	);
end entity;

architecture controle_architeture of controle is
begin
	init: process (opcode)
	begin
		case opcode	is
			when X"00"  => -- TIPO R
				aluop 	<= "10";
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"0C"	=> -- ANDI
				aluop 	<= "10"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"0D"	=> -- ORI	
				aluop 	<= "10"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"08"	=>	--	ADDI
				aluop 	<= "10"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"09"	=> -- ADDIU
				aluop 	<= "10"; -- ?
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"04"	=> -- BEQ
				aluop 	<= "00";
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '1';
			when X"05"	=> -- BNE
				aluop 	<= "10"; -- ?
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"02"	=> -- J
				aluop 	<= "10"; -- ?
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"03"	=> -- JAL
				aluop 	<= "10"; -- ?
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"0F"	=> -- LUI
				aluop 	<= "10"; -- ?
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"23"	=> -- LW
				aluop 	<= "01";
				regdst 	<= '0';
				alusrc 	<= '1';
				memtoreg <= '1';
				regwrite <= '1';
				memread 	<= '1';
				memwrite <= '0';
				branch 	<= '0';
			when X"0A"	=> -- SLTI
				aluop 	<= "10"; -- ?
				regdst 	<= '1';
				alusrc 	<= '0';
				memtoreg <= '0';
				regwrite <= '1';
				memread 	<= '0';
				memwrite <= '0';
				branch 	<= '0';
			when X"2B"	=> -- SW
				aluop 	<= "00";
				regdst 	<= '1';
				alusrc 	<= '1';
				memtoreg <= '0';
				regwrite <= '0';
				memread 	<= '0';
				memwrite <= '1';
				branch 	<= '0';
			when others => 
		end case;			
	end process;

end architecture; 