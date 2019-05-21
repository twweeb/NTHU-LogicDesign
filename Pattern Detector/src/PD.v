`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define INIT 4'b1110
`define FINI 4'b1111

module DFF (clk, init_out, next_out, out, rst_n);
	parameter n = 1;
	input clk,rst_n;
	input [n-1:0] next_out,init_out;
	output reg [n-1:0] out;
	always@(posedge clk, negedge rst_n) begin
		if(rst_n==0)begin
			out <= init_out;
		end
		else begin
			out <= next_out;
		end
	end
endmodule

module PD(clk, rst_n, data, flag, addr, fin);
	input clk;
	input rst_n;
	input [9:0]data;
	output reg flag;
	output [9:0]addr;
	output fin;
	
	reg [9:0]length;
	wire [9:0]next_addr;
	wire [3:0]state,next_state;
	reg [3:0]next_state1, init_state;

	DFF #(4) DFF1(clk, `INIT, next_state, state, rst_n);
	DFF #(10) DFF2(clk, 10'd1023 ,next_addr, addr, rst_n);

    assign next_addr = (state == `INIT)? 1'b0 : addr+1;
	assign fin = (state == 	`FINI) ? 1'b1 : 1'b0;
	assign next_state = (addr == length)? `FINI : next_state1;

	always @(*)
	begin
		case(state)
			`INIT:begin
				next_state1 = `S0;
				length = data;
				flag = 1'b0;
			end
			
			`FINI:begin
				next_state1 = `FINI;
				flag = 1'b0;
			end

			`S0:begin
				next_state1 = (data[0]==1)? `S1 : `S0;
				flag = 1'b0;
			end
	
			`S1:begin
				next_state1 = (data[0]==1)? `S2 : `S0;
				flag = 1'b0;
			end
	
			`S2:begin
				next_state1 = (data[0]==1)? `S2 : `S3;
				flag = 1'b0;
			end
	
			`S3:begin
				next_state1 = (data[0]==1)? `S1 : `S4;
				flag = 1'b0;
			end
	
			`S4:begin
				next_state1 = (data[0]==1)? `S5 : `S0;
				flag = 1'b0;
			end
	
			`S5:begin
				next_state1 = (data[0]==1)? `S2 : `S6;
				flag = 1'b0;
			end
	
			`S6:begin
				next_state1 = (data[0]==1)? `S7 : `S4;
				flag = 1'b0;
			end
	
			`S7:begin
				next_state1 = (data[0]==1)? `S2 : `S8;
				flag = (data[0] == 1) ? 1'b0 : 1'b1;
			end
			
			`S8:begin
				next_state1 = (data[0]==1)? `S1 : `S0;
				flag = 1'b0;
			end
			
			default:begin
				next_state1 = `INIT;
				flag = 1'b0;
			end
	 	endcase
	end
endmodule