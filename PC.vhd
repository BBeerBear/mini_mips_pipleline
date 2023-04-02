library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(	clk				: in std_logic;
				addr_next	: in unsigned(31 downto 0);
				addr_now	: out unsigned(31 downto 0));
end PC;

architecture RTL of PC is
signal addr : unsigned(31 downto 0);
begin

process(clk)
begin
	if rising_edge(clk) then
		addr <= addr_next;
	end if;
end process;

addr_now <= addr;

end RTL;