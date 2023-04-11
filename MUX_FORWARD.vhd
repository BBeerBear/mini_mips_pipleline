library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_FORWARD is
	port(	sel 		: in std_logic_vector(1 downto 0);
				in_00		: in unsigned(31 downto 0);
				in_01		: in unsigned(31 downto 0);
				in_10		: in unsigned(31 downto 0);
				mux_out	: out unsigned(31 downto 0));
end MUX_FORWARD;

architecture RTL of MUX_FORWARD is
begin

process(sel, in_00, in_01, in_10)
begin
	if sel = "00" then 
		mux_out <= in_00;
	elsif sel = "01" then
		mux_out <= in_01;
	else 
		mux_out <= in_10;
	end if;
end process;
end RTL;
	