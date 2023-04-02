library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INSTRUCTION_MEMORY_TB is
end INSTRUCTION_MEMORY_TB;

architecture TEST of INSTRUCTION_MEMORY_TB is
signal clk: std_logic := '0';
signal addr: unsigned(31 downto 0) := (others => '0');
signal instruction: std_logic_vector(31 downto 0);
component INSTRUCTION_MEMORY is
	port( clk 				: in std_logic;
				addr		 		: in unsigned(31 downto 0);
				instruction : out std_logic_vector(31 downto 0));
end component;
begin 
-- 1KB ROM
UUT : INSTRUCTION_MEMORY port map(
		clk => clk,
		addr => addr,
		instruction => instruction
);

clk <= not clk after 5 ns;
	
process
begin
	addr <= to_unsigned(0, 32);
	wait for 10 ns;
end process;
end architecture TEST;

