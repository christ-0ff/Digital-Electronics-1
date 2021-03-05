-- The code:


-- The Libraries:

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Entity declaration:

entity top is
    Port 
    (
     SW  : in  STD_LOGIC_VECTOR (4 - 1 downto 0);   --Input Binary
     --    
     CA  : out STD_LOGIC;
     CB  : out STD_LOGIC;
     CC  : out STD_LOGIC;
     CD  : out STD_LOGIC;
     CE  : out STD_LOGIC;
     CF  : out STD_LOGIC;
     CG  : out STD_LOGIC;
     
     LED : out STD_LOGIC_VECTOR (8 - 1 downto 0);   -- LED indicators
     AN  : out STD_LOGIC_VECTOR (8 - 1 downto 0)    -- Common anode signals to individual displays
     );
end top;

-- Architecture:

architecture Behavioral of top is
begin
    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map
        (
            hex_i    => SW,           
            --
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_0111";

    -- Display input value
    LED(4 - 1 downto 0) <= SW;

    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    LED(4) <= '1' when (SW = "0000") else '0';
    
    -- Turn LED(5) on if input value is greater than "1001"
    LED(5) <= '1' when (SW > "1001") else '0';
    
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    LED(6) <= SW(0);
    
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    LED(7)  <= '1' when (SW = "0001") else
               '1' when (SW = "0010") else
               '1' when (SW = "0100") else
               '1' when (SW = "1000") else
               '0';
               
--    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8               
--    p_led7 : process (SW)
--    begin
--        case SW is
--            when "0001" =>
--                LED(7) <= '1';     -- 1
--            when "0010" =>
--                LED(7) <= '1';     -- 2
--            when "0100" =>
--                LED(7) <= '1';     -- 4
--            when "1000" =>
--                LED(7) <= '1';     -- 8
--            when others =>
--                LED(7) <= '0';     
--        end case;
--    end process p_led7;

--    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8    
--   p_led7_2 : process (SW)
--   begin
--       if    (SW = "0001") then
--           LED(7) <= '1';
--       elsif (SW = "0010") then
--           LED(7) <= '1';
--       elsif (SW = "0100") then
--           LED(7) <= '1';
--       elsif (SW = "1000") then
--           LED(7) <= '1';  
--       else
--           LED(7) <= '0';         
--       end if;
--   end process p_led7_2;

end Behavioral;
