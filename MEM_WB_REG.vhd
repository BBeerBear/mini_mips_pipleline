library ieee;
use ieee.std_logic_1164.all;

entity EX_MEM_REG is
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
			 write_reg_out		: out std_logic_vector(4 downto 0);
end EX_MEM_REG;