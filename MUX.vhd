library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity MUX is
	port(	sel    	: in  std_logic;
				in_0 		: in  unsigned(31 downto 0);
				in_1		: in  unsigned(31 downto 0);
				out_mux	: out unsigned(31 downto 0));
end MUX;

architecture RTL of MUX is
begin
process (sel, in_0, in_1) is
begin
if sel = '0' then
		out_mux <= in_0;
else
		out_mux <= in_1;
end if;
end process;
end RTL;
