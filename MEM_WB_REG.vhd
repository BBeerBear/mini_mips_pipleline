library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_WB_REG is
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
end MEM_WB_REG;

architecture RTL of MEM_WB_REG is
begin

process(clk)
begin
	if rising_edge(clk) then
		reg_write_out <= reg_write_in;
		mem_to_reg_out <= mem_to_reg_in;
		read_data_out <= read_data_in;
		alu_output_out <= alu_output_in;
		write_reg_out <= write_reg_in;
	end if;
end process;

end RTL;