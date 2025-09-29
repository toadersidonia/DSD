----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2024 16:01:07
-- Design Name: 
-- Module Name: decidere_semn - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decidere_semn is
  Port (a, b: in std_logic_vector(7 downto 0);
        buton: in std_logic_vector(3 downto 0);
        semn_rez: out std_logic );
end decidere_semn;

architecture Behavioral of decidere_semn is
signal semn_inmultire: std_logic := '0';
signal semn_impartire: std_logic := '0';
signal comparare: std_logic := '0';
signal semn_adunare: std_logic := '0';
signal semn_scadere: std_logic := '0';

 --comparare = 0 daca a <= b
 --comparare = 1 daca a > b

begin
--semn_adunare <= (a(7) and b(7)) or (a(7) and (not comparare)) or (b(7) and comparare);
    semn_inmultire <= a(7) xor b(7);
    semn_impartire <= a(7) xor b(7);
    comparare <= (a(0) and not b(0)) or ( (a(0) xnor b(0)) and ( a(1) and not b(1))) or  ((a(0) xnor b(0) ) and (a(1) xnor b(1)) and (a(2) and not b(2))) or (	(a(0) xnor b(0)) and (a(1) xnor b(1))  and (a(2) xnor b(2)) and ( a(3) and not b(3))) or ( (a(0) xnor b(0)) and (a(1) xnor b(1))  and (a(2) xnor b(2)) and (a(3) xnor b(3)) and (a(4) and not b(4))) or (  (a(0) xnor b(0)) and (a(1) xnor b(1))  and (a(2) xnor b(2)) and (a(3) xnor b(3)) and (a(4) xnor b(4)) and (a(5) and not b(5))) or (	(a(0) xnor b(0)) and (a(1) xnor b(1))  and (a(2) xnor b(2)) and (a(3) xnor b(3)) and (a(4) xnor b(4)) and (a(5) xnor b(5)) and (a(6) and not b(6)));
    semn_adunare <= (a(7) and b(7)) or (a(7) and comparare) or (b(7) and (not comparare)); 
    semn_scadere <= ((not a(7) and not b(7)) and (not comparare)) or ((a(7) and not b(7)) or (a(7) and b(7) and comparare));
    
    with buton(3 downto 0) select
        semn_rez <= semn_inmultire when "0100",
                    semn_impartire when "1000",
                    semn_adunare when "0001",
                    semn_scadere when "0010",
                    '0' when others;
    
end Behavioral;
