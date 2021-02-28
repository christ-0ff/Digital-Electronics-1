-- The code


-- Libraries:

library ieee;
use ieee.std_logic_1164.all;


-- Entity declaration for 2-bit binary comparator

entity comparator_2bit is
    port(
        a_i               : in  std_logic_vector(2 - 1 downto 0);
		b_i               : in  std_logic_vector(2 - 1 downto 0);
		c_i               : in  std_logic_vector(2 - 1 downto 0);
		d_i               : in  std_logic_vector(2 - 1 downto 0);
		sel_i             : in  std_logic_vector(2 - 1 downto 0);
        --
        f_o               : out std_logic_vector(2 - 1 downto 0)
    );
end entity comparator_2bit;


-- Architecture body for 2-bit binary comparator

architecture Behavioral of comparator_2bit is
begin

    f_o  <= a_i when (sel_i = "00") else
            b_i when (sel_i = "01") else
            c_i when (sel_i = "10") else
            d_i;
            
    
end architecture Behavioral;

