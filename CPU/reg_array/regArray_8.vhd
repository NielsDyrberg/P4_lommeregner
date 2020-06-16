LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

ENTITY regArray_8 IS 

generic( 	DB : integer := 20; -- Data brede
            AB : integer := 3); -- Adresse brede

PORT (
	EN:     IN STD_LOGIC;-- Register Array Enable
	WE:     IN STD_LOGIC;-- Aktiver skriving
	AD:    	IN STD_LOGIC_VECTOR(AB-1 DOWnTO 0); -- Adresse vektor
	D:     	IN STD_LOGIC_VECTOR(DB-1 DOWNTO 0); -- Data input
	Q:     	out STD_LOGIC_VECTOR(DB-1 DOWNTO 0)); --Data output
END regArray_8;

 


ARCHITECTURE Behavioral OF regArray_8 IS
	TYPE RegArray IS array(0 TO (2**AB)-1) OF STD_LOGIC_VECTOR(DB-1 DOWNTO 0); -- definerer bredde og længde (8 x 16bit)
	signal Reg: RegArray;
begin
 
process (EN, WE, AD)
	variable omskriv : natural range 0 to (2**AB)-1; -- En variabel der kan indeholde 0-2^AB - Skal bruges for omskrivning  
		begin

		omskriv := to_integer(unsigned(AD));  

		if (EN = '1') then

			if(WE ='1')      then
				reg(omskriv) <=D;
			elsif(WE = '0') then    
				Q <= Reg(omskriv);
			end if;

		end if;
 
end process ; 
   
end architecture Behavioral;