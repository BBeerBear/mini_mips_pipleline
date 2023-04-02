library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(alu_in_1 	: in unsigned(31 downto 0);
			 alu_in_2 	: in unsigned(31 downto 0)
			 alu_output	: output unsigned(31 downto 0);
end ALU;

architecture RTL of ALU is 
	
begin

end RTL;