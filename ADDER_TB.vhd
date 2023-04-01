library ieee;
use ieee.std_logic_1164.all;

entity ADDER_TB is
end ADDER_TB;

architecture TEST of ADDER_TB is
signal input 	: std_logic_vector(31 downto 0);
signal output : std_logic_vector(31 downto 0);
component ADDER is
	port( input : in std_logic_vector(31 downto 0);
				output: out std_logic_vector(31 downto 0));
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
