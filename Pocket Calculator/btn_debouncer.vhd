----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 08:12:16 AM
-- Design Name: 
-- Module Name: debouncer - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is


signal count: std_logic_vector (15 downto 0):=(others =>'0');
signal t: std_logic;
signal q1,q2,q3:std_logic;
begin

process(clk)
begin
    if(rising_edge(clk))then
        count<=count + 1;
        end if;
     end process;
     
  t<='1' when count = x"FFFF" else '0';
  
  process(clk)
  begin
  if(rising_edge(clk)) then
  if(t ='1') then
    q1<=btn;
    end if;
  end if;
  end process;
  
  process(clk)
  begin
    if(rising_edge(clk)) then 
        q2<=q1;
        q3<=q2;
        end if;
        end process;
  en <= q2 and not q3;
end Behavioral;
