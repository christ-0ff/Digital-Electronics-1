# 03-Vivado
**List of content:**

[1. Connections of LEDs and switches to pins](#connections-of-LEDs-and-switches-to-pins)

[2. Two-bit wide 4-to-1 multiplexer.](#Two-bit-wide-4-to-1-multiplexer)

[3. Vivado tutorials](#Vivado-tutorials)
   
## Connections of LEDs and switches to pins

**LEDs are active-high => logic value 1 will switch LEDs on.**

**Switches can represent both logical values => their logical value depends on the position of each switch.**

```
Table with pin connections:

Switches:                                    LEDs:
Switch 00 => J15                             LED 00 => H17
Switch 01 => L16                             LED 01 => K15
Switch 02 => M13                             LED 02 => J13
Switch 03 => R15                             LED 03 => N14
Switch 04 => R17                             LED 04 => R18
Switch 05 => T18                             LED 05 => V17
Switch 06 => U18                             LED 06 => U17
Switch 07 => R13                             LED 07 => U16
Switch 08 => T8                              LED 08 => V16
Switch 09 => U8                              LED 09 => T15
Switch 10 => R16                             LED 10 => U14
Switch 11 => T13                             LED 11 => T16
Switch 12 => H6                              LED 12 => V15
Switch 13 => U12                             LED 13 => V14
Switch 14 => U11                             LED 14 => V12
Switch 15 => V10                             LED 15 => V11
```


## Two-bit wide 4-to-1 multiplexer

**VHDL Architecture of mux_2bit_4to1**
```vhdl
architecture Behavioral of mux_2bit_4to1 is
begin

       f_o  <= a_i when (sel_i = "00") else
               b_i when (sel_i = "01") else
               c_i when (sel_i = "10") else
               d_i;

end architecture Behavioral;
```

**VHDL Stimulus process from testbench**
```vhdl
p_stimulus : process
  begin
      -- Report a note at the begining of stimulus process
      report "Stimulus process started" severity note;

              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; 
              s_sel <= "00";
      wait for 100 ns;
     
              s_a <= "01"; s_b <= "10"; s_c <= "11"; s_d <= "00"; 
              s_sel <= "01";
      wait for 100 ns;
      
              s_a <= "10"; s_b <= "11"; s_c <= "00"; s_d <= "01";
              s_sel <= "10";
      wait for 100 ns;
      
              s_a <= "11"; s_b <= "00"; s_c <= "01"; s_d <= "10";
              s_sel <= "11";
      wait for 100 ns;
      --
              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; 
              s_sel <= "00";
      wait for 100 ns;
     
              s_a <= "01"; s_b <= "10"; s_c <= "11"; s_d <= "00"; 
              s_sel <= "00";
      wait for 100 ns;
      
              s_a <= "10"; s_b <= "11"; s_c <= "00"; s_d <= "01";
              s_sel <= "00";
      wait for 100 ns;
      
              s_a <= "11"; s_b <= "00"; s_c <= "01"; s_d <= "10";
              s_sel <= "00";
      wait for 100 ns;
      --
              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; 
              s_sel <= "00";
      wait for 100 ns;
     
              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; 
              s_sel <= "01";
      wait for 100 ns;
      
              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11";
              s_sel <= "10";
      wait for 100 ns;
      
              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11";
              s_sel <= "11";
      wait for 100 ns;
      --
              s_a <= "11"; s_b <= "00"; s_c <= "01"; s_d <= "10";
              s_sel <= "11";
      wait for 100 ns;     

              s_a <= "10"; s_b <= "11"; s_c <= "00"; s_d <= "01";
              s_sel <= "10";
      wait for 100 ns;

              s_a <= "01"; s_b <= "10"; s_c <= "11"; s_d <= "00"; 
              s_sel <= "01";
      wait for 100 ns;

              s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; 
              s_sel <= "00";
      wait for 100 ns;              
                   
      -- Report a note at the end of stimulus process
      report "Stimulus process finished" severity note;
      wait;
end process p_stimulus;
```
**Image of waveforms**
![Waveforms](Images/waveforms.png)


## Vivado tutorials
**Links for each tutorial:**

[Project creation](#Project-creation)

[Adding source files](#Adding-design-source-files)

[Adding testbench files](#Adding-testbench-files)

[Adding XDC constraints files](#Adding-XDC-constraints-files)

[Running simulation](#Running-simulation)

### **Project creation**

#### 1. *First step:*
![](Images/1.png)
#### 2. *Naming project:*
![](Images/2.png)
#### 3. *Project type selection:*
![](Images/3.png)
#### 4. *We can skip this step and add source files later.*
 ![](Images/5.png)
 #### 5. *We can skip this step and add constraints files later.*
 ![](Images/6.png)
 #### 6. *Finishing:*
 ![](Images/8.png)
 #### 7. *On this summary page just click on **Finish** button*:
 ![](Images/4.png)
 
 [Go back button](#Vivado-tutorials)
 
### **Adding design source files**

#### 1. *First step:*
![](Images/1a.png)
#### 2. *Source selection:*
![](Images/2d.png)
#### 3. *Source file addition:*
![](Images/3d.png)
#### 4. *Modul definition:*
![](Images/4d.png)
#### 5. *Making sure everythink is added:*
![](Images/5d.png)

[Go back button](#Vivado-tutorials)

### **Adding testbench files**

#### 1. *First step:*
![](Images/1a.png)
#### 2. *Source selection:*
![](Images/2s.png)
#### 3. *Source file addition:*
![](Images/3s.png)
#### 4. *Modul definition:*
![](Images/4s.png)
#### 5. *Making sure everythink is added:*
![](Images/5s.png)

[Go back button](#Vivado-tutorials)

### **Adding XDC constraints files**

#### 1. *First step:*
![](Images/1a.png)
#### 2. *Source selection:*
![](Images/2c.png)
#### 3. *Source file addition:*
![](Images/3c.png)
#### 4. *Making sure everythink is added:*
![](Images/4c.png)
#### 5. *Taking right connections*
*Now we can visit this [website](https://github.com/Digilent/digilent-xdc), find our board (Nexys A7-50T), and copy whole content to our `nexys-a7-50t.xdc` file.*

[Go back button](#Vivado-tutorials)

### **Running simulation**

#### 1. *First&Last step:*
![](Images/sim.png)

[Go back button](#Vivado-tutorials)

[Go to the start of this READMe.md file](#03-vivado)
   
