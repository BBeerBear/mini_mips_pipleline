library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MINI_MIPS is
	port(clk			: in std_logic;
			 if_id_reg: out std_logic_vector(31 downto 0));
end MINI_MIPS;

architecture RTL of MINI_MIPS is
-- signal if_id_reg, ID_EX_REG, EX_MEM_REG, MEM_WB_REG : std_logic_vector(31 downto 0);

component PC is
	port(	clk				: in std_logic;
				addr_next	: in unsigned(31 downto 0);
				addr_now	: out unsigned(31 downto 0));
end component;
signal addr_next, addr_now : unsigned(31 downto 0);

component ADDER is
	port( input : in unsigned(31 downto 0);
				output: out unsigned(31 downto 0));
end component;
signal adder_output : unsigned(31 downto 0);
	
component INSTRUCTION_MEMORY is
	port( clk 				: in std_logic;
				addr		 		: in unsigned(31 downto 0);
				instruction : out std_logic_vector(31 downto 0));
end component;
signal addr : unsigned(31 downto 0);
signal instruction : std_logic_vector(31 downto 0);

begin
	
	PC_inst: PC port map (
		clk => clk,
		addr_next => addr_next,
		addr_now => addr_now
	);
	
	ADDER_inst: ADDER port map (
		input => addr_now,
		output => adder_output
	);
	
	INST_MEM_inst: INSTRUCTION_MEMORY port map (
		clk => clk,
		addr => addr_now,
		instruction => if_id_reg
	);
	
end RTL;

