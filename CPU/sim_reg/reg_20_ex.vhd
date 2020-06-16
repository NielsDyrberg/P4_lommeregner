library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity reg_20_ex is
	port( D : in std_logic_vector(19 downto 0) := (others => '0');
			E : in std_logic;
			rw: in std_logic;
			Q : out std_logic_vector(19 downto 0));
end reg_20_ex;

architecture ARCHI of reg_20_ex is

component reg_20 is
	port( D : in std_logic_vector(19 downto 0);
			E : in std_logic;
			Q : out std_logic_vector(19 downto 0));
end component;

signal en 	: std_logic := '0';
signal out_sig	: std_logic_vector(19 downto 0);

begin

reg : reg_20 port map (	D => D,
								E => en,
								Q => out_sig
								);

process(E, rw) is
	
begin
	
	if (E = '1' and rw = '0') then
			en <= '0';
			Q	<= out_sig;
			
	elsif (E = '0' and rw = '0') then
			en <= '0';
			Q	<= (others => '-');
		
	elsif (E = '1' and rw = '1') then
			en <= '1';
			Q	<= (others => '-');
		
	elsif (E = '0' and rw = '1') then
			en <= '0';
			Q	<= (others => '-');
	end if;
end process;

end ARCHI;


