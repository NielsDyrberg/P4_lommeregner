
-- ##########

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity AND_2 is
	port( a, b : in std_logic;
			c : out std_logic);
end AND_2;

architecture ARCHI of AND_2 is 
begin 
  c <= a and b; 
end ARCHI;


---- ##########

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity AND_3 is
	port( a, b, c : in std_logic;
			d : out std_logic);
end AND_3;

architecture ARCHI of AND_3 is 
begin 
  d <= a and b and c; 
end ARCHI;

--###########

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity OR_2 is
	port( a, b : in std_logic;
			c : out std_logic);
end OR_2;

architecture ARCHI of OR_2 is 
begin 
  c <= a or b; 
end ARCHI;

--###########

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity NOT_2 is
	port( a : in std_logic;
			b : out std_logic);
end NOT_2;

architecture ARCHI of NOT_2 is 
begin 
  b <= not a; 
end ARCHI;

-- ##########

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity NAND_2 is
	port( a, b : in std_logic;
			c : out std_logic);
end NAND_2;

architecture ARCHI of NAND_2 is 
begin 
  c <= a nand b; 
end ARCHI;

