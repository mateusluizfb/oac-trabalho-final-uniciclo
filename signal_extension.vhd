library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_extension is
	port (
		input  : in  std_logic_vector(15 downto 0);
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture signal_extension_arch of signal_extension is
begin

	init: process (input)
	begin
		for i in 0 to 15 loop
			output(i) <= input(i);
		end loop;
		
		for j in 16 to 31 loop
			output(j) <= input(15);
		end loop;
	end process;

end architecture;