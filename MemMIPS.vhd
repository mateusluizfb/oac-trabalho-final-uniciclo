library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity MemMIPS is
    port (
     clk: in std_logic;
     clk0: in std_logic;
     mux_sin: in std_logic;
     wpc: in std_logic;
     instruction: out std_logic_vector(31 downto 0);
     out_pc: out std_logic_vector(31 downto 0)
     );
end MemMIPS ; -- MemMIPS
architecture arch of MemMIPS is
--signal clk : std_logic;
--signal mux_sin : std_logic;
--signal wpc : std_logic;
signal sin4: std_logic_vector(31 downto 0) := X"00000004";

signal init_address: std_logic_vector(31 downto 0) := X"00000000";
signal jump_address: std_logic_vector(31 downto 0);
signal mux_i1_out: std_logic_vector(31 downto 0);
signal pc_out: std_logic_vector(31 downto 0);
signal data : std_logic_vector(31 downto 0) := X"00000000";
signal q : std_logic_vector(31 downto 0);
signal wren : std_logic := '0';

component mux
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

component somador
    port (
    input1: in std_logic_vector(31 downto 0);
	input2: in std_logic_vector(31 downto 0);
    output1: out std_logic_vector(31 downto 0)
  );
end component;

component ram
    port (
    address : in std_logic_vector(7 downto 0);
    clock : in std_logic;
    data : in std_logic_vector(31 downto 0);
    q : out std_logic_vector(31 downto 0);
    wren : in std_logic
    );
end component;

begin
    mux_i1: mux
    port map (
        sel => mux_sin,
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

    somador_pc_i1: somador
    port map (
        input1 => pc_out,
		input2 => sin4,
        output1 => jump_address
    );

    i1 : ram
    port map (
      -- list connections between master ports and signals
      address => pc_out(9 downto 2),
      clock => clk0,
      data => data,
      q => instruction,
      wren => wren
    );

    out_pc <= pc_out;

sum_4 : process(clk,clk0)
begin
    sin4 <= X"00000004";
    init_address <= X"00000000";
    data <= X"00000000";
    wren <= '0';
end process ; -- sum_4
end architecture ; -- arch
