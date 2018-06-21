library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS_tb is
end UniMIPS_tb;
architecture UniMIPS_arch of UniMIPS_tb is
signal clk : std_logic;
signal clk0 : std_logic;
signal mux_reg_dst : std_logic;
signal mux_sin : std_logic;
signal out_pc : std_logic_vector(31 downto 0);
signal r1_out : std_logic_vector(31 downto 0);
signal r2_out : std_logic_vector(31 downto 0);
signal wpc : std_logic;
signal write_data : std_logic_vector(31 downto 0);
component UniMIPS
    port (
    clk : in std_logic;
    clk0 : in std_logic;
    mux_reg_dst : in std_logic;
    mux_sin : in std_logic;
    out_pc : out std_logic_vector(31 downto 0);
    r1_out : out std_logic_vector(31 downto 0);
    r2_out : out std_logic_vector(31 downto 0);
    wpc : in std_logic;
    write_data : in std_logic_vector(31 downto 0)
    );
end component;
begin
    i1 : UniMIPS
    port map (
-- list connections between master ports and signals
    clk => clk,
    clk0 => clk0,
    mux_reg_dst => mux_reg_dst,
    mux_sin => mux_sin,
    out_pc => out_pc,
    r1_out => r1_out,
    r2_out => r2_out,
    wpc => wpc,
    write_data => write_data
    );

init : process( clk, clk0 )
begin
    m1_sin <= '1';
    wpc <= '1';
    wait for 100 ps;
    m1_sin <= '0';
    wait for 100 ps;
    wait;
end process init; -- init
end architecture ; -- arch
