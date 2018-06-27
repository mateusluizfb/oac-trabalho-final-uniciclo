library ieee;
use ieee.std_logic_1164.all;

entity jump_entity is
	port(
		adder_in1, adder_in2	:	in std_logic_vector(31 downto 0); -- Sinais de entrada do somador
		branch, zer, jump		:	in std_logic;							 -- Sinais enviados pelo controle
		mux_branch_in			:	in std_logic_vector(31 downto 0); -- Endereço calculado de jump
		mux_branch_out			:	out std_logic
	);
end entity jump_entity;