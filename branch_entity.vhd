library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;


entity branch_entity is
    port(
        clk                         : in std_logic;
        pc_value                    : in std_logic_vector(31 downto 0); -- Sinais de entrada do pc
        beq, bne                    : in std_logic := '0';              -- Sinais de salto
        zero, jump                  : in std_logic := '0';              -- Sinais enviados pelo controle
        ovfl, eret                  : in std_logic := '0';              -- Sinais de exececao
        jr, jal                     : in std_logic := '0';              -- Sinais de jr e jal
        shift26_in                  : in std_logic_vector(25 downto 0);
        shift32_in                  : in std_logic_vector(31 downto 0);
        rs_address                  : in std_logic_vector(31 downto 0);
        branch_out                  : out std_logic_vector(31 downto 0)
    );
end entity branch_entity;

architecture branch_entity_arch of branch_entity is

    component somador
        port (
            input1, input2  : in std_logic_vector(31 downto 0);
            output1         : out std_logic_vector(31 downto 0)
        );
    end component somador;

    component pc
        port (
            clk             : in std_logic;
            wpc             : in std_logic;
            in1             : in std_logic_vector(31 downto 0);
            out1            : out std_logic_vector(31 downto 0)
      );
    end component;

    component shift_26
        port (
          shift_26_input     :  in std_logic_vector(25 downto 0);
          shift_26_output : out std_logic_vector(27 downto 0)
        );
    end component shift_26;

    component shift_32 is
        port (
          shift_32_input     :  in std_logic_vector(31 downto 0);
          shift_32_output : out std_logic_vector(31 downto 0)
        );
    end component shift_32;

    component mux is
      generic (WSIZE : natural := 32);
      port (
         sel : in std_logic;
         input0 : in std_logic_vector(WSIZE-1 downto 0);
         input1 : in std_logic_vector(WSIZE-1 downto 0);
         output1: out std_logic_vector(WSIZE-1 downto 0)
      ) ;
    end component mux;

    signal somador_out  :   std_logic_vector(31 downto 0);
    signal shift26_out  :   std_logic_vector(27 downto 0);
    signal shift32_out  :   std_logic_vector(31 downto 0);
    signal mux1_out     :   std_logic_vector(31 downto 0);
    signal mux_branch_out:  std_logic_vector(31 downto 0);
    signal mux_epc      :  std_logic_vector(31 downto 0);
    signal epc_address  :  std_logic_vector(31 downto 0);
    signal recover_address:  std_logic_vector(31 downto 0);
    signal mux1_sel     :   std_logic;
    signal jump_jal     :   std_logic;
    signal mux2_in      :   std_logic_vector(31 downto 0);
    signal mux_eret     :   std_logic_vector(31 downto 0);
    signal pc_4_out     :  std_logic_vector(31 downto 0);
    signal pc_4         :  std_logic_vector(31 downto 0);


    begin
        mux1_sel <= ((bne and not(zero)) xor (beq and zero));
        mux2_in <=  pc_4_out(31 downto 28) & shift26_out;
        pc_4 <= std_logic_vector(to_unsigned(4, 32));
        recover_address <= X"00004380";
        jump_jal <= jump or jal;

        somador_pc_4_i2: somador
            port map (
                input1  =>  pc_value,
                input2  =>   pc_4,
                output1  =>  pc_4_out
            );

        epc_i1: pc
            port map (
                clk => clk,
                wpc => ovfl,
                in1 => pc_4_out,
                out1 => epc_address
            );

        shift32_i1: shift_32
            port map (
                shift_32_input  => shift32_in,
                shift_32_output => shift32_out
            );

        shift26_i1: shift_26
            port map (
                shift_26_input   => shift26_in,
                shift_26_output => shift26_out
            );

        somador_i1: somador
            port map (
                input1  =>  pc_4_out,
                input2  =>   shift32_out,
                output1  =>  somador_out
            );

        mux_i1: mux
            port map (
                sel     =>  mux1_sel,
                input0  =>  pc_4_out,
                input1  =>  somador_out,
                output1 =>  mux1_out
            );

        mux_i2: mux
            port map (
                sel     =>  jump_jal,
                input0  =>  mux1_out,
                input1  =>  mux2_in,
                output1 =>  mux_branch_out
            );

        -- mux para o tratamento de excecao
        mux_i3: mux
            port map (
                sel     =>  ovfl,
                input0  =>  mux_branch_out,
                input1  =>  recover_address,
                output1 =>  mux_epc
            );

        mux_i4: mux
            port map (
                sel     =>  eret,
                input0  =>  mux_epc,
                input1  =>  epc_address,
                output1 =>  mux_eret
            );

        mux_i5: mux
            port map (
                sel => jr,
                input0 => mux_eret,
                input1 => rs_address,
                output1 => branch_out
            );

end architecture branch_entity_arch;
