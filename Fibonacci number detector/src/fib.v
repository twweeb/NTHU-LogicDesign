module my_and_2(out, in);
	parameter n=2;
            
	input [n-1:0]in;
	output out;
	
	wire nand_0,nand_1;
	
	nand nand0(nand_0, in[0], in[1]);
	nand nand1(nand_1, in[0], in[1]);
	
	nand nand3(out, nand_0, nand_1);
	
endmodule

module my_and_3(out, in_0, in_1, in_2);
	input in_0, in_1, in_2;
	output out;
	
	wire and_0;
	
	my_and_2 and0(and_0, {in_0, in_1});
	my_and_2 and1(out, {and_0, in_2});
	
endmodule

module my_or_2(out, in_0, in_1);
	input in_0, in_1;
	output out;
	
	wire nand_0,nand_1;
	
	nand nand0(nand_0, in_0, in_0);
	nand nand1(nand_1, in_1, in_1);
	
	nand nand3(out, nand_0, nand_1);

endmodule

module my_not(out, in_0);
	input in_0;
	output out;

	nand nand0(out, in_0, in_0);

endmodule

module fib_G(in, out);
			parameter n=4;
            
            //IO port declaration
            input [n-1:0]in;
            output out;//Output can be wire or reg, default type is wire.
            
            
            wire not_a, not_b, not_c, not_d;//the default width of wire is 1-bit
            wire and0, and1, and2, and3;
            wire or0, or1;
            
            //<gate><gate name>(output,input1,input2,input3...);
            my_not not_0(not_a,in[3]);
            my_not not_1(not_b,in[2]);
            my_not not_2(not_c,in[1]);
            my_not not_3(not_d,in[0]);
            
            my_and_2 and_0(and0, {not_a, not_b});
            my_and_3 and_1(and1, not_b, not_c, not_d);
            my_and_3 and_2(and2, not_a, not_c, in[0]);
            my_and_3 and_3(and3, in[2], not_c, in[0]);
            
            my_or_2 or_0(or0, and0, and1);
            my_or_2 or_1(or1, and2, and3);
            my_or_2 or_2(out, or0, or1);

endmodule

module fib_D(in, out);
            parameter n=4;
            
            input [n-1:0]in;
            output out;
            
            /*Be careful, "!" and "~" are different in Verilog.*/
            assign out=(!in[3]&!in[2])|(!in[2]&!in[1]&!in[0])|(!in[3]&!in[1]&in[0])|(in[2]&!in[1]&in[0]);
            
    //your code here
endmodule

module fib_B(in, out);
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
                    0,1,2,3,5,8,13:begin
                        out=1'b1;
                    end
                    default:begin
                        out=1'b0;
                    end
                endcase
            end 
    //wryyyyy
endmodule
