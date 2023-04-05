library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(alu_in_1 	: in unsigned(31 downto 0);
			 alu_in_2 	: in unsigned(31 downto 0);
			 alu_op			: in std_logic_vector(2 downto 0);
			 alu_cond   : out std_logic;
			 alu_output	: out unsigned(31 downto 0));
end ALU;

architecture RTL of ALU is 
begin
	process (alu_in_1, alu_in_2, alu_op)
	begin
	case alu_op is
		when "001" => -- NOR 
			alu_output <= alu_in_1 nor alu_in_2;
		when "010" => -- SLL
			alu_output <= shift_left(alu_in_2, 2);
		when "100" => -- ADD, ADDI
			alu_output <= alu_in_1 + alu_in_2;
		when "101" => -- SUBUI
			alu_output <= alu_in_1 - alu_in_2;
		when "110" => -- BEQ
			if alu_in_1 = alu_in_2 then
				alu_cond <= '0';
			else
				alu_cond <= '1';
			end if;
			alu_output <= x"00000000";
		when others => 
			alu_output <= x"00000000";
	end case;
	end process;
end RTL;