library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGISTERS is
	port(
			 reg_write  : in std_logic; -- control signal
			 read_reg1	: in std_logic_vector(4 downto 0);
			 read_reg2	: in std_logic_vector(4 downto 0);
			 write_reg  : in std_logic_vector(4 downto 0);
			 write_data : in unsigned(31 downto 0);
			 read_data1 : out unsigned(31 downto 0);
			 read_data2 : out unsigned(31 downto 0));
end REGISTERS;

architecture RTL of REGISTERS is
	type reg_array is array (0 to 31) of unsigned(31 downto 0);
	signal reg_file : reg_array := (
		1 => x"66666666",
		2 => x"CCCCCCCC",
		3 => x"66666666",
		4 => x"00000001",
		others => (others => '0')
	);
begin

process(reg_write, read_reg1, read_reg2, write_reg, write_data)
begin

read_data1 <= reg_file(to_integer(unsigned(read_reg1)));
read_data2 <= reg_file(to_integer(unsigned(read_reg2)));

-- Write data to register if write enable is high
if write_reg /= "00000" and reg_write = '1' then
	reg_file(to_integer(unsigned(write_reg))) <= write_data;
end if;

end process;
end RTL;