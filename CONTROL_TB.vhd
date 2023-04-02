library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONTROL_TB is
end CONTROL_TB;

architecture sim of CONTROL_TB is
	component CONTROL is
		port(opcode 					: in std_logic_vector(5 downto 0);
				 funct						: in std_logic_vector(5 downto 0);
				 reg_dst					: out std_logic; -- EX
				 alu_op 					: out std_logic_vector(2 downto 0); -- EX
				 alu_src					: out std_logic; -- EX
				 branch						: out std_logic; -- MEM
				 mem_read					: out std_logic; -- MEM
				 mem_write				: out std_logic; -- MEM
				 reg_write				: out std_logic; -- WB
				 mem_to_reg				: out std_logic); -- WB
	end component;
	
	signal opcode,funct : std_logic_vector(5 downto 0);
	signal alu_op : std_logic_vector(2 downto 0);
	signal reg_dst,alu_src,branch,mem_read,mem_write,reg_write,mem_to_reg : std_logic;
begin
	UUT : CONTROL port map(
		opcode => opcode,
		funct => funct,
		reg_dst => reg_dst,
		alu_op => alu_op,
		alu_src => alu_src,
		branch => branch,
		mem_read => mem_read,
		mem_write => mem_write,
		reg_write => reg_write,
		mem_to_reg => mem_to_reg
	);
	
	process 
	begin
		opcode <= "000000";
		funct <= "100111";
		wait for 5 ns;
		opcode <= "000000";
		funct <= "000000";
		wait;
	end process;
end sim;
	