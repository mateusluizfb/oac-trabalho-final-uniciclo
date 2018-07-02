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
SIGNAL clk : STD_LOGIC;
SIGNAL ovfl : STD_LOGIC;
SIGNAL eret : STD_LOGIC;
SIGNAL branch : STD_LOGIC;
SIGNAL jump : STD_LOGIC;
SIGNAL zero : STD_LOGIC;
SIGNAL pc_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL shift26_in : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL shift32_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL branch_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

constant CLK_PERIOD : time := 100 ps;
constant CLK0_PERIOD : time := 10 ps;

COMPONENT branch_entity
    PORT (
    clk : in STD_LOGIC;
    branch : IN STD_LOGIC;
    branch_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    jump : IN STD_LOGIC;
    ovfl : IN STD_LOGIC;
    eret : IN STD_LOGIC;
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
    clk => clk,
    ovfl => ovfl,
    eret => eret,
    branch => branch,
    branch_out => branch_out,
    jump => jump,
    pc_value => pc_value,
    shift26_in => shift26_in,
    shift32_in => shift32_in,
    zero => zero
    );

Clk_process : process
begin
    clk <= '0';
    wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
    clk <= '1';
    wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once 
          
    -- Passa o valor do pc + 4 direto pra saída
    wait for 50 ps;
    pc_value   <= x"0000CFA0";
    wait for 50 ps;
    pc_value      <= x"0000CFA0";
    branch        <= '0';
    ovfl          <= '0';
    eret          <= '0';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000000";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert ( branch_out = x"0000CFA4");
    
    -- soma o imediato shiftado << 2 e soma com o PC
    --pc_value   <= x"0000CFA0";
    wait for 50 ps;
    branch        <= '1';
    ovfl          <= '0';
    eret          <= '0';
    zero          <= '1';
    jump          <= '0';
    shift26_in <= "00" & x"000000";
    shift32_in <= x"0000000C";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert ( branch_out = x"0000CFD8");

    -- jump
    --pc_value   <= x"E000CFA4";
    wait for 50 ps;
    branch    <= '0';
    ovfl      <= '0';
    eret      <= '0';
    zero          <= '0';
    jump          <= '1';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"00003030");

    -- no jump
    --pc_value   <= x"E0003030";
    wait for 50 ps;
    branch        <= '0';
    ovfl          <= '0';
    eret          <= '0';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"00003034");

    -- exception handling
    --pc_value   <= x"E0003034";
    wait for 50 ps;
    branch        <= '0';
    ovfl          <= '1';
    eret          <= '0';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"00004380");

    -- exception handling
    --pc_value   <= x"00004380";
    wait for 50 ps;
    branch        <= '0';
    ovfl          <= '0';
    eret          <= '0';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"00004384");

    -- return address
    --pc_value   <= x"00004384";
    wait for 50 ps;
    branch        <= '0';
    ovfl          <= '0';
    eret          <= '1';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"00003038");

    --pc_value   <= x"E0003038";
    wait for 50 ps;
    branch        <= '0';
    ovfl          <= '0';
    eret          <= '0';
    zero          <= '0';
    jump          <= '0';
    shift26_in <= "00" & x"000C0C";
    shift32_in <= x"00000000";
    wait for 50 ps;
    pc_value   <= branch_out;
    assert (branch_out = x"0000303C");
    wait for 100 ps;
WAIT;                                                       
END PROCESS init;                                    
END branch_entity_arch;
