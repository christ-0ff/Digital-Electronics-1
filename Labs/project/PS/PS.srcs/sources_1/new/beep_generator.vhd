----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 10:24:09 PM
-- Design Name: 
-- Module Name: beep_generator - Behavioral
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
-- Entity declaration for beep_generator
------------------------------------------------------------------------
entity beep_generator is
    generic(
        tone_freq    : natural := 1000; --Hz   - Tone frequency
        slow_period  : natural := 5;    --ms   - Slow beeping half period
        fast_period  : natural := 2     --ms   - Fast beeping half period
    );  
    port(
        clk          : in  std_logic;
        reset        : in  std_logic;
        dist_lvl     : in  std_logic_vector(2-1 downto 0);
        tone_o       : out std_logic:='0'
    );
end beep_generator;

architecture Behavioral of beep_generator is

    signal s_clk_counter      : natural;
    signal s_local_clock      : std_logic :='1';
    signal s_en               : std_logic :='0';
    signal s_pulse_counter    : natural :=0;
    signal s_clk_period       : natural :=100000000/tone_freq;
    signal pulse_clock_period : natural :=5;     --initial pulse length value in ms, low value for testing
    signal pc_out             : std_logic :='0'; -- Signal with frequency of beeping

begin
    --------------------------------------------------------------------
    -- Process for changing frequency of the tone
    --------------------------------------------------------------------
    p_pulse_clock : process(pulse_clock_period,clk)  -- Generates signal, which determines the     
    begin                                            -- frequency of beeping.
        if (rising_edge(clk)) then
            if (s_pulse_counter < 100000*pulse_clock_period) then
                s_pulse_counter <= s_pulse_counter +1;
            else
                pc_out <= not pc_out;
                s_pulse_counter <= 0;                         
            end if;
        end if;
    end process p_pulse_clock;
    
    --------------------------------------------------------------------
    -- Process for changing frequency of tone depending on the input
    --------------------------------------------------------------------
    p_clock_enable : process(dist_lvl,clk)
    begin
        case dist_lvl is
            when "11" =>                            -- Shortest distance => continuous tone.
                s_en <= '1';                        -- Tone generator output enabled
            when "10" =>                            -- Second shortest distance => fast beeping
                pulse_clock_period <= fast_period;  -- Pulse clock generates fast beeping signal
                s_en  <= pc_out;                    -- Enables tone generator output with the frequencz of pulse clock
            when "01" =>                            -- Second longest distance => slow beeping
                pulse_clock_period <= slow_period;  -- Pulse clock generates slow beeping signal
                s_en  <= pc_out;                    -- Enables tone generator output with the frequencz of pulse clock
            when others =>                          -- Farthest distance => silence
                s_en <= '0';                        -- Tone generator output off
        end case;
    end process p_clock_enable;
    
    --------------------------------------------------------------------
    -- Tone generating process
    --------------------------------------------------------------------
    p_1kHz_gen : process(clk, s_en)                 -- Tone generator
    begin        
        if rising_edge(clk) then        
            if (reset = '1') then
                s_clk_counter   <= 0;
                s_local_clock   <= '0';
                tone_o          <= '0';
            elsif (s_clk_counter >= ((s_clk_period-1)/2 )) then
                s_clk_counter   <= 0;
                s_local_clock   <= not s_local_clock;
            else
                s_clk_counter   <= s_clk_counter + 1;
            end if;           
        end if;
           
        if (s_en = '1') then
            tone_o <= s_local_clock;   -- Enables tone gen. output 
        else
            tone_o <= '0';
        end if;
    end process p_1kHz_gen;
end Behavioral;