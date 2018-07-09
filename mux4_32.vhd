library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mux4_32 is
  port (
    sel_0 : in std_logic;
    sel_1 : in std_logic;
    input0 : in std_logic_vector(31 downto 0);
    input1 : in std_logic_vector(31 downto 0);
    input2 : in std_logic_vector(31 downto 0);
    input3 : in std_logic_vector(31 downto 0);
    output1: out std_logic_vector(31 downto 0)
  ) ;
end entity ; -- mux4_32

architecture arch of mux4_32 is
signal out1: std_logic_vector(31 downto 0);

begin
output1 <= out1;
mux4_32_process : process( sel_0, sel_1, input0, input1, input2, input3 )
begin
  case( sel_0 ) is
    when '0' =>
      case sel_1 is
        when '0' => out1 <= input0;
        when '1' => out1 <= input1;
      end case;
    when '1' => 
      case sel_1 is
        when '0' => out1 <= input2;
        when '1' => out1 <= input3;
      end case;
  end case ;
end process ; -- mux4_32_process

end architecture ; -- arch
