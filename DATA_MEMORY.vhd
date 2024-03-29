library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DATA_MEMORY is
	port(mem_write  : in std_logic;
			 mem_read		: in std_logic;
			 address 		: in unsigned(31 downto 0);
			 write_data : in unsigned(31 downto 0);
			 read_data	: out unsigned(31 downto 0));
end DATA_MEMORY;

architecture RTL of DATA_MEMORY is
	type mem_type is array(0 to 2**20 - 1) of unsigned(31 downto 0);
	signal mem : mem_type
	 := (
		3 => x"0000000B",
		others => (others => '0')
	 );
begin
	process(mem_write, mem_read, address, write_data)
	begin

		if mem_write = '1' then
			mem(to_integer(address)) <= write_data;
		end if;
		if mem_read = '1' then
			read_data <= mem(to_integer(address));
		end if;

	end process;
end RTL;