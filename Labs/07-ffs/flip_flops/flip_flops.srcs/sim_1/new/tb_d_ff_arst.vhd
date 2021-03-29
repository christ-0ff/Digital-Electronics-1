----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 11:02:30
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
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

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is

           constant c_CLK_100MHZ_PERIOD : time    := 50 ns;

           signal s_clk   : STD_LOGIC;
           signal s_d     : STD_LOGIC;
           signal s_arst  : STD_LOGIC;
           signal s_q     : STD_LOGIC;
           signal s_q_bar : STD_LOGIC;
begin

uut_d_ff_arst : entity work.d_ff_arst

        port map(
            clk    => s_clk,    
            d     => s_d,     
            arst  => s_arst,  
            q     => s_q,     
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
    s_arst <= '1';
    wait for 10 ns;
    s_arst <= '0';       
    wait for 210 ns;
    s_arst <= '1';
    wait for 40 ns;
    s_arst <= '0';       
    wait for 120 ns;
    s_arst <= '1';
    wait for 300 ns;   
    s_arst <= '0';
    wait for 30 ns;    
    s_arst <= '1';
    wait for 10 ns;
    s_arst <= '0';
    wait for 100 ns;
    s_arst <= '1';
    wait for 10 ns;
    s_arst <= '0';
    wait for 65 ns;  
    s_arst <= '1';
    wait for 10 ns;  
end process p_reset_gen;

--------------------------------------------------------------------
-- Data generation process
--------------------------------------------------------------------
p_stimulus : process
begin
    report "Stimulus process started" severity note;
   
    s_d <= '1';
    wait for 50 ns;    
    
    s_d <= '0';
    wait for 25 ns; 

    s_d <= '1';
    wait for 50 ns; 
    
    -- Expected output
    assert ((s_q = '1') and (s_q_bar = '0' ))
    -- If false, then report an error
    report "Test failed for input: '1' " severity error;
          
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 325 ns;
    --500ns
    s_d <= '0';
    wait for 125 ns; 

    s_d <= '1';
    wait for 250 ns; 
    
    s_d <= '0';
    wait for 125 ns;      

    -- Expected output
    assert ((s_q = '0') and (s_q_bar = '1' ))
    -- If false, then report an error
    report "Test failed for input: '0' " severity error;
   
    report "Stimulus process finished" severity note;
    wait;
end process p_stimulus;

end Behavioral;
