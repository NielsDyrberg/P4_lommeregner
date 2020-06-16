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
		
		data_out_cu	: out	std_logic_vector(2 downto 0)
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
					if ready_cu = '1' then
						state <= s4;
					else
						state <= s3;
					end if;
				when s4 =>
					state <= s5;
				when s5 =>
					state <= s6;
				when s6 =>
					state <= s7;
				when s7 =>
					if ready_cu = '1' then
						state <= s0;
					else
						state <= s7;
					end if;
			end case;
		end if;
	end process;
	
	-- Output depends solely on the current state
	process (state)
	begin
	
		case state is
			when s0 =>
				data_out_cu <= "000";
			when s1 =>
				data_out_cu <= "001";
			when s2 =>
				data_out_cu <= "010";
			when s3 =>
				data_out_cu <= "011";
			when s4 =>
				data_out_cu	<= "100";
			when s5 =>
				data_out_cu	<= "101";
			when s6 =>
				data_out_cu	<= "110";
			when s7 =>
				data_out_cu	<= "111";
		end case;
	end process;
	
end rtl;
