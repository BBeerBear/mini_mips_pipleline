library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ID_EX_REG is
	port(clk 							: in std_logic;
			 ex_flush					: in std_logic;
	
			 reg_dst_in 			: in std_logic; -- EX
			 alu_op_in				: in std_logic_vector(2 downto 0); -- EX
			 alu_src_in				: in std_logic; -- EX
			 mem_read_in			: in std_logic; -- MEM
			 mem_write_in			: in std_logic; -- MEM
			 reg_write_in			: in std_logic; -- WB
			 mem_to_reg_in		: in std_logic; -- WB
			 read_data1_in		: in unsigned(31 downto 0);
			 read_data2_in		: in unsigned(31 downto 0);
			 sign_extend_in	  : in unsigned(31 downto 0);
			 rt_addr_in				: in std_logic_vector(4 downto 0);
			 rd_addr_in				: in std_logic_vector(4 downto 0);
			 rs_addr_in				: in std_logic_vector(4 downto 0);
			 
			 reg_dst_out 			: out std_logic; -- EX
			 alu_op_out				: out std_logic_vector(2 downto 0); -- EX
			 alu_src_out			: out std_logic; -- EX
			 mem_read_out			: out std_logic; -- MEM
			 mem_write_out		: out std_logic; -- MEM
			 reg_write_out		: out std_logic; -- WB
			 mem_to_reg_out		: out std_logic; -- WB
			 read_data1_out		: out unsigned(31 downto 0);
			 read_data2_out		: out unsigned(31 downto 0);
			 sign_extend_out	: out unsigned(31 downto 0);
			 rt_addr_out			: out std_logic_vector(4 downto 0);
			 rd_addr_out			: out std_logic_vector(4 downto 0);
			 rs_addr_out			: out std_logic_vector(4 downto 0));
end ID_EX_REG;

architecture RTL of ID_EX_REG is 
begin
process(clk)
begin
	if rising_edge(clk) then
		if ex_flush = '1' then
			reg_dst_out <= 'X';
			alu_op_out <= "XXX";
			alu_src_out <= 'X';
			mem_read_out <= 'X';
			mem_write_out <= 'X';
			reg_write_out <= 'X';
			mem_to_reg_out <= 'X';
			read_data1_out <= x"00000000";
			read_data2_out <= x"00000000";
			sign_extend_out <= x"00000000";
			rt_addr_out <= "00000";
			rd_addr_out <= "00000";	
			rs_addr_out <= "00000";
		else 
			reg_dst_out <= reg_dst_in;
			alu_op_out <= alu_op_in;
			alu_src_out <= alu_src_in;
			mem_read_out <= mem_read_in;
			mem_write_out <= mem_write_in;
			reg_write_out <= reg_write_in;
			mem_to_reg_out <= mem_to_reg_in;
			read_data1_out <= read_data1_in;
			read_data2_out <= read_data2_in;
			sign_extend_out <= sign_extend_in;
			rt_addr_out <= rt_addr_in;
			rd_addr_out <= rd_addr_in;
			rs_addr_out <= rs_addr_in;
		end if;
	end if;
end process;
end RTL;