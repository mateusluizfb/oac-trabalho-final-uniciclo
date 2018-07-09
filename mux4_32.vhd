library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mux4_32 is
  port (
    sel : in std_logic_vector(1 downto 0);
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
mux4_32_process : process( sel, input0, input1, input2, input3 )
begin
  case( sel ) is
    when "00" => 
      out1 <= input0;
    when "01" => 
      out1 <= input1;
    when "10" => 
      out1 <= input2;
    when "11" => 
      out1 <= input3;
    when others => 
      out1 <= input0;
  end case ;
end process ; -- mux4_32_process

end architecture ; -- arch
