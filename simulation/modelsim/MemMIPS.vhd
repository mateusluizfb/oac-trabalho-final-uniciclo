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
-- Generated on "06/17/2018 10:36:30"
                                                            
-- Vhdl Test Bench template for design  :  MemMIPS
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY MemMIPS_tb IS
END MemMIPS_tb;
ARCHITECTURE MemMIPS_arch OF MemMIPS_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
signal clk0: std_logic;
SIGNAL m1_sin : STD_LOGIC;
SIGNAL wpc : STD_LOGIC;
signal out_pc: std_logic_vector(31 downto 0);
signal instruction: std_logic_vector(31 downto 0);
COMPONENT MemMIPS
    PORT (
    clk : IN STD_LOGIC;
    clk0: in std_logic;
    m1_sin : IN STD_LOGIC;
    wpc : IN STD_LOGIC;
    instruction: out std_logic_vector(31 downto 0);
    out_pc: out std_logic_vector(31 downto 0)
    );
END COMPONENT;
BEGIN
    i1 : MemMIPS
    PORT MAP (
-- list connections between master ports and signals
    clk => clk,
    clk0 => clk0,
    m1_sin => m1_sin,
    wpc => wpc,
    instruction => instruction,
    out_pc => out_pc
    );
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
        m1_sin <= '1';
        wpc <= '1';
        wait for 100 ps;
        m1_sin <= '0';
        wait for 100 ps;
        wait;
END PROCESS init;                                                                           
END MemMIPS_arch;
