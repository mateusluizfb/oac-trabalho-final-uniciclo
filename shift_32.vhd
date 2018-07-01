library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity shift_32 is
	port (
	  shift_32_input	 :	in std_logic_vector(31 downto 0);
	  shift_32_output : out std_logic_vector(31 downto 0)
	);
end entity shift_32;

architecture behaviour of shift_32 is
begin
	shift_32_output <= std_logic_vector(shift_left(unsigned(shift_32_input), 2));
end behaviour;