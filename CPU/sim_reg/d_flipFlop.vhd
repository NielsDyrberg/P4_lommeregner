library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

--###########
entity d_flipFlop is
	port( D 							: in std_logic;
			E 							: in std_logic;
			Q 							: out std_logic);
end d_flipFlop;

architecture ARCHI of d_flipFlop is

--###########
component NAND_2
	port( a, b 						: in std_logic;
			c 							: out std_logic
	);
end component;

--###########
component NOT_2
	port( a 							: in std_logic;
			b 							: out std_logic);
end component;

--###########
signal s1, s2, s3, s4, s5: std_logic;
	
begin

U1 : NAND_2 port map (D, E, s2);
U2 : NAND_2 port map (s1, E, s3);
U3 : NAND_2 port map (s2, s4, s5);
U4 : NAND_2 port map (s5, s3, s4);
U5 : NOT_2 	port map (D, s1);

Q <= s5;

end ARCHI;
