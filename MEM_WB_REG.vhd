entity EX_MEM_REG is
	port(clk 							: in std_logic;
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic); -- WB
end EX_MEM_REG;