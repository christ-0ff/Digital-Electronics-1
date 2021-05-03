----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2021 21:01:08
-- Design Name: 
-- Module Name: tb_urm_driver_decoder - Behavioral
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

entity tb_urm_driver_decoder is
--  Port ( );
end tb_urm_driver_decoder;

architecture Behavioral of tb_urm_driver_decoder is
     -- Distance & clk constants 
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
     constant c_g_lvl_0     : natural := 50;
     constant c_g_lvl_1     : natural := 100;
     constant c_g_lvl_2     : natural := 200;
     constant c_g_lvl_3     : natural := 400;
                  
    -- Clk & reset signals
     signal s_clk           : std_logic;                           
     signal s_reset         : std_logic;   
                             
     -- Input from sensor output                                           
     signal s_sensor_out_i  : std_logic;  
                              
     -- Output for sensor input                                           
     signal s_sensor_in_o   : std_logic; 
                                                                                                
     -- Update for other modules                                 
     signal s_update_o      : std_logic; 
                                                                                 
     -- Quantized distance                    
     signal s_dist_lvl_o    : std_logic_vector(2 - 1 downto 0);
     
begin

    -- Connecting testbench signals with urm_driver_decoder entity
    -- (Unit Under Test)
    uut_urm_driver_decoder  : entity work.urm_driver_decoder
        generic map(
            g_lvl_0         => c_g_lvl_0,
            g_lvl_1         => c_g_lvl_1,
            g_lvl_2         => c_g_lvl_2,
            g_lvl_3         => c_g_lvl_3
        )   
        port map(
            clk             => s_clk,      
            reset           => s_reset,       
            sensor_out_i    => s_sensor_out_i,  
            sensor_in_o     => s_sensor_in_o, 
            update_o        => s_update_o,
            dist_lvl_o      => s_dist_lvl_o
        );


    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ms loop         
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                           -- Process is suspended forever
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
       
        --Initial reset activated
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
        wait for 500 us;              -- Waiting for inital pulse
            s_sensor_out_i <= '1';
        wait for 150 us;              -- "Reciving" distance lesser than lvl_0 distance
            s_sensor_out_i <= '0';    -- its length is 2.58 cm (150/58)
        wait for 50 us;               -- Waiting for sending 10us pulse (We have to wait
            s_sensor_out_i <= '1';    -- at least 10us. Here we wait 50us to be sure.)
        wait for 3000 us;             -- "Reciving" distance bigger than lvl_0 distance 
            s_sensor_out_i <= '0';    -- its length is 51.8 cm (3000/58)
        wait for 50 us;               -- Waiting for sending 10us pulse
            s_sensor_out_i <= '1';
        wait for 6000 us;             -- "Reciving" distance bigger than lvl_1 distance 
            s_sensor_out_i <= '0';    -- its length is 103.4 cm (6000/58)
        wait for 50 us;               -- Waiting for sending 10us pulse
            s_sensor_out_i <= '1';
        wait for 12000 us;            -- "Reciving" distance bigger than lvl_2 distance 
            s_sensor_out_i <= '0';    -- its length is 206.9 cm (12000/58)
        wait for 50 us;               -- Waiting for sending 10us pulse
            s_sensor_out_i <= '1';
        wait for 24000 us;            -- "Reciving" distance bigger than lvl_2 distance
            s_sensor_out_i <= '0';    -- its length is 413.8 cm (24000/58)
        wait for 50 us;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;


end Behavioral;
