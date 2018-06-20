library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS is
    port (
    clk: in std_logic;
    clk0: in std_logic;
    write_data: in std_logic_vector(31 downto 0);
    r1_out: out std_logic_vector(31 downto 0);
    r2_out: out std_logic_vector(31 downto 0);
    -- sinais de controle
    mux_sin: in std_logic;
    mux_reg_dst: in std_logic;
    wpc: in std_logic;
    --*sinais de controle
    -- sinal de entrada breg
    out_pc: out std_logic_vector(31 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

-- sinais de controle do breg
signal wren_breg: std_logic;
signal reset_breg: std_logic;

-- sinal de saida da memoria e entrada do breg
signal instruction: std_logic_vector(31 downto 0);
-- sinal de 
signal reg_dst_out: std_logic_vector(4 downto 0);

component MemMIPS
    port (
    clk, clk0, mux_sin, wpc         : in std_logic;
    instruction                     : out std_logic_vector(31 downto 0);
    out_pc                          : out std_logic_vector(31 downto 0)
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
    generic (WSIZE : natural := 5);
    port (
    sel                             : in std_logic;
    input0                          : in std_logic_vector(4 downto 0);
    input1                          : in std_logic_vector(4 downto 0);
    output1                         : out std_logic_vector(4 downto 0)
  );
end component;

begin

    -- instacia  a memoria de instruções
    inst_mem_i1: MemMIPS
    port map (
        clk => clk,
        clk0 => clk0,
        mux_sin => mux_sin,
        wpc => wpc,
        instruction => instruction,
        out_pc => out_pc
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
        write_data => write_data,
        register_output_1 => r1_out,
        register_output_2 => r2_out
    );

    mux_reg_dst_i1: mux
    generic map (WSIZE => 5)
    port map (
        sel => mux_reg_dst,
        input0 => instruction(20 downto 16),
        input1 => instruction(15 downto 11),
        output1 => reg_dst_out
    );

end architecture ; -- arch
