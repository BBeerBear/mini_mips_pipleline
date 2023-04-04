library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MINI_MIPS is
	port(clk			: in std_logic);
end MINI_MIPS;

architecture RTL of MINI_MIPS is

signal if_pc_in, if_pc_out : unsigned(31 downto 0);
signal if_adder_out : unsigned(31 downto 0);

signal if_id_instr_in: std_logic_vector(31 downto 0);
signal if_id_instr_out : std_logic_vector(31 downto 0);

signal id_pc : unsigned(31 downto 0);

-- ID/EX signal
signal id_ex_reg_dst_in 			: std_logic; -- EX
signal id_ex_alu_op_in				: std_logic_vector(2 downto 0); -- EX
signal id_ex_alu_src_in				: std_logic; -- EX
signal id_ex_branch_in				: std_logic; -- MEM
signal id_ex_mem_read_in			: std_logic; -- MEM
signal id_ex_mem_write_in			: std_logic; -- MEM
signal id_ex_reg_write_in			: std_logic; -- WB
signal id_ex_mem_to_reg_in		: std_logic; -- WB
signal id_ex_pc_in						: unsigned(31 downto 0); -- pc
signal id_ex_read_data1_in		: unsigned(31 downto 0); -- read data1
signal id_ex_read_data2_in		: unsigned(31 downto 0); -- read data2
signal id_ex_sign_extend_in	  : unsigned(31 downto 0); -- sign extend output
signal id_ex_rt_addr_in				: std_logic_vector(4 downto 0); -- rt
signal id_ex_rd_addr_in				: std_logic_vector(4 downto 0); -- rd
signal id_ex_reg_dst_out 			: std_logic; -- EX
signal id_ex_alu_op_out				: std_logic_vector(2 downto 0); -- EX
signal id_ex_alu_src_out			: std_logic; -- EX
signal id_ex_branch_out				: std_logic; -- MEM
signal id_ex_mem_read_out			: std_logic; -- MEM
signal id_ex_mem_write_out		: std_logic; -- MEM
signal id_ex_reg_write_out		: std_logic; -- WB
signal id_ex_mem_to_reg_out		: std_logic; -- WB
signal id_ex_pc_out						: unsigned(31 downto 0);
signal id_ex_read_data1_out		: unsigned(31 downto 0);
signal id_ex_read_data2_out		: unsigned(31 downto 0);
signal id_ex_sign_extend_out	: unsigned(31 downto 0);
signal id_ex_rt_addr_out			: std_logic_vector(4 downto 0);
signal id_ex_rd_addr_out			: std_logic_vector(4 downto 0);

-- EX signal
signal ex_alu_in_2 	: unsigned(31 downto 0);
signal ex_shift_left_2_out : unsigned(31 downto 0);

-- EX/MEM signal
signal ex_mem_branch_in					: std_logic; -- MEM
signal ex_mem_mem_read_in				: std_logic; -- MEM
signal ex_mem_mem_write_in			: std_logic; -- MEM
signal ex_mem_reg_write_in			: std_logic; -- WB
signal ex_mem_mem_to_reg_in			: std_logic; -- WB
signal ex_mem_pc_in							: unsigned(31 downto 0);
signal ex_mem_cond_in						: boolean;
signal ex_mem_alu_output_in    	: unsigned(31 downto 0);
signal ex_mem_write_data_in			: unsigned(31 downto 0);
signal ex_mem_write_reg_in			: std_logic_vector(4 downto 0);
signal ex_mem_branch_out				: std_logic; -- MEM
signal ex_mem_mem_read_out			: std_logic; -- MEM
signal ex_mem_mem_write_out			: std_logic; -- MEM
signal ex_mem_reg_write_out			: std_logic; -- WB
signal ex_mem_mem_to_reg_out		: std_logic; -- WB
signal ex_mem_pc_out						: unsigned(31 downto 0);
signal ex_mem_cond_out					: boolean;
signal ex_mem_alu_output_out    : unsigned(31 downto 0);
signal ex_mem_write_data_out		: unsigned(31 downto 0);
signal ex_mem_write_reg_out		  : std_logic_vector(4 downto 0);

-- MEM/WB signal
signal mem_wb_reg_write_out : std_logic; -- control signal RegWrite
signal mem_wb_write_reg_out : std_logic_vector(4 downto 0); -- rd
signal wb_write_reg_data_out : unsigned(31 downto 0); -- write data
-- signal id_read_reg1, id_read_reg2, id_write_reg, id_write_data: unsigned(31 downto 0);
begin
	-- IF
	PC_inst: entity work.PC port map (
		clk => clk,
		addr_next => if_pc_in,
		addr_now => if_pc_out
	);
	
	ADDER_IF_inst: entity work.ADDER port map (
		input_1 => if_pc_out,
		input_2 => x"00000004",
		output => if_adder_out
	);
	
	INST_MEM_inst: entity work.INSTRUCTION_MEMORY port map (
		clk => clk,
		addr => if_pc_out,
		instruction => if_id_instr_in
	);
	
	-- IF/ID
	IF_ID_REG_inst : entity work.IF_ID_REG port map(
		clk => clk,
		instruction_in => if_id_instr_in,
		pc_in => if_adder_out,
		instruction_out => if_id_instr_out,
		pc_out => id_pc
	);
	
	-- ID
	CONTROL_inst : entity work.CONTROL port map(
		opcode => if_id_instr_out(31 downto 26),
		funct => if_id_instr_out(5 downto 0),
		reg_dst	=> id_ex_reg_dst_in, -- EX
		alu_op => id_ex_alu_op_in, -- EX
		alu_src	=> id_ex_alu_src_in, -- EX
		branch => id_ex_branch_in, -- MEM
		mem_read => id_ex_mem_read_in, -- MEM
		mem_write	=> id_ex_mem_write_in, -- MEM
		reg_write	=> id_ex_reg_write_in, -- WB
		mem_to_reg => id_ex_mem_to_reg_in -- WB
	);
	
	REGISTERS_inst : entity work.REGISTERS port map (
		clk => clk,
		reg_write => mem_wb_reg_write_out,
		read_reg1 => if_id_instr_out(25 downto 21),
		read_reg2 => if_id_instr_out(20 downto 16),
		write_reg => mem_wb_write_reg_out, 
		write_data => wb_write_reg_data_out
	);
	
	SIGN_EXTEND_inst: entity work.SIGN_EXTEND port map(
		data_in => if_id_instr_out(15 downto 0),
    data_out => id_ex_sign_extend_in
	);
	
	-- ID/EX
	ID_EX_REG_inst : entity work.ID_EX_REG port map (
		clk => clk,
		reg_dst_in => id_ex_reg_dst_in,
		alu_op_in	=> id_ex_alu_op_in,
		alu_src_in => id_ex_alu_src_in,
		branch_in	=> id_ex_branch_in,
		mem_read_in	=> id_ex_mem_read_in,
		mem_write_in => id_ex_mem_write_in,
		reg_write_in => id_ex_reg_write_in,
		mem_to_reg_in	=> id_ex_mem_to_reg_in,
		pc_in	=> id_ex_pc_in,
		read_data1_in	=> id_ex_read_data1_in,
		read_data2_in => id_ex_read_data2_in,
		sign_extend_in => id_ex_sign_extend_in,
		rt_addr_in => id_ex_rt_addr_in,
		rd_addr_in => id_ex_rd_addr_in,
		
		reg_dst_out => id_ex_reg_dst_out,
		alu_op_out => id_ex_alu_op_out,
		alu_src_out	=> id_ex_alu_src_out,
		branch_out => id_ex_branch_out,
		mem_read_out => id_ex_mem_read_out,
		mem_write_out => id_ex_mem_write_out,
		reg_write_out	=> id_ex_reg_write_out,
		mem_to_reg_out => id_ex_mem_to_reg_out,
		pc_out => id_ex_pc_out,
		read_data1_out => id_ex_read_data1_out,
		read_data2_out => id_ex_read_data1_out,
		sign_extend_out	=> id_ex_sign_extend_out,
		rt_addr_out	=> id_ex_rt_addr_out,
		rd_addr_out	=> id_ex_rd_addr_out
	);
	
	-- EX
	MUX_RegDst_inst: entity work.MUX_RegDst port map (
		sel => id_ex_reg_dst_out,
		in_0 => id_ex_rt_addr_out,
		in_1 => id_ex_rd_addr_out,
		mux_out => ex_mem_write_reg_in
	);
	
	MUX_ALUSrc_inst: entity work.MUX port map (
		sel => id_ex_alu_src_out,
		in_0 => id_ex_read_data2_out,
		in_1 => id_ex_sign_extend_out,
		mux_out => ex_alu_in_2
	);
	
	ALU_inst : entity work.ALU port map (
		alu_in_1 => id_ex_read_data1_in,
		alu_in_2 => ex_alu_in_2,
		alu_op => id_ex_alu_op_out,
		alu_cond => ex_mem_cond_in,
		alu_output => ex_mem_alu_output_in
	);
	
	SHIFT_LEFT_2_inst : entity work.SHIFT_LEFT_2 port map (
		data_in => id_ex_sign_extend_out,
    data_out => ex_shift_left_2_out
	);
	
	ADDER_EX_inst : entity work.ADDER port map (
		input_1 => id_ex_pc_out,
		input_2 => ex_shift_left_2_out,
		output => ex_mem_pc_in
	);
	
	-- EX/MEM
	EX_MEM_REG_inst: entity work.EX_MEM_REG port map (
		 clk => clk,
		 branch_in => ex_mem_branch_in, -- MEM
		 mem_read_in => ex_mem_mem_read_in, -- MEM
		 mem_write_in	=> ex_mem_mem_write_in, -- MEM
		 reg_write_in => ex_mem_reg_write_in, -- WB
		 mem_to_reg_in => ex_mem_mem_to_reg_in, -- WB
		 pc_in => ex_mem_pc_in,
		 cond_in => ex_mem_cond_in,
		 alu_output_in => ex_mem_alu_output_in,
		 write_data_in => ex_mem_write_data_in, 
		 write_reg_in	=> ex_mem_write_reg_in,
		 
		 branch_out => ex_mem_branch_out, -- MEM
		 mem_read_out	=> ex_mem_mem_read_out, -- MEM
		 mem_write_out => ex_mem_mem_write_out, -- MEM
		 reg_write_out => ex_mem_reg_write_out, -- WB
		 mem_to_reg_out	=> ex_mem_mem_to_reg_out, -- WB
		 pc_out	=> ex_mem_pc_out,
		 cond_out	=> ex_mem_cond_out,
		 alu_output_out => ex_mem_alu_output_out,
		 write_data_out => ex_mem_write_data_out,
		 write_reg_out => ex_mem_write_reg_out
	);
	
	
	
	
	
end RTL;

