----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 10:52:03
-- Design Name: 
-- Module Name: d_ff_arst - Behavioral
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

entity d_ff_arst is
    Port( 
        clk   : in  STD_LOGIC;
        d     : in  STD_LOGIC;
        arst  : in  STD_LOGIC;
        q     : out STD_LOGIC;
        q_bar : out STD_LOGIC
        );
end d_ff_arst;

architecture Behavioral of d_ff_arst is
begin

p_d_ff_arst : process(clk, arst)
begin     

         if (arst = '1') then        
              q     <= '0';
              q_bar <= '1';
              
         elsif rising_edge(clk) then       
              q     <= d;
              q_bar <= not d;    
         end if;    
            
end process p_d_ff_arst;

end Behavioral;
