

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is 
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
     
     signal s_CLK_100MHZ : STD_LOGIC;
     signal s_BTNC      : STD_LOGIC;           
     signal s_SW        : STD_LOGIC_VECTOR (1 - 1 downto 0);
     --    
     signal s_CA        : STD_LOGIC;
     signal s_CB        : STD_LOGIC;
     signal s_CC        : STD_LOGIC;
     signal s_CD        : STD_LOGIC;
     signal s_CE        : STD_LOGIC;
     signal s_CF        : STD_LOGIC;
     signal s_CG        : STD_LOGIC;
     --
--     signal s_LED       : STD_LOGIC_VECTOR (4 - 1 downto 0);
     signal s_LED       : STD_LOGIC_VECTOR (16 - 1 downto 0);
     signal s_AN        : STD_LOGIC_VECTOR (8 - 1 downto 0);    
      
begin

      uut_top  : entity work.top
        port map
        (       
         CLK100MHZ => s_CLK_100MHZ, 
         BTNC => s_BTNC,             
         SW  =>  s_SW, 
         --
         CA  =>  s_CA,  
         CB  =>  s_CB,  
         CC  =>  s_CC,  
         CD  =>  s_CD,  
         CE  =>  s_CE,  
         CF  =>  s_CF,  
         CG  =>  s_CG,  
                
         LED =>  s_LED,
         AN  =>  s_AN
       );
       
    p_clk_gen : process
    begin
        while now < 1000 ns loop         -- 75 periods of 100MHz clock
            s_CLK_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
p_stimulus : process 
begin
    report "Stimulus process started" severity note;
    
     s_SW(0) <= '1';
     wait for 100ns;
     
     s_SW(0) <= '0';
     wait for 100ns;
     
     s_SW(0) <= '1';
     wait for 150ns;
     
     s_SW(0) <= '0';
     wait for 150ns;
     
    report "Stimulus process finished" severity note;
wait;
end process p_stimulus;

p_reset : process 
begin      
     s_BTNC <= '1';
     wait for 50ns;
     
     s_BTNC <= '0';
     wait for 50ns;    
wait;
end process p_reset;

end Behavioral;