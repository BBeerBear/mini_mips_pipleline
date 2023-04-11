library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ISZERO is
port (read_data1 : in unsigned(31 downto 0);
			read_data2 : in unsigned(31 downto 0);
			cond 			 : out std_logic := '0');
end ISZERO;

architecture RTL of ISZERO is
begin
process(read_data1, read_data2)
begin
	if read_data1 - read_data2 = 0 then
		cond <= '1';
	end if;
end process;
end RTL;