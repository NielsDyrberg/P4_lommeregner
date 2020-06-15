library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity top is
	port(
		--data											: inout std_logic_vector(19 downto 0);
		clk											:	in  std_logic;
		rst_but										:	in  std_logic;
		clk_trig										:	out std_logic;
		
		-- DEBUGING
		
		sw1											:	in std_logic -- Benyttes til at trigger data_in
	);

end top;

architecture rtl of top is
	
	signal	clk_l, rst_but_sig			: std_logic := '0';
	signal	ready, error, rw, en, oe	: std_logic;	
	signal	addr								: std_logic;
	signal	data_in							: std_logic;
	signal	data_out							: std_logic_vector(2 downto 0);

	
	component cpu
		port(
				clk_cpu			: in	std_logic;
				data_in_cpu		: in	std_logic;
				reset_cpu	 	: in	std_logic;
				data_out_cpu	: out	std_logic_vector(2 downto 0)
			);
	end component;

begin

	rst_but_sig				<= not(rst_but);
	
	cpu1	: cpu	port map (	clk_cpu			=> clk_l,
									data_in_cpu		=> data_in,
									reset_cpu		=> rst_but_sig,
									data_out_cpu	=> data_out
								);


	CLK_Divider_1	: entity work.clk_divider 	--hoved_clk 
		
				GENERIC MAP ( TCOUNT => 25000000, 			-- Hvor mange den skal tælle til inden den giver et clk output
								  N_BITS => 26 )					-- Variable hvor antal TCOUNT kan være i
								  
				PORT MAP ( CLK_IN => clk,						-- Clokken ind
							  RESET => rst_but,					-- Reset
							  CLK_OUT => clk_l 					-- CLK ud
							  ); 
							  
	CLK_Divider_2	: entity work.clk_divider 	--trigger clk
		
				GENERIC MAP ( TCOUNT => 500000,
								  N_BITS => 26 )
								  
				PORT MAP ( CLK_IN => clk,
							  RESET => rst_but,
							  CLK_OUT => clk_trig	-- CLK ud
							  ); 
	
	
	data_in <= sw1;
	 
end rtl;




