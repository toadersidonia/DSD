----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 15:50:15
-- Design Name: 
-- Module Name: scazator8biti - Behavioral
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

entity scazator8biti is
  Port (a, b: in std_logic_vector(7 downto 0);
        d: out std_logic_vector(7 downto 0));
end scazator8biti;

architecture Behavioral of scazator8biti is
signal semn_a: std_logic := '0';
signal semn_b: std_logic := '0';
signal a_farasemn: std_logic_vector(6 downto 0) := "0000000";
signal b_farasemn: std_logic_vector(6 downto 0) := "0000000";
signal semn_scadere: std_logic := '0';
signal aux_scadere: std_logic_vector(6 downto 0) := "0000000";
begin

a_farasemn <= a(6 downto 0);
b_farasemn <= b(6 downto 0);
semn_a <= a(7);
semn_b <= b(7);

process(a, b, semn_a, semn_b, a_farasemn, b_farasemn)
variable a_b_semn: std_logic := '0';
begin
a_b_semn := semn_a xnor semn_b;

if a_b_semn = '1' then
    if a_farasemn > b_farasemn then
        aux_scadere <= std_logic_vector(unsigned(a_farasemn) - unsigned(b_farasemn));
        semn_scadere <= semn_a;
    elsif a_farasemn < b_farasemn then
           aux_scadere <= std_logic_vector(unsigned(b_farasemn) - unsigned(a_farasemn));
           semn_scadere <= not(semn_a);
    else aux_scadere <= "0000000";
         semn_scadere <= '0';
    end if;
else aux_scadere <= std_logic_vector(unsigned(b_farasemn) + unsigned(a_farasemn));
     semn_scadere <= semn_a;
end if;

end process;

d <= semn_scadere & aux_scadere;
   
end Behavioral;
