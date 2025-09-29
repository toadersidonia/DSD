----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 17:20:31
-- Design Name: 
-- Module Name: sumator16biti - Behavioral
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

entity sumator16biti is
  Port (a, b: in std_logic_vector(15 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(15 downto 0);
        cout: out std_logic);
end sumator16biti;

architecture Behavioral of sumator16biti is
component sumator1bit is
 Port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end component;

signal carry1: std_logic_vector(16 downto 0) := (others=>'0');
begin
    carry1(0) <= cin;

e1: for i in 0 to 15 generate
e2: sumator1bit port map(a(i),b(i),carry1(i),s(i),carry1(i+1));
end generate;

cout <= carry1(16);

end Behavioral;
