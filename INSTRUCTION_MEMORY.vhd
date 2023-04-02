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
		"00000000001010000110000000100111", -- NOR $s1, $s3, $s2
		-- "000000 000100 000101 000110 101010"  -- SLL;
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000"
	);
begin
  process(clk)
  begin
    if rising_edge(clk) then
      instruction <= rom(to_integer(addr));
    end if;
  end process;
end architecture rtl;

