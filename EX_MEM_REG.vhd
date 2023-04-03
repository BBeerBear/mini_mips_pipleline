library ieee;
use ieee.std_logic_1164.all;

entity EX_MEM_REG is
	port(clk 							: in std_logic;
			 branch_in				: in std_logic; -- MEM
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 branch_out				: out std_logic; -- MEM
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic); -- WB
end EX_MEM_REG;