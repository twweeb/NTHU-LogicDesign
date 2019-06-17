`define GET_N 3'b000
`define READ_Y 3'b001
`define READ_A 3'b010
`define READ_X 3'b011
`define WRITE_X 3'b100
`define INIT 3'b101

module DFF (clk, next_out, out);
    parameter n = 1;
    input clk;
    input [n-1:0] next_out;
    output reg [n-1:0] out;
    always@(posedge clk) begin
        out <= next_out;
    end
endmodule

module Final(clk, rst_n, in_data, i, j, opcode, out_data, fin);
    input clk, rst_n;
    input [19:0] in_data;
	
    output fin;
    output [2:0] opcode;
    output [19:0] i, j;
    output [19:0] out_data;
    
	wire idx, next_idx;
	wire [2:0] state, next_state, next_opcode;
	wire [19:0] sum, next_sum,n, next_n, fin_cnt, next_fin_cnt;
	wire [19:0] row, next_row, col, next_col;
	wire [19:0] rA, rY, rX, wX_col, next_rA, next_rY, next_rX, next_wX_col;
	wire [19:0] counter, next_counter;
	wire [19:0]	Psum, next_Psum;
	
	reg [2:0] next_state1;
	
	DFF	#(3)	DFF0(clk, next_state, state);
	DFF #(20)	DFF1(clk, next_sum, sum);
	DFF #(20)	DFF2(clk, next_row, row);
	DFF #(20)	DFF3(clk, next_col, col);
	DFF #(20)	DFF4(clk, next_rA, rA);
	DFF #(20)	DFF5(clk, next_rX, rX);
	DFF #(20)	DFF6(clk, next_rY, rY);
	DFF #(20)	DFF8(clk, next_n, n);
	DFF #(20)	DFF10(clk, next_counter, counter);
	DFF #(1)	DFF11(clk, next_idx, idx);
	DFF #(20)	DFF12(clk, next_wX_col, wX_col);
	DFF #(3)	DFF13(clk, next_opcode, opcode);
	DFF #(20)	DFF14(clk, next_Psum, Psum);
	DFF #(20)	DFF15(clk, next_fin_cnt, fin_cnt);
	
	
	assign next_n	= (state == `INIT)? 20'b0 : 
					  (state == `GET_N)? in_data : n;
	assign next_rA	= (state == `INIT)? 20'b0 : 
					  (state == `WRITE_X)? 20'b0 : 
					  (state == `READ_A)? in_data : rA;
	assign next_rX	= (state == `INIT)? 20'b0 : 
					  (state == `READ_Y)? 20'b0 : 
					  (state == `READ_A)? 20'b0 : 
					  (state == `READ_X)? (counter == 20'b0 || counter == 20'b1) ? 20'b0: in_data : rX;
	assign next_rY	= (state == `INIT)? 20'b0 : 
					  (state == `WRITE_X)? 20'b0 :
					  (state == `READ_Y)? in_data : rY;
	assign next_wX_col	= (state == `INIT)? 20'b0 : 
					  (state == `GET_N)? in_data - 20'b1 :
					  (state == `WRITE_X)? wX_col - 20'b1 : wX_col;
	assign next_counter = (state == `INIT)? 20'b0 : 
					  (state == `READ_Y)? 20'b0 : 
					  (state == `READ_A)? counter + 20'b1 :
					  (state == `READ_X)? (counter == (n-wX_col))? 20'b0 : counter : counter;
	assign next_row	= (state == `INIT)? 20'b0 : 
					  (state == `GET_N)? in_data - 20'b1: 
					  (state == `WRITE_X)? row - 20'b1: row;
	assign next_col = (state == `INIT)? 20'b0 : 
					  (state == `GET_N)? in_data-20'b1 : 
					  (state == `READ_X)? col + 20'b1 : 
					  (state == `WRITE_X)? wX_col - 20'b1 : col;
	assign next_idx	= (state == `INIT)? 1'b0 : 
					  (state == `READ_A)? 1'b1 :
					  (state == `READ_X)? 1'b0 : 
					  (state == `WRITE_X)? 1'b0 : idx;
	assign next_sum = (state == `INIT)? 20'b0 : 
					  (state == `READ_Y)? in_data :
					  (state == `READ_A)? sum - rX*rA: 
					  (state == `READ_X)? sum:
					  (state == `WRITE_X)? 20'b0 : sum;
	assign next_Psum = (state == `INIT)? 20'b0 :(state == `READ_X) ? rX*rA : Psum;
	assign next_fin_cnt = (state == `INIT)? 20'b0 :(state == `WRITE_X) ? fin_cnt + 20'b1 : fin_cnt;

	
	always@(*)begin
		case(state)
			`INIT: next_state1 = `GET_N;
			`GET_N: next_state1 = `READ_Y;
			`READ_Y: next_state1 = `READ_A;
			`READ_A: next_state1 = `READ_X;
			`READ_X: next_state1 = (counter == (n - wX_col))? `WRITE_X : `READ_A;
			`WRITE_X: next_state1 = `READ_Y;
			default: next_state1 = `INIT;
		endcase
	end
	

	assign next_opcode = (rst_n == 1'b0)? `GET_N : next_state1;
	assign next_state = (rst_n == 1'b0)? `INIT : next_state1;
	assign fin = (state == `READ_Y && fin_cnt == n)? 1'b1 : 1'b0;
	assign i = (state == `READ_Y || state == `READ_X) ? col : (idx == 1'b0) ? row : col;
	assign j = col;
	assign out_data = sum - rX*rA;
endmodule