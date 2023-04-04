library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SIGN_EXTEND is
  port (
    data_in   : in  std_logic_vector(15 downto 0); -- Input data to be sign-extended
    data_out  : out unsigned(31 downto 0)  -- Output sign-extended data
  );
end SIGN_EXTEND;

architecture Behavioral of SIGN_EXTEND is
begin
  process (data_in)
  begin
		data_out <= (others => '0');
		data_out(15 downto 0) <=  unsigned(data_in);
  end process;
end Behavioral;