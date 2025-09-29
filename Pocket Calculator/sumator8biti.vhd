----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 09:34:01 AM
-- Design Name: 
-- Module Name: sumator_4 - Behavioral
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


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator8biti is
 Port (a,b: in std_logic_vector(7 downto 0);
       s: out std_logic_vector(7 downto 0));
end sumator8biti;

architecture Behavioral of sumator8biti is
signal semn_a: std_logic := '0';
signal semn_b: std_logic := '0';
signal a_farasemn: std_logic_vector(6 downto 0) := "0000000";
signal b_farasemn: std_logic_vector(6 downto 0) := "0000000";
signal semn_suma: std_logic := '0';
signal aux_suma: std_logic_vector(6 downto 0) := "0000000";

begin
a_farasemn <= a(6 downto 0);
b_farasemn <= b(6 downto 0);
semn_a <= a(7);
semn_b <= b(7);

process(a, b, semn_a, semn_b, a_farasemn, b_farasemn)
variable a_b_semn: std_logic := '0';
begin
a_b_semn := semn_a xnor semn_b;

if a_b_semn = '1' then --ambele negative sau ambele pozitive
    aux_suma <= std_logic_vector(unsigned(a_farasemn) + unsigned(b_farasemn));
    semn_suma <= a(7);
else
    if a_farasemn >= b_farasemn then
            semn_suma <= semn_a;
            aux_suma <= std_logic_vector(unsigned(a_farasemn) - unsigned(b_farasemn));
    else  semn_suma <= semn_b;
          aux_suma <= std_logic_vector(unsigned(b_farasemn) - unsigned(a_farasemn));
    end if;
end if;
 
end process;

s <= semn_suma & aux_suma;

end Behavioral;