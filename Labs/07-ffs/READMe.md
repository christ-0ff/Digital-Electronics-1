# 7-Latches and Flip-flops

## 1. Characteristic equations and tables for flip-flops.

### Tables of D, JK, T flip-flops and characteristic equations

**D flip-flop**

   | **D** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No Change |
   | 0 | 1 | 0 | Reset |
   | 1 | 0 | 1 | Set |
   | 1 | 1 | 1 | No Change |

![](Images/1.png)

**JK flip-flop**

   | **J** | **K** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 0 | 1 | Set |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 1 | 0 | Toggle |

![](Images/2.png)

**T flip-flop**
   
   | **T** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 1 | No change |
   | 1 | 0 | 1 | Invert |
   | 1 | 1 | 0 | Invert |

![](Images/3.png)

## 2. D Latch

**VHDL code listing of the process `p_d_latch`**
```vhdl
p_d_latch : process(d, arst, en)
begin

         if (arst = '1') then        
              q     <= '0';
              q_bar <= '1';
         elsif (en = '1') then       
              q     <= d;
              q_bar <= not d;    
         end if;     
         
end process p_d_latch;
```

**Listing of VHDL reset and stimulus processes from the testbench file `tb_d_latch.vhd`**
```vhdl
--------------------------------------------------------------------
-- Reset generation process
--------------------------------------------------------------------
p_reset_gen : process
begin
    s_arst <= '1';
    wait for 50 ns;
    
    s_arst <= '0';
    wait for 75 ns;
    
    s_arst <= '1';
    wait for 100 ns;
    
    s_arst <= '0';
    wait for 275 ns;        
    
    s_arst <= '0';
    wait for 150 ns;
    
    s_arst <= '1';
    wait for 50 ns;
    
    s_arst <= '0';
    wait for 100 ns;
    
    s_arst <= '1';
    wait for 20 ns;
    
    s_arst <= '0';
    wait for 200 ns;  
end process p_reset_gen;

--------------------------------------------------------------------
-- Data generation process
--------------------------------------------------------------------
p_stimulus : process
begin
    report "Stimulus process started" severity note;

    -- Enable latch
    s_en     <= '1';
    
    -- Output change
    s_d <= '1';
    wait for 50 ns;       
    
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 50 ns;
    
    s_d <= '0';
    wait for 50 ns; 
       
    s_d <= '1';
    wait for 50 ns;

    -- Expected output
    assert ((s_q = '1') and (s_q_bar = '0' ))
    -- If false, then report an error
    report "Test failed for input: '1' " severity error;
        
    s_d <= '0';
    wait for 50 ns;

    s_d <= '1';
    wait for 50 ns;
    
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 50 ns;
    
    s_d <= '0';
    wait for 50 ns;
    --500ns
    
    -- Expected output
    assert ((s_q = '0') and (s_q_bar = '1' ))
    -- If false, then report an error
    report "Test failed for input: '0' " severity error;
    
    s_d <= '1';
    wait for 25 ns;
    
    -- Disable latch
    s_en     <= '0';
    wait for 25 ns;
        
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 50 ns;
    
    s_d <= '0';
    wait for 50 ns; 
       
    s_d <= '1';
    wait for 25 ns;
    
    -- Enable latch
    s_en     <= '1';
    wait for 25 ns;
    
    -- Output change
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 50 ns;
    
    s_d <= '0';
    wait for 50 ns;
    
    s_d <= '1';
    wait for 50 ns; 
       
    s_d <= '0';
    wait for 50 ns;
    
    report "Stimulus process finished" severity note;
    wait;
end process p_stimulus;
```

**Screenshot with simulated time waveforms**
![](Images/w1.png)


## 3. Flip-Flops

**VHDL code listing of the processes p_d_ff_arst, p_d_ff_rst, p_jk_ff_rst, p_t_ff_rst with syntax highlighting,**
```vhdl
```

**Listing of VHDL clock, reset and stimulus processes from the testbench files with syntax highlighting and asserts,**
```vhdl
```

**Screenshot with simulated time waveforms**

## 4. Shift Register

**Image of the shift register schematic.**
![](Images/.png)
