library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_LEFT_2 is
  port (
    data_in  : in  unsigned(31 downto 0); -- Input data to be shifted
    data_out : out unsigned(31 downto 0)  -- Output shifted data
  );
end shift_left_2;

architecture Behavioral of SHIFT_LEFT_2 is
begin
  data_out <= data_in(29 downto 0) & "00"; -- Shift input left by 2 bits and append 2 0's to the end
end Behavioral;