library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INSTRUCTION_MEMORY is
	port(
				addr		 		: in unsigned(31 downto 0);
				instruction : out std_logic_vector(31 downto 0));
end INSTRUCTION_MEMORY;

architecture RTL of INSTRUCTION_MEMORY is
	-- 1KB ROM
	type rom_type is array (0 to 31) of std_logic_vector(31 downto 0);
	constant rom : rom_type := (
		--  NOR, SLL, XOR, ANDI, SUBUI, ADD, BEQ, LW, SB, JR and J.
		1 => "00000000001000100100000000100111", -- NOR $8,$1,$2   11111111
		2 => "00000000001000010110000010000000", -- SLL $12,$1,2   99999998
		3 => "00010000001000110000000000000101", -- BEQ $1,$3,5   
		4 => "00000000001000100011000000100110", -- XOR $6,$1,$2   AAAAAAAA
		5 => "00000000001000101000100000100000", -- ADD $17,$1,$2
		6 => "00000000001000101000100000100000", -- ADD $17,$1,$2
		7 => "00000000001000101000100000100000", -- ADD $17,$1,$2
		8 => "00000000001000101000100000100000", -- ADD $17,$1,$2
		9 => "00110000001010100000000000001010", -- ANDI $10,$1,10	66666670
		10 => "00000101000010110000000000001010", -- SUBUI $11,$8,10		11111107 
		11 => "00000000001011000011100000100000", -- ADD $7,$1,$12		xFFFFFFFE			
		12 => "10100000100010000000000000000010", -- SB $8,$4,2
		13 => "10001100100010010000000000000010", -- LW $9,$4,2
		14 => "00000001101000000000000000001000", -- JR $13
		18 => "00001000000000000000000000000100", -- J 4
		others => (others => '0')
	);
begin
process (addr)
begin
	instruction <= rom(to_integer(addr(31 downto 2)));
end process;
end architecture rtl;

