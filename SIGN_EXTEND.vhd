library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SIGN_EXTEND is
	generic (
		input_size : integer := 16;
		output_size : integer := 32
	);
  port (
    data_in   : in  std_logic_vector(input_size - 1 downto 0); -- Input data to be sign-extended
    data_out  : out unsigned(output_size - 1 downto 0)  -- Output sign-extended data
  );
end SIGN_EXTEND;

architecture RTL of SIGN_EXTEND is
begin
  process (data_in)
  begin
		data_out <= (others => '0');
		data_out(input_size - 1 downto 0) <=  unsigned(data_in(input_size - 1 downto 0));
  end process;
end RTL;