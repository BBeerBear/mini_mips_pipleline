library ieee;
use ieee.std_logic_1164.all;

entity IF_ID_REG is
	port(clk						: in std_logic;
			 instruction_in : in std_logic_vector(31 downto 0);
			 pc_in 					: in unsigned(31 downto 0);
			 instruction_out: out std_logic_vector(31 downto 0));
			 pc_out					: out unsigned(31 downto 0);
end entity;

architecture behavioral of IF_ID_REG is
  signal pc_reg : unsigned(31 downto 0) := (others => '0');
  signal instruction_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      pc_reg <= pc_in;
      instruction_reg <= instruction_in;
    end if;
  end process;

  pc_out <= pc_reg;
  instruction_out <= instruction_reg;

end architecture behavioral;