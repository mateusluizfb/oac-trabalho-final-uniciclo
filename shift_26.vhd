library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity shift_26 is
	port (
	  shift_26_input	 :	in std_logic_vector(25 downto 0);
	  shift_26_output : out std_logic_vector(27 downto 0)
	);
end entity shift_26;

architecture behaviour of shift_26 is
	signal aux	:	std_logic_vector(27 downto 0) := "00" & shift_26_input; -- Converte de um bundle de 26 para 28 bits
begin
	shift_26_output <= std_logic_vector(shift_left(unsigned(aux), 2));
end behaviour;