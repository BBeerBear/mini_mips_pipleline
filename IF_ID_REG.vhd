entity IF_ID_REG is
	port(clk						: in std_logic;
			 instruction_in : in std_logic_vector(31 downto 0);
			 pc_in 					: in unsigned(31 downto 0);
			 instruction_out: out std_logic_vector(31 downto 0));
			 pc_out					: out unsigned(31 downto 0);
end entity;