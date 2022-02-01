library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter is
    generic(
        WIDTH : INTEGER := 16
    ); port(
        clk        : IN STD_LOGIC;
        en         : IN STD_LOGIC;
        rst_n      : IN STD_LOGIC;
        count_up   : IN STD_LOGIC;
        load       : IN STD_LOGIC;
        load_count : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        count      : IN STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        cntr       : buffer STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        cnt_done   : buffer STD_LOGIC
    ); end counter;

architecture rtl of counter is 

begin 

    --Counter
    process(clk, rst_n, count_up, count) begin 
        if (rst_n = '0') then 
            if (count_up = '1') then 
                cntr <= (others => '0');
            else 
                cntr <= count;
            end if;
        elsif RISING_EDGE(clk) then 
            if (load = '1') then 
                cntr <= load_count;
            elsif (en = '1') then
                if (count_up = '1') then 
                    if (cnt_done = '1') then 
                        cntr <= (others => '0');
                    else 
                        cntr <= cntr + 1;
                    end if;
                else 
                    if (cnt_done = '1') then 
                        cntr <= count;
                    else 
                        cntr <= cntr - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    --Count done
    process(cntr, count_up, count) begin 
        if (count_up = '1') then 
            if (cntr = (count-1)) then 
                cnt_done <= '1';
            else 
                cnt_done <= '0';
            end if;
        else 
            if (cntr = std_logic_vector(to_unsigned(1, cntr'length))) then 
                cnt_done <= '1';
            else 
                cnt_done <= '0';
            end if;
        end if;
    end process;

end rtl;