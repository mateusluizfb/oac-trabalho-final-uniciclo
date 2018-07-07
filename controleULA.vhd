library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ula_package.all;

-- aluop:
--  0000: tipo-R
--  0001: add
--  0010: addu
--  0011: sub
--  0100: and
--  0101: or
--  0110: slt
--  0111: lui
--  1000: xori

entity controleULA is
    port (
        aluop   :   in  std_logic_vector(3 downto 0);
        funct   :   in  std_logic_vector(5 downto 0);
        ulasin  :   out ULA_OPERATION; -- 4 bits: consultar ula_package para a instruÃ§Ã£o
        jr      :   out std_logic
    );
end entity;

architecture controleULA_arch of controleULA is
    begin
        init: process(aluop, funct)
        begin
            jr <= '0';
            case aluop is   -- no caso de uma operação tipo r
                when "0000" =>
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
                        when "001000" => -- jr
                            jr <= '1';
                            ulasin <= SLL_OP;
                        when others   => -- operacao nao implementada na ula
                            ulasin <= SLL_OP;
                    end case;
            when "0001" =>    -- addi, lw, sw
                ulasin <= ADD;
            when "0010" =>  -- addiu
                ulasin <= ADDU;
            when "0011" =>  -- bne, beq
                ulasin <= SUB;
            when "0100" =>  -- andi
                ulasin <= AND_OP;
            when "0101" =>  -- ori
                ulasin <= OR_OP;
            when "0110" =>  -- slti
                ulasin <= SLT;
            when "0111" =>  -- lui
                ulasin <= LUI;
            when "1000" => -- xori
                ulasin <= XOR_OP;
            when others => ulasin <= SLL_OP;
            end case;
        end process init;
    end architecture;
