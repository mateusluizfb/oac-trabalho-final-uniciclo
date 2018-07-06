library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ula_package.all;


-- aluop:
--	0000: tipo-R
-- 0001: add
-- 0010: addu
-- 0011: sub
-- 0100: and
-- 0101: or
-- 0110: slt
--	0111: lui
-- 1000: xori

entity controller_entity is
    port(
        op_in, funct_in     : in std_logic_vector(5 downto 0);
        val1_in, val2_in    : in std_logic_vector(31 downto 0);
        entity_out          : out std_logic_vector(31 downto 0);
        ovflw_out, zero_out : out std_logic   
    );
end entity;

architecture controller_entity_arch of controller_entity is
    component controle 
        port (
            opcode						    : in std_logic_vector(5 downto 0);
            regdst, jump, beq, bne		    : out std_logic;
            memread, memtoreg, memwrite 	: out std_logic;
            alusrc, regwrite            	: out std_logic;
            aluop							: out std_logic_vector(3 downto 0)
        );
    end component;

    component controleULA is
        port (
            aluop	:	in	std_logic_vector(3 downto 0);
            funct	:	in 	std_logic_vector(5 downto 0);
            ulasin	:	out ULA_OPERATION -- 4 bits: consultar ula_package para a instruÃ§Ã£o
        );
    end component;

    component ula is
        port (
            A:                  in std_logic_vector(31 downto 0);
            B:                  in std_logic_vector(31 downto 0);
            ula_op:             in ULA_OPERATION;
            ula_out:            out std_logic_vector(31 downto 0);
            zero:               out std_logic;
            overflow:           out std_logic
        );
    end component;

    signal control_out  :   std_logic_vector(3 downto 0);
    signal rdst, jmp, beq_out, bne_out  :   std_logic;
    signal mread, mwrite, mtoreg, ulasrc, rwrite : std_logic;
    signal alucontrol_out : ULA_OPERATION;

    begin
        controle_i1: controle
            port map(
                opcode => op_in,
                regdst => rdst,
                jump => jmp,
                beq => beq_out,
                bne => bne_out,
                memread => mread,
                memtoreg => mtoreg,
                memwrite => mwrite,
                alusrc => ulasrc,
                regwrite => rwrite,
                aluop => control_out
            );

        controleULA_i1: controleULA 
            port map(
                aluop => control_out,
                funct => funct_in,
                ulasin => alucontrol_out
            );
        ula_i1: ula
            port map(
                A => val1_in,
                B => val2_in,
                ula_op => alucontrol_out,
                ula_out => entity_out,
                zero => zero_out,
                overflow => ovflw_out
            );
        
    end architecture;