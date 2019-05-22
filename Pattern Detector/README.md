# Lab3 Pattern Detector
[Toc]

## Concept
* 這次的作業我們要來設計一個bit pattern偵測器，而我們偵測的pattern如下所示：
<p style="font-size:300%;text-align:center">110(010)<sup>+</sup>10</p> 

* <font color = red> 注意中間的010是可以重複的</font>
* Here are some examples the give a better idea of the pattern we are detecting.
    * 11001010   ->correct
    * 110010010 ->not correct
    * 110010 ->not correct, 在pattern的尾端應該要有10
    * 01001001010 ->not correct, 在pattern的開頭應該要有110

## Overview & Signal Explanations
![](https://i.imgur.com/j5EGPkb.png)
### input
| name | width | function |
| --- | --- | --- |
| clk | 1-bit | clock signal |
| rst_n | 1-bit | 當rst_n = 0的時候，reset detector並從下個cycle 開始進行運算 |
| data | 10-bit | 從ROM讀出來的訊號，我們的bit pattern會放在 data[0]|

### output
| name | width | function |
| --- | --- | --- |
|flag | 1-bit | 當我們讀取到一個pattern的尾端的cycle拉成1 |
|addr | 10-bit | 控制我們要從ROM裡面的哪個位置讀取值，<font color = red> 有效資料的長度會放在 addr = 1023|
| fin | 1-bit | 當運算結束（偵測完有效資料之後）設成 1 </font> |

* <font color = red> 請不要更動template中的input, ouput port name, 否則會造成同學的module無法使用。</font>
## Memory
* 首先先解釋ROM跟PD的關係，PD的addr會傳給ROM，ROM接著就會在negative edge 的時候把存放在addr這個位置的資料回傳給PD作為data，如下圖
![](https://i.imgur.com/uVzgObO.png)


* 這次的測資會從ROM讀取出來，ROM會根據module 所輸出的addr在negative edge把那個位置的資料(10-bits)輸出給你。而我們所要偵測的bit pattern的那個bit會放在data[0]。
* <font color = red>我們所要偵測的pattern長度會存放在addr = 1023的地方</font>，同學取得長度之後，只要從addr = 0開始往下偵測 data[0]即可，也可以觀察info.dat 以及 PD_tb.v 來更了解運作。
## Correct simulation result
![](https://i.imgur.com/Vyu0Qs3.png)

必須get到6個flag且accpeted否則就是程式碼有誤

## Tutorials & Tools(<font color = red>**IMPORTANT**</font>)

* [nWave Tutorial](https://hackmd.io/s/HkTX3I75V)

* [Design Vision Synthesis Tool (Sequential)](https://hackmd.io/s/HkllSD79E)

* [Sequential Circuit Tutorial](https://hackmd.io/s/HJRwmu3KN)
  
  5. <font color = red>SUBMIT YOUR WORK ON TIME</font> and do not copy other's work.

# Lab3 Bonus Luxury Pattern Detector
## Block Diagram
![](https://i.imgur.com/QUezjDS.png)


## Concept
根據lab3的module作延伸，不過增加以下規則

1. 在每次pattern結尾flag=1的時候，把中間010的重複次數已count輸出並維持一個cycle。

2. 在偵測的時候如果出現111的pattern的之後即使出現我們所要偵測的pattern，flag也不會被拉起，也不會輸出count。在停止偵測的情況下當出現第二次111的時候pattern detector就會恢復正常運作。<font color = red>一個測資裡面有可能會有多次的停止偵測與開始偵測。而且在恢復正常運作之後得要出現完整的pattern才能再次把flag拉為一</font>。

3. 最後就是在fin拉起等於1的時候，我們要把偵測到的總pattern數量以count輸出（在停止偵測狀態下的pattern不算）。

4. <font color = red>測資中flag 跟 fin 不會同時被拉起的情況。</font>

5. <font color = red>必須完整的偵測到一次111才會trigger停止或開始偵測（1111只算trigger一次，111111才會trigger兩次。</font>

## Template

```verilog= 
module LPD(clk, data, rst_n, flag, addr, fin, count);
    input clk;
    input [9:0] data;
    input rst_n;
    output flag;
    output [9:0] addr;
    output fin;
    output [3:0] count;
    //your code
endmodule
```
## File Provided By TAs

1. header.v：裡面有timescale specification

2. PD.v：同學的電路實作模版

3. PD_tb.v：testbench

4. info.dat：測資，到時候demo的時候會以隱藏測資來測試同學的電路

5. LPD.v

6. LPD_tb.v

7. info_bonus.dat 

8. synopsys_dc.setup：design vision setup file.

## File You Should Submit

1. PD.v

2. PD_syn.v

3. PD.sdf

4. LPD.v

5. LPD_syn.v

6. LPD.sdf 

4. report_area.txt

5. report_clk.txt

6. report_area_bonus.txt

7. report_clk_bonus.txt  

8. lab3_你的學號_report.pdf (Example: lab3_105062371_report.pdf )：要有詳細解釋，Block Diagram, nWave result, 問題討論, Bonus實作.....etc.

<font color = red> 作業不用壓縮，直接上傳到ilms即可</font>

## Requirement
1. 所有的DFFs都必須是positive edge triggered.

2. 請同學們務必跟從教材裡便以及課本中的形式來進行實作，否則不予給分

3. 請同學務必按照助教給的方法壓縮檔案，並注意檔名是否正確，以免影響成績。

4. Demo的時候會驗證同學的PD_syn.v檔，並以此跑出來的結果為評分標準。

5. 用define語法來命名各個state

6. 實作出DFF module 並且在主要module中直接呼叫

7. reset請在主要module中實作 不可以直接在DFF module 裡面進行 reset

## DEADLINE
<font color = red>**2019/5/2(Thurs) 11:59 A.M.**</font>
不接受遲交以及補交，請同學提早繳交。






# [Homepage](/QlFRj1cASdaBed8r3k-6iQ)