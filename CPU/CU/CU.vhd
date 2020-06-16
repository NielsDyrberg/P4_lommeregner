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
		clk_cu		: in	std_logic;
		reset_cu	 	: in	std_logic;
		ready_cu		: in  std_logic;
		
		data_out_cu	: out	std_logic_vector(2 downto 0);
		
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
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
	
	-- Register to hold the current state
	signal state   : state_type;

begin
	-- Logic to advance to the next state
	process (clk_cu, reset_cu)
	begin
		if reset_cu = '1' then
			state <= s0;
		elsif (rising_edge(clk_cu)) then
			case state is
				when s0=>
					state <= s1;
						
				when s1=>
					state <= s2;
					
				when s2=>

					state <= s3;
					
				when s3 =>
					
					state <= s4;
					
				when s4 =>
					state <= s5;
					
				when s5 =>
					if ready_cu = '1' then
						state			<= s6;
					else
						state			<= s5;
					end if;
					
				when s6 =>
					state <= s7;
					
				when s7 =>
						state <= s0;
					
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
		data_out_cu 			<= "000";
		
		case state is
			when s0 =>
				data_out_cu <= "000";
				
			when s1 =>
				aluSel_cu 					<= aluZero;
				data_out_cu <= "001";
				
			when s2 =>
				aluSel_cu 					<= aluZero;
				outSel_cu					<= wr;
				data_out_cu <= "010";
				
			when s3 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				data_out_cu <= "011";
				
			when s4 =>
				outSel_cu					<= rd;
				oe_cu							<= '1';
				regSel_cu(4 downto 3)	<= wr;
				regSel_cu(2 downto 0)	<= progReg;
				addrSel_cu					<=	'1';
				opregSel_cu					<= '1';
				data_out_cu	<= "100";
				
			when s5 =>
				vma_cu						<= '1';
				data_out_cu	<= "101";
				
			when s6 =>
				vma_cu						<= '1';
				instrSel_cu 				<=	'1';
				data_out_cu	<= "110";
				
			when s7 =>
			
				data_out_cu	<= "111";
				
		end case;
	end process;
	
end rtl;
