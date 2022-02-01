library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity comparador is 
    generic(
        WIDTH : INTEGER:= 8
    ); port(
        a : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        b : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        a_mayor_b : OUT STD_LOGIC;
        a_menor_b : OUT STD_LOGIC;
        a_igual_b : OUT STD_LOGIC
    ); end comparador;

architecture rtl of comparador is 

begin 

    --A mayor que B
    process(a, b) begin 
        if (a > b) then 
            a_mayor_b <= '1';
        else 
            a_mayor_b <= '0';
        end if;
    end process;

    --A menor que B
    process(a, b) begin 
        if (a < b) then 
            a_menor_b <= '1';
        else 
            a_menor_b <= '0';
        end if;
    end process;

    --A igual que B
    process(a, b) begin 
        if (a = b) then 
            a_igual_b <= '1';
        else 
            a_igual_b <= '0';
        end if;
    end process;

end rtl;