# 01-Gates
## 2. De Morganovy zákony funkce f:
### Zdrojový kód:
```
f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
fnand_o <= not(not((not b_i) and a_i) and not((not c_i) and (not b_i)));
fnor_o <= not(b_i or (not a_i)) or not(c_i or b_i);
```
### Obrázek:
![De Morganovy zákony](Images/DeMorg.png)

### Link: 
https://www.edaplayground.com/x/uq2V

### Tabulka hodnot:
| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |
## 3. Distributivní zákony:
### Zdrojový kód:
```
f1_o  <= (x_i and y_i) or (x_i and z_i) ;
f2_o  <= x_i and (y_i or z_i);
f3_o  <= (x_i or y_i) and (x_i or z_i);
f4_o  <= x_i or (y_i and z_i);
```
### Obrázek:
![Distributivní zákony](Images/Dis.png)

### Link:
https://www.edaplayground.com/x/SaUt
