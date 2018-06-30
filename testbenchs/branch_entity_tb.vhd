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
-- Generated on "06/30/2018 12:53:24"
                                                            
-- Vhdl Test Bench template for design  :  branch_entity
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY branch_entity_tb IS
END branch_entity_tb;
ARCHITECTURE branch_entity_arch OF branch_entity_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL branch : STD_LOGIC;
SIGNAL branch_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jump : STD_LOGIC;
SIGNAL pc_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL shift26_in : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL shift32_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL zero : STD_LOGIC;
COMPONENT branch_entity
	PORT (
	branch : IN STD_LOGIC;
	branch_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	jump : IN STD_LOGIC;
	pc_value : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	shift26_in : IN STD_LOGIC_VECTOR(25 DOWNTO 0);
	shift32_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	zero : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : branch_entity
	PORT MAP (
-- list connections between master ports and signals
	branch => branch,
	branch_out => branch_out,
	jump => jump,
	pc_value => pc_value,
	shift26_in => shift26_in,
	shift32_in => shift32_in,
	zero => zero
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once 
	branch 	<= '0';
	zero 	 	<= '0';
	jump 	 	<= '0';
	pc_value <= x"0000CFA0";
	wait for 10 ns;
	assert ( branch_out = x"0000CFA0");
	
WAIT;                                                       
END PROCESS init;                                    
END branch_entity_arch;
