
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity CPU is

	port(
				clk_cpu		: in	std_logic;
				data_in_cpu	: in	std_logic;
				reset_cpu	: in	std_logic;
				data_out_cpu: out	std_logic_vector(2 downto 0)
	);
	
end CPU;


architecture rtl of CPU is

	component cu
		port(
				clk_cu		: in	std_logic;
				data_in_cu	: in	std_logic;
				reset_cu	 	: in	std_logic;
				data_out_cu	: out	std_logic_vector(2 downto 0)
			);
	end component;


begin
	cu1	: cu	port map (	clk_cu		=> clk_cpu,
									data_in_cu	=> data_in_cpu,
									reset_cu		=> reset_cpu,
									data_out_cu	=> data_out_cpu
								);
	


end rtl;





