----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 12:36:11 AM
-- Design Name: 
-- Module Name: tb_distance_comparator - Behavioral
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

entity tb_distance_comparator is
--  Port ( );
end tb_distance_comparator;

architecture Behavioral of tb_distance_comparator is

    -- Local signals
    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_c       : std_logic_vector(2 - 1 downto 0);
    signal s_d       : std_logic_vector(2 - 1 downto 0);
    signal s_e       : std_logic_vector(2 - 1 downto 0);
    signal s_f       : std_logic_vector(2 - 1 downto 0);
    signal s_goat    : std_logic_vector(2 - 1 downto 0);
    

begin
    -- Connecting testbench signals with distance_comparator
    uut_distance_comparator : entity work.distance_comparator
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            e_i           => s_e,
            f_i           => s_f,
            greatest_o    => s_goat
        );
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin        
        report "Stimulus process started" severity note;
        s_a <= "01";
        s_b <= "00";
        s_c <= "00";
        s_d <= "00";
        s_e <= "00";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "01";
        s_c <= "00";
        s_d <= "00";
        s_e <= "00";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "00";
        s_c <= "01";
        s_d <= "00";
        s_e <= "00";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "00";
        s_c <= "00";
        s_d <= "01";
        s_e <= "00";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "00";
        s_c <= "00";
        s_d <= "01";
        s_e <= "00";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "00";
        s_c <= "00";
        s_d <= "00";
        s_e <= "01";
        s_f <= "00";
        wait for 10ns;
        
        s_a <= "00";
        s_b <= "00";
        s_c <= "00";
        s_d <= "00";
        s_e <= "00";
        s_f <= "01";
        wait for 10ns;
        
        s_a <= "11";
        s_b <= "11";
        s_c <= "00";
        s_d <= "00";
        s_e <= "00";
        s_f <= "01";
        wait for 10ns;
        wait;
    end process p_stimulus;
    
end Behavioral;
