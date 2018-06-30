library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.ula_package.all;

entity ula_mem_tb is
end entity ; -- ula_mem_tb

architecture arch of ula_mem_tb is
signal     clk, clk0                       : in std_logic;
signal     md_data                         : in std_logic_vector(31 downto 0);
signal     r1_out                          : out std_logic_vector(31 downto 0);
signal     r2_out                          : out std_logic_vector(31 downto 0);
signal     r1_read                         : out std_logic_vector(4 downto 0);
signal     r2_read                         : out std_logic_vector(4 downto 0);
signal     reg_input_write                 : in std_logic_vector(4 downto 0);
signal     wb_sin                          : in std_logic;
signal     wren_breg                       : in std_logic;
signal     mux_sin                         : in std_logic;
signal     mux_reg_dst                     : in std_logic;
signal     wpc                             : in std_logic;
signal     ula_sel                         : in std_logic;
signal     ula_op                          : in ULA_OPERATION;
signal     wren_md                         : in std_logic;
signal     zero                            : out std_logic;
signal     ovfl                            : out std_logic;
signal     instruction_out                 : out std_logic_vector(31 downto 0);
signal     inst_counter                    : out std_logic_vector(31 downto 0);
signal     alu_out                         : out std_logic_vector(31 downto 0);
signal     md_out                          : out std_logic_vector(31 downto 0)
component UniMIPS
    port (
    clk, clk0                       : in std_logic;
    --write_data                      : in std_logic_vector(31 downto 0);
    md_data                         : in std_logic_vector(31 downto 0);
    r1_out                          : out std_logic_vector(31 downto 0);
    r2_out                          : out std_logic_vector(31 downto 0);
    r1_read                         : out std_logic_vector(4 downto 0);
    r2_read                         : out std_logic_vector(4 downto 0);
    reg_input_write                 : in std_logic_vector(4 downto 0);
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
    md_data => md_data,
    r1_out => r1_out, 
    r2_out => r2_out,
    r1_read => r1_read,
    r2_read => r2_read,
    reg_input_write => reg_input_write,
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

init : process
begin
    
    wait;
end process ; -- init

end architecture ; -- arch
