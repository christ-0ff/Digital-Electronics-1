----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 11:27:52
-- Design Name: 
-- Module Name: tb_jk_ff_rst - Behavioral
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

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

architecture Behavioral of tb_jk_ff_rst is

           constant c_CLK_100MHZ_PERIOD : time    := 50 ns;

           signal s_clk   :   STD_LOGIC;
           signal s_j     :   STD_LOGIC;
           signal s_k     :   STD_LOGIC;
           signal s_rst   :   STD_LOGIC;
           signal s_q     :   STD_LOGIC;
           signal s_q_bar :   STD_LOGIC;
begin

    uut_jk_ff_rst : entity work.jk_ff_rst
        port map(
            clk     => s_clk,  
            j       => s_j,    
            k       => s_k,    
            rst     => s_rst,  
            q       => s_q,    
            q_bar => s_q_bar
                );
                
--------------------------------------------------------------------
-- Clock generation process
--------------------------------------------------------------------
p_clk_gen : process
begin
    while now < 2000 ns loop         -- 200 periods of 100MHz clock
        s_clk <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk <= '0';
        wait for c_CLK_100MHZ_PERIOD / 2;
    end loop;
    wait;
end process p_clk_gen;
                
--------------------------------------------------------------------
-- Reset generation process
--------------------------------------------------------------------
p_reset_gen : process
begin
    s_rst <= '1';
    wait for 55 ns;
    s_rst <= '0';
    wait for 165 ns;
    s_rst <= '1';
    wait for 100 ns;
    s_rst <= '0';
    wait for 100 ns;
    s_rst <= '1';
    wait for 120 ns;
    s_rst <= '0';
    wait for 200 ns;
    s_rst <= '1';
    wait for 100 ns;
    s_rst <= '0';
    wait for 105 ns;
    s_rst <= '1';
    wait for 10 ns;
    s_rst <= '0';
    wait for 200 ns;
end process p_reset_gen;

--------------------------------------------------------------------
-- Data generation process
--------------------------------------------------------------------
p_stimulus : process
begin
    report "Stimulus process started" severity note;

    s_j <= '1';
    s_k <= '0';
    wait for 70 ns;

    s_j <= '1';
    s_k <= '1';
    wait for 250 ns;
    
    s_j <= '0';
    s_k <= '0';
    wait for 70 ns;
    
    s_j <= '1';
    s_k <= '0';
    wait for 100 ns;
    
    -- Expected output
    assert ((s_q = '0') or (s_q_bar = '1'))
    -- If false, then report an error
    report "Test failed for input: '0' " severity error;
    
    --500ns
    s_j <= '1';
    s_k <= '1';
    wait for 180 ns;   

    s_j <= '1';
    s_k <= '0';
    wait for 220 ns;
    s_j <= '0';
    s_k <= '0';
    wait for 220 ns;     
    
    -- Expected output
    assert ((s_q = '1') or (s_q_bar = '0'))
    -- If false, then report an error
    report "Test failed for input: '1' " severity error;
              
    report "Stimulus process finished" severity note;
    wait;
    
end process p_stimulus;                
end architecture Behavioral;
