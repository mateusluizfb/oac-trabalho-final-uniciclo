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
-- Generated on "07/01/2018 16:34:02"
                                                            
-- Vhdl Test Bench template for design  :  controle
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY controle_tb IS
END controle_tb;
ARCHITECTURE controle_arch OF controle_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL aluop : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL alusrc : STD_LOGIC;
SIGNAL beq : STD_LOGIC;
SIGNAL bne : STD_LOGIC;
SIGNAL jump : STD_LOGIC;
SIGNAL memread : STD_LOGIC;
SIGNAL memtoreg : STD_LOGIC;
SIGNAL memwrite : STD_LOGIC;
SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL regdst : STD_LOGIC;
SIGNAL regwrite : STD_LOGIC;
COMPONENT controle
	PORT (
	aluop : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	alusrc : OUT STD_LOGIC;
	beq : OUT STD_LOGIC;
	bne : OUT STD_LOGIC;
	jump : OUT STD_LOGIC;
	memread : OUT STD_LOGIC;
	memtoreg : OUT STD_LOGIC;
	memwrite : OUT STD_LOGIC;
	opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	regdst : OUT STD_LOGIC;
	regwrite : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : controle
	PORT MAP (
-- list connections between master ports and signals
	aluop => aluop,
	alusrc => alusrc,
	beq => beq,
	bne => bne,
	jump => jump,
	memread => memread,
	memtoreg => memtoreg,
	memwrite => memwrite,
	opcode => opcode,
	regdst => regdst,
	regwrite => regwrite
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
	opcode <=  "000000"; -- TIPO R
	wait for 4 ps;
	assert(aluop  = "000");
	assert(regdst = '1');
	assert(alusrc = '0');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');

	opcode <=  "001100"; --ANDI
	wait for 4 ps;
	assert(aluop  = "100");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "001101"; -- ORI
	wait for 4 ps;
	assert(aluop  = "101");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "001000"; -- ADDI
	wait for 4 ps;
	assert(aluop  = "001");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "001001"; -- ADDIU
	wait for 4 ps;
	assert(aluop  = "010");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "000100"; -- BEQ
	wait for 4 ps;
	assert(aluop  = "011");
	assert(regdst = '1');
	assert(alusrc = '0');
	assert(memtoreg = '0');
	assert(regwrite = '0');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '1');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "000101"; --BNE
	wait for 4 ps;
	assert(aluop  = "011");
	assert(regdst = '1');
	assert(alusrc = '0');
	assert(memtoreg = '0');
	assert(regwrite = '0');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '1');
	assert(jump	= '0');

	opcode <=  "000010"; --J
	wait for 4 ps;
	assert(aluop  = "010");
	assert(regdst = '0');
	assert(alusrc = '0');
	assert(memtoreg = '0');
	assert(regwrite = '0');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '1');
	
	opcode <=  "000011"; -- JAL
	wait for 4 ps;
	assert(aluop  = "010");
	assert(regdst = '1');
	assert(alusrc = '0');
	assert(memtoreg = '0');
	assert(regwrite = '0');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '1');
	
	opcode <=  "001111";  -- LUI
	wait for 4 ps;
	assert(aluop  = "111");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "100011"; -- LW
	wait for 4 ps;
	assert(aluop  = "010");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '1');
	assert(regwrite = '1');
	assert(memread  = '1');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "001010"; -- SLTI
	wait for 4 ps;
	assert(aluop  = "110");
	assert(regdst = '0');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '1');
	assert(memread  = '0');
	assert(memwrite = '0');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "101011"; -- SW
	wait for 4 ps;
	assert(aluop  = "010");
	assert(regdst = '1');
	assert(alusrc = '1');
	assert(memtoreg = '0');
	assert(regwrite = '0');
	assert(memread  = '0');
	assert(memwrite = '1');
	assert(beq = '0');
	assert(bne	= '0');
	assert(jump	= '0');
	
	opcode <=  "111111"; -- OPERACAO NAO IMPLEMENTADA QUALQUER
	wait for 4 ps;
	assert(aluop  = "---");
	assert(regdst = '-');
	assert(alusrc = '-');
	assert(memtoreg = '-');
	assert(regwrite = '-');
	assert(memread  = '-');
	assert(memwrite = '-');
	assert(beq = '-');
	assert(bne	= '-');
	assert(jump	= '-');
	
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
END controle_arch;
