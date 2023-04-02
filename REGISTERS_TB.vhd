library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGISTERS_TB is
end entity;

architecture sim of REGISTERS_TB is
	component REGISTERS is
		port(clk				: in std_logic;
				 read_reg1	: in std_logic_vector(4 downto 0);
				 read_reg2	: in std_logic_vector(4 downto 0);
				 write_reg  : in std_logic_vector(4 downto 0);
				 write_data : in unsigned(31 downto 0);
				 read_data1 : out unsigned(31 downto 0);
				 read_data2 : out unsigned(31 downto 0));
	end component;
	signal clk : std_logic := '0';
	signal read_reg1, read_reg2, write_reg : std_logic_vector(4 downto 0);
	signal write_data, read_data1, read_data2 : unsigned(31 downto 0);
begin
	clk <= not clk after 5 ns;

	UUT : REGISTERS port map(
		clk => clk,
		read_reg1 => read_reg1,
		read_reg2 => read_reg2,
		write_reg => write_reg,
		write_data => write_data,
		read_data1 => read_data1,
		read_data2 => read_data2
	);

	process
	begin
		read_reg1 <= "00000";
		read_reg2 <= "00001";
		write_reg <= "00010";
		write_data <= x"CCCCCCCC";
		wait;
	end process;
end sim;