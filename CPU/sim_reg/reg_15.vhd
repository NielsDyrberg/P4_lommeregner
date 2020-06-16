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
--###########
component d_flipFlop
	port( D, E : in std_logic;
			Q : out std_logic
	);
end component;

--###########
signal s1 : std_logic;
signal sVec : std_logic_vector(11 downto 0);

begin

s1 <= E;

GEN_REG: for I in 0 to 11 generate
	REGX : d_flipFlop port map (D(I), s1, sVec(I));
end generate GEN_REG;

Q <= sVec;

end ARCHI;


