library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EX_MEM_REG is
	port(clk 							: in std_logic;
			 
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 alu_output_in    : in unsigned(31 downto 0);
			 write_data_in		: in unsigned(31 downto 0);
			 write_reg_in			: in std_logic_vector(4 downto 0);
			 
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 alu_output_out   : out unsigned(31 downto 0);
			 write_data_out		: out unsigned(31 downto 0);
			 write_reg_out		: out std_logic_vector(4 downto 0));
end EX_MEM_REG;

architecture RTL of EX_MEM_REG is
begin

process(clk)
begin
	if rising_edge(clk) then
		mem_read_out <= mem_read_in; -- MEM
		mem_write_out	<= mem_write_in; -- MEM
		reg_write_out <= reg_write_in; -- WB
		mem_to_reg_out <=	mem_to_reg_in; -- WB
		alu_output_out <= alu_output_in;
		write_data_out <= write_data_in;
		write_reg_out <= write_reg_in;
	end if;
end process;

end RTL;