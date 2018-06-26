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
-- Generated on "06/22/2018 18:39:48"
                                                            
-- Vhdl Test Bench template for design  :  signal_extension
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY signal_extension_tb IS
END signal_extension_tb;
ARCHITECTURE signal_extension_arch OF signal_extension_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL input : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL output : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT signal_extension
	PORT (
	input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : signal_extension
	PORT MAP (
-- list connections between master ports and signals
	input => input,
	output => output
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN
	input <= x"7FFF";
	wait for 10 ns;
	assert (output = x"00007FFF");
	
	input <= x"8000";
	wait for 10 ns;
	assert (output = x"FFFF8000");
WAIT;                                                       
END PROCESS init;                                           
END signal_extension_arch;
