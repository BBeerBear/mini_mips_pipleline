library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER_TB is
end ADDER_TB;

architecture TEST of ADDER_TB is
signal input 	: unsigned(31 downto 0);
signal output : unsigned(31 downto 0);
component ADDER is
	port( input : in unsigned(31 downto 0);
				output: out unsigned(31 downto 0));
end component;
begin
	uut: ADDER port map (
		input  => input,
		output => output
	);
	
process
begin
	input <= x"00000000";
	wait for 10 ns;
	input <= x"0000000F";
	wait;
end process;
end TEST;
