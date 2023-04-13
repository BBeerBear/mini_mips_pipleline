library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MINI_MIPS_TB is
end entity;

architecture TEST of MINI_MIPS_TB is
signal clk: std_logic := '0';
signal reset: std_logic := '0';
begin

MINI_MIPS_inst: entity work.MINI_MIPS port map(
	reset => reset,
	clk => clk
);

clk <= not clk after 5ns;
reset <= '0', '1' after 10ns;


end TEST;