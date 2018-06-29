library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity somador_pc is
  port (
	input1, input2	: in std_logic_vector(31 downto 0);
	output1			: out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- somador_pc

architecture arch of somador_pc is
signal out1: std_logic_vector(31 downto 0);
begin
	output1 <= out1;
	somador_pc_process : process( input1)
	begin
		out1 <= std_logic_vector(unsigned(input1) + unsigned(input2));
	end process ; -- somador_pc_process
end architecture ; -- arch