library ieee;
use ieee.std_logic_1164.all;

entity CONTROL is
	port(
			 opcode 					: in std_logic_vector(5 downto 0);
			 funct						: in std_logic_vector(5 downto 0);
			 jump 						: out std_logic; -- ID
			 jump_src					: out std_logic; -- ID
			 reg_dst					: out std_logic; -- EX
			 alu_op 					: out std_logic_vector(2 downto 0); -- EX
			 alu_src					: out std_logic; -- EX
			 branch						: out std_logic; -- MEM
			 mem_read					: out std_logic; -- MEM
			 mem_write				: out std_logic; -- MEM
			 reg_write				: out std_logic; -- WB
			 mem_to_reg				: out std_logic); -- WB
end CONTROL;

architecture RTL of CONTROL is
begin
	process (opcode, funct)
	begin
		case opcode is
			-- R-type
			when "000000" => -- NOR, SLL, XOR, ADD, JR
				reg_dst <= '1';
				alu_src <= '0';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '1';
				mem_to_reg <= '1';
				jump <= '0';
				case funct is
					when "100111" => -- NOR
						alu_op <= "001";
					when "000000" => -- SLL
						alu_op <= "010";			
					when "100110" => -- XOR
						alu_op <= "011";
					when "100000" => -- ADD
						alu_op <= "100";
					when "001000" => -- JR
						jump <= '1';
						jump_src <= '0';
						alu_op <= "000";
						mem_to_reg <= 'X';
					when others => 
						alu_op <= "XXX"; 
						mem_to_reg <= 'X';
				end case;
			-- I-type
			when "001100" => -- ADDI
				reg_dst <= '1';
				alu_op <= "100";
				alu_src <= '1';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '1';
				mem_to_reg <= '1';
				jump <= '0';
			when "000001" => -- SUBUI
				reg_dst <= '1';
				alu_op <= "101";
				alu_src <= '1';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '1';
				mem_to_reg <= '1';
				jump <= '0';
			when "000100" => -- BEQ
				reg_dst <= 'X';
				alu_op <= "110";
				alu_src <= '0';
				branch <= '1';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '0';
				mem_to_reg <= 'X';
				jump <= '0';
			when "100011" => -- LW
				reg_dst <= '0';  -- rt
				alu_op <= "100"; -- +
				alu_src <= '1';
				branch <= '0';
				mem_read <= '1';
				mem_write <= '0';
				reg_write <= '1';
				mem_to_reg <= '1';
				jump <= '0';
			when "101000" => -- SB
				reg_dst <= 'X';
				alu_op <= "100"; -- +
				alu_src <= '1';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '1';
				reg_write <= '0';
				mem_to_reg <= 'X';
				jump <= '0';
			-- J-type
			when "000010" =>
				reg_dst <= '0';
				alu_op <= "111";
				alu_src <= 'X';
				jump <= '1';
				jump_src <= '1';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '0';
				mem_to_reg <= 'X';
			when others => -- 
				reg_dst <= 'X';
				alu_op <= "XXX";
				alu_src <= 'X';
				branch <= '0';
				mem_read <= '0';
				mem_write <= '0';
				reg_write <= '0';
				mem_to_reg <= 'X';
				jump <= '0';
		end case;
	end process;
end RTL;