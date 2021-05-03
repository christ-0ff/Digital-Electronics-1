----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2021 12:54:49 AM
-- Design Name: 
-- Module Name: mux_2bit_6to1 - Behavioral
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

------------------------------------------------------------------------
-- Entity declaration for mux_2bit_6to1
------------------------------------------------------------------------
entity mux_2bit_6to1 is
port(
        a_i           : in   std_logic_vector(2 - 1 downto 0); -- Data A
        b_i           : in   std_logic_vector(2 - 1 downto 0); -- Data B
        c_i           : in   std_logic_vector(2 - 1 downto 0); -- Data C
        d_i           : in   std_logic_vector(2 - 1 downto 0); -- Data D
        e_i           : in   std_logic_vector(2 - 1 downto 0); -- Data E
        f_i           : in   std_logic_vector(2 - 1 downto 0); -- Data F
        sel_i         : in   std_logic_vector(3 - 1 downto 0); -- Data Sel
        f_o           : out  std_logic_vector(2 - 1 downto 0)  -- Output F
    );
end mux_2bit_6to1;

architecture Behavioral of mux_2bit_6to1 is

begin
       f_o <= a_i when (sel_i = "000") else
              b_i when (sel_i = "001") else
              c_i when (sel_i = "010") else
              d_i when (sel_i = "011") else
              e_i when (sel_i = "100") else
              f_i;                 

end Behavioral;