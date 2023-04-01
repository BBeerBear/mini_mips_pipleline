library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ADDER is
	port( input : in std_logic_vector(31 downto 0);
				output: out std_logic_vector(31 downto 0));
end ADDER;

architecture RTL of ADDER is
begin
	output <= input + x"00000004";
end RTL;
