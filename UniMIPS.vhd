library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.ula_package.all;

entity UniMIPS is
    port (
    clk, clk0                       : in std_logic;
    --write_data                      : in std_logic_vector(31 downto 0);
    --md_data                         : in std_logic_vector(31 downto 0);
    r1_out                          : out std_logic_vector(31 downto 0);
    r2_out                          : out std_logic_vector(31 downto 0);
    r1_read                         : out std_logic_vector(4 downto 0);
    r2_read                         : out std_logic_vector(4 downto 0);

    --*sinais de controle
    wpc                             : in std_logic;
    -- sinal de entrada breg
    zero                            : out std_logic;
    ovfl                            : out std_logic;
    instruction_out                 : out std_logic_vector(31 downto 0);
    inst_counter                    : out std_logic_vector(31 downto 0);
    alu_out                         : out std_logic_vector(31 downto 0);
    md_out                          : out std_logic_vector(31 downto 0);

    -- sinal de debug do controle
    debug_controle_opcode   : out std_logic_vector(5 downto 0);
    debug_ULA_funct              : out std_logic_vector(5 downto 0);
    debug_mux_reg_dst        : out std_logic;
    debug_jump                : out std_logic;
    debug_beq                 : out std_logic;
    debug_bne                 : out std_logic;
    debug_jr                  : out std_logic;
    debug_jal                 : out std_logic;
    debug_memread              : out std_logic;
    debug_memtoreg          : out std_logic;
    debug_memwrite          : out std_logic;
    debug_alusrc                : out std_logic;
    debug_regwrite           : out std_logic;
    debug_aluop             : out std_logic_vector(3 downto 0)
    );
end entity ; -- UniMIPS

architecture arch of UniMIPS is

-- sinais de controle do breg
--signal wren_breg: std_logic;
signal reset_breg: std_logic := '0';
signal jal: std_logic := '0';

-- sinal de saida da memoria e entrada do breg
signal instruction: std_logic_vector(31 downto 0);
-- sinal de 
signal register_ra: std_logic_vector(4 downto 0);
signal reg_dst_out: std_logic_vector(4 downto 0);
signal reg_rd_rt_out: std_logic_vector(4 downto 0);
signal r1, r2, ula_dst: std_logic_vector(31 downto 0);
signal immediate: std_logic_vector(31 downto 0);
signal md_address: std_logic_vector(7 downto 0);
signal write_data_breg: std_logic_vector(31 downto 0);
signal md_read_data: std_logic_vector(31 downto 0);
signal Z: std_logic_vector(31 downto 0);
signal pc_in: std_logic_vector(31 downto 0);
signal counter_to_pc: std_logic_vector(31 downto 0);
signal Z_md_data: std_logic_vector(31 downto 0);
signal wb_sin, wren_breg, mux_sin, mread : std_logic;
signal mux_reg_dst, ula_sel, wren_md: std_logic;
signal ula_op : ULA_OPERATION;
signal controleULA_op : std_logic_vector(3 downto 0);
signal con_jum, con_bne, con_beq : std_logic;
signal con_jr, con_jal : std_logic;
signal zeroUla : std_logic;

component MemMIPS
    port (
    clk, clk0, wpc                  : in std_logic;
    pc_in                           : in std_logic_vector(31 downto 0);
    instruction                     : out std_logic_vector(31 downto 0);
    out_pc                          : out std_logic_vector(31 downto 0)
    );
end component;

component breg
    port (
    clock, write_enable, reset      : in  std_logic;
    register_input_1                : in  std_logic_vector(4 downto 0);
    register_input_2                : in  std_logic_vector(4 downto 0);
    register_write                  : in  std_logic_vector(4 downto 0);
    write_data                      : in  std_logic_vector(31 downto 0);
    register_output_1               : out std_logic_vector(31 downto 0);
    register_output_2               : out std_logic_vector(31 downto 0)
    );
end component;

component mux
    generic (WSIZE : natural := 32);
    port (
    sel                             : in std_logic;
    input0                          : in std_logic_vector(WSIZE-1 downto 0);
    input1                          : in std_logic_vector(WSIZE-1 downto 0);
    output1                         : out std_logic_vector(WSIZE-1 downto 0)
  );
end component;

component ula
    port (
        A                           : in std_logic_vector(31 downto 0);
        B                           : in std_logic_vector(31 downto 0);
        ula_op                      : in ULA_OPERATION;
        shift_amount                : in std_logic_vector(4 downto 0);
        ula_out                     : out std_logic_vector(31 downto 0);
        zero                        : out std_logic;
        overflow                    : out std_logic
    );
end component;

component signal_extension
    port (
        input                       : in  std_logic_vector(15 downto 0);
        output                      : out std_logic_vector(31 downto 0)
    );
end component;

component branch_entity
    port(
        clk                         : in std_logic;
        pc_value                    : in std_logic_vector(31 downto 0) := x"00000000"; -- Sinais de entrada do pc
        beq, bne, zero              : in std_logic := '0';
        jump, jr, jal               : in std_logic := '0';                             -- Sinais enviados pelo controle
        shift26_in                  : in std_logic_vector(25 downto 0) := "00" & x"000000";
        shift32_in                  : in std_logic_vector(31 downto 0) := x"00000000";
        rs_address                  : in std_logic_vector(31 downto 0);
        branch_out                  : out std_logic_vector(31 downto 0)
    );
end component;

component mem_dados
    port (
        clock                       : in std_logic;
        wren                        : in std_logic;
        address                     : in std_logic_vector(7 downto 0);
        data                        : in std_logic_vector(31 downto 0);
        q                           : out std_logic_vector(31 downto 0)
    );
end component;

component controle is
    port (
        opcode                          : in std_logic_vector(5 downto 0);
        regdst, jump, beq, bne, jal     : out std_logic;
        memread, memtoreg, memwrite     : out std_logic;
        alusrc, regwrite                : out std_logic;
        aluop                           : out std_logic_vector(3 downto 0)
    );
end component;

component controleULA is
    port (
        aluop   :   in  std_logic_vector(3 downto 0);
        funct   :   in  std_logic_vector(5 downto 0);
        jr      :   out std_logic;
        ulasin  :   out ULA_OPERATION -- 4 bits: consultar ula_package para a instruÃ§Ã£o
    );
end component;

begin

    instruction_out <= instruction;
    r1_read <= instruction(25 downto 21);
    r2_read <= instruction(20 downto 16);
    r1_out <= r1;
    r2_out <= r2;
    md_out <=  md_read_data;
    alu_out <= Z;
    inst_counter <= counter_to_pc;
    register_ra <= "11111";
    zero <= zeroUla;

    -- instancia o component de jump e pc + 4
    -- TODO: Quando fazer o controle mapear os sinais dos branchs e jumps
    branch_component_i1: branch_entity
    port map (
        clk => clk,
        beq => con_beq,
        bne => con_bne,
        zero => zeroUla,
        jump => con_jum,
        jal => con_jal,
        jr => con_jr,
        pc_value    => counter_to_pc,
        rs_address  => r2,
        shift26_in => instruction(25 downto 0),
        shift32_in => immediate,
        branch_out  => pc_in
    );

    -- instancia a memoria de instruções
    inst_mem_i1: MemMIPS
    port map (
        clk             => clk,
        clk0            => clk0,
        wpc             => wpc,
        pc_in           => pc_in,
        instruction     => instruction,
        out_pc      => counter_to_pc
    );

    -- instacia o banco de registradores
    breg_i1: breg
    port map (
        clock => clk,
        write_enable => wren_breg,
        reset => reset_breg,
        register_input_1 => instruction(25 downto 21),
        register_input_2 => instruction(20 downto 16),
        register_write   => reg_dst_out,
        write_data => write_data_breg,
        register_output_1 => r1,
        register_output_2 => r2
    );

    -- instacia o mux que seleciona o registrador a ser escrito
    mux_reg_dst_i1: mux
    generic map (WSIZE => 5)
    port map (
        sel => mux_reg_dst,
        input0 => instruction(20 downto 16),
        input1 => instruction(15 downto 11),
        --input1 => reg_input_write,
        output1 => reg_rd_rt_out
    );

    mux_reg_dst_i2: mux
    generic map (WSIZE => 5)
    port map (
        sel => con_jal,
        input0 => reg_rd_rt_out,
        input1 => register_ra,
        output1 => reg_dst_out
    );

    ula_i1: ula
    port map (
        A => r1,
        B => ula_dst,
        ula_op => ula_op,
        shift_amount => instruction(10 downto 6), -- a quantidade de shift fica no lugar do 'rd'
        ula_out => Z,
        zero => zeroUla,
        overflow => ovfl
    );

    mux_ula_i1: mux
    generic map (WSIZE => 32)
    port map (
        sel => ula_sel,
        input0 => r2,
        input1 => immediate,
        output1 => ula_dst
    );

    sign_ext_i1: signal_extension
    port map (
        input => instruction(15 downto 0),
        output => immediate
    );

    data_memory_i1: mem_dados
    port map (
        address => Z(9 downto 2),
        clock => clk0,
        data => r2,
        wren => wren_md,
        q => md_read_data
    );

    mux_md_i1: mux
    generic map (WSIZE => 32)
    port map (
        sel => wb_sin,
        input0 => Z,
        input1 => md_read_data,
        output1 => Z_md_data
    );

    mux_jal_i1: mux
    port map (
        sel => con_jal,
        input0 => Z_md_data,
        input1 => counter_to_pc,
        output1 => write_data_breg 
    );

    debug_controle_opcode       <= instruction(31 downto 26);
    debug_ULA_funct             <= instruction(5 downto 0);
    debug_mux_reg_dst           <= mux_reg_dst;
    debug_jump                  <= con_jum;
    debug_beq                   <= con_beq;
    debug_bne                   <= con_bne;
    debug_memread               <= mread;
    debug_memtoreg              <= wb_sin;
    debug_memwrite              <= wren_md;
    debug_alusrc                <= ula_sel;
    debug_regwrite              <= wren_breg;
    debug_aluop                 <= controleULA_op;
    debug_jal                   <= con_jal;
    debug_jr                    <= con_jr;

    controle_i1: controle
    port map (
        opcode => instruction(31 downto 26),
        regdst => mux_reg_dst,
        jump => con_jum,
        beq => con_beq,
        bne => con_bne,
        memread => mread,
        memtoreg => wb_sin,
        memwrite => wren_md,
        alusrc => ula_sel,
        jal => con_jal,
        regwrite => wren_breg,
        aluop => controleULA_op
    );

    controleULA_i1: controleULA
    port map (
        aluop => controleULA_op,
        funct => instruction(5 downto 0),
        jr => con_jr,
        ulasin => ula_op
    );

end architecture ; -- arch
