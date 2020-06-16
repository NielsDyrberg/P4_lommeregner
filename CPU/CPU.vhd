
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
				
				data_in_cpu				: in  std_logic_vector(19 downto 0);
				data_out_cpu			: out std_logic_vector(19 downto 0)
	);
	
end CPU;


architecture rtl of CPU is

	signal IC_cpu			:	std_logic_vector(19 downto 0) := (others => '0');
	signal status_cpu		:	std_logic_vector(4 downto 0)	:= (others => '0');
	signal OA_cpu, AO_cpu:	std_logic_vector(19 downto 0) := (others => '0');
	signal aluSel_cpu		:	std_logic_vector(3 downto 0)	:= (others => '0');
	signal addrSel_cpu	:	std_logic							:= '0';
	signal opregSel_cpu	:	std_logic							:= '0';
	signal instrSel_cpu	:	std_logic							:= '0';
	signal outSel_cpu		:	std_logic_vector(1 downto 0)	:= (others => '0');
	signal regSel_cpu		:	std_logic_vector(4 downto 0)	:=	(others => '0');

	component cu
		port(
				clk_cu								: in	std_logic;
				reset_cu	 							: in	std_logic;
				ready_cu								: in  std_logic;
				
				state_cnt_cu						: out	integer;
				
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
	
	component ALU
		Port(
			INPUT_A 			: in STD_LOGIC_VECTOR (19 downto 0) ;
			INPUT_B 			: in STD_LOGIC_VECTOR (19 downto 0) ;
			SELECTPIN 		: in STD_LOGIC_VECTOR (3 downto 0);
			OUTPUT 			: out STD_LOGIC_VECTOR (19 downto 0); 
			STATUSPIN 		: out STD_LOGIC_VECTOR (4 downto 0) 
			);
	end component;
			
	component reg_15
		port( 
			D 										: in std_logic_vector(11 downto 0);
			E 										: in std_logic;
			Q 										: out std_logic_vector(11 downto 0)
		);
	end component;

	component reg_20
		port( 
			D 										: in std_logic_vector(19 downto 0);
			E 										: in std_logic;
			Q 										: out std_logic_vector(19 downto 0)
		);
	end component;

	component reg_20_ex is
		port( 
			D 										: in std_logic_vector(19 downto 0) := (others => '0');
			E 										: in std_logic	:= '0';
			rw										: in std_logic := '0';
			Q 										: out std_logic_vector(19 downto 0)
		);
	end component;

	component regArray_8 is
	port(	
		EN										: IN STD_LOGIC;							-- Register Array Enable
		WE										: IN STD_LOGIC;							-- Aktiver skriving
		AD										: IN STD_LOGIC_VECTOR(2 DOWnTO 0); 	-- Adresse vektor
		D										: IN STD_LOGIC_VECTOR(19 DOWNTO 0); -- Data input
		Q										: out STD_LOGIC_VECTOR(19 DOWNTO 0)	--Data output
	); 
	end component;


begin
	cu1	: cu	port map (	clk_cu		=> clk_cpu,
									reset_cu		=> reset_cpu,	
									ready_cu		=> ready_cpu,

									state_cnt_cu	=> open,
									
									rw_cu			=> rw_cpu, 
									vma_cu		=> en_cpu, 
									opregSel_cu	=> opregSel_cpu, 
									errorSel_cu	=> error_cpu, 
									addrSel_cu	=> addrSel_cpu, 
									instrSel_cu	=> instrSel_cpu, 
									oe_cu			=> oe_cpu,
									outSel_cu	=> outSel_cpu,
									regSel_cu	=> regSel_cpu,
									shiftSel_cu	=> open,
									aluSel_cu	=> aluSel_cpu,
									status_cu	=> status_cpu,
									instrReg_cu	=> IC_cpu
								);
	
	alu1	: ALU port map (	INPUT_A		=> data_in_cpu,
									INPUT_B		=> OA_cpu,
									SELECTPIN	=> aluSel_cpu,
									OUTPUT		=> AO_cpu,
									STATUSPIN	=> status_cpu
								
								);
	
	addrReg	: reg_15 port map (	D			=>	data_in_cpu(11 downto 0),
											E			=>	addrSel_cpu,
											Q			=>	addr_cpu
											);

	opReg		: reg_20 port map (	D			=> data_in_cpu,
											E			=> opregSel_cpu,
											Q			=> OA_cpu
											);
											
	instrReg	: reg_20 port map (	D			=> data_in_cpu,
											E			=> instrSel_cpu,
											Q			=> IC_cpu
											);
	outReg	: reg_20_ex port map (
											D			=> AO_cpu,
											E			=> outSel_cpu(1),
											rw			=> outSel_cpu(0),
											Q			=> data_out_cpu
											);
	internMen: regArray_8 port map(
											EN			=> regSel_cpu(4),
											WE			=> regSel_cpu(3),
											AD			=> regSel_cpu(2 downto 0),
											D			=> data_in_cpu,
											Q			=> open
											);
	
end rtl;





