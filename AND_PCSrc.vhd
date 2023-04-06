library ieee;
use ieee.std_logic_1164.all;

entity AND_PCSrc is
	port (
				branch 	 : in std_logic;
				cond   	 : in std_logic;
				pcsrc		 : out std_logic);
end AND_PCSrc;

architecture RTL of AND_PCSrc is
begin
	pcsrc <= branch and cond;
end RTL;