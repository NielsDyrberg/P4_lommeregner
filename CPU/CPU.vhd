
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity CPU is

	port(
				clk_cpu					: in	std_logic;
				reset_cpu				: in	std_logic;
				ready_cpu				: in  STD_LOGIC;
				
				error_cpu, rw_cpu, 
				en_cpu, oe_cpu			: out std_logic;	
				addr_cpu					: out std_logic_vector(11 downto 0);
				
				data_in_cpu				: in std_logic;
				data_out_cpu			: out std_logic_vector(2 downto 0)
	);
	
end CPU;


architecture rtl of CPU is

	signal instrReg_cpu	:	std_logic_vector(19 downto 0) := (others => '0');
	signal status_cpu		:	std_logic_vector(4 downto 0)	:= (others => '0');

	component cu
		port(
				clk_cu								: in	std_logic;
				reset_cu	 							: in	std_logic;
				ready_cu								: in  std_logic;
				
				data_out_cu							: out	std_logic_vector(2 downto 0);
				
				rw_cu, vma_cu, opregSel_cu, 
				errorSel_cu, addrSel_cu, 
				instrSel_cu, oe_cu				: out std_logic;
				outSel_cu							: out std_logic_vector(1 downto 0);
				regSel_cu							: out std_logic_vector(4 downto 0); 
				shiftSel_cu							: out std_logic_vector(2 downto 0);
				aluSel_cu							: out std_logic_vector(3 downto 0);
				status_cu							: in 	std_logic_vector(4 downto 0);
				instrReg_cu							: in 	std_logic_vector(19 downto 0)
			);
	end component;


begin
	cu1	: cu	port map (	clk_cu		=> clk_cpu,
									reset_cu		=> reset_cpu,	
									ready_cu		=> ready_cpu,

									data_out_cu	=> data_out_cpu,
									
									rw_cu			=> open, 
									vma_cu		=> open, 
									opregSel_cu	=> open, 
									errorSel_cu	=> open, 
									addrSel_cu	=> open, 
									instrSel_cu	=> open, 
									oe_cu			=> open,
									outSel_cu	=> open,
									regSel_cu	=> open,
									shiftSel_cu	=> open,
									aluSel_cu	=> open,
									status_cu	=> status_cpu,
									instrReg_cu	=> instrReg_cpu
								);
	


end rtl;





