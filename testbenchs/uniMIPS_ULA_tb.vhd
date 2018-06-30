use work.ula_package.all;
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS_tb is
end UniMIPS_tb;
architecture UniMIPS_arch of UniMIPS_tb is
signal clk : std_logic := '0';
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
signal overflow : std_logic;
signal zero		 : std_logic;
signal ula_out	 : std_logic_vector(31 downto 0);
signal ula_op   : ULA_OPERATION;

constant CLK_PERIOD : time := 100 ps;
constant CLK0_PERIOD : time := 10 ps;

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
    write_data : in std_logic_vector(31 downto 0);
	 overflow : out std_logic;
	 zero : out std_logic;
	 ula_out : out std_logic_vector(31 downto 0);
	 ula_op  : in ULA_OPERATION
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
		 write_data => write_data,
		 overflow => overflow,
		 zero => zero,
		 ula_out => ula_out,
		 ula_op  => ula_op
    );


Clk_process :process
begin
    clk <= '0';
    wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
    clk <= '1';
    wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

Clk0_process :process
begin
    clk0 <= '0';
    wait for CLK0_PERIOD/2;  --for half of clock period clk stays at '0'.
    clk0 <= '1';
    wait for CLK0_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

init : process
begin	 
	 -- PARA RODAR O CÓDIGO É NECESSÁRIO BOTAR O MIF DE TESTE COM A ULA

    mux_reg_dst <= '1';
    mux_sin <= '1';
    wren_breg <= '1';
	 wpc <= '0'; -- desabilitar o pc
	 
	 reg_input_write <= (std_logic_vector(to_unsigned(8, 5)));
	 write_data <=  (std_logic_vector(to_unsigned(8, 32))); -- $t0 = 5
	 wait for 100 ns;
	 reg_input_write <= (std_logic_vector(to_unsigned(8, 5)));
	 write_data <=  (std_logic_vector(to_unsigned(8, 32))); -- $t1 = 6
	 wait for 100 ns;
	 
	 -- TODO add $s0, $t0, $t1 / 0x01098020
	 
	 -- $t0 = 0x80000000
	 -- $t1 = 0x00000001
	 -- sub $s0, $t0, $t1
	 -- Overflow 1
	 
	 -- $t0 = 10
	 -- $t1 = 10
	 -- beq $t0, $t1, LABEL
	 -- Zero 1
	 
    wait;
end process init; -- init
end architecture ; -- arch
