library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER is
	port( input_1 : in unsigned(31 downto 0);
				input_2 : in unsigned(31 downto 0);
				output  : out unsigned(31 downto 0));
end ADDER;

architecture RTL of ADDER is
begin
	output <= input_1 + input_2;
end RTL;
