`timescale 1ns/1ps

module AM(A, B, Sel, Out, Ovf);
	input [3:0] A;
	input [3:0] B;
	input [3:0] Sel;
	output reg [15:0] Out;
	output reg Ovf;

	wire [2:0]out1;
	wire [3:0]out2,out4,out5,out6,out7,out8;
	wire [7:0]out9;
	wire [15:0]out3;
	wire ovf1,ovf2,ovf3;
	Priority_Encoder	pri(out1, A, B);
	Decoder_2_to_4		dec2(out2, A[3], B[3]);
	Decoder_4_to_16		dec4(out3, A[3:2], B[3:2]);
	Select_Large		Lar(out4, A, B);
	Select_Small		Sma(out5, A, B);
	Adder				add(out6, ovf1, A, B);
	Subtractor			sub(out7, ovf2, A, B);
	Abs_Subtractor		abs(out8, ovf3, A, B);
	Multiplier			mul(out9, A, B);
	
	//Decoder_2_to_4 zxc(A, B,Out)
	always@(*)begin
	case(Sel)
		0: begin // Priority Encoder
			Out = {13'b0,out1};
			Ovf = 1'b0;
		end
		
		1: begin // A&B
			Out = {12'b0,A&B};
			Ovf = 1'b0;
		end
		
		2: begin // A^B
			Out = {12'b0,A^B};
			Ovf = 1'b0;
		end
		
		3: begin // A*B
			Out = {8'b0,{{4{A[3]}},A}*{{4{B[3]}},B}};
			Ovf = 1'b0;
		end
		
		4: begin // A>>>1’b1
			Out = {12'b0,{A>>>1'b1}};
			Ovf = 1'b0;
		end
		
		5: begin // A<<<1’b1
			Out = {12'b0,{A<<<1'b1}};
			Ovf = 1'b0;
		end
		
		6: begin // A>>1’b1
			Out = {12'b0,{A>>1'b1}};
			Ovf = 1'b0;
		end

		7: begin // A<<1’b1
			Out = {12'b0,{A<<1'b1}};
			Ovf = 1'b0;
		end

		8: begin // 2-to-4 decoder
			Out = {12'b0,out2};
			Ovf = 1'b0;
		end
		
		9: begin // 4-to-16 decoder
			Out = out3;
			Ovf = 1'b0;
		end
		
		10: begin // select the larger number
			Out = {12'b0,out4};
			Ovf = 1'b0;
		end
		
		11: begin // select the smaller number
			Out = {12'b0,out5};
			Ovf = 1'b0;
		end
		
		12: begin // A+B
			Out = (ovf1)? {{12{!out6[3]}},out6} : {{12{out6[3]}},out6};
			Ovf = ovf1;
		end
		
		13: begin // A-B
			Out = (ovf2)? {{12{!out7[3]}},out7} : {{12{out7[3]}},out7};
			Ovf = ovf2;
		end
		
		14: begin // |A-B|
			Out = {12'b0,out8};
			Ovf = ovf3;
		end
		
		15: begin // A*B
			Out = {{8{out9[7]}},out9};
			Ovf = 1'b0;
		end

	endcase
	end

endmodule

module Priority_Encoder(out, a, b); // input with higher priority will take place
	input wire [3:0]a,b;
	output [2:0]out;
	
	wire [7:0]ab;
	assign ab = {a[3:0],b[3:0]};
	
	assign out = (ab[7] == 1'b1) ? 3'b111:
				 (ab[6] == 1'b1) ? 3'b110:
				 (ab[5] == 1'b1) ? 3'b101:
				 (ab[4] == 1'b1) ? 3'b100:
				 (ab[3] == 1'b1) ? 3'b011:
				 (ab[2] == 1'b1) ? 3'b010:
				 (ab[1] == 1'b1) ? 3'b001: 3'b000;
endmodule

module Decoder_2_to_4(out, a, b);// Only gate level
	input a,b;
	output [3:0] out;
	  
	wire not_a, not_b;
	
	not (not_a, a),(not_b, b);
	and (out[3],a,b),(out[2],a,not_b),(out[1],not_a,b),(out[0],not_a,not_b);
endmodule

module Decoder_4_to_16(out, a, b);// Only gate level
	input [1:0]a,b;
	output [15:0] out;
	
	wire [3:0]x,y;
	
	Decoder_2_to_4 dec1(x, a[1], a[0]);
	Decoder_2_to_4 dec2(y, b[1], b[0]);
	
	and (out[0],x[0],y[0]),(out[1],x[0],y[1]),(out[2],x[0],y[2]),
		(out[3],x[0],y[3]),and4(out[4],x[1],y[0]),(out[5],x[1],y[1]),
		(out[6],x[1],y[2]),(out[7],x[1],y[3]),(out[8],x[2],y[0]),
		(out[9],x[2],y[1]),(out[10],x[2],y[2]),(out[11],x[2],y[3]),
		(out[12],x[3],y[0]),(out[13],x[3],y[1]),(out[14],x[3],y[2]),
		(out[15],x[3],y[3]);
endmodule

module bitslice(out, pa, pb, a, b);
	input pa,pb,a,b;
	output [1:0]out;
	
	wire not_a, not_b, not_pa, not_pb, or_a, or_b;
	
	not (not_pa,pa),(not_pb,pb);
	or (or_a, a, pa),(or_b, b, pb);
	and (out[1], or_a, not_pb),(out[0], or_b, not_pa);
endmodule

module Select_Large(out, a, b);// Design bit slice
	input [3:0] a,b;
	output [3:0] out;
	
	wire [1:0]nab0,nab1,nab2,nab3,nab4;
	assign nab4 = 2'b0;
	bitslice b_3(nab3, nab4[1], nab4[0], a[3], b[3]);
	bitslice b_2(nab2, nab3[1], nab3[0], a[2], b[2]);
	bitslice b_1(nab1, nab2[1], nab2[0], a[1], b[1]);
	bitslice b_0(nab0, nab1[1], nab1[0], a[0], b[0]);
	
	assign out = (nab0[1]) ? a : b;
endmodule

module Select_Small(out, a, b);// Design bit slice
	input [3:0] a,b;
	output [3:0] out;
	
	wire [1:0]nab0,nab1,nab2,nab3,nab4;
	assign nab4 = 2'b0;
	bitslice b_3(nab3, nab4[1], nab4[0], a[3], b[3]);
	bitslice b_2(nab2, nab3[1], nab3[0], a[2], b[2]);
	bitslice b_1(nab1, nab2[1], nab2[0], a[1], b[1]);
	bitslice b_0(nab0, nab1[1], nab1[0], a[0], b[0]);
	
	assign out = (!nab0[1]) ? a : b;
endmodule

module Bit_Adder(cout, s, a, b, cin);// Design bit slice
	input a,b,cin;
	output cout,s;
	
	wire and0,and1,and2;
	xor (s,a,b,cin); // ODD function
	
	and (and0,a,b),(and1,b,cin),(and2,a,cin);
	or  (cout,and0,and1,and2);
endmodule

module Adder(out, ovf, a, b);// Design bit slice
	input [3:0] a,b;
	output [3:0] out;
	output ovf;
	
	wire [3:0]cout,c,d;
	
	Bit_Adder ad3(cout[0], out[0], a[0], b[0], 1'b0);
	Bit_Adder ad2(cout[1], out[1], a[1], b[1], cout[0]);
	Bit_Adder ad1(cout[2], out[2], a[2], b[2], cout[1]);
	Bit_Adder ad0(cout[3], out[3], a[3], b[3], cout[2]);
	
	xor (ovf, cout[3], cout[2]);
	//(a[3]!=b[3]) ? 1'b0 : (a[3]!=out[3]) ? 1'b1 : 1'b0;
endmodule

module Subtractor(out, ovf, a, b);// Reuse adder
	input [3:0] a,b;
	output [3:0] out;
	output ovf;
	
	wire [3:0]b2;
	assign b2[3:0] = (~b[3:0]+ 1'b1);
	Adder add(out, ovf, a, b2);
endmodule

module Abs_Subtractor(out, ovf, a, b);// Reuse Subtractor
	input [3:0] a,b;
	output [3:0] out;
	output ovf;
	
	wire [3:0] tmp;
	
	Subtractor sub(tmp, ovf, a, b);
	assign out = (tmp[3]) ? (~tmp[3:0]+ 1'b1) : tmp;
	
endmodule

module Multiplier(out, a, b);// Only gate level
	input [3:0] a,b;
	output [7:0] out;
	
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,
		 d1,d2,d3,d4,d5,d6,d7,
		 e1,e2,e3,e4,e5,e6,e7,
		 f1,f2,f3,f4;
	
	and	(c1,b[3],a[1]),	(c2,b[2],a[2]),	(c3,b[1],a[3]),
		(c4,b[3],a[0]),	(c5,b[2],a[1]),	(c6,b[1],a[2]),
		(c7,b[2],a[0]),	(c8,b[1],a[1]),	(c9,b[0],a[2]),
		(c10,b[1],a[0]),(c11,b[0],a[1]),(out[0],b[0],a[0]),
		(c12,b[2],a[3]),(c13,b[3],a[2]),(c14,b[0],a[3]),
		(f1,b[3],a[3]);

	Bit_Adder bitAdder0(d1,d2,c1,c2,c3);
	Bit_Adder bitAdder1(d3,d4,c4,c5,c6);
	Bit_Adder bitAdder2(d5,d6,c7,c8,c9);
	Bit_Adder bitAdder3(d7,out[1],c10,c11,1'b0);
	
	Bit_Adder bitAdder4(e1,e2,c12,c13,d1);
	Bit_Adder bitAdder5(e3,e4,d2,d3,e5);
	Bit_Adder bitAdder6(e5,e6,d4,c14,d5);
	Bit_Adder bitAdder7(e7,out[2],d6,d7,1'b0);
	Bit_Adder bitAdder8(out[7],out[6],f1,e1,f2); 
	 
	Bit_Adder bitAdder9(f2,out[5],e2,e3,f3);
	Bit_Adder bitAdder10(f3,out[4],e4,1'b0,f4);
	Bit_Adder bitAdder11(f4,out[3],e6,e7,1'b0);
endmodule