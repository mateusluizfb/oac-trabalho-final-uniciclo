library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.ula_package.all;

entity UniMIPS is
    port (
    clk, clk0                       : in std_logic;
    --write_data                      : in std_logic_vector(31 downto 0);
    --md_data                         : in std_logic_vector(31 downto 0);
    r1_out                          : out std_logic_vector(31 downto 0);
    r2_out                          : out std_logic_vector(31 downto 0);
    r1_read                         : out std_logic_vector(4 downto 0);
    r2_read                         : out std_logic_vector(4 downto 0);
    --reg_input_write                 : in std_logic_vector(4 downto 0);
    -- sinais de controle
    wb_sin                          : in std_logic;
    wren_breg                       : in std_logic;
    mux_sin                         : in std_logic;
    mux_reg_dst                     : in std_logic;
    wpc                             : in std_logic;
    ula_sel                         : in std_logic;
    ula_op                          : in ULA_OPERATION;
    wren_md                         : in std_logic;
    --*sinais de controle
    -- sinal de entrada breg
    zero                            : out std_logic;
    ovfl                            : out std_logic;
    instruction_out                 : out std_logic_vector(31 downto 0);
    inst_counter                    : out std_logic_vector(31 downto 0);
    alu_out                         : out std_logic_vector(31 downto 0);
    md_out                          : out std_logic_vector(31 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

-- sinais de controle do breg
--signal wren_breg: std_logic;
signal reset_breg: std_logic := '0';

-- sinal de saida da memoria e entrada do breg
signal instruction: std_logic_vector(31 downto 0);
-- sinal de 
signal reg_dst_out: std_logic_vector(4 downto 0);
signal r1, r2, ula_dst: std_logic_vector(31 downto 0);
signal immediate: std_logic_vector(31 downto 0);
signal md_address: std_logic_vector(7 downto 0);
signal write_data_breg: std_logic_vector(31 downto 0);
signal md_read_data: std_logic_vector(31 downto 0);
signal Z: std_logic_vector(31 downto 0);
signal pc_in: std_logic_vector(31 downto 0);
signal counter_to_pc: std_logic_vector(31 downto 0); 

component MemMIPS
    port (
    clk, clk0, wpc 			        : in std_logic;
    pc_in								  : in std_logic_vector(31 downto 0);
	 instruction                    : out std_logic_vector(31 downto 0);
    out_pc                         : out std_logic_vector(31 downto 0)
    );
end component;

component breg 
    port (
    clock, write_enable, reset      : in  std_logic;
    register_input_1                : in  std_logic_vector(4 downto 0);
    register_input_2                : in  std_logic_vector(4 downto 0);
    register_write                  : in  std_logic_vector(4 downto 0);
    write_data                      : in  std_logic_vector(31 downto 0);
    register_output_1               : out std_logic_vector(31 downto 0);
    register_output_2               : out std_logic_vector(31 downto 0)
    );
end component;

component mux
    generic (WSIZE : natural := 32);
    port (
    sel                             : in std_logic;
    input0                          : in std_logic_vector(WSIZE-1 downto 0);
    input1                          : in std_logic_vector(WSIZE-1 downto 0);
    output1                         : out std_logic_vector(WSIZE-1 downto 0)
  );
end component;

component ula
    port (
        A                           : in std_logic_vector(31 downto 0);
        B                           : in std_logic_vector(31 downto 0);
        ula_op                      : in ULA_OPERATION;
        ula_out                     : out std_logic_vector(31 downto 0);
        zero                        : out std_logic;
        overflow                    : out std_logic
    );
end component;

component signal_extension
    port (
        input                       : in  std_logic_vector(15 downto 0);
        output                      : out std_logic_vector(31 downto 0)
    );
end component;

component branch_entity
	port(
		pc_value					:	in std_logic_vector(31 downto 0) := x"00000000"; -- Sinais de entrada do pc
		branch, zero, jump	:	in std_logic := '0';							         -- Sinais enviados pelo controle
		shift26_in				: 	in std_logic_vector(25 downto 0) := "00" & x"000000";
		shift32_in				:	in std_logic_vector(31 downto 0) := x"00000000";
		branch_out				:	out std_logic_vector(31 downto 0)
	);
end component;

component mem_dados
    port (
        address                     : in std_logic_vector(7 downto 0);
        clock                       : in std_logic;
        data                        : in std_logic_vector(31 downto 0);
        wren                        : in std_logic;
        q                           : out std_logic_vector(31 downto 0)
    );
end component;

begin

    instruction_out <= instruction;
    r1_read <= instruction(25 downto 21);
    r2_read <= instruction(20 downto 16);
    r1_out <= r1;
    r2_out <= r2;
    md_out <=  md_read_data;
    alu_out <= Z;
	 inst_counter <= counter_to_pc;
	 
	 -- instancia o component de jump e pc + 4
	 -- TODO: Quando fazer o controle mapear os sinais dos branchs e jumps
	 branch_component_i1: branch_entity
	 port map (
		pc_value 	=> counter_to_pc,
		branch_out 	=> pc_in
	 );
	 
    -- instancia a memoria de instruções
    inst_mem_i1: MemMIPS
    port map (
        clk 			=> clk,
        clk0 			=> clk0,
        wpc 			=> wpc,
		  pc_in  		=> pc_in,
        instruction 	=> instruction,
        out_pc 		=> counter_to_pc
    );

    -- instacia o banco de registradores
    breg_i1: breg
    port map (
        clock => clk,
        write_enable => wren_breg,
        reset => reset_breg,
        register_input_1 => instruction(25 downto 21),
        register_input_2 => instruction(20 downto 16),
        register_write   => reg_dst_out,
        write_data => write_data_breg,
        register_output_1 => r1,
        register_output_2 => r2
    );

    -- instacia o mux que seleciona o registrador a ser escrito
    mux_reg_dst_i1: mux
    generic map (WSIZE => 5)
    port map (
        sel => mux_reg_dst,
        input0 => instruction(20 downto 16),
        input1 => instruction(15 downto 11),
        --input1 => reg_input_write,
        output1 => reg_dst_out
    );

    ula_i1: ula
    port map (
        A => r1,
        B => ula_dst,
        ula_op => ula_op,
        ula_out => Z,
        zero => zero,
        overflow => ovfl
    );

    mux_ula_i1: mux
    generic map (WSIZE => 32)
    port map (
        sel => ula_sel,
        input0 => r2,
        input1 => immediate,
        output1 => ula_dst
    );

    sign_ext_i1: signal_extension
    port map (
        input => instruction(15 downto 0),
        output => immediate
    );

    data_memory_i1: mem_dados
    port map (
        address => Z(9 downto 2),
        clock => clk0,
        data => r2,
        wren => wren_md, 
        q => md_read_data
    );

    mux_md_i1: mux
    generic map (WSIZE => 32)
    port map (
        sel => wb_sin,
        input0 => Z,
        input1 => md_read_data,
        output1 => write_data_breg 
    );

end architecture ; -- arch
