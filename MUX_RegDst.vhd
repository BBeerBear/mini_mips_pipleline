library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity MUX_RegDst is
	port(	sel    	: in  std_logic;
				in_0    : in  std_logic_vector(4 downto 0);
				in_1		: in  std_logic_vector(4 downto 0);
				mux_out	: out std_logic_vector(4 downto 0));
end MUX_RegDst;

architecture RTL of MUX_RegDst is
begin
process (sel, in_0, in_1) is
begin
if sel = '0' then
		mux_out <= in_0;
else
		mux_out <= in_1;
end if;
end process;
end RTL;
