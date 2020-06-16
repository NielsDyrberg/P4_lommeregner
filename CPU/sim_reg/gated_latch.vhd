library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;


--###########
entity gated_latch is
	port( D : in std_logic;
			E : in std_logic;
			Q : out std_logic);
end gated_latch;

architecture ARCHI of gated_latch is
--###########
component AND_2
	port( a, b : in std_logic;
			c : out std_logic
	);
end component;

--###########
component OR_2
	port( a, b : in std_logic;
			c : out std_logic);
end component;

--###########
component NOT_2
	port( a : in std_logic;
			b : out std_logic);
end component;

--###########
signal s1, s2, s3, s4, s5, s6 : std_logic;
	
begin

U1 : AND_2 port map (D, E, s2);
U2 : NOT_2 port map (D, s1);
U3 : AND_2 port map (s1, E, s3);
U4 : OR_2 port map (s2, s6, s5);
U5 : NOT_2 port map (s3, s4);
U6 : AND_2 port map (s5, s4, s6);

Q <= s6;

end ARCHI;
