library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.ula_package.all;

entity breg_ula_tb is
end breg_ula_tb;
architecture UniMIPS_arch of breg_ula_tb is
signal clk, clk0                       : std_logic;
signal wren_breg                       : std_logic;
signal mux_sin                         : std_logic;
signal mux_reg_dst                     : std_logic;
signal wpc                             : std_logic;
signal ula_sel                         : std_logic;
signal ula_op                          : ULA_OPERATION;
signal zero                            : std_logic;
signal ovfl                            : std_logic;
signal instruction_out                 : std_logic_vector(31 downto 0);
signal r1_read                         : std_logic_vector(4 downto 0);
signal r2_read                         : std_logic_vector(4 downto 0);
signal reg_input_write                 : std_logic_vector(4 downto 0);
signal inst_counter                    : std_logic_vector(31 downto 0);
signal r1_out                          : std_logic_vector(31 downto 0);
signal r2_out                          : std_logic_vector(31 downto 0);
signal write_data                      : std_logic_vector(31 downto 0);
signal Z                               : std_logic_vector(31 downto 0);

constant CLK_PERIOD : time := 100 ps;
constant CLK0_PERIOD : time := 10 ps;

component UniMIPS
    port (
    clk, clk0                       : in std_logic;
    wren_breg                       : in std_logic;
    mux_sin                         : in std_logic;
    mux_reg_dst                     : in std_logic;
    wpc                             : in std_logic;
    ula_sel                         : in std_logic;
    ula_op                          : in ULA_OPERATION;
    zero                            : out std_logic;
    ovfl                            : out std_logic;
    instruction_out                 : out std_logic_vector(31 downto 0);
    r1_read                         : out std_logic_vector(4 downto 0);
    r2_read                         : out std_logic_vector(4 downto 0);
    reg_input_write                 : in  std_logic_vector(4 downto 0);
    inst_counter                    : out std_logic_vector(31 downto 0);
    r1_out                          : out std_logic_vector(31 downto 0);
    r2_out                          : out std_logic_vector(31 downto 0);
    write_data                      : in  std_logic_vector(31 downto 0);
    Z                               : out std_logic_vector(31 downto 0)
    );
end component;
begin
    i1: UniMIPS
    port map (
-- list connections between master ports and signals
    clk => clk,
    clk0 => clk0,
    write_data => write_data,
    r1_out => r1_out,
    r2_out => r2_out,
    r1_read => r1_read,
    r2_read => r2_read,
    reg_input_write => reg_input_write,
    wren_breg => wren_breg,
    -- sinais de controle
    mux_sin => mux_sin,
    mux_reg_dst => mux_reg_dst,
    wpc => wpc,
    ula_sel => ula_sel,
    ula_op => ula_op,
    --*sinais de controle
    -- sinal de entrada breg
    zero => zero,
    ovfl => ovfl,
    instruction_out => instruction_out,
    inst_counter    => inst_counter,
    Z => Z
    );


Clk_process : process
begin
    clk <= '0';
    wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
    clk <= '1';
    wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

Clk0_process : process
begin
    clk0 <= '0';
    wait for CLK0_PERIOD/2;  --for half of clock period clk stays at '0'.
    clk0 <= '1';
    wait for CLK0_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

init : process
begin
    wren_breg   <= '1';
    mux_sin <= '1';
    mux_reg_dst <= '1';
    wpc <= '0';
    ula_sel <= '0';
    ula_op  <= ADD;
    write_data <= std_logic_vector(to_unsigned(0, 32));
    reg_input_write <= std_logic_vector(to_unsigned(0, 5));
    wait for 10 ps;
    for i in 0 to 32 loop
        write_data <= std_logic_vector(to_unsigned(i, 32));
        reg_input_write <= std_logic_vector(to_unsigned(i, 5));
        wait for 100 ps;
    end loop;
    wren_breg   <= '0';
    mux_reg_dst <= '0';
    mux_sin <= '1';
    wpc <= '1';
    ula_sel <= '1';
    wait for 100 ps;
    mux_sin <= '0';
    -- add
    ula_op  <= ADD;
    assert (Z = std_logic_vector(signed(r1_out) + X"00002000")) report "add failure" severity failure;
    wait for 100 ps;
    ula_sel <= '0';
    -- sub
    wait for 100 ps;
    ula_op <= SUB;
    assert (Z = std_logic_vector(signed(r1_out) + signed(r2_out))) report "add failure" severity failure;
    wait for 100 ps;
wait;
end process ; -- init
end architecture ; -- arch
