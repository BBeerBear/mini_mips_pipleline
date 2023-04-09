library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(	clk						: in std_logic;
				reset					: in std_logic;
				pc_in					: in unsigned(31 downto 0);
				pc_out      	: out unsigned(31 downto 0));
end PC;

architecture RTL of PC is
begin

process(clk, reset)
begin
	if rising_edge(clk) then
		if reset='0' then
			pc_out <= x"00000004";
		else
			pc_out <= pc_in;
		end if;
	end if;
end process;
end RTL;