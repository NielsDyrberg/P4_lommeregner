library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;


--###########
entity reg_15 is
	port( D : in std_logic_vector(11 downto 0);
			E : in std_logic;
			Q : out std_logic_vector(11 downto 0));
end reg_15;

architecture ARCHI of reg_15 is


begin

-- Register with active-high clock
   PROCESS
   BEGIN
       WAIT UNTIL E = '1';         
       Q <= D;
   END PROCESS;

end ARCHI;


