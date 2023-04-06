library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(	clk						: in std_logic;
				first_pc_in  	: in std_logic;
				addr_next			: in unsigned(31 downto 0);
				addr_now			: out unsigned(31 downto 0);
				first_pc_out	: out std_logic);
end PC;

architecture RTL of PC is
begin

process(clk)
begin
	if rising_edge(clk) then
		if first_pc_in = '1' then
			addr_now <= x"00000004";
			first_pc_out <= '0';
		else
			addr_now  <= addr_next;
		end if;
	end if;
end process;
end RTL;