library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity registro is 
    generic(
        WIDTH: integer:= 8
    ); port(
        clk   : IN STD_LOGIC;
        en    : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        d     : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        q     : OUT STD_LOGIC_VECTOR(WIDTH-1 downto 0)
    ); end registro;

architecture rtl of registro is
    
begin 

    --Write Data
    process(clk, rst_n) begin 
        if (rst_n = '0') then 
            q <= (others => '0');
        elsif RISING_EDGE(clk) then 
            if (en = '1') then 
                q <= d;
            end if;
        end if;
    end process;

end rtl;