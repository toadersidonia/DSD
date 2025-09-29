----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2024 18:24:23
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
  Port (
        a: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        buton: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        anod: out std_logic_vector(7 downto 0); 
        catod: out std_logic_vector(6 downto 0));
        
end main;

architecture Behavioral of main is

component afisorr is
  Port (input_data:in STD_LOGIC_VECTOR(31 downto 0);
        clk:in std_logic;
        catods: out std_logic_vector(6 downto 0); --catdos(6) = a
        anods:out std_logic_vector(7 downto 0)  );
end component;

component decidere_output is
    Port (
        rez_scadere: in std_logic_vector(7 downto 0);
        rez_impartire: in std_logic_vector(7 downto 0);
        rez_inmultire: in std_logic_vector(15 downto 0);
        rez_adunare: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(15 downto 0);
        buton: in std_logic_vector(3 downto 0)
    );
end component;

component sumator8biti is
 Port (a,b: in std_logic_vector(7 downto 0);
       s: out std_logic_vector(7 downto 0));
end component;

component scazator8biti is
  Port (a, b: in std_logic_vector(7 downto 0);
        d: out std_logic_vector(7 downto 0));
end component;

component inmultitor is
 Port (a, b: in std_logic_vector(7 downto 0);
       i: out std_logic_vector(15 downto 0) );
end component;

component impartitor is
  Port (a, b: in std_logic_vector(7 downto 0);
        rest, cat: out std_logic_vector(7 downto 0));
end component;

component debouncer is
   Port ( btn : in STD_LOGIC;
          clk : in STD_LOGIC;
          en : out STD_LOGIC);
end component;

component decidere_semn is
  Port (a, b: in std_logic_vector(7 downto 0);
        buton: in std_logic_vector(3 downto 0);
        semn_rez: out std_logic );
end component;

signal adunare_deb: std_logic := '0';
signal scadere_deb: std_logic := '0';
signal impartire_deb: std_logic := '0';
signal inmultire_deb: std_logic := '0';

signal rez_suma_aux: std_logic_vector(7 downto 0) := "00000000";
signal rez_scadere_aux: std_logic_vector(7 downto 0) := "00000000";
signal rez_inmultire_aux: std_logic_vector(15 downto 0) := x"0000";
signal rez_impartire_aux: std_logic_vector(7 downto 0) := "00000000";
signal output_final: std_logic_vector(15 downto 0) := x"0000";
signal rest_impartire: std_logic_vector(7 downto 0) := "00000000";
signal afisor_data_final: std_logic_vector(31 downto 0) := x"00000000"; --fie val de pe switch fie rez
signal output_sign: std_logic := '0';
signal unsigned_a: std_logic_vector(7 downto 0) := x"00";
signal unsigned_b: std_logic_vector(7 downto 0) := x"00";

begin

unsigned_a <= '0' & a(6 downto 0);
unsigned_b <= '0' & b(6 downto 0);

l3: decidere_output port map(rez_scadere_aux, rez_impartire_aux, rez_inmultire_aux, rez_suma_aux, output_final, buton); 
l4: sumator8biti port map(a, b, rez_suma_aux);
l5: scazator8biti port map(a, b, rez_scadere_aux);
l6: inmultitor port map(unsigned_a, unsigned_b, rez_inmultire_aux);
l7: impartitor port map(unsigned_a, unsigned_b, rest_impartire, rez_impartire_aux);
l8: afisorr port map(afisor_data_final, clk, catod, anod);
l9: decidere_semn port map(a, b, buton, output_sign);
a1: debouncer port map(buton(0),clk,adunare_deb);
a2: debouncer port map(buton(1),clk,scadere_deb);
a3: debouncer port map(buton(2),clk,inmultire_deb);
a4: debouncer port map(buton(3),clk,impartire_deb);

afisor_data_final <= a & b & output_sign & output_final(14 downto 0); --32 de biti

end Behavioral;
