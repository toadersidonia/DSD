----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2024 08:25:07 AM
-- Design Name: 
-- Module Name: ex1 - Behavioral
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

entity afisorr is
  Port (input_data:in STD_LOGIC_VECTOR(31 downto 0);
        clk:in std_logic;
        catods: out std_logic_vector(6 downto 0); --catdos(6) = a
        anods:out std_logic_vector(7 downto 0)  );
end afisorr;

architecture Behavioral of afisorr is

signal count :STD_LOGIC_VECTOR(15 downto 0):=x"0000";
signal current_digit :STD_LOGIC_VECTOR(3 downto 0):=(others => '0');

begin

process(clk)
begin
    if rising_edge(clk) then
      count<=count+1;
    end if;
end process;

 --trebuie sa afisam 32 de biti =? 8 cifre in hexa
 
process(count(15 downto 13))
begin
    case(count(15 downto 13)) is
        when "000" => anods <= "11111110";
                      current_digit <= input_data(3 downto 0);
        when "001" => anods <= "11111101";
                      current_digit <= input_data(7 downto 4);
        when "010" => anods <= "11111011";
                      current_digit <= input_data(11 downto 8);
        when "011" => anods <= "11110111";
                      current_digit <= input_data(15 downto 12);
        when "100" => anods <= "11101111";
                      current_digit <= input_data(19 downto 16);
        when "101" => anods <= "11011111";
                      current_digit <= input_data(23 downto 20);
        when "110" => anods <= "10111111";
                      current_digit <= input_data(27 downto 24);
        when "111" => anods <= "01111111";
                      current_digit <= input_data(31 downto 28);
        when others => anods <= (others => '0');  
                       current_digit <= (others => '0');
    end case;
end process;

with current_digit select
        catods <= "1000000" when "0000", --pt 0 dezactiveaza g din catod
               "1111001" when "0001",   --pt 1 activeaza doar b si c
               "0100100" when "0010",   --etc
               "0110000" when "0011",   
               "0011001" when "0100",   
               "0010010" when "0101",   
               "0000010" when "0110",   
               "1111000" when "0111",  
               "0000000" when "1000",   
               "0010000" when "1001",  
               "0001000" when "1010",   
               "0000011" when "1011",   
               "1000110" when "1100",   
               "0100001" when "1101",   
            "0000110" when "1110",   
            "0001110" when "1111",   --f
           (others => '0') when others;
           
end Behavioral;
