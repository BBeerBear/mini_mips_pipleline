library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_tb is
end PC_tb;

architecture TEST of PC_TB is

    signal clk 			 : std_logic := '0';
    signal addr_next : unsigned(31 downto 0) := (others => '0');
    signal addr_now  : unsigned(31 downto 0);

    component PC is
        port (
            clk : in std_logic;
            addr_next : in unsigned(31 downto 0);
            addr_now : out unsigned(31 downto 0)
        );
    end component;

begin

    uut : PC
        port map (
            clk => clk,
            addr_next => addr_next,
            addr_now => addr_now
        );

		clk <= not clk after 5 ns;

    test_process : process
    begin
        addr_next <= x"AAAAAAAA";
				wait for 10 ns;
				addr_next <= x"BBBBBBBB";
        wait;
    end process;

end TEST;
