module PE(clk,reset,in_a,in_b,out_a,out_b,out_c);
	parameter size=10;
	input wire reset,clk;
	input wire [size-1:0] in_a,in_b;
	output reg [2*size-1:0] out_c;
	output reg [size-1:0] out_a,out_b;

	always @(posedge clk)begin
		if(reset) begin
			out_a=0;
			out_b=0;
			out_c=0;
		end
		else begin  
			out_c=out_c+in_a*in_b;
			out_a=in_a;
			out_b=in_b;
		end
	end
endmodule

module SA(clk,reset,a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16);

	parameter size=10;
	input clk,reset;
	input  [size-1:0] a1,a2,a3,a4,b1,b2,b3,b4;
	output  [2*size-1:0] c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;

	wire [size-1:0] p00,p01,p02,p10,p11,p12,p20,p21,p22,p30,p31,p32,q00,q01,q02,q03,q10,q11,q12,q13,q20,q21,q22,q23;

	PE pe1 (.clk(clk), .reset(reset), .in_a(a1),	.in_b(b1), 	.out_a(p00),.out_b(q00),.out_c(c1) );
	PE pe2 (.clk(clk), .reset(reset), .in_a(p00),	.in_b(b2), 	.out_a(p01),.out_b(q01),.out_c(c2) );
	PE pe3 (.clk(clk), .reset(reset), .in_a(p01),	.in_b(b3), 	.out_a(p02),.out_b(q02),.out_c(c3) );
	PE pe4 (.clk(clk), .reset(reset), .in_a(p02),	.in_b(b4), 	.out_a(),	.out_b(q03),.out_c(c4) );

	PE pe5 (.clk(clk), .reset(reset), .in_a(a2),	.in_b(q00),	.out_a(p10),.out_b(q10),.out_c(c5) );
	PE pe6 (.clk(clk), .reset(reset), .in_a(p10),	.in_b(q01),	.out_a(p11),.out_b(q11),.out_c(c6) );
	PE pe7 (.clk(clk), .reset(reset), .in_a(p11),	.in_b(q02),	.out_a(p12),.out_b(q12),.out_c(c7) );
	PE pe8 (.clk(clk), .reset(reset), .in_a(p12),	.in_b(q03),	.out_a(),	.out_b(q13),.out_c(c8) );

	PE pe9 	(.clk(clk), .reset(reset), .in_a(a3),	.in_b(q10),	.out_a(p20),.out_b(q20),.out_c(c9) );
	PE pe10 (.clk(clk), .reset(reset), .in_a(p20),	.in_b(q11),	.out_a(p21),.out_b(q21),.out_c(c10));
	PE pe11 (.clk(clk), .reset(reset), .in_a(p21),	.in_b(q12),	.out_a(p22),.out_b(q22),.out_c(c11));
	PE pe12 (.clk(clk), .reset(reset), .in_a(p22),	.in_b(q13),	.out_a(),	.out_b(q23),.out_c(c12));

	PE pe13 (.clk(clk), .reset(reset), .in_a(a4),	.in_b(q20),	.out_a(p30),.out_b(),	.out_c(c13));
	PE pe14 (.clk(clk), .reset(reset), .in_a(p30),	.in_b(q21),	.out_a(p31),.out_b(),	.out_c(c14));
	PE pe15 (.clk(clk), .reset(reset), .in_a(p31),	.in_b(q22),	.out_a(p32),.out_b(),	.out_c(c15));
	PE pe16 (.clk(clk), .reset(reset), .in_a(p32),	.in_b(q23),	.out_a(),	.out_b(),	.out_c(c16));
endmodule

