-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
use work.cu_lib.all;


entity CU is

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
	
end entity;

architecture rtl of CU is

	-- Build an enumerated type for the state machine
	type state_type is (
								rst0, rst1, rst2, rst3, rst4, rst5, rst6, execute
								);
	
	-- Register to hold the current state
	signal state   : state_type;

begin
	-- Logic to advance to the next state
	process (clk_cu, reset_cu)
	begin
		if reset_cu = '1' then
			state <= rst0;
		elsif (rising_edge(clk_cu)) then
			case state is
				when rst0=>
					state <= rst1;
						
				when rst1=>
					state <= rst2;
					
				when rst2=>

					state <= rst3;
					
				when rst3 =>
					
					state <= rst4;
					
				when rst4 =>
					state <= rst5;
					
				when rst5 =>
					if ready_cu = '1' then
						state			<= rst6;
					else
						state			<= rst5;
					end if;
					
				when rst6 =>
					state <= execute;
					
				when execute =>
						state <= rst0;
					
			end case;
		end if;
	end process;
	
	-- Output depends solely on the current state
	process (state)
	begin
		oe_cu						<= '0';	--1 data_in <= data_out, 0 data_in <= ZZ
		addrSel_cu 				<= '0';	-- 0 == NA, 1 == wr
		outSel_cu				<= "00"; -- (en, rw)
		opregSel_cu				<= '0'; 	-- (rd, wr)
		instrSel_cu				<= '0'; 	-- 0 == NA, 1 == wr
		rw_cu						<= '1';	-- 1 == rd, 0 == wr 	
		vma_cu					<= '0';
		errorSel_cu				<= '0';	--0 == No error, 1 == Si Error
		regSel_cu				<= "00000";
		shiftSel_cu 			<= shiftpass;
		aluSel_cu				<= alupass;
		state_cnt_cu 			<= 16#0000#;
		
		case state is
			when rst0 =>
				state_cnt_cu <= 16#0000#;
				
			when rst1 =>
				aluSel_cu 					<= aluZero;
				oe_cu							<= '1';
				state_cnt_cu <= 16#0001#;
				
			when rst2 =>
				aluSel_cu 					<= aluZero;
				oe_cu							<= '1';
				outSel_cu					<= wr;
				state_cnt_cu <= 16#0002#;
				
			when rst3 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				state_cnt_cu <= 16#0003#;
				
			when rst4 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				regSel_cu(4 downto 3)	<= wr;
				regSel_cu(2 downto 0)	<= progReg;
				addrSel_cu					<=	'1';
				opregSel_cu					<= '1';
				state_cnt_cu	<= 16#0004#;
				
			when rst5 =>
				vma_cu						<= '1';
				state_cnt_cu	<= 16#0005#;
				
			when rst6 =>
				vma_cu						<= '1';
				instrSel_cu 				<=	'1';
				state_cnt_cu	<= 16#0006#;
				
			when execute =>
			
				state_cnt_cu	<= 16#0100#;
				
		end case;
	end process;
	
end rtl;
