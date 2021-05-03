----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 12:36:59 PM
-- Design Name: 
-- Module Name: parking_assistant_6sensor - Behavioral
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
-- Entity declaration for parking_assistant_6sensor
------------------------------------------------------------------------
entity parking_assistant_6sensor is
    generic(
        -- Optionable constants
        g_tone_freq              : natural; --Hz
        g_slow_period            : natural; --ms
        g_fast_period            : natural; --ms
        
        -- Thresholds of measured distances
        g_distance_threshold1    : natural;
        g_distance_threshold2    : natural;
        g_distance_threshold3    : natural;
        g_distance_threshold4    : natural
    );     
    Port (
        -- Clk & Reset signal
        clk                      : in  std_logic;
        reset                    : in  std_logic;
        
        -- Inputs from sensors   
        sensor0_i                : in  std_logic:='0';
        sensor1_i                : in  std_logic:='0';
        sensor2_i                : in  std_logic:='0';
        sensor3_i                : in  std_logic:='0';
        sensor4_i                : in  std_logic:='0';
        sensor5_i                : in  std_logic:='0';
       
        -- Outputs to sensors 
        sensor0_o                : out std_logic:='0';
        sensor1_o                : out std_logic:='0';
        sensor2_o                : out std_logic:='0';
        sensor3_o                : out std_logic:='0';
        sensor4_o                : out std_logic:='0';
        sensor5_o                : out std_logic:='0';
        
        -- LEDs output & and their mux selector output
        LED_o                    : out std_logic_vector(2 - 1 downto 0):="00";
        sel_o                    : out std_logic_vector(3 - 1 downto 0);
        
        -- Sound output
        sound_o                  : out std_logic
    );
end parking_assistant_6sensor;

architecture Behavioral of parking_assistant_6sensor is
    --------------------------------------------------------------------
    -- INTERNAL SIGNALS
    --------------------------------------------------------------------
    -- State definition & it's defined internal singals
    type t_state is (LEFT, 
                     CENTER,   
                     RIGHT   
                     );
    signal s_sensor_front    : t_state :=LEFT;
    signal s_sensor_back     : t_state :=LEFT;
    
    -- Measured distances from front and back drivers
    signal s_dist_lvl_front  : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl_back   : std_logic_vector(2 - 1 downto 0);
    
    -- Measured distances of individual sensors
    signal s_dist_lvl0       : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl1       : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl2       : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl3       : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl4       : std_logic_vector(2 - 1 downto 0);
    signal s_dist_lvl5       : std_logic_vector(2 - 1 downto 0);
    
    -- Signal to determine type of tone generated
    signal s_tone_gen_data_i : std_logic_vector(2 - 1 downto 0);           
    
    -- Signals multiplexing back & front sensors to their drivers
    signal s_sensorfront_i   : std_logic;
    signal s_sensorfront_o   : std_logic;
    signal s_sensorback_i    : std_logic;
    signal s_sensorback_o    : std_logic;

    -- Update signal to switch measuring sensors
    signal s_updatefront_i   :  std_logic;
    signal s_updateback_i    :  std_logic;
    
    -- LED multiplexer selection signal
    signal s_sel_o         :  std_logic_vector(3 - 1 downto 0);
    
    -- Signal from clock enable. Pulsing every 2ms.
    signal s_2ms           :  std_logic;

begin

    --------------------------------------------------------------------
    -- Proces for switching between Left & Center & Right front sensor
    -- So only one is measuring at the moment 
    --------------------------------------------------------------------
    p_front_sensor_select : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_sensor_front <= LEFT; -- Initial state                 
            else
                case s_sensor_front is
                
                    when LEFT =>
                        s_sensorfront_i <= sensor0_i;        -- Conecting input and output of urm_driver_decoder(front)
                        sensor0_o <= s_sensorfront_o;        -- to its proper sensor input and output...
                        
                        if(s_updatefront_i = '1') then       -- Reciving update signal will...
                            s_dist_lvl0 <= s_dist_lvl_front; -- Save measured value to proper interal signal &
                            s_sensor_front <= CENTER;        -- Change state.
                        end if;                              -- Rest works same, but with its own sensors.    
                        
                    when CENTER =>                
                        s_sensorfront_i <= sensor1_i;
                        sensor1_o <= s_sensorfront_o;
    
                        if(s_updatefront_i = '1') then
                            s_dist_lvl1 <= s_dist_lvl_front;
                            s_sensor_front <= RIGHT;
                        end if;
                        
                    when RIGHT =>
                        s_sensorfront_i <= sensor2_i;
                        sensor2_o <= s_sensorfront_o;
    
                        if(s_updatefront_i = '1') then
                            s_dist_lvl2 <= s_dist_lvl_front;
                            s_sensor_front <= LEFT;
                        end if;
                        
                    when others =>-- Other states
                        s_sensor_front <= LEFT;
        
                end case;
            end if;
        end if;
    end process p_front_sensor_select;
    
    --------------------------------------------------------------------
    -- Proces for switching between Left & Center & Right back sensor
    -- So only one is measuring at the moment
    --------------------------------------------------------------------
    p_back_sensor_select : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_sensor_back <= LEFT; -- Initial state       
            else
                case s_sensor_back is
                
                    when LEFT =>
                        s_sensorback_i <= sensor3_i;        -- Conecting input and output of urm_driver_decoder(back)   
                        sensor3_o <= s_sensorback_o;        -- to its proper sensor input and output...                  
    
                        if(s_updateback_i = '1') then       -- Reciving update signal will...                            
                            s_dist_lvl3 <= s_dist_lvl_back; -- Save measured value to proper interal signal &            
                            s_sensor_back <= CENTER;        -- Change state.                                             
                        end if;                             -- Rest works same, but with its own sensors.
                        
                    when CENTER =>                
                        s_sensorback_i <= sensor4_i;
                        sensor4_o <= s_sensorback_o;
    
                        if(s_updateback_i = '1') then
                            s_dist_lvl4 <= s_dist_lvl_back;
                            s_sensor_back <= RIGHT;
                        end if;
                        
                    when RIGHT =>
                        s_sensorback_i <= sensor5_i;
                        sensor5_o <= s_sensorback_o;
    
                        if(s_updateback_i = '1') then
                            s_dist_lvl5 <= s_dist_lvl_back;
                            s_sensor_back <= LEFT;
                        end if;
                        
                    when others =>-- Other states
                        s_sensor_back <= LEFT;
                        
                end case;
            end if;
        end if;
    end process p_back_sensor_select;  
    
     --------------------------------------------------------------------
    -- Connecting testbench signals with entities 
    --------------------------------------------------------------------  
    -- Entity: Ultrasonic range meter driver - for front sensors
    uut_urm_driver_front : entity work.urm_driver_decoder
            generic map(
                g_lvl_0      => g_distance_threshold1,
                g_lvl_1      => g_distance_threshold2,
                g_lvl_2      => g_distance_threshold3,
                g_lvl_3      => g_distance_threshold4
            )
            port map(
                clk          => clk,
                reset        => reset,
                sensor_out_i => s_sensorfront_i,
                sensor_in_o  => s_sensorfront_o,
                dist_lvl_o   => s_dist_lvl_front,
                update_o     => s_updatefront_i
            );
            
    -- Entity: Ultrasonic range meter driver - for back sensors
    uut_urm_driver_back : entity work.urm_driver_decoder
            generic map(
                g_lvl_0      => g_distance_threshold1,
                g_lvl_1      => g_distance_threshold2,
                g_lvl_2      => g_distance_threshold3,
                g_lvl_3      => g_distance_threshold4
            )
            port map(
                clk          => clk,
                reset        => reset,
                sensor_out_i => s_sensorback_i,
                sensor_in_o  => s_sensorback_o,
                dist_lvl_o   => s_dist_lvl_back,
                update_o     => s_updateback_i
            );
    
    -- Entity: Comparation of distances measured by sensors        
    uut_distance_comparator : entity work.distance_comparator
            port map (
                a_i          => s_dist_lvl0,
                b_i          => s_dist_lvl1,
                c_i          => s_dist_lvl2,
                d_i          => s_dist_lvl3,
                e_i          => s_dist_lvl4,
                f_i          => s_dist_lvl5,
                greatest_o   => s_tone_gen_data_i
            );
            
     -- Entity: For tone generation dependant on closest measuerd range
    uut_tone_gen: entity work.beep_generator
            generic map(
                tone_freq    =>  g_tone_freq,  -- 1000; --Hz
                slow_period  =>  g_slow_period,  -- 5; --ms
                fast_period  =>  g_fast_period  -- 2  --ms
            )  
            port map  (
                clk          =>  clk,
                reset        =>  reset,
                dist_lvl     =>  s_tone_gen_data_i,
                tone_o       =>  sound_o
            );
    
    -- Entity: Multiplexer for 6-LEDs(bargraphs)      
    uut_mux_led: entity work.mux_2bit_6to1
            port map (
                a_i          =>  s_dist_lvl0, 
                b_i          =>  s_dist_lvl1, 
                c_i          =>  s_dist_lvl2, 
                d_i          =>  s_dist_lvl3, 
                e_i          =>  s_dist_lvl4, 
                f_i          =>  s_dist_lvl5, 
                sel_i        =>  s_sel_o,
                f_o          =>  LED_o
            );
            
    -- Entity: For sending pulse every 2ms
    uut_clk_en0 : entity work.clock_enable
            generic map(
                g_MAX        => 200000
            )
            port map(
                clk          => clk,
                reset        => reset,
                ce_o         => s_2ms
            );   
                 
    -- Entity: To change multiplexer selector signal
    uut_bin_cnt0 : entity work.cnt_up_down
            generic map(
                g_CNT_WIDTH  => 3
            )
            port map(
                clk          => clk,
                reset        => reset,
                en_i         => s_2ms,
                cnt_up_i     => '1',
                cnt_o        => s_sel_o            
            );             
                -- Connecting internal mux selecting singal to output          
                sel_o <= s_sel_o;
                           
end Behavioral;
