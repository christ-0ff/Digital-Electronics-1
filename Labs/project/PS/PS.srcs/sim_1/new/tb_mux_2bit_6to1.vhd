----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2021 05:47:46 PM
-- Design Name: 
-- Module Name: tb_mux_2bit_6to1 - Behavioral
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

entity tb_mux_2bit_6to1 is
--  Port ( );
end tb_mux_2bit_6to1;

architecture Behavioral of tb_mux_2bit_6to1 is

        signal s_a      : std_logic_vector(2 - 1 downto 0);
        signal s_b      : std_logic_vector(2 - 1 downto 0);
        signal s_c      : std_logic_vector(2 - 1 downto 0);
        signal s_d      : std_logic_vector(2 - 1 downto 0);
        signal s_e      : std_logic_vector(2 - 1 downto 0);
        signal s_f      : std_logic_vector(2 - 1 downto 0);
        signal s_sel    : std_logic_vector(3 - 1 downto 0);
        signal s_o      : std_logic_vector(2 - 1 downto 0); 
        
begin

    -- Connecting testbench signals with mux_2bit_6to1
    uut_mux_2bit_6to1 : entity work.mux_2bit_6to1
        port map(
            a_i    =>  s_a,  
            b_i    =>  s_b,  
            c_i    =>  s_c,  
            d_i    =>  s_d,  
            e_i    =>  s_e,  
            f_i    =>  s_f,  
            sel_i  =>  s_sel,
            f_o    =>  s_o
        );
        
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin        
        report "Stimulus process started" severity note;
        s_a <= "00";
        s_b <= "01";
        s_c <= "10";
        s_d <= "11";
        s_e <= "00";
        s_f <= "01";
        
        s_sel <= "000";
        wait for 10ns;        
        s_sel <= "001";
        wait for 10ns;
        s_sel <= "010";
        wait for 10ns;        
        s_sel <= "011";
        wait for 10ns;
        s_sel <= "100";
        wait for 10ns;        
        s_sel <= "101";
        
        wait;
    end process p_stimulus;

end Behavioral;
