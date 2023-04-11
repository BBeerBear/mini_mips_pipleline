library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HARZARD_UNIT is
	port( ex_rs					: in std_logic_vector(4 downto 0);
				ex_rt					: in std_logic_vector(4 downto 0);
				mem_write_reg : in std_logic_vector(4 downto 0);
				wb_write_reg	: in std_logic_vector(4 downto 0);
				id_rs					: in std_logic_vector(4 downto 0);
				id_rt					: in std_logic_vector(4 downto 0);
			  ex_mem_to_reg	: in std_logic;
				pc_src				: in std_logic;
				id_pc					: in unsigned(31 downto 0);
				branch_addr		: in unsigned(31 downto 0);
				forward_data1 : out std_logic_vector(1 downto 0);
				forward_data2 : out std_logic_vector(1 downto 0);
			  if_stall			: out std_logic;
			  id_stall			: out std_logic;
				id_flush			: out std_logic;
			  ex_flush			: out std_logic
			);
end HARZARD_UNIT;

architecture RTL of HARZARD_UNIT is
begin

process(ex_rs, ex_rt, mem_write_reg, wb_write_reg, pc_src, branch_addr, id_pc, id_rs, id_rs)
begin 
	-- Data Harzard
	if ex_rs /= "00000" and ex_rs = mem_write_reg then
		forward_data1 <= "10";
	elsif ex_rs /= "00000" and ex_rs = wb_write_reg then
		forward_data1 <= "01";	
	elsif ex_rs /= "00000" and ex_rs = wb_write_reg then
		forward_data1 <= "01";
	else
		forward_data1 <= "00";
	end if;
	if ex_rt /= "00000" and ex_rt = mem_write_reg then
		forward_data2 <= "10";
	elsif ex_rt /= "00000" and ex_rt = wb_write_reg then
		forward_data2 <= "01";
	else
		forward_data2 <= "00";
	end if;
	-- LW Harzard
	if (ex_rt = id_rt or ex_rt = id_rs) and ex_mem_to_reg = '0' then
		if_stall <= '1';
		id_stall <= '1';
		ex_flush <= '1';
	else
		if_stall <= '0';
		id_stall <= '0';
		ex_flush <= '0';
	end if;
	-- Control Harzard
	if pc_src = '1' and branch_addr /= id_pc then
		id_flush <= '1';
	else 
		id_flush <= '0';
	end if;
end process;
end RTL;
	