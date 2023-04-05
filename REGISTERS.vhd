library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGISTERS is
	port(clk				: in std_logic;
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
		1 => x"55555555",
		2 => x"AAAAAAAA",
		others => (others => '0')
	);
begin

process(clk)
begin
	if rising_edge(clk) then
		read_data1 <= reg_file(to_integer(unsigned(read_reg1)));
		read_data2 <= reg_file(to_integer(unsigned(read_reg2)));
		
		 -- Write data to register if write enable is high
		if write_reg /= "00000" and reg_write = '1' then
				reg_file(to_integer(unsigned(write_reg))) <= write_data;
		end if;
	end if;
end process;
end RTL;