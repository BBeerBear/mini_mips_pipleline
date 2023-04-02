library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_tb is
end MUX_tb;

architecture sim of MUX_tb is
    signal sel : std_logic;
    signal in_0 : unsigned(31 downto 0);
    signal in_1 : unsigned(31 downto 0);
    signal out_mux : unsigned(31 downto 0);
		component MUX is
			port(	sel    	: in  std_logic;
						in_0 		: in  unsigned(31 downto 0);
						in_1		: in  unsigned(31 downto 0);
						out_mux	: out unsigned(31 downto 0));
		end component;	
begin
    dut : MUX port map (sel => sel, in_0 => in_0, in_1 => in_1, out_mux => out_mux);

    process
    begin
        -- Test case 1: sel = '0'
        sel <= '0';
        in_0 <= to_unsigned(42, 32);
        in_1 <= to_unsigned(84, 32);
        wait for 1 ns;
        assert out_mux = to_unsigned(42, 32) report "Test case 1 failed" severity error;

        -- Test case 2: sel = '1'
        sel <= '1';
        in_0 <= to_unsigned(42, 32);
        in_1 <= to_unsigned(84, 32);
        wait for 1 ns;
        assert out_mux = to_unsigned(84, 32) report "Test case 2 failed" severity error;

        -- Add more test cases here...

        wait;
    end process;
end sim;
