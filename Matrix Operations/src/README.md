# Matrix-Operations

## 目標
這次的 lab 要來實作 Matrix Operations。輸出的結果是 **Y = AX + B**。當中**A(n\*r)**、**X(r\*n)**、**B(n\*n)**。如圖：
| ![](https://i.imgur.com/GncdXbe.png) |
| ---- |

## lab內容描述
<font color="red">**架構**</font>：架構圖如下。
- input port 有 3 個：`clk`、`reset`、`in_data`
- output port 有 5 個，分別是`i`、`j`、`opcode`、`out_data`、`fin`。

| ![](https://i.imgur.com/7gsUeR2.png) |
| ---- |

<font color="red">**訊號**</font>：以下做更詳細的訊號說明：
:point_right:**輸入訊號**
| name   | size | 功能              |
| ------ | ---- | ---------------- |
| clk    | 1    | 時間訊號           |
| reset  | 1    | reset=0 進行reset |
| in_data| 10   | 讀取的資料         |


:point_right:**輸出訊號**
| name    | size | 功能                  |
| ------- | ---- | -------------------- |
| i       | 10   | row index 0<=i<=9    |
| j       | 10   | column index 0<=i<=9 |
| opcode  | 3    | 控制讀寫               |
| out_data| 20   | 輸出的資料             |
| fin     | 1    | 結束時讓 fin=1         |

根據不同的 opcode 可以取得不同功能，如表：
| opcode | function |     i,j    |   in_data    | out_data   |
| ------ | -------- | ---------- | ------------ | ---------- |
| 000    | get   n  | don't care |       n      | don't care |
| 001    | get   r  | don't care |       r      | don't care |
| 010    | read  A  |   i,j      |    A[i][j]   | don't care |
| 011    | read  X  |   i,j      |    X[i][j]   | don't care |
| 100    | read  B  |   i,j      |    B[i][j]   | don't care |
| 101    | write Y  | don't care |  don't care  | Y          |

---

<font color="red">**注意事項**</font>：

:exclamation:A、X、B 的內容都是 unsign number。且 Y 不會有 overflow 的情況。

:exclamation:請在`reset`等於 0 的時候進行 reset，`clk`和`reset`的關係如下圖：
| ![](https://i.imgur.com/hAEQJXw.png) |
| ---- |

:exclamation:在寫入答案的部分，要在<font color="red"> negedge clk </font>以前將`opcode`設為 101，同時設定`out_data`的數值；寫入答案的順序是<font color="red">**由左而右，再由上而下**</font> (i.e. Y[0][0]、Y[0][1]、...、Y[1][0]、Y[1][1]、...、Y[n-1][n-1])，順序錯誤將導致答案錯誤。

## Template
請根據以下 template 做修改：
```verilog=
module MO(clk, reset, in_data, i, j, opcode, out_data, fin);
input clk, reset;
input [9:0] in_data;
output fin;
output [2:0] opcode;
output [9:0] i, j;
output [19:0] out_data;

//(your code)...

endmodule
```

## 工作站呈現
本次 Lab 有附 makefile 檔案，所以 run simulation 的時候可以參考以下指令：
```
make sim
```
以及 run synthesis 的時候可以參考以下指令：
```
make syn
```
另外，如果要清除多餘檔案的話，可以參考以下指令：
```
make clean
```
跑出來的結果如下：
*Correct Answer*
| ![](https://i.imgur.com/JwdusME.png) |
| --- |
*Wrong Answer*
| ![](https://i.imgur.com/sid6tAS.png) |
| --- |

# Lab4 Bonus-4x4 Systolic array
[toc]

發明者之一:[孔祥重](https://zh.wikipedia.org/wiki/%E5%AD%94%E7%A5%A5%E9%87%8D)

{%youtube cmy7LBaWuZ8 %}

## Diagram:
![](https://i.imgur.com/4o9rzzJ.png)
* Processing Element(PE)的結構
![](https://i.imgur.com/3JhT2Ok.png)

## spec


|  input  | size | 功能              |
| ------ | ---- | ---------------- |
| clk    | 1    | 時間訊號           |
| reset  | 1    | <font color="red">reset=1</font> 進行初始化 |
| a1~a4| 10   | A matrix的值    |
| b1~b4| 10   | B matrix的值    |

|  output  | size | 功能              |
| ------ | ---- | ---------------- |
| c1~c16| 10   | C matrix的值    |

## Task 說明
這次想讓同學體驗一下以額外的硬體降低時間複雜度(i.e花錢買時間)的一種structure
實作上我們在reset=1後等一個cycle開始送值![](https://i.imgur.com/T6Xx7II.png)
而TB會在把全部值送進去的時間點額外再等n cycle(這裡n=4)讓array做運算，之後把c1~c16跟答案做比對
:::warning
這次沒有fin，每個cycle給的值是固定的，clock在開始運算後只會走11 cycle就開始偵測答案，而且不像lab3可以用addr要求memory給對應的值，所以請同學務必小心細節
:::
* 矩陣的輸入方式
![](https://i.imgur.com/DcJPNKY.png)







## Template
```verilog=
module SA(clk,reset,a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16);

 parameter size=10;
 input clk,reset;
 input  [size-1:0] a1,a2,a3,a4,b1,b2,b3,b4;
 output  [2*size-1:0] c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;

//(your code)...

endmodule
```
* 模擬請用make bon
* 合成請用make bon_syn


## 備註

- Bonus 計算方式為(總成績*1.3)。
- 請不要分享 code 給**任何人**，我們嚴格執行抄襲偵測。
- Demo 時有隱藏測資，請在繳交前確認都寫好。
- 本次助教提供檔案有： `header.v`、`MO.v`、`MO_tb.v`、`memory.dat`、`ans.dat`、`makefile`、`synopsys_dc.setup`。
- 檔名錯誤一律 0 分
- 上傳錯檔案一律 0 分（記得上傳.sdf）
- coding style 請根據助教範例: https://hackmd.io/s/HJRwmu3KN
- synthesis 參閱: https://hackmd.io/s/HkllSD79E

## 繳交文件
- MO.v
- MO_syn.v
- MO.sdf
- SA.v（如果有做bonus）
- SA_syn.v（如果有做bonus）
- SA.sdf （如果有做bonus）
- report_area.txt
- report_clk.txt
- report_area_bonus.txt（如果有做bonus）
- report_clk_bonus.txt（如果有做bonus）
- lab4_你的學號_report.pdf (Example: lab4_105062371_report.pdf )：要有詳細解釋，Block Diagram、nWave result、問題討論、Bonus實作...etc.

<font color=red> **NOTE: 作業不用壓縮，直接上傳到ilms即可。**</font>

## Deadline
5/23(四) 11:59以前上傳到 iLMS，遲交一律 0 分。


