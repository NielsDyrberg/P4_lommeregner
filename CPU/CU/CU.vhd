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
								rst00, rst01, rst02, rst03, rst04, rst05, rst06, execute,
								
								incPc00, incPc01, incPc02, incPc03, incPc04, incPc05, incPc06, incPc07, incPc08,
								incPc09, incPc0A, incPc0B, incPc0C
								);
	
	-- Register to hold the current state
	signal state   : state_type;

begin
	-- Logic to advance to the next state
	process (clk_cu, reset_cu)
	begin
		if reset_cu = '1' then
			state <= rst00;
		elsif (rising_edge(clk_cu)) then
			case state is
			
				--###############      Restart      ###############--
				when rst00=>
					state <= rst01;
						
				when rst01=>
					state <= rst02;
					
				when rst02=>

					state <= rst03;
					
				when rst03 =>
					
					state <= rst04;
					
				when rst04 =>
					state <= rst05;
					
				when rst05 =>
					if ready_cu = '1' then
						state			<= rst06;
					else
						state			<= rst05;
					end if;
					
				when rst06 =>
					state <= execute;
				
				--###############      Execute      ###############--
				when execute =>
					case instrReg_cu(19 downto 15) is
						when "00000" =>												--NA
							state						<= incpc00;
							
--						when 	"00001" | "00010" |
--								"00011" | "00100" |
--								"00101" |
--								"01000" | "01001"	
--										 =>												-- Simple arytmetik
--							state						<= arr2;
--						
--						when	"00110" | "00111"
--										 =>												--inc % dec
--							state						<= incDec2;
--							
--						when "01010" =>												--LOAD
--							state 					<= load2;
--								
--						when "01011" =>												--STORE	
--							state 					<= store2;
--							
--						when 	"01100" | "01101" |
--								"01110" =>												--Compare
--							state						<= com2;
--						
--						when "01111" =>												--JMP
--							state						<= jmp2;
--							
--						when "10010" =>												--COPY
--							state						<= cp2;
--						
--						when "10011" =>												--LOADI
--							state 					<= loadi2;
							
						when others =>
							state 					<= incPc00;
						
					end case;
				
				--###############       incPC       ###############--
				when incPc00 =>
					state					<= incPc01;
				
				when incPc01 =>
					state					<= incPc02;
				
				when incPc02 =>
					state					<= incPc03;
				
				when incPc03 =>
					state					<= incPc04;
					
				when incPc04 =>
					state					<= incPc05;
					
				when incPc05 =>
					state					<= incPc06;
				
				when incPc06 =>
					state					<= incPc07;
				
				when incPc07 =>
					state					<= incPc08;
				
				when incPc08 =>
					state					<= incPc09;
				
				when incPc09 =>
					if ready_cu = '1' then
						state				<= incPc0A;
					else
						state				<= incPc09;
					end if;
				
				when incPc0A =>
					state					<= incPc0B;
					
				when incPc0B =>
					state					<= incPc0C;
					
				when incPc0C =>
					state					<= execute;
					
					
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
		aluSel_cu				<= aluPass;
		state_cnt_cu 			<= 16#0000#;
		
		case state is
			when rst00 =>
				state_cnt_cu <= 16#0000#;
				
			when rst01 =>
				aluSel_cu 					<= aluZero;
				oe_cu							<= '1';
				state_cnt_cu <= 16#0001#;
				
			when rst02 =>
				aluSel_cu 					<= aluZero;
				oe_cu							<= '1';
				outSel_cu(1)				<= '1';
				outSel_cu(0)				<= '1';
				state_cnt_cu <= 16#0002#;
				
			when rst03 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				state_cnt_cu <= 16#0003#;
				
			when rst04 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				regSel_cu(4 downto 3)	<= wr;
				regSel_cu(2 downto 0)	<= progReg;
				addrSel_cu					<=	'1';
				opregSel_cu					<= '1';
				state_cnt_cu	<= 16#0004#;
				
			when rst05 =>
				vma_cu						<= '1';
				oe_cu							<= '1';
				state_cnt_cu	<= 16#0005#;
				
			when rst06 =>
				vma_cu						<= '1';
				oe_cu							<= '1';
				instrSel_cu 				<=	'1';
				state_cnt_cu	<= 16#0006#;
				
			--###############      Execute      ###############--	
			when execute =>
				state_cnt_cu	<= 16#0100#;
				
			--###############       incPC       ###############--
			when incPc00 =>
				state_cnt_cu	<= 16#0200#;
				regSel_cu(4 downto 3)	<= rd;
				regSel_cu(2 downto 0)	<= progReg;
				oe_cu							<= '1';
			
			when incPc01 =>
				state_cnt_cu	<= 16#0201#;
				regSel_cu(4 downto 3)	<= rd;
				regSel_cu(2 downto 0)	<= progReg;
				oe_cu							<= '1';
				aluSel_cu					<= aluAcc;
			
			when incPc02 =>
				state_cnt_cu	<= 16#0202#;
				regSel_cu(4 downto 3)	<= rd;
				regSel_cu(2 downto 0)	<= progReg;
				oe_cu							<= '1';
				aluSel_cu					<= aluAcc;
				outSel_cu					<=	wr;
			
			when incPc03 =>
				state_cnt_cu	<= 16#0203#;
				regSel_cu(4 downto 3)	<= rd;
				regSel_cu(2 downto 0)	<= progReg;
				oe_cu							<= '1';
				aluSel_cu					<= aluAcc;
				
			when incPc04 =>
				state_cnt_cu	<= 16#0204#;
				
			when incPc05 =>
				state_cnt_cu	<= 16#0205#;
				outSel_cu					<= rd;
				oe_cu							<= '1';
			
			when incPc06 =>
				state_cnt_cu	<= 16#0206#;
				outSel_cu					<= rd;
				oe_cu							<= '1';
				regSel_cu(4 downto 3)	<= wr;
				regSel_cu(2 downto 0)	<= progReg;
				addrSel_cu					<= '1';
			
			when incPc07 =>
				state_cnt_cu	<= 16#0207#;
				outSel_cu					<= rd;
				oe_cu							<= '1';
			
			when incPc08 =>
				state_cnt_cu	<= 16#0208#;
			
			when incPc09 =>
				state_cnt_cu	<= 16#0209#;
				vma_cu						<= '1';
				oe_cu							<= '1';
			
			when incPc0A =>
				state_cnt_cu	<= 16#020A#;
				vma_cu						<= '1';
				instrSel_cu					<= '1';
				oe_cu							<= '1';
				
				
			when incPc0B =>
				state_cnt_cu	<= 16#020B#;
				vma_cu						<= '1';
				oe_cu							<= '1';
				
				
			when incPc0C =>
				state_cnt_cu	<= 16#020C#;

				
		end case;
	end process;
	
end rtl;
