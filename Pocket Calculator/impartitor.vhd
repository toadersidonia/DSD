----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 19:07:34
-- Design Name: 
-- Module Name: impartitor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity impartitor is
  Port (a, b: in std_logic_vector(7 downto 0);
        rest, cat: out std_logic_vector(7 downto 0));
end impartitor;

architecture Behavioral of impartitor is

signal rest_aux :  std_logic_vector(0 to 15);
signal cat_aux :  std_logic_vector(0 to 15);

signal neshiftat : std_logic_vector(0 to 15);	--pt ca concatenam mai jos 8 biti, iar numerele in sine sunt pe 8 biti => maxim 16 biti
signal shift1 : std_logic_vector(0 to 15);	
signal shift2 : std_logic_vector(0 to 15);	
signal shift3 : std_logic_vector(0 to 15);	
signal shift4 : std_logic_vector(0 to 15);	
signal shift5 : std_logic_vector(0 to 15);	
signal shift6 : std_logic_vector(0 to 15);	
signal shift7 : std_logic_vector(0 to 15);	

begin

    --ex: a = 10010011 si b = 1011, vrem sa eliminam cazul cand nr format primii 4 biti a lui a e mai mic decat b
    --incepem comparatia intre rest_intermediar si shifti, i = 1, 7
    --rest_intermediar = a & "00000000"
    -- pentru ca de ex, daca impartim 15 la 18, catul va fi 0 si restul 15
    -- 1001001100000000 si 1011000000000000 (000 in plus) nu e ok, b nu intra in a
    -- 1001001100000000 si 1011000000000000 (00) nu
    -- 1001001100000000 si 1011000000000000 (0) nu
    -- 1001001100000000 si 1011000000000000 nu
    -- cmp cu shift3: 1001001100000000 si 101100000000000 da
    -- rest_intermediar = 1001001100000000 - 101100000000000 = ...
    -- c_intermediar = 00001000 (primele incercari nereusite, bitul de 1 indicia o scadere reusita)
    -- am incercat 1011 in 1=>0, 1011 in 10=>0, 1011 in 100=>0, 1011 in 1001=>0, 1011 in 10010 =>1 incercare reusira
    neshiftat <= b & "00000000";
    shift1 <= neshiftat + neshiftat; -- 2 * neshiftat, 2 * b
    shift2 <= shift1 + shift1; --2^2 * b
	shift3 <= shift2 + shift2;	
	shift4 <= shift3 + shift3;	
	shift5 <= shift4 + shift4;	
	shift6 <= shift5 + shift5;	
	shift7 <= shift6 + shift6;	
	
	process(shift1, shift2, shift3, shift4, shift5, shift6, shift7)
	variable rest_intermediar: std_logic_vector(0 to 15);
	variable cat_intermediar: std_logic_vector(0 to 15);
	
	begin
	
	rest_intermediar := a & "00000000";
	cat_intermediar := "0000000000000000";
	
	--verificam mereu ca shift_i sa fie mai mare ca 0 pt ca impartirea la 0 nu are sens
	if(shift7 > "00000000" and rest_intermediar >= shift7) then --rest_intermediar-shift7>=0
			rest_intermediar := rest_intermediar - shift7;
			cat_intermediar := cat_intermediar + 128; --2^7
		end if;
		
		if( shift6 > "00000000" and rest_intermediar >= shift6) then
			rest_intermediar := rest_intermediar - shift6;
			cat_intermediar:=cat_intermediar+64; --2^6 = 1000000
		end if;
		
		if( shift5 > "00000000"and rest_intermediar >= shift5) then
			rest_intermediar := rest_intermediar - shift5;
			cat_intermediar := cat_intermediar + 32;
		end if;
		
		if( shift4 > "00000000" and rest_intermediar >= shift4) then
			rest_intermediar := rest_intermediar - shift4;
			cat_intermediar := cat_intermediar + 16;
		end if;
		
		if( shift3 > "00000000" and rest_intermediar >= shift3) then
			rest_intermediar := rest_intermediar - shift3;
			cat_intermediar := cat_intermediar + 8;
		end if;
		
		if( shift2 > "00000000" and rest_intermediar >= shift2) then
			rest_intermediar := rest_intermediar - shift2;
			cat_intermediar := cat_intermediar + 4;
		end if; 
		
		if( shift1 > "00000000" and rest_intermediar >= shift1) then
			rest_intermediar := rest_intermediar - shift1;
			cat_intermediar := cat_intermediar + 2;
		end if; 
		
		if( neshiftat > "00000000" and rest_intermediar >= neshiftat) then
			rest_intermediar := rest_intermediar - neshiftat;
			cat_intermediar := cat_intermediar + 1;
		end if; 
		
	rest_aux <= rest_intermediar;
	cat_aux <= cat_intermediar; 
	
	end process;
	
	rest <= rest_aux(0 to 7);
	cat <= cat_aux(8 to 15);
	
end Behavioral;
