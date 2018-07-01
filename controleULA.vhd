library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ula_package.all;

-- aluop:
--	000: tipo-R
--  001: add
--  010: addu
--  011: sub
--  100: and
--  101: or
--  110: slt
--	111: lui

entity controleULA is
	port (
		aluop	:	in	std_logic_vector(2 downto 0);
		funct	:	in 	std_logic_vector(5 downto 0);
		ulasin	:	out std_logic_vector(3 downto 0) -- 4 bits: consultar ula_package para a instruÃ§Ã£o
	);
end entity;

architecture controleULA_arch of controleULA is
	begin
		init: process(aluop)
		begin
			if aluop = "000" then	-- no caso de uma operação tipo r
				case funct is
					when "100000" => -- add
						ulasin <= "0000";
					when "100001" => -- addu
						ulasin <= "0001";
					when "100010" => -- sub
						ulasin <= "0010";
					when "100011" => -- subu
						ulasin <= "0011";
					when "100100" => -- and
						ulasin <= "0100";
					when "100101" => -- or
						ulasin <= "0101";
					when "101010" => -- slt
						ulasin <= "0110";
					when "101011" => -- sltu
						ulasin <= "0111";
					when "100111" => -- nor
						ulasin <= "1000";
					when "100110" => -- xor
						ulasin <= "1001";
					when "000000" => -- sll
						ulasin <= "1010";
					when "000010" => -- srl
						ulasin <= "1011";
					when "000011" => -- sra
						ulasin <= "1100";
					when "111111" => -- rtl(?)
						ulasin <= "1101";
					when "111110" => -- rtr(?)
						ulasin <= "1110";
					when "111101" => -- lui(?)
						ulasin <= "1111";
					when others	  => -- operacao nao implementada na ula
						ulasin <= "----";
				end case;
			elsif aluop = "001" then    -- addi, lw, sw
				ulasin <= "0000";
			elsif aluop = "010" then	-- addiu
				ulasin <= "0001";
			elsif aluop = "011" then	-- bne, beq
				ulasin <= "0010";
			elsif aluop = "100" then	-- andi
				ulasin <= "0100";
			elsif aluop = "101" then	-- ori
				ulasin <= "0101";
			elsif aluop = "110" then	-- slti
				ulasin <= "0110";
			elsif aluop = "111" then	-- lui
				ulasin <= "1111";
			end if;
		end process init;
	end architecture;