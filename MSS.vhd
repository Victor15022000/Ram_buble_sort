library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity MSS is 
    port(
        --INPUTS
        clk                     : IN STD_LOGIC;
        en                      : IN STD_LOGIC;
        rst_n                   : IN STD_LOGIC;
        write_ram               : IN STD_LOGIC;
        write_ram_done          : IN STD_LOGIC;
        start_sort              : IN STD_LOGIC;
        read_ram                : IN STD_LOGIC;
        read_ram_done           : IN STD_LOGIC;
        a_mayor_b               : IN STD_LOGIC;
        a_menor_b               : IN STD_LOGIC;
        cntr1_done              : IN STD_LOGIC;
        cntr2_done              : IN STD_LOGIC;
        ascendente              : IN STD_LOGIC;
        --OUTPUTS
        wr_en_ram_mss           : OUT STD_LOGIC;
        rd_en_ram_mss           : OUT STD_LOGIC;
        read_reg1               : OUT STD_LOGIC;
        read_reg2               : OUT STD_LOGIC;
        write_reg1              : OUT STD_LOGIC;
        write_reg2              : OUT STD_LOGIC;
        incr_cntr1              : OUT STD_LOGIC;
        decr_cntr2              : OUT STD_LOGIC;
        rst_n_cntr1             : OUT STD_LOGIC;
        rst_n_cntr2             : OUT STD_LOGIC;
        rst_n_addr_write_cntr   : OUT STD_LOGIC;
        rst_n_addr_read_cntr    : OUT STD_LOGIC;
        done                    : OUT STD_LOGIC
    ); end MSS;


architecture rtl of MSS is 
    type state_t is (IDLE_S, WRITE_RAM_S, READ_RAM_S, START_SORT_S, READ_REG1_S, READ_REG2_S, CHECK_VALUES_S, WRITE_REG1_S, WRITE_REG2_S, INCR_CNTR1_S, DECR_CNTR2_S);
    signal state, next_state: state_t;
    signal swap : std_logic;
begin 

    --Parte secuencial
    process(clk, rst_n) begin 
        if (rst_n = '0') then 
            state <= IDLE_S;
        elsif RISING_EDGE(clk) then 
				if (en = '1') then
					state <= next_state;
				end if;
        end if;
    end process;

    --Swap
    process(a_mayor_b, a_menor_b, ascendente) begin 
        if (ascendente = '1') then 
            if (a_mayor_b = '1') then 
                swap <= '1';
            else 
                swap <= '0';
            end if;
        else    --Descendente
            if (a_menor_b = '1') then 
                swap <= '1';
            else 
                swap <= '0';
            end if;
        end if;
    end process;

    --Siguiente estado
    process(state, write_ram, start_sort, read_ram, write_ram_done, read_ram_done, swap, cntr1_done, cntr2_done) begin 
        case( state ) is
            when IDLE_S =>
                if (write_ram = '1') then             ---Write RAM
                    next_state <= WRITE_RAM_S;
                elsif (start_sort = '1') then 
                    next_state <= START_SORT_S;
                elsif (read_ram = '1') then 
                    next_staTe <= READ_RAM_S;
                else 
                    next_state <= IDLE_S;
                end if;
            when WRITE_RAM_S =>
                if (write_ram_done = '1') then 
                    next_state <= IDLE_S;
                else 
                    next_state <= WRITE_RAM_S;
                end if;
            when READ_RAM_S =>
                if (read_ram_done = '1') then 
                    next_state <= IDLE_S;
                else 
                    next_state <= READ_RAM_S;
                end if;
            when START_SORT_S =>
                next_state <= READ_REG1_S;
            when READ_REG1_S =>
                if (cntr2_done = '1') then 
                    next_state <= IDLE_S;
                else 
                    next_state <= READ_REG2_s;
                end if;
            when READ_REG2_S =>
                next_state <= CHECK_VALUES_S;
            when CHECK_VALUES_S =>
                if (swap = '1') then 
                    next_state <= WRITE_REG1_S;
                else 
                    next_state <= INCR_CNTR1_S;
                end if;
            when WRITE_REG1_S =>
                next_state <= WRITE_REG2_s;
            when WRITE_REG2_S =>
                next_state <= INCR_CNTR1_S;
            when INCR_CNTR1_S => 
                if (cntr1_done = '1') then 
                    next_state <= DECR_CNTR2_S;
                else 
                    next_state <= READ_REG1_S;
                end if;
            when DECR_CNTR2_S => 
                if (cntr2_done = '1') then 
                    next_state <= IDLE_S;
                else 
                    next_state <= READ_REG1_S;
                end if;
            when others =>
                next_state <= IDLE_S;
        end case ;
    end process;

    --Salidas
    process(state, write_ram, read_ram) begin 
        wr_en_ram_mss           <= '0';
        rd_en_ram_mss           <= '0';
        read_reg1               <= '0';
        read_reg2               <= '0';
        write_reg1              <= '0';
        write_reg2              <= '0';
        incr_cntr1              <= '0';
        decr_cntr2              <= '0';
        rst_n_cntr1             <= '1';
        rst_n_cntr2             <= '1';
        rst_n_addr_write_cntr   <= '1';
        rst_n_addr_read_cntr    <= '1';
        done                    <= '0';
        case( state ) is
            when IDLE_S =>
                rst_n_addr_write_cntr <= not(write_ram);
                rst_n_addr_read_cntr  <= not(read_ram);
                done                  <= '1';
            when WRITE_RAM_S =>
                wr_en_ram_mss <= '1';
            when READ_RAM_S =>
                rd_en_ram_mss <= '1';
            when START_SORT_S =>
                rst_n_cntr1 <= '0';
                rst_n_cntr2 <= '0';
            when READ_REG1_S =>
                read_reg1 <= '1';
            when READ_REG2_S =>
                read_reg2 <= '1';
            when CHECK_VALUES_S =>

            when WRITE_REG1_S =>
                write_reg1 <= '1';
            when WRITE_REG2_S =>
                write_reg2 <= '1';
            when INCR_CNTR1_S =>
                incr_cntr1  <= '1';
            when DECR_CNTR2_S =>
                decr_cntr2  <= '1';
            when others =>
                wr_en_ram_mss           <= '0';
                rd_en_ram_mss           <= '0';
                read_reg1               <= '0';
                read_reg2               <= '0';
                write_reg1              <= '0';
                write_reg2              <= '0';
                incr_cntr1              <= '0';
                decr_cntr2              <= '0';
                rst_n_cntr1             <= '1';
                rst_n_cntr2             <= '1';
                rst_n_addr_write_cntr   <= '1';
                rst_n_addr_read_cntr    <= '1';
        end case ;
    end process;

end rtl;