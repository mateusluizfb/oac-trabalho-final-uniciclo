library ieee;
use ieee.std_logic_1164.all;

entity branch_entity is
	port(
		pc_value					:	in std_logic_vector(31 downto 0); -- Sinais de entrada do somador
		branch, zero, jump	:	in std_logic;							 -- Sinais enviados pelo controle
		shift26_in				: 	in std_logic_vector(25 downto 0);
		shift32_in				:	in std_logic_vector(31 downto 0);
		branch_out				:	out std_logic_vector(31 downto 0)
	);
end entity branch_entity;

architecture branch_entity_arch of branch_entity is
	
	component somador
		port (
			input1, input2	: in std_logic_vector(31 downto 0);
			output1			: out std_logic_vector(31 downto 0)
		);
	end component somador;	
	
	component shift_26
		port (
		  shift_26_input	 :	in std_logic_vector(25 downto 0);
		  shift_26_output : out std_logic_vector(27 downto 0)
		);
	end component shift_26;

	component shift_32 is
		port (
		  shift_32_input	 :	in std_logic_vector(31 downto 0);
		  shift_32_output : out std_logic_vector(31 downto 0)
		);
	end component shift_32;

	component mux is
	  generic (WSIZE : natural := 32);
	  port (
		 sel : in std_logic;
		 input0 : in std_logic_vector(WSIZE-1 downto 0);
		 input1 : in std_logic_vector(WSIZE-1 downto 0);
		 output1: out std_logic_vector(WSIZE-1 downto 0)
	  ) ;
	end component mux;
	
	signal somador_out	:	std_logic_vector(31 downto 0);
	signal shift26_out	: 	std_logic_vector(27 downto 0);
	signal shift32_out	: 	std_logic_vector(31 downto 0);
	signal mux1_out		:	std_logic_vector(31 downto 0);
	signal mux_branch_out:	std_logic_vector(31 downto 0);
	signal mux1_sel		:	std_logic;
	signal mux2_in			:	std_logic_vector(31 downto 0);
	
	begin
		
		mux1_sel <= branch and zero;
		mux2_in	<=	std_logic_vector(pc_value(31 downto 28) & shift26_out);
		
		shift32_i1: shift_32
			port map (
				shift_32_input  => shift32_in,
				shift_32_output => shift32_out
			);
			
		shift26_i1:	shift_26
			port map (
				shift_26_input	 => shift26_in,
				shift_26_output => shift26_out
			);
		
		somador_i1: somador
			port map (
				input1 	=>  pc_value,
				input2	=>	 shift32_out,
				output1  =>	 somador_out
			);

		mux_i1: mux
			port map (
				sel		=>	mux1_sel,
				input0	=>	pc_value,
				input1	=> somador_out,
				output1	=> mux1_out
			);
			
		mux_i2: mux
			port map (
				sel		=>	jump,
				input0	=>	mux1_out,
				input1	=>	mux2_in,
				output1	=> branch_out
			);
		
end architecture branch_entity_arch;
	
