library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_divider is
	generic ( TCOUNT : natural := 60;
				 N_BITS : natural := 6 );


	Port(
			CLK_IN : in STD_LOGIC;
			RESET : in STD_LOGIC;
			CLK_OUT : OUT STD_LOGIC );

			
end clk_divider;


architecture arch of clk_divider is

	signal COUNT_OUT : STD_LOGIC_VECTOR (N_BITS -1 downto 0) := (others => '0');
	signal clk_mellem : std_logic := '0';
	
begin 

CLK_OUT <= clk_mellem;

process (CLK_IN)
begin
	
	if rising_edge(CLK_IN) then
		COUNT_OUT <= COUNT_OUT + '1';
		if RESET = '0' then
			COUNT_OUT <= (others => '0');
			clk_mellem <= '0';
		elsif COUNT_OUT = (TCOUNT) then
			COUNT_OUT <= (others => '0');
			clk_mellem <= not clk_mellem;

		end if;
	end if;

end process;

end arch;