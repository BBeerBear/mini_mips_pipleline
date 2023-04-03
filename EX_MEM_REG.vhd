library ieee;
use ieee.std_logic_1164.all;

entity EX_MEM_REG is
	port(clk 							: in std_logic;
	
			 branch_in				: in std_logic; -- MEM
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 pc_in						: in unsigned(31 downto 0);
			 cond_in					: in boolean;
			 alu_output_in    : in unsigned(31 downto 0);
			 write_data_in		: in unsigned(31 downto 0);
			 write_reg_in			: in std_logic_vector(4 downto 0);
			 
			 branch_out				: out std_logic; -- MEM
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 pc_out						: out unsigned(31 downto 0);
			 cond_out					: out boolean;
			 alu_output_out   : out unsigned(31 downto 0);
			 write_data_out		: out unsigned(31 downto 0);
			 write_reg_out		: out std_logic_vector(4 downto 0);
end EX_MEM_REG;