library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity bcd_7segment is
Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
Seven_Segment : out STD_LOGIC_VECTOR (7 downto 0));
end bcd_7segment;
 
architecture Behavioral of bcd_7segment is
 
begin
 
bcd_proc: process(BCDin)
begin
 
case BCDin is
        when "0000" =>
          Seven_Segment <= X"7E";
        when "0001" =>
          Seven_Segment <= X"30";
        when "0010" =>
          Seven_Segment <= X"6D";
        when "0011" =>
          Seven_Segment <= X"79";
        when "0100" =>
          Seven_Segment <= X"33";          
        when "0101" =>
          Seven_Segment <= X"5B";
        when "0110" =>
          Seven_Segment <= X"5F";
        when "0111" =>
          Seven_Segment <= X"70";
        when "1000" =>
          Seven_Segment <= X"7F";
        when "1001" =>
          Seven_Segment <= X"7B";
        when "1010" =>
          Seven_Segment <= X"77";
        when "1011" =>
          Seven_Segment <= X"1F";
        when "1100" =>
          Seven_Segment <= X"4E";
        when "1101" =>
          Seven_Segment <= X"3D";
        when "1110" =>
          Seven_Segment <= X"4F";
        when "1111" =>
          Seven_Segment <= X"47";
      end case;
 
end process;
 
end Behavioral;