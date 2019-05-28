# Stack Machine

## 前言
這次的lab同學們要實作出一個支援加法，減法，以及乘法的Stack Machine，根據送入的instruction，輸出正確的ouput，底下將介紹stack machine的運作方式。

## Stack Machine 介紹
不同於一般使用register file來暫存資料的處理器。Stack Machine是一種更簡單，更精簡的處理器。顧名思義，是利用一個**Last in First out**(LIFO或者是資料結構中所謂的stack)的記憶體來暫存資料。
### Stack 介紹
相信有修程式設計二的同學都對stack不會太陌生，一般的stack有以下的特色以及功能：
1. Top: 一個指向Stack頂端資料的指標（為了verilog實作的方便，top可以**想成一個counter用來記錄Stack頂端的資料是第幾個資料**）
3. Push：**也就是把資料加到Stack的頂端**，並移動top，如下圖所示：
    ![](https://i.imgur.com/1CHxf5X.jpg)
3. Pop: **移除Stack最頂端的資料**，如下圖所示：
    ![](https://i.imgur.com/pbnuIrJ.jpg)

### 運作功能介紹
這次要同學們實作的Stack Machine要能支援以下的instruction:
1. push [constant] :將一個常數push到stack memory中


2. add: 把stack memory中最上面的兩個值pop出來進行相加，並且把兩數的和push回到stack memory中


3. sub: 把stack memory中最上面的兩個值pop出來，把pop出來的第一個值減調第二個值之後，把兩個數值的差push回去stack memory中


4. multiply: 把stack memory中最上面得兩個值pop出來進行相乘，接著把兩數的積push回stack memory中

5. fin: 把stack memory中最上面也是唯一的值pop出來，代表instruction結束
### 運作範例
* 考慮底下這一系列instruction:
```verilog=
push 10
push 20
push 10
mul
push 1
sub
```
接著我們用圖例step through上面這一系列instruction的執行

---

1. initial: 一開始的stack memory是空的

![](https://i.imgur.com/QDMBAST.png)

2. push 20

![](https://i.imgur.com/F5fQy4L.png)


3. push 10

![](https://i.imgur.com/Npcnexb.png)


4. mul
    
![](https://i.imgur.com/mGTagif.png)
    
![](https://i.imgur.com/pamSaI8.png)

![](https://i.imgur.com/qMxxE0W.png)

5. push 1

![](https://i.imgur.com/Tm7EumC.png)

6. sub

![](https://i.imgur.com/Fv88tYK.png)

![](https://i.imgur.com/IJFlSS8.png)

![](https://i.imgur.com/UjzoIA2.png)


## Overview

![](https://i.imgur.com/elA1GwB.png)

## Signals
### TestBench and SM Interaction Interface
**Input Signals**

| name   | size | 功能                  |
| ------ | ---- | ----------------     |
| clk    | 1    | 時間訊號              |
| rst_n  | 1    | rst_n = 0時進行reset  |
| instr  | 13   | instruction          |

**Output Signals**

| name    | size | 功能                  |
| ------- | ---- | -------------------- |
| pc       | 10   |instruction address，instruction的總長度放在pc = 1023的位置|
| err_code | 3  | 錯誤訊息 |
| d_valid  | 1    | 當輸出的資料為add, sub, mul,或是fin的最終結果時把d_valid拉起|
| out_data | 20   | 輸出的資料 |
| fin | 1 | 當處理完所有的instruction之後拉成1|

### SM and SM_MEM Interaction Interface
<font color = red>底下的input/output是從SM的視角來看</font>
| name   | size | 功能                  | I/O |
| ------ | ---- | ----------------     |-----|
| cntrl   | 2   | 控制stack memory的功能 |  output |
| w_data | 20   | 要寫入stack memory的資料 | output |
| r_data | 20   | 從stack memroy讀出來的資料 | input | 
| full | 1 | 當stack memory 滿的時候拉為一 | input |
| empty | 1 | 當stack memory 是空的時候拉為一 | input |

:::danger
w_data, r_data, instr[9:0], out_data 均為signed number並且保證運算不會有overflow的出現
:::

:::danger
stack memory中最多只能存放8個數字
:::
### cntrl 信號解釋

| cntrl   | function |
| ------ | ---- |
| 00     | no operation |
| 01    | push |
| 10    | pop |

### instr 信號解釋
* instr[12:10] 為指令型別，不同指令的encoding如下

| instr[12:10]   | function |
| ------ | ---- |
| 000     | push |
| 001    | add |
| 010    | sub |
| 011    | mul |
:::warning
在每個add/sub/mul instruction都要輸出運算的結果（記得在算完輸出的時候把d_valid設成一喔）
:::

* instr[9:0] 為push指令要push到stack memory上的值，<font color = blue>當指令為add, sub, mul的時候，instr[9:0] = 10'd0</font>
* 範例
    考慮以下範例指令
    ```
    push 4 
    push -4 
    add 
    push 5 
    sub
    ```
    以二進位編碼之後會變成
    ```
    000_0000000100 // push 4
    000_1111111100 // push -4
    001_0000000000 // add
    000_0000000101 // push 5
    010_0000000000 // sub
    ```
:::success
非bonus的測資裡面保證不會有error，同學直接輸出err_code = 000即可
:::
## Template
```verilog=
module SM(clk, rst_n, instr, pc, d_valid, out_data, err_code, fin);
    input clk;
    input rst_n;
    input [12:0] instr;
    output [9:0] pc;
    output d_valid;
    output [19:0] out_data;
    output [2:0] err_code;
    output fin;
    // your code here, remember to instantiate your SM_Mem  
endmodule
module SM_Mem(clk, rst_n, cntrl, w_data, r_data, full, empty);
    input clk;
    input rst_n;
    input [1:0] cntrl;
    input [19:0] w_data;
    output [19:0] r_data;
    output full;
    output empty;
    // your code
    
    
endmodule
```
## Requirment

1. Stack 最多只能裝8筆資料
2. reset 的時候把stack memory清空（top = 0)
3. testbench只有在d_valid=1時才會檢查data_out以及err_code的正確性。
4. 一組instruction的長度放在 pc = 1023的位置，instructions會從pc = 0 開始（很像lab3)
5. add/sub/mul 會需要多個cycle來完成，在計算完運算結果之後把d_valid設成1並且在out_data輸出運算結果

6. 必須按照助教給的模板實作出SM_MEM, SM並且在SM中呼叫SM_MEM<font color = red>否則以零分計算</font>
7. 必須follow lab3 lab4的coding style，<font color = red>否則以零分計算</font>


## Files Provided by TA
* header.v：裡面有timescale specification

* SM.v：同學的電路實作模版

* SM_tb.v：testbench

* info.dat：測資，到時候demo的時候會以隱藏測資來測試同學的電路

* makefile

* synopsys_dc.setup：design vision setup file.

## Files You Should Submit

* SM.v

* SM_syn.v

* SM.sdf

* report_area.txt

* report_clk.txt

* **lab5_你的學號_report.pdf(Example: lab3_105062371_report.pdf )：要有詳細解釋，Block Diagram, nWave result, 問題討論, Bonus實作, State Transition Graph…etc.**

<font color = red> **作業不用壓縮，請注意檔名是否正確**</font>

## Deadline

<font color = red> **6/13 Thur. 中午11:59**
不接受遲交，補交
請同學提早開始做</font>
