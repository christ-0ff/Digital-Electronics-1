----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2021 05:58:40 PM
-- Design Name: 
-- Module Name: urm_driver_decoder - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

------------------------------------------------------------------------
-- Entity declaration for urm_driver_decoder
------------------------------------------------------------------------
entity urm_driver_decoder is
    generic(
        -- Distance constants in cm
        g_lvl_0           : natural := 50;  
        g_lvl_1           : natural := 100;
        g_lvl_2           : natural := 200;
        g_lvl_3           : natural := 400                  
    );
    
    port(
        -- Clk & Reset signal
        clk               : in  std_logic;
        reset             : in  std_logic;
        
        -- Input from sensor output       
        sensor_out_i      : in  std_logic;
        
        -- Output for sensor input   
        sensor_in_o       : out std_logic:='0';
        
        -- Signal updating mux
        update_o          : out std_logic;     
        
        -- Measured distance  
        dist_lvl_o        : out std_logic_vector(2 - 1 downto 0)
    );
end urm_driver_decoder;

architecture Behavioral of urm_driver_decoder is
    --------------------------------------------------------------------
    -- INTERNAL SIGNALS
    --------------------------------------------------------------------
    -- State definition & it's defined internal singal
    type t_state is (INITIAL,
                     PULSE,
                     WAITING,
                     COUNT
                     );               
    signal s_state        : t_state :=INITIAL;
       
    -- Constant for 1us pulse               
    constant PULSE_LENGTH : natural := 1000;        
                                             
    -- Local signals for distance measurement
    signal s_local_cnt    : natural :=0;
    signal s_distance     : natural :=400;
    
begin

    --------------------------------------------------------------------
    -- Process for sending 10us signal into a sensor & 
    -- For measuring returning signal
    --------------------------------------------------------------------
    p_distance_measurement : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then         -- Synchronous reset
                s_state       <= INITIAL; -- Set initial state
                s_local_cnt   <= 0;       -- Clear all counters
                update_o      <= '0';     -- Reset update signal
                sensor_in_o   <= '0';     -- Reset sensor input
                s_distance    <= 201;     -- Initialize distance
            else
                case s_state is  
                              
                    when INITIAL =>-- Initial state                                              
                        if (reset = '0') then
                            s_state         <= PULSE;     
                            update_o <= '0';-- Setting mux update to 0                        
                        end if;
                        
                    when PULSE =>-- State for sending 10us pulse     
                        if (s_local_cnt >= (PULSE_LENGTH - 1)) then
                            s_local_cnt     <= 0;        -- Clear counter
                            sensor_in_o     <= '0';      -- Reset output
                            s_state         <= WAITING;  -- Next state
                        else -- 10 us counter
                            s_local_cnt     <= s_local_cnt + 1; 
                            sensor_in_o     <= '1';      
                        end if;
                        
                    when WAITING =>-- Waiting state for signal returning from sensor
                        if (sensor_out_i = '1') then 
                            s_state         <= COUNT; 
                        end if;
                        
                    when COUNT =>-- State for counting the length of returning signal
                        if (sensor_out_i = '1') then -- Counter
                            s_local_cnt     <= s_local_cnt + 1;
                        else -- Dividing s_distance(length) of measured signal by constant 100*58                           
                            s_distance      <= s_local_cnt /5800;    -- specified by datasheet & 
                            s_local_cnt     <= 0;                    -- to eliminate efect of clk
                            update_o        <='1';                   -- to get dist in cm.          
                            s_state         <= INITIAL;             
                        end if;                           
                      
                    when others =>-- Other states
                        s_state <= INITIAL;
        
                end case;
            end if; 
        end if; 
    end process p_distance_measurement;
    
    --------------------------------------------------------------------
    -- Process for quantization measured signal
    --------------------------------------------------------------------
    p_dist_decoder : process(s_distance)
    begin
        if   (s_distance <= g_lvl_0) then -- The closest distance
            dist_lvl_o <= "11";
        elsif(s_distance <= g_lvl_1) then
            dist_lvl_o <= "10";
        elsif(s_distance <= g_lvl_2) then
            dist_lvl_o <= "01";
        else                              -- The furthest distance
            dist_lvl_o <= "00";
        end if;           
    end process p_dist_decoder;
       
end Behavioral;
