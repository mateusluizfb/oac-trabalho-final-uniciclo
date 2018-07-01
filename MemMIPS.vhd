library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity MemMIPS is
    port (
     clk: 			in std_logic;
     clk0: 			in std_logic;
     wpc: 			in std_logic;
	  pc_in:			in std_logic_vector(31 downto 0);
     instruction: out std_logic_vector(31 downto 0);
     out_pc: 		out std_logic_vector(31 downto 0)
     );
end MemMIPS ; -- MemMIPS
architecture arch of MemMIPS is
--signal clk : std_logic;
--signal mux_sin : std_logic;
--signal wpc : std_logic;
signal sin4: std_logic_vector(31 downto 0) := X"00000004";

signal init_address: std_logic_vector(31 downto 0) := X"00000000";
signal pc_out: std_logic_vector(31 downto 0);
signal data : std_logic_vector(31 downto 0) := X"00000000";
signal q : std_logic_vector(31 downto 0);
signal wren : std_logic := '0';

component pc
    port (
    clk: in std_logic;
    wpc: in std_logic;
    in1: in std_logic_vector(31 downto 0);
    out1: out std_logic_vector(31 downto 0)
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
    pc_i1: pc
    port map (
        clk => clk,
        wpc => wpc,
        in1 => pc_in,
        out1 => pc_out
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
end architecture ; -- arch
