entity ID_EX_REG is
	port(clk 							: in std_logic;
			 alu_op_in				: in std_logic_vector(2 downto 0); -- EX
			 alu_src_in				: in std_logic; -- EX
			 branch_in				: in std_logic; -- MEM
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 alu_op_out				: out std_logic_vector(2 downto 0); -- EX
			 alu_src_out			: out std_logic; -- EX
			 branch_out				: out std_logic; -- MEM
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic); -- WB
end ID_EX_REG;