----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 12:24:20 AM
-- Design Name: 
-- Module Name: distance_comparator - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for 2-bit binary comparator
------------------------------------------------------------------------
entity distance_comparator is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
        b_i           : in  std_logic_vector(2 - 1 downto 0);
        c_i           : in  std_logic_vector(2 - 1 downto 0);
        d_i           : in  std_logic_vector(2 - 1 downto 0);
        e_i           : in  std_logic_vector(2 - 1 downto 0);
        f_i           : in  std_logic_vector(2 - 1 downto 0);
        greatest_o    : out std_logic_vector(2 - 1 downto 0)  -- Outputs the shortest distance out of 6 input distances
    );
end entity distance_comparator;


architecture Behavioral of distance_comparator is
    -- Temporary internal signals
    signal temp_1     : std_logic_vector(2 - 1 downto 0);
    signal temp_2     : std_logic_vector(2 - 1 downto 0);
    signal temp_3     : std_logic_vector(2 - 1 downto 0);
    signal temp_4     : std_logic_vector(2 - 1 downto 0);
    
begin
    --------------------------------------------------------------------
    -- Process for finding highest value
    --------------------------------------------------------------------
    p_comp : process(a_i,b_i,c_i,d_i,e_i,f_i,temp_1,temp_2,temp_3,temp_4)
    begin
        -- Finding the highest value from input signals, saving them into temporary signals
        if (b_i >= a_i) then  
            temp_1 <= b_i;
        else
            temp_1 <= a_i;
        end if;
        
        if (c_i >= d_i) then
            temp_2 <= c_i;
        else
            temp_2 <= d_i;
        end if;
        
        if (e_i >= f_i) then
            temp_3 <= e_i;
        else
            temp_3 <= f_i;
        end if;
        
        -- Finding the highest value of the temporary signals.
        if (temp_1 >= temp_2) then
            temp_4 <= temp_1;
        else
            temp_4 <= temp_2;
        end if;
        
        -- Greatest value sent to output.
        if (temp_4 >= temp_3) then
            greatest_o <= temp_4;
        else
            greatest_o <= temp_3;
        end if;
    end process p_comp;
    
end architecture Behavioral;