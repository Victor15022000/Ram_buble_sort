library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;


entity ram is 
    generic(
        DATA_WIDTH: INTEGER := 8;
        NUM_ENTRIES: INTEGER := 32
    ); port(
        clk      : IN STD_LOGIC;
        wr_en    : IN STD_LOGIC;
        addr     : IN STD_LOGIC_VECTOR(5 downto 0);
        data_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
    ); end ram;

architecture rtl of ram is 
    type mem_t is array (0 to NUM_ENTRIES-1) of std_logic_vector(DATA_WIDTH-1 downto 0); 
    signal mem: mem_t; 
begin 

    --Write Data
    process (clk) begin
        if RISING_EDGE(clk) then
            if (wr_en = '1') then 
                mem(conv_integer(addr)) <= data_in;
            end if;
        end if;
    end process;

    --Read Data
    data_out <= mem(conv_integer(addr));

end rtl;