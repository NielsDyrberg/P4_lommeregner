library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

--###########
entity d_flipFlop_dataflow is
	port( D 							: in std_logic;
			E 							: in std_logic;
			Q 							: out std_logic);
end d_flipFlop_dataflow;

architecture ARCHI of d_flipFlop_dataflow is

--###########
signal s1, s2, s3, s4, s5: std_logic := '0';
	
begin

s2 <= D NAND E;
S3 <= s1 NAND E;
s5	<= s2 NAND s4;
s4 <= s5 NAND s3;
s1 <= NOT D;

Q <= s5;

end ARCHI;
