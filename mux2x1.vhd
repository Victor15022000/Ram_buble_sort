library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity mux2x1 is 
    generic(
        WIDTH : INTEGER:= 8
    ); port(
        a   : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);        --0
        b   : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);        --1
        sel : IN STD_LOGIC;
        q   : OUT STD_LOGIC_VECTOR(WIDTH-1 downto 0)
    ); end mux2x1;

architecture rtl of mux2x1 is 

begin 

    --MUX
    process(sel, a, b) begin 
        if (sel = '1') then 
            q <= b;
        else
            q <= a;
        end if;
    end process;

end rtl;