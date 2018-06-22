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
		output(15 downto 0)  <= input(15 downto 0);
		output(31 downto 16) <= (others => input(15));
	end process;

end architecture;