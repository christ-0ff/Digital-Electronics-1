# Lab 4: Seven-segment display decoder



### Learning objectives

The purpose of this laboratory exercise is to design a 7-segment display decoder and to become familiar with the VHDL structural description that allows you to build a larger system from simpler or predesigned components.




## Preparation tasks (done before the lab at home)

The Nexys A7 board provides two four-digit common anode seven-segment LED displays (configured to behave like a single eight-digit display). See schematic or reference manual of the Nexys A7 board and find out the connection of 7-segment displays, ie to which FPGA pins are connected and how.

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

Complete the decoder truth table for common anode 7-segment display.

| **Hex** | **Inputs** | **A** | **B** | **C** | **D** | **E** | **F** | **G** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 |   |   |   |   |   |   |   |
| 3 | 0011 |   |   |   |   |   |   |   |
| 4 | 0100 |   |   |   |   |   |   |   |
| 5 | 0101 |   |   |   |   |   |   |   |
| 6 | 0110 |   |   |   |   |   |   |   |
| 7 | 0111 |   |   |   |   |   |   |   |
| 8 | 1000 |   |   |   |   |   |   |   |
| 9 | 1001 |   |   |   |   |   |   |   |
| A | 1010 |   |   |   |   |   |   |   |
| b | 1011 |   |   |   |   |   |   |   |
| C | 1100 |   |   |   |   |   |   |   |
| d | 1101 |   |   |   |   |   |   |   |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |
