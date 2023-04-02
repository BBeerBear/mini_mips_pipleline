library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MINI_MIPS_TB is
end MINI_MIPS_TB;

architecture sim of MINI_MIPS_TB is
	component MINI_MIPS is
		port(clk			: in std_logic;
				 if_id_reg: out std_logic_vector(31 downto 0));
	end component;
	signal clk: std_logic := '0';
	signal if_id_reg : std_logic_vector(31 downto 0);
begin
	clk <= not clk after 5 ns;
	
	UUT: MINI_MIPS port map(
		clk => clk,
		if_id_reg => if_id_reg
	);

end sim;