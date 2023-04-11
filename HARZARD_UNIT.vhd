library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HARZARD_UNIT is
	port( rs						: in std_logic_vector(4 downto 0);
				rt						: in std_logic_vector(4 downto 0);
				mem_write_reg : in std_logic_vector(4 downto 0);
				wb_write_reg	: in std_logic_vector(4 downto 0);
				forward_data1 : out std_logic_vector(1 downto 0);
				forward_data2 : out std_logic_vector(1 downto 0));
end HARZARD_UNIT;

architecture RTL of HARZARD_UNIT is
begin

process(rs, rt, mem_write_reg, wb_write_reg)
begin 
	if rs /= "00000" and rs = mem_write_reg then
		forward_data1 <= "10";
	elsif rs /= "00000" and rs = wb_write_reg then
		forward_data1 <= "01";	
	elsif rs /= "00000" and rs = wb_write_reg then
		forward_data1 <= "01";
	else
		forward_data1 <= "00";
	end if;
	if rt /= "00000" and rt = mem_write_reg then
		forward_data2 <= "10";
	elsif rt /= "00000" and rt = wb_write_reg then
		forward_data2 <= "01";
	else
		forward_data2 <= "00";
	end if;
end process;
end RTL;
	