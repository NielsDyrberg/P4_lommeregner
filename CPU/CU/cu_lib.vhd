library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

package cu_lib is
	
	constant shiftpass 	: std_logic_vector(2 downto 0) :=	"000";
	
	constant alupass 		: std_logic_vector(3 downto 0) :=	"0000";
	constant aluAdd		: std_logic_vector(3 downto 0) :=	"0001";
	constant aluSub		: std_logic_vector(3 downto 0) :=	"0010";
	constant aluAnd		: std_logic_vector(3 downto 0) :=	"0011";
	constant aluOr			: std_logic_vector(3 downto 0) :=	"0100";
	constant aluXor		: std_logic_vector(3 downto 0) :=	"0101";
	constant aluAcc		: std_logic_vector(3 downto 0) :=	"0110";
	constant aluDec		: std_logic_vector(3 downto 0) :=	"0111";
	constant aluZero		: std_logic_vector(3 downto 0) :=	"1000";
	constant aluMul		: std_logic_vector(3 downto 0) :=	"1001";
	constant aluDiv		: std_logic_vector(3 downto 0) :=	"1010";
	
	constant	rd				: std_logic_vector(1 downto 0) :=	"11";
	constant	wr				: std_logic_vector(1 downto 0) :=	"10";
	constant progReg		: std_logic_vector(2 downto 0) :=	"111";
	constant dataBuf		: std_logic_vector(2 downto 0) :=	"110";
	
--	type state is (rst0, rst1, rst1b, rst1c, rst2, rst3, rst4, execute,
--						arr2, arr2b, arr3, arr3b, arr3c, arr4,
--						incDec2, incDec3, incDec3b, incDec3c, incDec4, incDec5, incDec5b, incDec5c,
--						incPc, incPc1, incPc1b, incPc1c, incPc2, incPc3,
--						eincPc, eincPc1, eincPc1b, eincPc1c, eincPc2,
--						load2, load2b, load2c, load3, load4, load4b, load5, load6,
--						store2, store2b, store2c, store3, store4, store4b, store5, store5b, store6,
--						com2, com2b, com3, com3b,
--						jmp2,
--						cp2, cp2b, cp2c, cp2d, cp3,
--						loadi2, loadi2b, loadi2c, loadi3, loadi4,
--						err0
--						);

end cu_lib;