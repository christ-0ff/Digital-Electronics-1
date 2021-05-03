----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 02:04:09 PM
-- Design Name: 
-- Module Name: tb_parking_assistant_6sensor - Behavioral
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

entity tb_parking_assistant_6sensor is
--  Port ( );
end tb_parking_assistant_6sensor;

architecture Behavioral of tb_parking_assistant_6sensor is

     -- Clk & distance & beep generator constants
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns; 
     -- Distances constants
     constant c_g_lvl_0      : natural := 50;   --in cm
     constant c_g_lvl_1      : natural := 100;  --in cm
     constant c_g_lvl_2      : natural := 200;  --in cm
     constant c_g_lvl_3      : natural := 400;  --in cm
     -- Frequency of tone & period constants
     constant c_tone_freq    : natural := 3000; --in Hz
     constant c_slow_period  : natural := 2;    --in ms
     constant c_fast_period  : natural := 1;    --in ms
     
     -- Distances - to wait - constants in cm 
     constant c_dist_0       : time := 600 us;  --10 cm(600/58)
     constant c_dist_1       : time := 2000 us; --34 cm
     constant c_dist_2       : time := 3000 us; --51 cm
     constant c_dist_3       : time := 5000 us; --86 cm
     constant c_dist_4       : time := 10000 us;--172 cm
     constant c_dist_5       : time := 12000 us;--206 cm
     
    -- Clk & reset signal
     signal s_clk            : std_logic;                           
     signal s_reset          : std_logic;    
                            
     -- Input from sensor output                                           
     signal s_sensor0_out_i  : std_logic;
     signal s_sensor1_out_i  : std_logic;
     signal s_sensor2_out_i  : std_logic;
     signal s_sensor3_out_i  : std_logic;
     signal s_sensor4_out_i  : std_logic;
     signal s_sensor5_out_i  : std_logic;
     
     -- Output for sensor input                                           
     signal s_sensor0_in_o   : std_logic;
     signal s_sensor1_in_o   : std_logic;
     signal s_sensor2_in_o   : std_logic;
     signal s_sensor3_in_o   : std_logic;
     signal s_sensor4_in_o   : std_logic;
     signal s_sensor5_in_o   : std_logic;
     
     -- LEDs & Tone signalization output
     signal s_tone_o         : std_logic;
     signal s_LED_o          : std_logic_vector(2 - 1 downto 0);

begin

    -- Connecting testbench signals with parking_assistant_6sensor
    -- (Unit Under Test)
    uut_parking_assistant_6sensor : entity work.parking_assistant_6sensor
        generic map(
            g_tone_freq                 => c_tone_freq,
            g_slow_period               => c_slow_period,
            g_fast_period               => c_fast_period,
            
            g_distance_threshold1       => c_g_lvl_0,
            g_distance_threshold2       => c_g_lvl_1,
            g_distance_threshold3       => c_g_lvl_2,
            g_distance_threshold4       => c_g_lvl_3
        )   
        port map(
            clk           => s_clk,      
            reset         => s_reset,
            
            sensor0_i     => s_sensor0_out_i,
            sensor1_i     => s_sensor1_out_i,
            sensor2_i     => s_sensor2_out_i,
            sensor3_i     => s_sensor3_out_i,
            sensor4_i     => s_sensor4_out_i,
            sensor5_i     => s_sensor5_out_i,
                          
            sensor0_o     => s_sensor0_in_o,
            sensor1_o     => s_sensor1_in_o,
            sensor2_o     => s_sensor2_in_o,
            sensor3_o     => s_sensor3_in_o,
            sensor4_o     => s_sensor4_in_o,
            sensor5_o     => s_sensor5_in_o, 
            
            sound_o       => s_tone_o,
            LED_o         => s_LED_o
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 100 ms loop         
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;   
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
       
        -- Initial reset activated
        s_reset <= '1';
        wait for 100 us;
    
        -- Reset deactivated
        s_reset <= '0';
        wait for 3 ms;
        
        -- Reset activated
        s_reset <= '1';
        wait for 100 us;
    
        -- Reset deactivated
        s_reset <= '0';
    
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
       --                     --1st block 
        wait for 180 us;
        s_sensor0_out_i <= '1';
        s_sensor3_out_i <= '1';
        wait for c_dist_0;
        s_sensor0_out_i <= '0';
        s_sensor3_out_i <= '0';
        
        wait for 180 us;        
        s_sensor1_out_i <= '1';
        s_sensor4_out_i <= '1'; 
        wait for c_dist_0;      
        s_sensor1_out_i <= '0';
        s_sensor4_out_i <= '0'; 
        
        wait for 100 us;
        s_sensor2_out_i <= '1';
        s_sensor5_out_i <= '1';
        wait for c_dist_0;
        s_sensor2_out_i <= '0';
        s_sensor5_out_i <= '0';
       --                     --2nd block                     
        wait for 180 us;
        s_sensor0_out_i <= '1';
        s_sensor3_out_i <= '1';
        wait for c_dist_4;
        s_sensor0_out_i <= '0';
        s_sensor3_out_i <= '0';
        
        wait for 180 us;        
        s_sensor1_out_i <= '1';
        s_sensor4_out_i <= '1'; 
        wait for c_dist_2;      
        s_sensor1_out_i <= '0';
        s_sensor4_out_i <= '0'; 
        
        wait for 100 us;
        s_sensor2_out_i <= '1';
        s_sensor5_out_i <= '1';
        wait for c_dist_3;
        s_sensor2_out_i <= '0';
        s_sensor5_out_i <= '0'; 
       --                     --3rd block                       
        wait for 180 us;
        s_sensor0_out_i <= '1';
        s_sensor3_out_i <= '1';
        wait for c_dist_3;
        s_sensor0_out_i <= '0';
        s_sensor3_out_i <= '0';
        
        wait for 180 us;        
        s_sensor1_out_i <= '1';
        s_sensor4_out_i <= '1'; 
        wait for c_dist_2;      
        s_sensor1_out_i <= '0';
        s_sensor4_out_i <= '0'; 
        
        wait for 100 us;
        s_sensor2_out_i <= '1';
        s_sensor5_out_i <= '1';
        wait for c_dist_4;
        s_sensor2_out_i <= '0';
        s_sensor5_out_i <= '0';
       --                     --4th block
        wait for 15 us;
        s_sensor0_out_i <= '1';
        s_sensor3_out_i <= '1';
        wait for c_dist_5;
        s_sensor0_out_i <= '0';
        s_sensor3_out_i <= '0';
       
        wait for 11 us;
        s_sensor1_out_i <= '1';
        s_sensor4_out_i <= '1';
        wait for c_dist_5;
        s_sensor1_out_i <= '0';
        s_sensor4_out_i <= '0';
        
        wait for 130 us;
        s_sensor2_out_i <= '1';
        s_sensor5_out_i <= '1';
        wait for c_dist_5;
        s_sensor2_out_i <= '0';
        s_sensor5_out_i <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
