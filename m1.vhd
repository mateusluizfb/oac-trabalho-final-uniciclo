library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity m1 is
  port (
    sel : in std_logic;
    input0 : in std_logic_vector(31 downto 0);
    input1 : in std_logic_vector(31 downto 0);
    output1: out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- m1

architecture arch of m1 is
signal out1: std_logic_vector(31 downto 0);

begin
output1 <= out1;
m1_process : process( sel, input0, input1 )
begin
    if(sel = '0') then out1 <= input0;
    else out1 <= input1;
    end if;
end process ; -- m1_process

end architecture ; -- arch