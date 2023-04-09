library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MINI_MIPS is
	port(clk			: in std_logic);
end MINI_MIPS;

architecture RTL of MINI_MIPS is

signal first_pc								: std_logic := '1';
signal first_pc_out 					: std_logic := '1';
-- IF signal
signal pc_in 									: unsigned(31 downto 0);
signal pc_out 								: unsigned(31 downto 0);
signal if_adder_out 					: unsigned(31 downto 0);
signal if_instruction					: std_logic_vector(31 downto 0);
signal if_pcsrc							  : std_logic;
signal if_mux_pcsrc_out				: unsigned(31 downto 0);
signal if_mux_jumpsrc_out			: unsigned(31 downto 0);

-- ID signal
signal id_instruction 				: std_logic_vector(31 downto 0);
signal id_pc 									: unsigned(31 downto 0); --pc
signal id_control_jump				: std_logic; -- ID
signal id_control_jumpsrc			: std_logic; -- ID
signal id_control_regdst 			: std_logic; -- EX
signal id_control_aluop				: std_logic_vector(2 downto 0); -- EX
signal id_control_alusrc			: std_logic; -- EX
signal id_control_branch			: std_logic; -- MEM
signal id_control_memread			: std_logic; -- MEM
signal id_control_memwrite		: std_logic; -- MEM
signal id_control_regwrite		: std_logic; -- WB
signal id_control_memtoreg		: std_logic; -- WB
signal id_read_data1					: unsigned(31 downto 0); -- read data1
signal id_read_data2					: unsigned(31 downto 0); -- read data2
signal id_sign_extend_out	  	: unsigned(31 downto 0); -- sign extend output
signal id_jump_pc 						: unsigned(31 downto 0);
signal id_jump_imm						: unsigned(31 downto 0);

-- EX signal
signal ex_control_regdst 			: std_logic; -- EX
signal ex_control_aluop				: std_logic_vector(2 downto 0); -- EX
signal ex_control_alusrc			: std_logic; -- EX
signal ex_control_branch			: std_logic; -- MEM
signal ex_control_memread			: std_logic; -- MEM
signal ex_control_memwrite		: std_logic; -- MEM
signal ex_control_regwrite		: std_logic; -- WB
signal ex_control_memtoreg		: std_logic; -- WB
signal ex_pc									: unsigned(31 downto 0);
signal ex_adder_out						: unsigned(31 downto 0);
signal ex_alu_in1							: unsigned(31 downto 0);
signal ex_read_data2				  : unsigned(31 downto 0);
signal ex_alu_in2 						: unsigned(31 downto 0);
signal ex_alu_cond						: std_logic;
signal ex_alu_result    			: unsigned(31 downto 0);
signal ex_shift_left_2_in			: unsigned(31 downto 0);
signal ex_shift_left_2_out 		: unsigned(31 downto 0);
signal ex_rt									: std_logic_vector(4 downto 0);
signal ex_rd									: std_logic_vector(4 downto 0);
signal ex_regdstmux_out				: std_logic_vector(4 downto 0);

-- MEM signal
signal mem_control_branch			: std_logic; -- MEM
signal mem_control_memread		: std_logic; -- MEM
signal mem_control_memwrite		: std_logic; -- MEM
signal mem_control_regwrite		: std_logic; -- WB
signal mem_control_memtoreg		: std_logic; -- WB
signal mem_branch_pc					: unsigned(31 downto 0);
signal mem_cond								: std_logic;
signal mem_alu_result    			: unsigned(31 downto 0);
signal mem_write_data					: unsigned(31 downto 0);
signal mem_write_reg		  		: std_logic_vector(4 downto 0);
signal mem_read_data					: unsigned(31 downto 0);

-- WB signal
signal wb_control_regwrite 		: std_logic; -- control signal RegWrite
signal wb_control_memtoreg    : std_logic;
signal wb_write_reg 					: std_logic_vector(4 downto 0); -- rd
signal wb_read_data 					: unsigned(31 downto 0); -- read data from mem
signal wb_alu_output					: unsigned(31 downto 0);
signal wb_write_data					: unsigned(31 downto 0);

component PC
port(	clk						: in std_logic;
			first_pc_in  	: in std_logic;
			addr_next			: in unsigned(31 downto 0);
			addr_now			: out unsigned(31 downto 0);
			first_pc_out	: out std_logic);
end component;
component ADDER
port( input_1 : in unsigned(31 downto 0);
			input_2 : in unsigned(31 downto 0);
			output  : out unsigned(31 downto 0));
end component;
component MUX
	port(	sel    	: in  std_logic;
				in_0    : in  unsigned(31 downto 0);
				in_1		: in  unsigned(31 downto 0);
				mux_out	: out unsigned(31 downto 0));
end component;
component SHIFT_LEFT_2
  port (
    data_in  : in  unsigned(31 downto 0); -- Input data to be shifted
    data_out : out unsigned(31 downto 0)  -- Output shifted data
  );
end component;
component SIGN_EXTEND
	generic (
		input_size : integer := 16;
		output_size : integer := 32
	);
  port (
    data_in   : in  std_logic_vector(input_size - 1 downto 0); -- Input data to be sign-extended
    data_out  : out unsigned(output_size - 1 downto 0)  -- Output sign-extended data
  );
end component;
component INSTRUCTION_MEMORY
	port(	addr		 		: in unsigned(31 downto 0);
				instruction : out std_logic_vector(31 downto 0));
end component;
component IF_ID_REG
	port(clk						: in std_logic;
			 instruction_in : in std_logic_vector(31 downto 0);
			 pc_in 					: in unsigned(31 downto 0);
			 instruction_out: out std_logic_vector(31 downto 0);
			 pc_out					: out unsigned(31 downto 0));
end component;
component CONTROL
	port(opcode 					: in std_logic_vector(5 downto 0);
			 funct						: in std_logic_vector(5 downto 0);
			 jump 						: out std_logic; -- ID
			 jump_src					: out std_logic; -- ID
			 reg_dst					: out std_logic; -- EX
			 alu_op 					: out std_logic_vector(2 downto 0); -- EX
			 alu_src					: out std_logic; -- EX
			 branch						: out std_logic; -- MEM
			 mem_read					: out std_logic; -- MEM
			 mem_write				: out std_logic; -- MEM
			 reg_write				: out std_logic; -- WB
			 mem_to_reg				: out std_logic); -- WB
end component;
component REGISTERS
	port(reg_write  : in std_logic; -- control signal
			 read_reg1	: in std_logic_vector(4 downto 0);
			 read_reg2	: in std_logic_vector(4 downto 0);
			 write_reg  : in std_logic_vector(4 downto 0);
			 write_data : in unsigned(31 downto 0);
			 read_data1 : out unsigned(31 downto 0);
			 read_data2 : out unsigned(31 downto 0));
end component;
component ID_EX_REG is
	port(clk 							: in std_logic;
			 reg_dst_in 			: in std_logic; -- EX
			 alu_op_in				: in std_logic_vector(2 downto 0); -- EX
			 alu_src_in				: in std_logic; -- EX
			 branch_in				: in std_logic; -- MEM
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 pc_in						: in unsigned(31 downto 0);
			 read_data1_in		: in unsigned(31 downto 0);
			 read_data2_in		: in unsigned(31 downto 0);
			 sign_extend_in	  : in unsigned(31 downto 0);
			 rt_addr_in				: in std_logic_vector(4 downto 0);
			 rd_addr_in				: in std_logic_vector(4 downto 0);
			 reg_dst_out 			: out std_logic; -- EX
			 alu_op_out				: out std_logic_vector(2 downto 0); -- EX
			 alu_src_out			: out std_logic; -- EX
			 branch_out				: out std_logic; -- MEM
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 pc_out						: out unsigned(31 downto 0);
			 read_data1_out		: out unsigned(31 downto 0);
			 read_data2_out		: out unsigned(31 downto 0);
			 sign_extend_out	: out unsigned(31 downto 0);
			 rt_addr_out			: out std_logic_vector(4 downto 0);
			 rd_addr_out			: out std_logic_vector(4 downto 0));
end component;
component MUX_RegDst
	port(	sel    	: in  std_logic;
				in_0    : in  std_logic_vector(4 downto 0);
				in_1		: in  std_logic_vector(4 downto 0);
				mux_out	: out std_logic_vector(4 downto 0));
end component;
component ALU
	port(alu_in_1 	: in unsigned(31 downto 0);
			 alu_in_2 	: in unsigned(31 downto 0);
			 alu_op			: in std_logic_vector(2 downto 0);
			 alu_cond   : out std_logic;
			 alu_output	: out unsigned(31 downto 0));
end component;
component EX_MEM_REG
	port(clk 							: in std_logic;
			 branch_in				: in std_logic; -- MEM
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 pc_in						: in unsigned(31 downto 0);
			 cond_in					: in std_logic;
			 alu_output_in    : in unsigned(31 downto 0);
			 write_data_in		: in unsigned(31 downto 0);
			 write_reg_in			: in std_logic_vector(4 downto 0);
			 branch_out				: out std_logic; -- MEM
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 pc_out						: out unsigned(31 downto 0);
			 cond_out					: out std_logic;
			 alu_output_out   : out unsigned(31 downto 0);
			 write_data_out		: out unsigned(31 downto 0);
			 write_reg_out		: out std_logic_vector(4 downto 0));
end component;
component AND_PCSrc
	port (branch 	 : in std_logic;
				cond   	 : in std_logic;
				pcsrc		 : out std_logic);
end component;
component DATA_MEMORY
	port(mem_write  : in std_logic;
			 mem_read		: in std_logic;
			 address 		: in unsigned(31 downto 0);
			 write_data : in unsigned(31 downto 0);
			 read_data	: out unsigned(31 downto 0));
end component;
component MEM_WB_REG
	port(clk 							: in std_logic;
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 read_data_in			: in unsigned(31 downto 0);
			 alu_output_in    : in unsigned(31 downto 0);
			 write_reg_in			: in std_logic_vector(4 downto 0);	
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 read_data_out		: out unsigned(31 downto 0);
			 alu_output_out   : out unsigned(31 downto 0);
			 write_reg_out		: out std_logic_vector(4 downto 0));
end component;
begin
	-- PC
	
	PC_inst: PC port map (
		clk => clk,
		first_pc_in => first_pc,
		addr_next => pc_in,
		addr_now => pc_out,
		first_pc_out => first_pc_out
	);
	first_pc <= first_pc_out when first_pc_out /= 'U';
	
	--IF
	ADDER_IF_inst: ADDER port map (
		input_1 => pc_out,
		input_2 => x"00000004",
		output => if_adder_out
	);
	
	MUX_PCSrc_inst: MUX port map (
		sel => if_pcsrc,
		in_0 => if_adder_out,
		in_1 => mem_branch_pc,
		mux_out => if_mux_pcsrc_out
	);
	
	SHIFT_LEFT_2_JUMP_inst : SHIFT_LEFT_2 port map (
		data_in  => id_jump_imm,
		data_out => id_jump_pc
	);
	
	SIGN_EXTEND_25_to_32_inst : SIGN_EXTEND
		generic map (
			input_size => 26,
			output_size => 32
		)
		port map (
			data_in => id_instruction(25 downto 0),
			data_out => id_jump_imm
		);
	
	MUX_JUMPSrc_inst: MUX port map (
		sel => id_control_jumpsrc,
		in_0 => id_read_data1,
		in_1 => id_jump_pc,
		mux_out => if_mux_jumpsrc_out
	);
	
	MUX_PC_inst: MUX port map (
		sel => id_control_jump,
		in_0 => if_mux_pcsrc_out,
		in_1 => if_mux_jumpsrc_out,
		mux_out => pc_in
	);
	
	INST_MEM_inst: INSTRUCTION_MEMORY port map (
		addr => pc_out,
		instruction => if_instruction
	);
	
	-- IF/ID
	IF_ID_REG_inst : IF_ID_REG port map(
		clk => clk,
		instruction_in => if_instruction,
		pc_in => if_adder_out,
		instruction_out => id_instruction,
		pc_out => id_pc
	);
	
	-- ID
	-- pc_in <= unsigned("000000" & id_instruction(25 downto 0)) when id_instruction(31 downto 26) = "000010" else -- J
	--				 id_read_data1 when id_instruction(31 downto 26) = "000000" and id_instruction(5 downto 0) = "001000"; -- JR
	
	CONTROL_inst : CONTROL port map(
		opcode => id_instruction(31 downto 26),
		funct => id_instruction(5 downto 0),
		jump => id_control_jump, -- ID
		jump_src => id_control_jumpsrc, -- ID
		reg_dst	=> id_control_regdst, -- EX
		alu_op => id_control_aluop, -- EX
		alu_src	=> id_control_alusrc, -- EX
		branch => id_control_branch, -- MEM
		mem_read => id_control_memread, -- MEM
		mem_write	=> id_control_memwrite, -- MEM
		reg_write	=> id_control_regwrite, -- WB
		mem_to_reg => id_control_memtoreg -- WB
	);
	
	REGISTERS_inst : REGISTERS port map (
		reg_write => wb_control_regwrite,
		read_reg1 => id_instruction(25 downto 21),
		read_reg2 => id_instruction(20 downto 16),
		write_reg => wb_write_reg, 
		write_data => wb_write_data,
		read_data1 => id_read_data1,
		read_data2 => id_read_data2
	);
	
	SIGN_EXTEND_inst: SIGN_EXTEND 
		generic map (
			input_size => 16,
			output_size => 32
		)
		port map(
			data_in => id_instruction(15 downto 0),
			data_out => id_sign_extend_out
		);
	
	-- ID/EX
	ID_EX_REG_inst : ID_EX_REG port map (
		clk => clk,
		reg_dst_in => id_control_regdst,
		alu_op_in	=> id_control_aluop,
		alu_src_in => id_control_alusrc,
		branch_in	=> id_control_branch,
		mem_read_in	=> id_control_memread,
		mem_write_in => id_control_memwrite,
		reg_write_in => id_control_regwrite,
		mem_to_reg_in	=> id_control_memtoreg,
		pc_in	=> id_pc,
		read_data1_in	=> id_read_data1,
		read_data2_in => id_read_data2,
		sign_extend_in => id_sign_extend_out,
		rt_addr_in => id_instruction(20 downto 16),
		rd_addr_in => id_instruction(15 downto 11),
		
		reg_dst_out => ex_control_regdst,
		alu_op_out => ex_control_aluop,
		alu_src_out	=> ex_control_alusrc,
		branch_out => ex_control_branch,
		mem_read_out => ex_control_memread,
		mem_write_out => ex_control_memwrite,
		reg_write_out	=> ex_control_regwrite,
		mem_to_reg_out => ex_control_memtoreg,
		pc_out => ex_pc,
		read_data1_out => ex_alu_in1,
		read_data2_out => ex_read_data2,
		sign_extend_out	=> ex_shift_left_2_in,
		rt_addr_out	=> ex_rt,
		rd_addr_out	=> ex_rd
	);
	
	-- EX
	MUX_RegDst_inst: MUX_RegDst port map (
		sel => ex_control_regdst,
		in_0 => ex_rt,
		in_1 => ex_rd,
		mux_out => ex_regdstmux_out
	);
	
	MUX_ALUSrc_inst: MUX port map (
		sel => ex_control_alusrc,
		in_0 => ex_read_data2,
		in_1 => ex_shift_left_2_in,
		mux_out => ex_alu_in2
	);
	
	ALU_inst : ALU port map (
		alu_in_1 => ex_alu_in1,
		alu_in_2 => ex_alu_in2,
		alu_op => ex_control_aluop,
		alu_cond => ex_alu_cond,
		alu_output => ex_alu_result
	);
	
	SHIFT_LEFT_2_inst : SHIFT_LEFT_2 port map (
		data_in => ex_shift_left_2_in,
    data_out => ex_shift_left_2_out
	);
	
	ADDER_EX_inst : ADDER port map (
		input_1 => ex_pc,
		input_2 => ex_shift_left_2_out,
		output => ex_adder_out
	);
	
	-- EX/MEM
	EX_MEM_REG_inst: EX_MEM_REG port map (
		 clk => clk,
		 branch_in => ex_control_branch, -- MEM
		 mem_read_in => ex_control_memread, -- MEM
		 mem_write_in	=> ex_control_memwrite, -- MEM
		 reg_write_in => ex_control_regwrite, -- WB
		 mem_to_reg_in => ex_control_memtoreg, -- WB
		 pc_in => ex_adder_out,
		 cond_in => ex_alu_cond,
		 alu_output_in => ex_alu_result,
		 write_data_in => ex_read_data2, 
		 write_reg_in	=> ex_regdstmux_out,
		 
		 branch_out => mem_control_branch, -- MEM
		 mem_read_out	=> mem_control_memread, -- MEM
		 mem_write_out => mem_control_memwrite, -- MEM
		 reg_write_out => mem_control_regwrite, -- WB
		 mem_to_reg_out	=> mem_control_memtoreg, -- WB
		 pc_out	=> mem_branch_pc,
		 cond_out	=> mem_cond,
		 alu_output_out => mem_alu_result,
		 write_data_out => mem_write_data,
		 write_reg_out => mem_write_reg
	);
	
  -- MEM
	
	AND_PCSrc_inst : AND_PCSrc port map (
		branch => mem_control_branch,
		cond => mem_cond,
		pcsrc	=> if_pcsrc
	);
	
	DATA_MEMORY_inst : DATA_MEMORY port map (
		mem_write => mem_control_memwrite,
		mem_read => mem_control_memread,
		address => mem_alu_result,
		write_data => mem_write_data,
		read_data => mem_read_data
	);
	
	-- MEM/WB
	MEM_WB_REG_inst : MEM_WB_REG port map (
		 clk => clk,
		 reg_write_in => mem_control_regwrite, -- WB
		 mem_to_reg_in => mem_control_memtoreg, -- WB
		 read_data_in	=> mem_read_data,
		 alu_output_in => mem_alu_result,
		 write_reg_in	=> mem_write_reg,
			
		 reg_write_out => wb_control_regwrite, -- WB
		 mem_to_reg_out	=> wb_control_memtoreg, -- WB
		 read_data_out => wb_read_data,
		 alu_output_out => wb_alu_output,
		 write_reg_out => wb_write_reg
	);
	
	-- WB
	MUX_MemtoReg_inst : MUX port map (
		sel => wb_control_memtoreg,
		in_0 => wb_read_data,
		in_1 => wb_alu_output,
		mux_out => wb_write_data
	);
	
	
end RTL;

