



# 02-Logic

## 1. Truth table:

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B > A** | **B = A** | **B < A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0|
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |



## 2. A 2-bit comparator:

### 1. B equals A
![B=A](/Users/krystufek/Documents/Digital-Electronics-1/Labs/02-logic/images/equals.png)

$$
B=A_{SoP}^{canon.}=(\overline{a_1}\cdot\overline{a_0}\cdot\overline{b_1}\cdot\overline{b_0})+(\overline{a_1}\cdot a_0\cdot\overline{b_1}\cdot b_0)+(\overline{a_0}\cdot a_1\cdot\overline{b_0}\cdot b_1)+(a_1\cdot a_0\cdot b_1\cdot b_0)
$$



### 1. B is greater than A

![B>A](/Users/krystufek/Documents/Digital-Electronics-1/Labs/02-logic/images/greater.png)

$$
B>A_{SoP}^{min}=(\overline{a_1}\cdot b_1)+(\overline{a_1}\cdot\overline{a_0}\cdot b_0)+(\overline{a_0}\cdot b_0 \cdot b_1)
$$

### 2. B is less than A

![B<A](/Digital-Electronics-1/Labs/02-logic/images/less.png)

**Diminished version**
$$
B<A_{PoS}^{min}=(\overline{b_1}+\overline{b_0})\cdot(a_0+\overline{b_1})\cdot(a_1+\overline{b_1})\cdot(a_1+\overline{b_0})\cdot(a_0+a_1)
$$

**Canonical version**
$$
B<A_{SoP}^{canon.}=(a_1+ a_0+b_1 + b_0)\cdot(a_1+ a_0+b_1 + \overline{b_0})\cdot(a_1+ \overline{a_0}+b_1 + \overline{b_0})\cdot(a_1+ a_0+\overline{b_1} + b_0)\cdot(a_1+ \overline{a_0}+\overline{b_1} + b_0)\cdot(\overline{a_1}+ a_0+\overline{b_1} + b_0)\cdot(a_1+ a_0+\overline{b_1} + \overline{b_0})\cdot(a_1+ \overline{a_0}+\overline{b_1} + \overline{b_0})\cdot(\overline{a_1}+ a_0+\overline{b_1} + \overline{b_0})\cdot(\overline{a_1}+ \overline{a_0}+\overline{b_1} + \overline{b_0})
$$


### 3. Link for EDA Playground

[The EDA Playground Link](https://www.edaplayground.com/x/74HF)

https://www.edaplayground.com/x/74HF

