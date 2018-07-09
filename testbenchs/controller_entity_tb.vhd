-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions
-- and other software and tools, and its AMPP partner logic
-- functions, and any output files from any of the foregoing
-- (including device programming or simulation files), and any
-- associated documentation or information are expressly subject
-- to the terms and conditions of the Altera Program License
-- Subscription Agreement, Altera MegaCore Function License
-- Agreement, or other applicable license agreement, including,
-- without limitation, that your use is for the sole purpose of
-- programming logic devices manufactured by Altera and sold by
-- Altera or its authorized distributors.  Please refer to the
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to
-- suit user's needs .Comments are provided in each section to help the user
-- fill out necessary details.
-- ***************************************************************************
-- Generated on "07/01/2018 18:20:21"

-- Vhdl Test Bench template for design  :  controller_entity
--
-- Simulation tool : ModelSim-Altera (VHDL)
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY controller_entity_tb IS
END controller_entity_tb;
ARCHITECTURE controller_entity_arch OF controller_entity_tb IS
-- constants
-- signals
SIGNAL entity_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL funct_in : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL op_in : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL val1_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL val2_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ovflw_out, zero_out, jal : std_logic;
COMPONENT controller_entity
	PORT (
	ovflw_out, zero_out : out std_logic;
	entity_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	funct_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	op_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	val1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	val2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	jal		: out STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : controller_entity
	PORT MAP (
-- list connections between master ports and signals
	entity_out => entity_out,
	funct_in => funct_in,
	op_in => op_in,
	val1_in => val1_in,
	val2_in => val2_in,
	ovflw_out => ovflw_out,
	zero_out => zero_out,
	jal => jal
	);
init : PROCESS
-- variable declarations
BEGIN
	-- Adicao tipo R
		op_in <= "000000";
		funct_in <= "100000";
		val1_in <= std_logic_vector(to_signed(1, 32));
		val2_in <= std_logic_vector(to_signed(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_signed(3, 32))) report "Add failure";
		assert(ovflw_out = '0') report "Overflow failure";

		wait for 4 ps;

		val1_in <= X"70000000";
		val2_in <= X"10000000";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"80000000") report "Add failure";
		assert(ovflw_out = '1') report "Overflow failure";

		wait for 4 ps;

	-- Addu tipo R
		funct_in <= "100001";
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(3, 32)));
		assert(ovflw_out = '0');

		wait for 4 ps;

		val1_in <= X"70000000";
		val2_in <= X"10000000";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"80000000");
		assert(ovflw_out = '0');

		wait for 4 ps;

	-- Subtracao tipo R
		funct_in <= "100010";
		val1_in <= std_logic_vector(to_signed(2, 32));
		val2_in <= std_logic_vector(to_signed(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_signed(1, 32)));

		wait for 4 ps;

	-- Subu tipo R
		funct_in <= "100011";
		val1_in <= std_logic_vector(to_unsigned(2, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(1, 32)));

		wait for 4 ps;
	-- And
		funct_in <= "100100";
		val1_in <= X"10101010";
		val2_in <= X"00001111";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00001010");

		wait for 4 ps;
	-- Or
		funct_in <= "100101";
		val1_in <= X"F0F0F0F0";
		val2_in <= X"0000FFFF";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"F0F0FFFF");

		wait for 4 ps;

	-- Slt
		funct_in <= "101010";
		val1_in <= std_logic_vector(to_unsigned(0, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000001");

		wait for 4 ps;

		val1_in <= std_logic_vector(to_unsigned(0, 32));
		val2_in <= std_logic_vector(to_signed(-1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000000");

		wait for 4 ps;

	-- Sltu
		funct_in <= "101011";
		val1_in <= std_logic_vector(to_unsigned(0, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000001");

		wait for 4 ps;

		val1_in <= X"00000001";
		val2_in <= X"80000000";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000001");

		wait for 4 ps;

	-- Nor
		funct_in <= "100111";
		val1_in <= X"F0F0F0F0";
		val2_in <= X"0000FFFF";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"0F0F0000");

		wait for 4 ps;
	-- Xor
		funct_in <= "100110";
		val1_in <= X"F0F0F0F0";
		val2_in <= X"0000FFFF";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"F0F00F0F");

		wait for 4 ps;
	-- Sll
		funct_in <= "000000";
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(2, 32)));

		wait for 4 ps;
	-- Srl
		funct_in <= "000010";
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(0, 32)));

		wait for 4 ps;
	-- Sra
		funct_in <= "000011";
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(0, 32)));

		wait for 4 ps;
	-- Rtl
		funct_in <= "111111";
		val1_in <= std_LOGIC_VECTOR(to_signed(4, 32));
		val2_in <= x"AAAACCCB";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = x"AAACCCBA");

		wait for 4 ps;

	-- Rtr
		funct_in <= "111110";
		val1_in <= std_LOGIC_VECTOR(to_signed(4, 32));
		val2_in <= x"AAAACCCB";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = x"BAAAACCC");

		wait for 4 ps;
	-- jal
		funct_in <= "001000";
		val1_in <= std_LOGIC_VECTOR(to_signed(4, 32));
		val2_in <= x"AAAACCCB";
		wait for 4 ps;
		assert(jal = '1') report "jal failure";
		assert(entity_out = x"BAAAACCC");

		wait for 4 ps;
	-- Lui
		funct_in <= "111101";
		val1_in <= std_LOGIC_VECTOR(to_signed(0, 32));
		val2_in <= x"0000FFFF";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = x"FFFF0000");

		wait for 4 ps;

		op_in <= "001100";  	-- Andi
		val1_in <= X"10101010";
		val2_in <= X"00001111";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out  = X"00001010");

		wait for 4 ps;

		op_in <= "001101";        -- Ori
		val1_in <= X"10101010";
		val2_in <= X"00001111";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out  = X"10101111");

		wait for 4 ps;

		op_in <= "001000";       -- Addi
		val1_in <= std_logic_vector(to_signed(1, 32));
		val2_in <= std_logic_vector(to_signed(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_signed(3, 32)));
		assert(ovflw_out = '0');

		wait for 4 ps;

		val1_in <= X"70000000";
		val2_in <= X"10000000";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"80000000");
		assert(ovflw_out = '1');

		wait for 4 ps;

		op_in <= "001001";        -- Addiu
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(3, 32)));
		assert(ovflw_out = '0');

		wait for 4 ps;

		val1_in <= X"70000000";
		val2_in <= X"10000000";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"80000000");
		assert(ovflw_out = '0');

		wait for 4 ps;

		op_in <= "000100";        -- Beq
		val1_in <= X"00000001";
		val2_in <= X"00000001";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000000");
		assert(zero_out = '1');

		wait for 4 ps;

		op_in <= "000101";        -- Bne
		val1_in <= X"00000001";
		val2_in <= X"00000001";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000000");
		assert(zero_out = '1');

		wait for 4 ps;

		op_in <= "001111";        -- LUI
		val1_in <= std_LOGIC_VECTOR(to_signed(0, 32));
		val2_in <= x"0000FFFF";
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = x"FFFF0000");

		wait for 4 ps;

		op_in <= "100011";        -- Lw
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(3, 32)));
		assert(ovflw_out = '0');

		wait for 4 ps;

		op_in <= "001010";        -- Slti
		val1_in <= std_logic_vector(to_unsigned(0, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000001");

		wait for 4 ps;

		val1_in <= std_logic_vector(to_unsigned(0, 32));
		val2_in <= std_logic_vector(to_signed(-1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = X"00000000");

		wait for 4 ps;

		op_in <= "101011";  -- Sw
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(2, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(3, 32)));
		assert(ovflw_out = '0');

    op_in <= "001110";  -- XORI
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(1, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(0, 32)));
		assert(ovflw_out = '0');

    op_in <= "001110"; -- XORI
		val1_in <= std_logic_vector(to_unsigned(1, 32));
		val2_in <= std_logic_vector(to_unsigned(0, 32));
		wait for 4 ps;
		assert(jal = '0') report "jal failure";
		assert(entity_out = std_logic_vector(to_unsigned(1, 32)));
		assert(ovflw_out = '0');

		wait for 4 ps;
WAIT;
END PROCESS init;
always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
        -- code executes for every event on sensitivity list
WAIT;
END PROCESS always;
END controller_entity_arch;
