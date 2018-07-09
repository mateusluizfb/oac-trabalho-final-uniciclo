library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_7seg is
  port (
	input: std_logic_vector(31 downto 0);
	output1: std_logic_vector(3 downto 0); 
	output2: std_logic_vector(3 downto 0); 
	output3: std_logic_vector(3 downto 0); 
	output4: std_logic_vector(3 downto 0); 
	output5: std_logic_vector(3 downto 0); 
	output6: std_logic_vector(3 downto 0); 
	output7: std_logic_vector(3 downto 0); 
	output8: std_logic_vector(3 downto 0) 
  ) ;
end entity ; -- display_7seg
