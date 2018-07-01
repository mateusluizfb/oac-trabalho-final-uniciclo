library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.ula_package.all;

entity ula_mem_tb is
end entity ; -- ula_mem_tb

architecture arch of ula_mem_tb is
signal     clk, clk0                       : std_logic;
--signal     md_data                         : std_logic_vector(31 downto 0);
signal     r1_out                          : std_logic_vector(31 downto 0);
signal     r2_out                          : std_logic_vector(31 downto 0);
signal     r1_read                         : std_logic_vector(4 downto 0);
signal     r2_read                         : std_logic_vector(4 downto 0);
--signal     reg_input_write                 : std_logic_vector(4 downto 0);
signal     wb_sin                          : std_logic;
signal     wren_breg                       : std_logic;
signal     mux_sin                         : std_logic;
signal     mux_reg_dst                     : std_logic;
signal     wpc                             : std_logic;
signal     ula_sel                         : std_logic;
signal     ula_op                          : ULA_OPERATION;
signal     wren_md                         : std_logic;
signal     zero                            : std_logic;
signal     ovfl                            : std_logic;
signal     instruction_out                 : std_logic_vector(31 downto 0);
signal     inst_counter                    : std_logic_vector(31 downto 0);
signal     alu_out                         : std_logic_vector(31 downto 0);
signal     md_out                          : std_logic_vector(31 downto 0);

constant CLK_PERIOD : time := 100 ps;
constant CLK0_PERIOD : time := 10 ps;


component UniMIPS
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
end component;

begin
    i1: UniMIPS
    port map (
    clk => clk,
    clk0 => clk0,
    --md_data => md_data,
    r1_out => r1_out, 
    r2_out => r2_out,
    r1_read => r1_read,
    r2_read => r2_read,
    --reg_input_write => reg_input_write,
    wb_sin => wb_sin,
    wren_breg => wren_breg,
    mux_sin => mux_sin,
    mux_reg_dst => mux_reg_dst,
    wpc => wpc,
    ula_sel => ula_sel,
    ula_op => ula_op,
    wren_md => wren_md,
    zero => zero,
    ovfl => ovfl,
    instruction_out => instruction_out,
    inst_counter => inst_counter,
    alu_out => alu_out,
    md_out => md_out
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
    mux_sin <= '1';
    wpc <= '1';
    wait for 50 ps;
    mux_sin <= '0';
    -- addi $4, $0, 8192 (0x2000)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(0, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002000") report "ula failure" severity failure;
    assert (md_out = X"00000001") report "md failure" severity failure;
    wait for 50 ps;

    -- addi $5, $0, 8228 (0x2024)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(0, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(5, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002024") report "ula failure" severity failure;
    assert (md_out = X"00000009") report "md failure" severity failure;
    wait for 50 ps;

    -- lw $5, 0($5)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '1';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(5, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(5, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002024") report "ula failure" severity failure;
    assert (md_out = X"00000009") report "md failure" severity failure;
    wait for 50 ps;

    -- addu $8, $0, $4
    wait for 20 ps;
    ula_op <= ADDU;
    ula_sel <= '0';
    wren_breg <= '1';
    mux_reg_dst <= '1';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(0, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002000") report "ula failure" severity failure;
    assert (md_out = X"00000001") report "md failure" severity failure;
    wait for 50 ps;

    -- lw $4, 0($8)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '1';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002000") report "ula failure" severity failure;
    assert (md_out = X"00000001") report "md failure" severity failure;
    wait for 50 ps;

    -- lw $4, 4($8)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '1';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002004") report "ula failure" severity failure;
    assert (md_out = X"00000002") report "md failure" severity failure;
    wait for 50 ps;

    -- lw $4, 8($8)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '1';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002008") report "ula failure" severity failure;
    assert (md_out = X"00000003") report "md failure" severity failure;
    wait for 50 ps;

    -- lw $4, 12($8)
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '1';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(4, 5))) report "breg failure" severity failure;
    assert (alu_out = X"0000200C") report "ula failure" severity failure;
    assert (md_out = X"00000004") report "md failure" severity failure;
    wait for 50 ps;

    -- addi $8, $8, 4
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(8, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00002004") report "ula failure" severity failure;
    --assert (md_out = X"00000004") report "md failure" severity failure;
    wait for 50 ps;

    -- addi $5, $5, -1
    wait for 20 ps;
    ula_op <= ADD;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(5, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(5, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00000008") report "ula failure" severity failure;
    --assert (md_out = X"00000008") report "md failure" severity failure;
    wait for 50 ps;

    -- addiu $2, $0, 1
    wait for 20 ps;
    ula_op <= ADDU;
    ula_sel <= '1';
    wren_breg <= '1';
    mux_reg_dst <= '0';
    wren_md <= '0';
    wb_sin <= '0';
    wait for 30 ps;
    assert (r1_read = std_logic_vector(to_unsigned(0, 5))) report "breg failure" severity failure;
    assert (r2_read = std_logic_vector(to_unsigned(2, 5))) report "breg failure" severity failure;
    assert (alu_out = X"00000001") report "ula failure" severity failure;
    --assert (md_out = X"00000008") report "md failure" severity failure;
    wait for 50 ps;

wait;
end process ; -- init

end architecture ; -- arch
