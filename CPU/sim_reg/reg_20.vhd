library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;


--###########
entity reg_20 is
	port( D : in std_logic_vector(19 downto 0);
			E : in std_logic;
			Q : out std_logic_vector(19 downto 0));
end reg_20;

architecture ARCHI of reg_20 is


begin

-- Register with active-high clock
   PROCESS
   BEGIN
       WAIT UNTIL E = '1';         
       Q <= D;
   END PROCESS;

end ARCHI;


