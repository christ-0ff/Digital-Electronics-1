----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 01:36:40 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

------------------------------------------------------------------------
-- Entity declaration for top
------------------------------------------------------------------------
entity top is
    Port (
        -- Clock signal & Reset button
        CLK100MHZ  : in  STD_LOGIC;
        BTN        : in  STD_LOGIC_VECTOR (1 - 1 downto 0);
        
        -- Pmod 1 - JA - for LEDs & mux selec signal & sound output
        JA         : out STD_LOGIC_VECTOR (6 - 1 downto 0);
        
        -- Pmod 1 - JB - High-Speed for sensors inputs
        JB         : in  STD_LOGIC_VECTOR (6 - 1 downto 0);
        
        -- Pmod 1 - JC - High-Speed for sensors outputs
        JC         : out STD_LOGIC_VECTOR (6 - 1 downto 0)    
        
    );
end top;

architecture Behavioral of top is

begin

    -- Connecting testbench signals with beep_generator
    uut_parking_assistant : entity work.parking_assistant_6sensor
    generic map(     
    
        -- Optionable constants  
        g_tone_freq    => 1000,
        g_slow_period  => 5,
        g_fast_period  => 2,
        
        -- Thresholds of measured distances
        g_distance_threshold1  =>  50,
        g_distance_threshold2  =>  150,
        g_distance_threshold3  =>  250,
        g_distance_threshold4  =>  400
    )
    port map  (
         -- Clk & Reset signal
        clk        =>  CLK100MHZ,
        reset      =>  BTN(0),
        
        -- Inputs from sensors            
        sensor0_i  =>  JB(0),
        sensor1_i  =>  JB(1),
        sensor2_i  =>  JB(2),
        sensor3_i  =>  JB(3),
        sensor4_i  =>  JB(4),
        sensor5_i  =>  JB(5),
        
        -- Outputs to sensors              
        sensor0_o  =>  JC(0),
        sensor1_o  =>  JC(1),
        sensor2_o  =>  JC(2),
        sensor3_o  =>  JC(3),
        sensor4_o  =>  JC(4),
        sensor5_o  =>  JC(5),
         
        -- LEDs output & and their mux selector output            
        LED_o(0)   =>  JA(0),
        LED_o(1)   =>  JA(1),
        sel_o(0)   =>  JA(2),
        sel_o(1)   =>  JA(3),
        sel_o(2)   =>  JA(4),
                       
        -- Sound output
        sound_o    =>  JA(5)
    );
    
end Behavioral;
