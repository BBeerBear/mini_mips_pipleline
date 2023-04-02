library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER is
	port( input : in unsigned(31 downto 0);
				output: out unsigned(31 downto 0));
end ADDER;

architecture RTL of ADDER is
begin
	output <= input + 4;
end RTL;
