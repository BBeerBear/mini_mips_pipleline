library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INSTRUCTION_MEMORY is
	port( clk 				: in std_logic;
				addr		 		: in unsigned(31 downto 0);
				instruction : out std_logic_vector(31 downto 0));
end INSTRUCTION_MEMORY;

architecture RTL of INSTRUCTION_MEMORY is
	-- 1KB ROM
	type rom_type is array (0 to 31) of std_logic_vector(31 downto 0);
	constant rom : rom_type := (
		--  NOR, SLL, XOR, ANDI, SUBUI, ADD, BEQ, LW, SB, JR and J.
		0 => "00000000010001000100000000100111", -- NOR
		1 => "00000000000010000110000010000000", -- SLL
		2 => "00000001000011000011000000100110", -- XOR
		3 => "00110001000011000000000000001010", -- ANDI
		4 => "00000101000011000000000000001010", -- SUBUI
		5 => "00000001000011000011000000100000", -- ADD
		6 => "00010001000011000000000000001010", -- BEQ
		7 => "10001101000011000000000000001010", -- LW
		8 => "10100001000011000000000000001010", -- SB
		9 => "00000001000000000000000000001000", -- JR
		10 => "00001000000000000000000000000010", -- J
		others => (others => '0')
	);
begin
  process(clk)
  begin
    if rising_edge(clk) then
      instruction <= rom(to_integer(addr));
    end if;
  end process;
end architecture rtl;

