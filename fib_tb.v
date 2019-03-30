module fib_tb;
        parameter delay=5;

        wire out_G,out_D,out_B;
        reg [3:0]in;
        integer i;



        initial begin
            //Give initial value.
            in=0;
            for(i=0;i<16;i=i+1)begin
                #delay
                //(0, 1, 2, 3, 5, 8, 13)
                if((out_G!=out_D)||(out_D!=out_B)||
                    ((in==0||in==1||in==2||in==3||in==5||in==8||in==13)&&(out_G&out_D&out_B)==0)||
                    ((in!=0&&in!=1&&in!=2&&in!=3&&in!=5&&in!=8&&in!=13)&&(out_G|out_D|out_B)==1))
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

        fib_G gate
        (
            .in(in),
            .out(out_G)
        );
        fib_D DF
        (
            .in(in),
            .out(out_D)
        );
        fib_B BH
        (
            .in(in),
            .out(out_B)
        );

    endmodule