library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decidere_output is
    Port (
        rez_scadere: in std_logic_vector(7 downto 0);
        rez_impartire: in std_logic_vector(7 downto 0);
        rez_inmultire: in std_logic_vector(15 downto 0);
        rez_adunare: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(15 downto 0);
        buton: in std_logic_vector(3 downto 0)
    );
end decidere_output;

architecture Behavioral of decidere_output is
begin  

     with buton(3 downto 0) select
              output <= "000000000" & rez_adunare(6 downto 0) when "0001",
                         "000000000" & rez_scadere(6 downto 0) when "0010",
                         rez_inmultire when "0100",
                         "00000000" & rez_impartire when "1000",
                         x"0000" when others;
   
end Behavioral;