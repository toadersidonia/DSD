----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 16:48:57
-- Design Name: 
-- Module Name: inmultitor - Behavioral
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

entity inmultitor is
 Port (a, b: in std_logic_vector(7 downto 0);
       i: out std_logic_vector(15 downto 0) );
end inmultitor;

architecture Behavioral of inmultitor is

component sumator16biti is
  Port (a, b: in std_logic_vector(15 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(15 downto 0);
        cout: out std_logic);
end component;

signal cifra1: std_logic_vector(7 downto 0); 
signal cifra2: std_logic_vector (7 downto 0);
signal cifra3: std_logic_vector (7 downto 0); 
signal cifra4: std_logic_vector (7 downto 0);
signal cifra5: std_logic_vector (7 downto 0);
signal cifra6: std_logic_vector (7 downto 0);
signal cifra7: std_logic_vector (7 downto 0);
signal cifra8: std_logic_vector (7 downto 0);

signal cifra1_shift: std_logic_vector(15 downto 0);
signal cifra2_shift: std_logic_vector(15 downto 0);
signal cifra3_shift: std_logic_vector(15 downto 0);
signal cifra4_shift: std_logic_vector(15 downto 0);
signal cifra5_shift: std_logic_vector(15 downto 0);
signal cifra6_shift: std_logic_vector(15 downto 0);
signal cifra7_shift: std_logic_vector(15 downto 0);
signal cifra8_shift: std_logic_vector(15 downto 0);


signal sum_aux1: std_logic_vector(15 downto 0); --suma primului produs partial cu cel de al doilea
signal sum_aux2: std_logic_vector(15 downto 0); --suma anterioara plus urmatorul produs partial
signal sum_aux3: std_logic_vector(15 downto 0);
signal sum_aux4: std_logic_vector(15 downto 0);
signal sum_aux5: std_logic_vector(15 downto 0);
signal sum_aux6: std_logic_vector(15 downto 0);
signal sum_aux7: std_logic_vector(15 downto 0);

--transporturi intermediare
signal carry1: std_logic;
signal carry2: std_logic;
signal carry3: std_logic;
signal carry4: std_logic;
signal carry5: std_logic;
signal carry6: std_logic;
signal carry7: std_logic;

begin

--inmultim numarul cu fiecare cifra din numarul b pt a optine acele produse partiale
cifra1 <= b(0)&b(0)&b(0)&b(0)&b(0)&b(0)&b(0)&b(0) and a; --inmultirea lui a cu prima cifra din b
cifra2 <= b(1)&b(1)&b(1)&b(1)&b(1)&b(1)&b(1)&b(1) and a;
cifra3 <= b(2)&b(2)&b(2)&b(2)&b(2)&b(2)&b(2)&b(2) and a;
cifra4 <= b(3)&b(3)&b(3)&b(3)&b(3)&b(3)&b(3)&b(3) and a;
cifra5 <= b(4)&b(4)&b(4)&b(4)&b(4)&b(4)&b(4)&b(4) and a;
cifra6 <= b(5)&b(5)&b(5)&b(5)&b(5)&b(5)&b(5)&b(5) and a;
cifra7 <= b(6)&b(6)&b(6)&b(6)&b(6)&b(6)&b(6)&b(6) and a;
cifra8 <= b(7)&b(7)&b(7)&b(7)&b(7)&b(7)&b(7)&b(7) and a;

--shiftam la stanga cu o pozitie, 2, 3, .., pentru a putea aduna produsele partiale, exact ca la inmultirea zecimala
cifra1_shift <= "00000000"&cifra1;	
cifra2_shift <= "0000000"&cifra2&"0";	
cifra3_shift <= "000000"&cifra3&"00";	
cifra4_shift <= "00000"&cifra4&"000";	
cifra5_shift <= "0000"&cifra5&"0000";	
cifra6_shift <= "000"&cifra6&"00000";	
cifra7_shift <= "00"&cifra7&"000000";	
cifra8_shift <= "0"&cifra8&"0000000";

sum1: sumator16biti port map(cifra1_shift, cifra2_shift, '0', sum_aux1, carry1);
sum2: sumator16biti port map(sum_aux1, cifra3_shift, carry1, sum_aux2, carry2);
sum3: sumator16biti port map(sum_aux2, cifra4_shift, carry2, sum_aux3, carry3);
sum4: sumator16biti port map(sum_aux3, cifra5_shift, carry3, sum_aux4, carry4);
sum5: sumator16biti port map(sum_aux4, cifra6_shift, carry4, sum_aux5, carry5);
sum6: sumator16biti port map(sum_aux5, cifra7_shift, carry5, sum_aux6, carry6);
sum7: sumator16biti port map(sum_aux6, cifra8_shift, carry6, sum_aux7, carry7);

i <= sum_aux7(15 downto 0);

end Behavioral;
