library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
use work.cu_lib.all;

entity CU is
	port(
		clk, rst, ready 				: in	STD_LOGIC;
		rw, vma, opregSel, errorSel,
		addrSel, instrSel, oe		: out std_logic;
		outSel							: out std_logic_vector(1 downto 0);
		regSel							: out std_logic_vector(4 downto 0); 
		shiftSel							: out std_logic_vector(2 downto 0);
		aluSel							: out std_logic_vector(3 downto 0);
		status							: in 	std_logic_vector(4 downto 0);
		instrReg							: in 	std_logic_vector(19 downto 0)
	);
end CU;

architecture rtl of CU is
	signal cur_state, nxt_state : state;
begin
	nxtstateproc	: process(cur_state, ready, instrReg, status)
	begin
		oe									<= '0';	--1 data_in <= data_out, 0 data_in <= ZZ
		addrSel 							<= '0';	-- 0 == NA, 1 == wr
		outSel							<= "00"; -- (en, rw)
		opregSel							<= '0'; 	-- (rd, wr)
		instrSel							<= '0'; 	-- 0 == NA, 1 == wr
		rw									<= '1';	-- 1 == rd, 0 == wr 	
		vma								<= '0';
		errorSel							<= '0';	--0 == No error, 1 == Si Error
		regSel							<= "00000";
		shiftSel 						<= shiftpass;
		aluSel							<= alupass;

	end process;
	
	cuProc			: process(clk, rst, status) is
	begin
		if rst = '1' then
			cur_state <= rst0;
		elsif status = "10000" then
			cur_state <= err0;
		elsif clk'event and clk = '1' then
			cur_state <= nxt_state;
		end if;
	
	end process;
end rtl;