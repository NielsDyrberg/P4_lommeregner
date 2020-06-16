--
--			20-bit ALU med 4 bit statusbit
--
--
--				SELECTPIN:				STATUSPIN:
--			"0000" --> 	A 				
--			"0001" --> A+B 				"00001" --> ZERO		
--			"0010" --> A-B 				"00010" --> GREATER
--			"0011" --> A AND B			"00100" --> EQUAL
--			"0100" --> A OR B			"01000" --> LESS
--			"0101" --> A XOR B			"10000" --> ERROR
--			"0110" --> A+1					
--			"0111" --> A-1					
--			"1000" --> "0"
--			"1001" --> A*B
--			"1010" --> A/B
--			"1011"
--			"1100"
--			"1101"
--			"1110"
--			"1111"
--
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;



entity ALU is

	Port(
			INPUT_A : in STD_LOGIC_VECTOR (19 downto 0) ;
			INPUT_B : in STD_LOGIC_VECTOR (19 downto 0) ;
			SELECTPIN : in STD_LOGIC_VECTOR (3 downto 0);
			OUTPUT : out STD_LOGIC_VECTOR (19 downto 0); 
			STATUSPIN : out STD_LOGIC_VECTOR (4 downto 0) );
			
end ALU;


architecture arch of ALU is


	signal RESULTAT : STD_LOGIC_VECTOR (39 downto 0);
	signal err : STD_LOGIC;

	
begin

OUTPUT <= RESULTAT(19 downto 0); -- ALU OUT
		  
		  
	process(INPUT_A,INPUT_B,SELECTPIN)
	begin
			case (SELECTPIN) is
			
			when "0000" => -- A -> OUT
				RESULTAT <= ("00000000000000000000" & INPUT_A);
				err <=  '0';
					
			when "0001" => -- Adder
				RESULTAT <= ("00000000000000000000" & INPUT_A ) + ("00000000000000000000" & INPUT_B);
				err <=  '0';
				
			when "0010" => -- Subtraction
				RESULTAT(19 downto 0) <=  INPUT_A -  INPUT_B;
				if(INPUT_B>INPUT_A) then
				err <= '1';
				else
				err <=  '0';
				end if;

				
			when "0011" => -- AND
				RESULTAT(19 downto 0) <=  INPUT_A AND  INPUT_B;
				err <=  '0';
					
			when "0100" => -- OR
				RESULTAT(19 downto 0) <= INPUT_A OR  INPUT_B;	
				err <=  '0';
			when "0101" => -- XOR
				RESULTAT(19 downto 0) <= INPUT_A XOR INPUT_B;
				err <=  '0';
			when "0110" => -- A + 1
				RESULTAT(19 downto 0) <= INPUT_A + '1';
				if(INPUT_A = "11111111111111111111") then
				err <= '1';
				else
				err <=  '0';
				end if;
			when "0111" => -- A - 1
				RESULTAT(19 downto 0) <= INPUT_A - '1';
				if(INPUT_A = "00000000000000000000") then
				err <= '1';
				else
				err <=  '0';
				end if;
			when "1000" => -- ZERO
				RESULTAT(19 downto 0) <= "00000000000000000000";
				err <=  '0';
			when "1001" => -- Multiplication
				RESULTAT <=  std_logic_vector(to_unsigned((to_integer(unsigned(INPUT_A)) * to_integer(unsigned(INPUT_B))),40));	
			when "1010" => -- Division
				if(INPUT_B>INPUT_A) then 
				err <= '1'; 	
				elsif(INPUT_B ="00000000000000000000") then
				err <= '1';
				else
				RESULTAT(19 downto 0) <=  std_logic_vector(to_unsigned((to_integer(unsigned(INPUT_A)) / to_integer(unsigned(INPUT_B))),20)) ;
				end if;
       when others => err <=  '1';			 
			end case;
	

end process;
	
STATUSPIN(0) <= '1' when RESULTAT="00000000000000000000" else '0';
STATUSPIN(1) <= '1' when INPUT_A>INPUT_B else '0';
STATUSPIN(2) <= '1' when INPUT_A=INPUT_B else '0';
STATUSPIN(3) <= '1' when INPUT_A<INPUT_B else '0';
STATUSPIN(4) <= '1' when err = '1'  else '1' when RESULTAT(20) = '1' else '1' when RESULTAT(21) = '1' else '1' when RESULTAT(22) = '1' else '1' when RESULTAT(23) = '1' 
	else '1' when RESULTAT(24) = '1' else '1' when RESULTAT(25) = '1' else '1' when RESULTAT(26) = '1' else '1' when RESULTAT(27) = '1' else '1' when RESULTAT(28) = '1' 
	else '1' when RESULTAT(29) = '1' else '1' when RESULTAT(30) = '1' else '1' when RESULTAT(31) = '1' else '1' when RESULTAT(32) = '1' else '1' when RESULTAT(33) = '1' 
	else '1' when RESULTAT(34) = '1' else '1' when RESULTAT(35) = '1' else '1' when RESULTAT(36) = '1' else '1' when RESULTAT(37) = '1' else '1' when RESULTAT(38) = '1' 
	else '1' when RESULTAT(39) = '1' else '0';


end arch;