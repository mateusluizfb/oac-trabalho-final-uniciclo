library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity MemMIPS is
    port (
     clk: in std_logic;
     clk0: in std_logic;
     m1_sin: in std_logic;
     wpc: in std_logic;
     instruction: out std_logic_vector(31 downto 0);
     out_pc: out std_logic_vector(31 downto 0)
     );
end MemMIPS ; -- MemMIPS
architecture arch of MemMIPS is
--signal clk : std_logic;
--signal m1_sin : std_logic;
--signal wpc : std_logic;
signal sin4: std_logic_vector(31 downto 0) := X"00000004";

signal init_address: std_logic_vector(31 downto 0);
signal jump_address: std_logic_vector(31 downto 0);
signal mux_i1_out: std_logic_vector(31 downto 0);
signal pc_out: std_logic_vector(31 downto 0);
SIGNAL data : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL q : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL wren : STD_LOGIC;

component m1
    port (
    sel : in std_logic;
    input0 : in std_logic_vector(31 downto 0);
    input1 : in std_logic_vector(31 downto 0);
    output1: out std_logic_vector(31 downto 0)
  );
end component;

component pc
    port (
    clk: in std_logic;
    wpc: in std_logic;
    in1: in std_logic_vector(31 downto 0);
    out1: out std_logic_vector(31 downto 0)
  );
end component;

component somador_pc
    port (
    input1: in std_logic_vector(31 downto 0);
    output1: out std_logic_vector(31 downto 0)
  );
end component;

COMPONENT ramtest
    PORT (
    address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clock : IN STD_LOGIC;
    data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    wren : IN STD_LOGIC
    );
END COMPONENT;

begin
    mux_i1: m1
    port map (
        sel => m1_sin,
        input0 => jump_address,
        input1 => init_address,
        output1 => mux_i1_out
    );

    pc_i1: pc
    port map (
        clk => clk,
        wpc => wpc,
        in1 => mux_i1_out,
        out1 => pc_out
    );

    somador_pc_i1: somador_pc
    port map (
        input1 => pc_out,
        output1 => jump_address
    );

    i1 : ramtest
    PORT MAP (
      -- list connections between master ports and signals
      address => pc_out(9 downto 2),
      clock => clk0,
      data => data,
      q => instruction,
      wren => wren
    );

init : process (clk,pc_out)
begin
    wren <= '0';
    init_address <= X"00000000";
    data <= X"00000000";
    out_pc <= pc_out;
end process ; -- init
end architecture ; -- arch
