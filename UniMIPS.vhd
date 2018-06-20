library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity UniMIPS is
    port (
    clk: in std_logic;
    clk0: in std_logic;
    --m1_sin: in std_logic;
    --wpc: in std_logic;
    --instruction: out std_logic_vector(31 downto 0);
    out_pc: out std_logic_vector(31 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

begin

end architecture ; -- arch
