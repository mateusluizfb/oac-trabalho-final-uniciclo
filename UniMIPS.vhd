library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS is
    port (
    clk: in std_logic;
    clk0: in std_logic;
    --m1_sin: in std_logic;
    --wpc: in std_logic;
    --instruction: out std_logic_vector(31 downto 0);
    out_pc: out std_logic_vector(31 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

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
    clock, write_enable, reset  : in  std_logic;
    register_input_1                : in  std_logic_vector(4 downto 0);
    register_input_2                : in  std_logic_vector(4 downto 0);
    register_write                  : in  std_logic_vector(4 downto 0);
    write_data                      : in  std_logic_vector(WSIZE - 1 downto 0);
    register_output_1               : out std_logic_vector(WSIZE - 1 downto 0);
    register_output_2               : out std_logic_vector(WSIZE - 1 downto 0)
    );
end component;


begin

end architecture ; -- arch
