library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS is
    port (
    clk: in std_logic;
    clk0: in std_logic;
    r1_out: out std_logic_vector(31 downto 0);
    r2_out: out std_logic_vector(31 downto 0);
    --m1_sin: in std_logic;
    --wpc: in std_logic;
    --instruction: out std_logic_vector(31 downto 0);
    out_pc: out std_logic_vector(31 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

-- sinais de controle do breg
signal wren_breg: std_logic;
signal reset_breg: std_logic;

-- sinais de saida da memoria e entrada do breg
signal instruction: std_logic_vector(31 downto 0);

component MemMIPS
    port (
    clk: in std_logic;
    clk0: in std_logic;
    m1_sin: in std_logic;
    wpc: in std_logic;
    instruction: out std_logic_vector(31 downto 0);
    out_pc: out std_logic_vector(31 downto 0)
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


begin

    -- instacia  a memoria de instruções
    inst_mem_i1: MemMIPS
    port map (
        clk => clk;
        clk0 => ,
        m1_sin => ,
        wpc => ,
        instruction => instruction;
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
        register_write   => instruction(15 downto 11),
        write_data => ,
        register_output_1 => r1_out;
        register_output_2 => r2_out
    );

end architecture ; -- arch
