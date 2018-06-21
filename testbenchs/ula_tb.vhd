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
-- Generated on "05/30/2018 20:26:28"
                                                            
-- Vhdl Test Bench template for design  :  ula
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;            
library work;                                   
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;
USE work.ula_package.all;

ENTITY ula_tb IS
END ula_tb;
ARCHITECTURE ula_arch OF ula_tb IS
	-- constants                                                 
	-- signals                                                   
	SIGNAL A 					: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B 					: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ula_control_op 	: STD_LOGIC_VECTOR(1 downto 0) := "10";
	SIGNAL ula_op 				: ula_operation;
	SIGNAL ula_out 			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL zero 				: std_logic;
	SIGNAL overflow			: std_logic;
	
	COMPONENT ula
		PORT (
			A 					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B 					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ula_control_op : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ula_op 			: IN ula_operation;
			ula_out 			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			zero				: OUT STD_LOGIC;
			overflow 		: OUT STD_LOGIC
		);
	END COMPONENT;
	BEGIN
		i1 : ula
		PORT MAP ( 
	-- list connections between master ports and signals
			A 					=> A,
			B 					=> B,
			ula_control_op 	=> ula_control_op,
			ula_op 			=> ula_op,
			ula_out 			=> ula_out,
			zero 				=> zero,
			overflow 		=> overflow
		);
	init : PROCESS                                               
	-- variable declarations                                     
	BEGIN
		
		-- TESTS ADD
	
		A <= std_LOGIC_VECTOR(to_signed(1, 32));
		B <= std_LOGIC_VECTOR(to_signed(1, 32));
		ula_op <= ADD;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(2, 32)));
		
		A <= std_LOGIC_VECTOR(to_signed(0, 32));
		B <= std_LOGIC_VECTOR(to_signed(0, 32));
		ula_op <= ADD;
		wait for 10 ns;
		assert (zero = std_LOGIC(to_signed(1, 1)(0)));
		
		A <= std_LOGIC_VECTOR(to_signed(5, 32));
		B <= std_LOGIC_VECTOR(to_signed(-6, 32));
		ula_op <= ADD;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(-1, 32)));
		
		A <= x"FFFFFFFF";
		B <= x"00000001";
		ula_op <= ADD;
		wait for 10 ns;
		assert (overflow = '1');
		
		-- TESTS ADDU
		
		A <= std_LOGIC_VECTOR(to_unsigned(1, 32));
		B <= std_LOGIC_VECTOR(to_unsigned(1, 32));
		ula_op <= ADDU;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_unsigned(2, 32)));
		
		A <= std_LOGIC_VECTOR(to_unsigned(0, 32));
		B <= std_LOGIC_VECTOR(to_unsigned(0, 32));
		ula_op <= ADDU;
		wait for 10 ns;
		assert (zero = std_LOGIC(to_unsigned(1, 1)(0)));
		
		A <= std_LOGIC_VECTOR(to_unsigned(5, 32));
		B <= x"FFFFFFF0";
		ula_op <= ADDU;
		wait for 10 ns;
		assert (ula_out = x"FFFFFFF5");
		
		-- TESTS SUB
		
		A <= std_LOGIC_VECTOR(to_signed(10, 32));
		B <= std_LOGIC_VECTOR(to_signed(5, 32));
		ula_op <= SUB;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(5, 32)));
		
		A <= std_LOGIC_VECTOR(to_signed(15, 32));
		B <= std_LOGIC_VECTOR(to_signed(15, 32));
		ula_op <= SUB;
		wait for 10 ns;
		assert (zero = '1');
		
		A <= std_LOGIC_VECTOR(to_signed(10, 32));
		B <= std_LOGIC_VECTOR(to_signed(12, 32));
		ula_op <= SUB;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(-2, 32)));
		
		A <= x"80000000";
		B <= x"00000001";
		ula_op <= SUB;
		wait for 10 ns;
		assert (overflow = '1');
		
		-- TESTS SUBU
		
		A <= std_LOGIC_VECTOR(to_unsigned(10, 32));
		B <= std_LOGIC_VECTOR(to_unsigned(5, 32));
		ula_op <= SUBU;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_unsigned(5, 32)));
		
		A <= std_LOGIC_VECTOR(to_unsigned(15, 32));
		B <= std_LOGIC_VECTOR(to_unsigned(15, 32));
		ula_op <= SUBU;
		wait for 10 ns;
		assert (zero = std_LOGIC(to_unsigned(1, 1)(0)));
		
		A <= std_LOGIC_VECTOR(to_unsigned(10, 32));
		B <= std_LOGIC_VECTOR(to_unsigned(12, 32));
		ula_op <= SUBU;
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(-2, 32)));
		
		-- TESTS AND
				
		A <= x"FFFF3000";
		B <= x"FFFF0020";
		ula_op <= AND_OP;
		wait for 10 ns;
		assert (ula_out = x"FFFF0000");
		
		-- TESTS OR
		
		A <= x"30005FFF";
		B <= x"30005000";
		ula_op <= OR_OP;
		wait for 10 ns;
		assert (ula_out = x"30005FFF");
		
		-- TESTS XOR
		
		A <= x"30005FFF";
		B <= x"30005000";
		ula_op <= XOR_OP;
		wait for 10 ns;
		assert (ula_out = x"00000FFF");
		
		-- TESTS NOR
		
		A <= x"30005FFF";
		B <= x"30005000";
		ula_op <= NOR_OP;
		wait for 10 ns;
		assert (ula_out = x"CFFFA000");
		
		-- TESTS SLT
		
		A <= std_LOGIC_VECTOR(to_signed(5, 32));
		B <= std_LOGIC_VECTOR(to_signed(10, 32));
		ula_op <= SLT;
		wait for 10 ns;
		assert (ula_out = x"00000001");
		
		A <= std_LOGIC_VECTOR(to_signed(11, 32));
		B <= std_LOGIC_VECTOR(to_signed(9, 32));
		ula_op <= SLT;
		wait for 10 ns;
		assert (ula_out = x"00000000");
		
		-- TESTS SLTU
		
		A <= std_LOGIC_VECTOR(to_signed(5, 32));
		B <= std_LOGIC_VECTOR(to_signed(10, 32));
		ula_op <= SLTU;
		wait for 10 ns;
		assert (ula_out = x"00000001");
		
		A <= std_LOGIC_VECTOR(to_signed(11, 32));
		B <= std_LOGIC_VECTOR(to_signed(9, 32));
		ula_op <= SLTU;
		wait for 10 ns;
		assert (ula_out = x"00000000");
		
		-- TESTS SLL
		
		A <= std_LOGIC_VECTOR(to_signed(1, 32));
		B <= x"00000001";
		ula_op <= SLL_OP;
		wait for 10 ns;
		assert (ula_out = x"00000002");
		
		A <= std_LOGIC_VECTOR(to_signed(2, 32));
		B <= x"00000001";
		ula_op <= SLL_OP;
		wait for 10 ns;
		assert (ula_out = x"00000004");
		
		-- TESTS SRL
		
		A <= std_LOGIC_VECTOR(to_signed(1, 32));
		B <= x"00000002";
		ula_op <= SRL_OP;
		wait for 10 ns;
		assert (ula_out = x"00000001");
		
		A <= std_LOGIC_VECTOR(to_signed(2, 32));
		B <= x"00000004";
		ula_op <= SRL_OP;
		wait for 10 ns;
		assert (ula_out = x"00000001");
		
		-- TESTS RTR
		
		A <= std_LOGIC_VECTOR(to_signed(4, 32));
		B <= x"AAAACCCB";
		ula_op <= RTR;
		wait for 10 ns;
		assert (ula_out = x"BAAAACCC");
		
		A <= std_LOGIC_VECTOR(to_signed(8, 32));
		B <= x"AAAACCCB";
		ula_op <= RTR;
		wait for 10 ns;
		assert (ula_out = x"CBAAAACC");
		
		-- TESTS RTL
				
		A <= std_LOGIC_VECTOR(to_signed(4, 32));
		B <= x"AAAACCCB";
		ula_op <= RTL;
		wait for 10 ns;
		assert (ula_out = x"AAACCCBA");
		
		A <= std_LOGIC_VECTOR(to_signed(8, 32));
		B <= x"AAAACCCB";
		ula_op <= rtl;
		wait for 10 ns;
		assert (ula_out = x"AACCCBAA");
		
		-- TESTS SRA
		
		A <= std_LOGIC_VECTOR(to_signed(4, 32));
		B <= x"FFFFFF01";
		ula_op <= SRA_OP;
		wait for 10 ns;
		assert (ula_out = x"FFFFFFF0");
		
		A <= std_LOGIC_VECTOR(to_signed(8, 32));
		B <= x"FFFFFF01";
		ula_op <= SRA_OP;
		wait for 10 ns;
		assert (ula_out = x"FFFFFFFF");
		
		-- Test LUI
		
		A <= std_LOGIC_VECTOR(to_signed(0, 32));
		B <= x"0000FFFF";
		ula_op <= LUI;
		wait for 10 ns;
		assert (ula_out = x"FFFF0000");
		
		-- Test ula op 00
		
		ula_control_op <= "00";
		A <= std_LOGIC_VECTOR(to_signed(5, 32));
		B <= std_LOGIC_VECTOR(to_signed(15, 32));
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(20, 32))); -- Tem que somar
		
		-- Test ula op 01

		ula_control_op <= "01";
		A <= std_LOGIC_VECTOR(to_signed(5, 32));
		B <= std_LOGIC_VECTOR(to_signed(15, 32));
		wait for 10 ns;
		assert (ula_out = std_LOGIC_VECTOR(to_signed(-10, 32))); -- Tem que subtrair


	WAIT;                                                       
END PROCESS init;                                                                                   
END ula_arch;
