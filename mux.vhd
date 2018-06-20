library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mux is
  generic (WSIZE : natural := 32);
  port (
    sel : in std_logic;
    input0 : in std_logic_vector(WSIZE-1 downto 0);
    input1 : in std_logic_vector(WSIZE-1 downto 0);
    output1: out std_logic_vector(WSIZE-1 downto 0)
  ) ;
end entity ; -- mux

architecture arch of mux is
signal out1: std_logic_vector(WSIZE-1 downto 0);

begin
output1 <= out1;
mux_process : process( sel, input0, input1 )
begin
    if(sel = '0') then out1 <= input0;
    else out1 <= input1;
    end if;
end process ; -- mux_process

end architecture ; -- arch
