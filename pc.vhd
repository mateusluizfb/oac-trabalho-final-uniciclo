library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity pc is
  port (
     clk, wpc: in std_logic;
     in1: in std_logic_vector(31 downto 0);
     out1: out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- pc

architecture arch of pc is
signal o1 : std_logic_vector(31 downto 0) := x"00000000";
begin
    out1 <= o1;
    pc_process : process( in1, clk, wpc )
    begin
        if(rising_edge(clk)) then
            if(wpc = '1') then
            o1 <= in1;
            end if;
        end if;
    end process ; -- pc_process
end architecture ; -- arch
