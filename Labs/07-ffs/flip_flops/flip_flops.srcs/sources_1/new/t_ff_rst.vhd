----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 11:14:40
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity t_ff_rst is
    Port (
           clk   : in  STD_LOGIC;
           t     : in  STD_LOGIC;
           rst   : in  STD_LOGIC;
           q     : out STD_LOGIC;
           q_bar : out STD_LOGIC
          );
end t_ff_rst;

architecture Behavioral of t_ff_rst is
     signal s_q     : STD_LOGIC;
begin

p_t_ff_rst : process(clk)
begin
        if rising_edge(clk) then
         
           if (rst = '1') then        
              s_q <= '0';
           else  
                 
              if (t = '0') then
                    s_q     <= s_q;                                     
              else  -- t = 1
                    s_q     <= not s_q;  
              end if;  
           
           end if;
             
        end if;       
                                 
end process p_t_ff_rst;

    q     <= s_q;
    q_bar <= not s_q;

end Behavioral;
