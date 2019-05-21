# Lab1 Fibonacci number detector


![](https://i.imgur.com/KHEAuD2.png)


這次lab我們要練習電路的三種描述方式，首先助教會先示範如何偵測在0~15的範圍內的<font color="blue">數列</font>(0,1,5,7)，再來會讓同學自行練習Fibonacci number 。

## 範例
1.概念圖
![](https://i.imgur.com/1N2kK0u.png)


2.電路圖
![](https://i.imgur.com/5o1DHWQ.png)


3.k-map
![](https://i.imgur.com/9vZPuXQ.png)


4.code
* Gate description
```verilog
    //=================Gate description=============//
    
    module Zawarudo_G(in,out);
            parameter n=4;
            
            //IO port declaration
            input [n-1:0]in;
            output out;//Output can be wire or reg, default type is wire.
            
            
            wire not_a, not_b, not_c;//the default width of wire is 1-bit
            wire and0,and1,and2;
            
            //<gate><gate name>(output,input1,input2,input3...);
            not not_0(not_a,in[3]);
            not not_1(not_b,in[2]);
            not not_2(not_c,in[1]);
            
            and and_0(and0,not_a,not_b,not_c);
            and and_1(and1,not_a,not_c,in[0]);
            and and_2(and2,not_a,in[2],in[0]);
            
            or or_0(out,and0,and1,and2);
            
        endmodule
```
* Data flow description
```verilog
        //=================Data flow description=============//
        module Zawarudo_D(in,out);
            parameter n=4;
            
            input [n-1:0]in;
            output out;
            
            /*Be careful, "!" and "~" are different in Verilog.*/
            assign out=(!in[3]&!in[2]&!in[1])|(!in[3]&!in[1]&in[0])|(!in[3]&in[2]&in[0]);
            
        endmodule 
```
* Behavior description
```verilog
        //=================Behavior description=============//
        module Zawarudo_B(in,out);
            parameter n=4;
            
            input [n-1:0]in;
            output out;//Be careful the default type is wire!!
            reg out;//It must be changed to reg type because of using in always block.
            
            /*
            or you can combine these two line into 
            output reg out;
            */
            
            always@(*)begin
                case(in)
                    0,1,5,7:begin
                        out=1'b1;
                    end
                    default:begin
                        out=1'b0;
                    end
                endcase
            end
            
            /*
            or can write as
            always@(*)begin
                out=1'b0;
                case(in)
                    5,7,14,15:begin
                        out=1'b1;
                    end
                endcase
            end
            */
            
        endmodule
```
* testbench
```verilog
    module Zawarudo_tb;
        parameter delay=5;

        wire out_G,out_D,out_B;
        reg [3:0]in;
        integer i;



        initial begin
            //Give initial value.
            in=0;
            for(i=0;i<16;i=i+1)begin
                #delay
                
                if((out_G!=out_D)||(out_D!=out_B)||
                    ((in==0||in==1||in==5||in==7)&&(out_G&out_D&out_B)==0)||
                    ((in!=0&&in!=1&&in!=5&&in!=7)&&(out_G|out_D|out_B)==1))
                begin
                    $display("-----------wrong answer!!------------\n");
                    $display("time=%4d,in=%b,out_G=%b,out_D=%b,out_B=%b",$time,in,out_G,out_D,out_B);
                    $display("-----------------------\n");
                    $finish;//program end here
                end
                $display("time=%4d,in=%b,out_G=%b,out_D=%b,out_B=%b",$time,in,out_G,out_D,out_B);
                in=in+1;
            end
            $display("All pass!! subarashii ");
            $finish;//program end here
        end

        Zawarudo_G gate
        (
            .in(in),
            .out(out_G)
        );
        Zawarudo_D DF
        (
            .in(in),
            .out(out_D)
        );
        Zawarudo_B BH
        (
            .in(in),
            .out(out_B)
        );

    endmodule
```



5.工作站呈現
* ___Correct answer___
![](https://i.imgur.com/cJxWZIU.png)
* ___Something wrong in your code___
![](https://i.imgur.com/T0qCi9T.png)



接下來就要換同學動手做嚕(ﾟ∀ﾟ)(ﾟ∀ﾟ)(ﾟ∀ﾟ)
不過我們會要你們做一點改變，那就是你們的gate level只能用nand gate來實作
<font color="red">不能用and,or,nor......等其他邏輯閘</font>

如果還不會的話，下面這網站會教你們如何用nand gate實作出其他gate
[Nand gate補充](https://market.cloud.edu.tw/content/vocation/control/tp_nh/logic/ch6/p3.htm)

---

:::info
#### 助教會提供testbench供同學做測試，等到lab1發佈請去ilms下載
:::


## Spec

<font color=red>2/25 18:20 更新spec</font>
```verilog
module fib_G(in, out);
    input [3:0]in;
    output out;
    
    //your code here
endmodule

module fib_D(in, out);
    input [3:0]in;
    output out;
    
    //your code here
endmodule

module fib_B(in, out);
    input [3:0]in;
    output out;
    
    //wryyyyy
endmodule
```
## ___Requirements:___
<font color=red>Caution!</font> <font color=blue>Requirements要求甚麼格式就一定要做到，不然會直接零分喔。</font>

 **去年助教的血淚史**((／‵Д′)／~ ╧╧
 ![](https://i.imgur.com/mgY3obz.png)


* 請使用以下三種方式，描述 4-bit Fibonacci number detector 電路(0, 1, 2, 3, 5, 8, 13)，並且module name和in/output都要符合上面<font color=red>spec</font>的格式。
    *  Gate Level Description(__需要化到最簡型態，<font color=red>並且只能用nand gate</font>__)
        * module name: fib_G
        - input name: in
        - output name: out

    * Dataflow Description(__需要化到最簡型態__)
        * module name: fib_D
        - in/output name同上
    * Behavior Description
        * module name: fib_B
        - in/output name同上
    <font color=red> 請將上述三種描述分三個 module 撰寫於 fib.v 檔  </font> 
    
    <font color=red>請注意！！ K-Map 化簡時，請考慮 Hazard-Free</font>
    



## __繳交文件:__

* fib.v
* fib_tb.v
* lab1_你的學號_report.pdf (Example: ___lab1_105062371_report.pdf___ )
    * k-map, 電路圖, 模擬結果, 遇到的問題與解決方法, 想問助教的問題等。

請把所有檔案打包成<font color="red">.zip</font>壓縮檔，(<font color="red">不接受.rar，report也只接受.pdf，去年很多人沒注意直接GG，包括我</font>)，上傳到iLMS作業區
(Example: ___lab1_105062371.zip___ )
## Deadline
:::danger
   ___3/11(一) 11:59以前上傳到 ilms，沒有屍體分數，遲交一律 0分___
:::

![](https://i.imgur.com/3L1dsRu.jpg)

# [Homepage](https://hackmd.io/s/HJdaLPTQV)

