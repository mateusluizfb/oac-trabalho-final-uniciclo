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
		ulasin	:	out ULA_OPERATION -- 4 bits: consultar ula_package para a instruÃ§Ã£o
	);
end entity;

architecture controleULA_arch of controleULA is
	begin
		init: process(aluop, funct)
		begin
			case aluop is	-- no caso de uma operação tipo r
				when "000" =>
					case funct is
						when "100000" => -- add
							ulasin <= ADD;
						when "100001" => -- addu
							ulasin <= ADDU;
						when "100010" => -- sub
							ulasin <= SUB;
						when "100011" => -- subu
							ulasin <= SUBU;
						when "100100" => -- and
							ulasin <= AND_OP;
						when "100101" => -- or
							ulasin <= OR_OP;
						when "101010" => -- slt
							ulasin <= SLT;
						when "101011" => -- sltu
							ulasin <= SLTU;
						when "100111" => -- nor
							ulasin <= NOR_OP;
						when "100110" => -- xor
							ulasin <= XOR_OP;
						when "000000" => -- sll
							ulasin <= SLL_OP;
						when "000010" => -- srl
							ulasin <= SRL_OP;
						when "000011" => -- sra
							ulasin <= SRA_OP;
						when "111111" => -- rtl(?)
							ulasin <= RTL;
						when "111110" => -- rtr(?)
							ulasin <= RTR;
						when "111101" => -- lui(?)
							ulasin <= LUI;
						when others	  => -- operacao nao implementada na ula
							ulasin <= SLL_OP;
					end case;
			when "001" =>    -- addi, lw, sw
				ulasin <= ADD;
			when "010" =>	-- addiu
				ulasin <= ADDU;
			when "011" =>	-- bne, beq
				ulasin <= SUB;
			when "100" =>	-- andi
				ulasin <= AND_OP;
			when "101" =>	-- ori
				ulasin <= OR_OP;
			when "110" =>	-- slti
				ulasin <= SLT;
			when "111" =>	-- lui
				ulasin <= LUI;
			when others => ulasin <= SLL_OP;
			end case;
		end process init;
	end architecture;
