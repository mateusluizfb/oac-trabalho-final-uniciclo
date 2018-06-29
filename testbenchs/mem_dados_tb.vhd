library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mem_dados_tb is
end entity ; -- mem_dados_tb
architecture arch of mem_dados_tb is
signal wren        : std_logic ;
signal clock       : std_logic;
signal address     : std_logic_vector (7 downto 0);
signal data        : std_logic_vector (31 downto 0);
signal q           : std_logic_vector (31 downto 0);
constant CLK_PERIOD : time := 100 ps;
component mem_dados
port(
    address     : IN std_logic_vector (7 downto 0);
    clock       : IN std_logic;
    data        : IN std_logic_vector (31 downto 0);
    wren        : IN std_logic ;
    q           : OUT std_logic_vector (31 downto 0)
    );
end component;
begin
    i1: mem_dados
    port map (
        address => address,
        clock => clock,
        data => data,
        wren => wren,
        q => q
        );
clock_process : process
begin
    clock <= '0';
    wait for CLK_PERIOD/2;  --for half of clock period clock stays at '0'.
    clock <= '1';
    wait for CLK_PERIOD/2;  --for next half of clock period clock stays at '1'.
end process;
init : process
begin
    wren <= '1';
    wait for 50 ps;
    -- writing memory
    for i in 0 to 100 loop
        address <= std_logic_vector(to_unsigned(i, 8));
        data    <= std_logic_vector(to_unsigned(i, 32));
        wait for 50 ps;
        assert (i = to_integer(unsigned(q))) report "Data memory read failure" severity failure;
        wait for 50 ps;
    end loop;
wait;
end process ; -- init
end architecture ; -- arch