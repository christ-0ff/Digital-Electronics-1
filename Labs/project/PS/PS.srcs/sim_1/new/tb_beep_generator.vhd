----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 10:27:10 PM
-- Design Name: 
-- Module Name: tb_beep_generator - Behavioral
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

entity tb_beep_generator is
--  Port ( );
end tb_beep_generator;

architecture Behavioral of tb_beep_generator is
    -- Constants for changing behaviour of beep_generator
    constant    frequency           : natural := 1000; --Hz
    constant    c_slow_period       : natural := 5; --ms
    constant    c_fast_period       : natural := 2;  --ms
    constant    c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz  : std_logic;
    signal s_reset       : std_logic;
    signal s_tone        : std_logic;
    signal distance_lvl  : std_logic_vector(2-1 downto 0);
    
begin
    -- Connecting testbench signals with beep_generator
    uut_ce : entity work.beep_generator
        generic map(
            tone_freq   =>   frequency,
            slow_period => c_slow_period,
            fast_period => c_fast_period
        )
        port map(
            clk      => s_clk_100MHz,
            reset    => s_reset,
            tone_o   => s_tone,
            dist_lvl => distance_lvl
        );
        
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------    
    p_clk_gen : process
    begin
        while now < 50 ms loop
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
            distance_lvl <= "00";
            wait for 10ms;
            distance_lvl <= "01";
            wait for 10ms;
            distance_lvl <= "10";
            wait for 10ms;
            distance_lvl <= "11";
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
