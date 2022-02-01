library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity sumador is 
    generic(
        WIDTH : INTEGER := 8
    ); port(
        a     : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        b     : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        c_in  : IN STD_LOGIC;
        s     : OUT STD_LOGIC_VECTOR(WIDTH-1 downto 0)
    ); end sumador;

architecture rtl of sumador is 
    signal suma : STD_LOGIC_VECTOR(WIDTH downto 0);
begin 

    --Suma
    s <= a + b + c_in;

end rtl;