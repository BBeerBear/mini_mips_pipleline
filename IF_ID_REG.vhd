library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID_REG is
	port(clk						: in std_logic;
			 instruction_in : in std_logic_vector(31 downto 0);
			 pc_in 					: in unsigned(31 downto 0);
			 instruction_out: out std_logic_vector(31 downto 0);
			 pc_out					: out unsigned(31 downto 0));
end entity;

architecture behavioral of IF_ID_REG is
begin
  process(clk)
  begin
    if rising_edge(clk) then
      pc_out <= pc_in;
      instruction_out <= instruction_in;
    end if;
  end process;

end architecture behavioral;