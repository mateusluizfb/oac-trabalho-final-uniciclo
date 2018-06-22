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
signal inst_counter : std_logic_vector(31 downto 0);
signal instruction_out : std_logic_vector(31 downto 0);
signal r1_out : std_logic_vector(31 downto 0);
signal r2_out : std_logic_vector(31 downto 0);
signal r1_read : std_logic_vector(4 downto 0);
signal r2_read : std_logic_vector(4 downto 0);
signal reg_input_write : std_logic_vector(4 downto 0);
signal wren_breg : std_logic;
signal wpc : std_logic;
signal write_data : std_logic_vector(31 downto 0);
component UniMIPS
    port (
    clk : in std_logic;
    clk0 : in std_logic;
    mux_reg_dst : in std_logic;
    mux_sin : in std_logic;
    inst_counter : out std_logic_vector(31 downto 0);
    instruction_out : out std_logic_vector(31 downto 0);
    r1_out : out std_logic_vector(31 downto 0);
    r2_out : out std_logic_vector(31 downto 0);
    r1_read : out std_logic_vector(4 downto 0);
    r2_read : out std_logic_vector(4 downto 0);
    reg_input_write : in std_logic_vector(4 downto 0);
    wren_breg : in std_logic;
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
    inst_counter => inst_counter,
    instruction_out => instruction_out,
    r1_out => r1_out,
    r2_out => r2_out,
    r1_read => r1_read,
    r2_read => r2_read,
    reg_input_write => reg_input_write,
    wren_breg => wren_breg,
    wpc => wpc,
    write_data => write_data
    );

init : process
begin
    mux_reg_dst <= '1';
    mux_sin <= '1';
    wren_breg <= '1';

    -- inicializa breg
    wpc <= '0';
    write_data <= std_logic_vector(to_unsigned(1, 32));
    reg_input_write <= std_logic_vector(to_unsigned(1, 5));
    
    -- 1
    reg_input_write <= (std_logic_vector(to_unsigned(1, 5)));
    write_data <= (std_logic_vector(to_unsigned(1, 32)));
    wait for 100 ps;
     -- 2
    reg_input_write <= (std_logic_vector(to_unsigned(2, 5)));
    write_data <= (std_logic_vector(to_unsigned(2, 32)));
    wait for 100 ps;
     -- 3
    reg_input_write <= (std_logic_vector(to_unsigned(3, 5)));
    write_data <= (std_logic_vector(to_unsigned(3, 32)));
    wait for 100 ps;
     -- 4
    reg_input_write <= (std_logic_vector(to_unsigned(4, 5)));
    write_data <= (std_logic_vector(to_unsigned(4, 32)));
    wait for 100 ps;
     -- 5
    reg_input_write <= (std_logic_vector(to_unsigned(5, 5)));
    write_data <=  (std_logic_vector(to_unsigned(5, 32)));
    wait for 100 ps;
     -- 6
    reg_input_write <= (std_logic_vector(to_unsigned(6, 5)));
    write_data <=  (std_logic_vector(to_unsigned(6, 32)));
    wait for 100 ps;
     -- 7
    reg_input_write <= (std_logic_vector(to_unsigned(7, 5)));
    write_data <=  (std_logic_vector(to_unsigned(7, 32)));
    wait for 100 ps;
     -- 8
    reg_input_write <= (std_logic_vector(to_unsigned(8, 5)));
    write_data <=  (std_logic_vector(to_unsigned(8, 32)));
    wait for 100 ps;
     -- 9
    reg_input_write <= (std_logic_vector(to_unsigned(9, 5)));
    write_data <=  (std_logic_vector(to_unsigned(9, 32)));
    wait for 100 ps;
     -- 10
    reg_input_write <= (std_logic_vector(to_unsigned(10, 5)));
    write_data <=  (std_logic_vector(to_unsigned(10, 32)));
    wait for 100 ps;
     -- 11
    reg_input_write <= (std_logic_vector(to_unsigned(11, 5)));
    write_data <=  (std_logic_vector(to_unsigned(11, 32)));
    wait for 100 ps;
     -- 12
    reg_input_write <= (std_logic_vector(to_unsigned(12, 5)));
    write_data <=  (std_logic_vector(to_unsigned(12, 32)));
    wait for 100 ps;
     -- 13
    reg_input_write <= (std_logic_vector(to_unsigned(13, 5)));
    write_data <=  (std_logic_vector(to_unsigned(13, 32)));
    wait for 100 ps;
     -- 14
    reg_input_write <= (std_logic_vector(to_unsigned(14, 5)));
    write_data <=  (std_logic_vector(to_unsigned(14, 32)));
    wait for 100 ps;
     -- 15
    reg_input_write <= (std_logic_vector(to_unsigned(15, 5)));
    write_data <=  (std_logic_vector(to_unsigned(15, 32)));
    wait for 100 ps;
     -- 16
    reg_input_write <= (std_logic_vector(to_unsigned(16, 5)));
    write_data <=  (std_logic_vector(to_unsigned(16, 32)));
    wait for 100 ps;
     -- 17
    reg_input_write <= (std_logic_vector(to_unsigned(17, 5)));
    write_data <=  (std_logic_vector(to_unsigned(17, 32)));
    wait for 100 ps;
     -- 18
    reg_input_write <= (std_logic_vector(to_unsigned(18, 5)));
    write_data <=  (std_logic_vector(to_unsigned(18, 32)));
    wait for 100 ps;
     -- 19
    reg_input_write <= (std_logic_vector(to_unsigned(19, 5)));
    write_data <=  (std_logic_vector(to_unsigned(19, 32)));
    wait for 100 ps;
     -- 20
    reg_input_write <= (std_logic_vector(to_unsigned(20, 5)));
    write_data <=  (std_logic_vector(to_unsigned(20, 32)));
    wait for 100 ps;
     -- 21
    reg_input_write <= (std_logic_vector(to_unsigned(21, 5)));
    write_data <=  (std_logic_vector(to_unsigned(21, 32)));
    wait for 100 ps;
     -- 22
    reg_input_write <= (std_logic_vector(to_unsigned(22, 5)));
    write_data <=  (std_logic_vector(to_unsigned(22, 32)));
    wait for 100 ps;
     -- 23
    reg_input_write <= (std_logic_vector(to_unsigned(23, 5)));
    write_data <=  (std_logic_vector(to_unsigned(23, 32)));
    wait for 100 ps;
     -- 24
    reg_input_write <= (std_logic_vector(to_unsigned(24, 5)));
    write_data <=  (std_logic_vector(to_unsigned(24, 32)));
    wait for 100 ps;
     -- 25
    reg_input_write <= (std_logic_vector(to_unsigned(25, 5)));
    write_data <=  (std_logic_vector(to_unsigned(25, 32)));
    wait for 100 ps;
     -- 26
    reg_input_write <= (std_logic_vector(to_unsigned(26, 5)));
    write_data <=  (std_logic_vector(to_unsigned(26, 32)));
    wait for 100 ps;
     -- 27
    reg_input_write <= (std_logic_vector(to_unsigned(27, 5)));
    write_data <=  (std_logic_vector(to_unsigned(27, 32)));
    wait for 100 ps;
     -- 28
    reg_input_write <= (std_logic_vector(to_unsigned(28, 5)));
    write_data <=  (std_logic_vector(to_unsigned(28, 32)));
    wait for 100 ps;
     -- 29
    reg_input_write <= (std_logic_vector(to_unsigned(29, 5)));
    write_data <=  (std_logic_vector(to_unsigned(29, 32)));
    wait for 100 ps;
     -- 30
    reg_input_write <= (std_logic_vector(to_unsigned(30, 5)));
    write_data <=  (std_logic_vector(to_unsigned(30, 32)));
    wait for 100 ps;
     -- 31
    reg_input_write <= (std_logic_vector(to_unsigned(31, 5)));
    write_data <=  (std_logic_vector(to_unsigned(31, 32)));

    wait for 100 ps;
    wren_breg <= '0';
    wpc <= '1';
    wait for 100 ps;
    mux_sin <= '0';
    wait for 100 ps;
    wait;
end process init; -- init
end architecture ; -- arch
