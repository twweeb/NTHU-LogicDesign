`define INIT	3'b111
`define GET_N	3'b000
`define GET_R	3'b001
`define READ_A	3'b010
`define READ_X	3'b011
`define READ_B	3'b100
`define WRITE_Y	3'b101

module DFF (clk, next_out, out);
    parameter n = 1;
    input clk;
    input [n-1:0] next_out;
    output reg [n-1:0] out;
    always@(posedge clk) begin
        out <= next_out;
    end
endmodule

module MO(clk, reset, in_data, i, j, opcode, out_data, fin);
	input clk, reset;
	input [9:0] in_data;
	output fin;
	output [2:0] opcode;
	output [9:0] i, j;
	output [19:0] out_data;
	
	wire [2:0]	state, next_state;
	wire [19:0]	sum, next_sum;
	wire [9:0]	row, next_row, col, next_col;
	wire [9:0]	rA, rX, rB, next_rA, next_rX, next_rB;
	wire [9:0]	m_n, m_r, next_m_n, next_m_r;
	wire [9:0]	counter, next_counter;
	wire 		idx, next_idx;
	wire [9:0]	X_col, next_X_col;
	wire [19:0]	rP, next_rP;
	
	reg  [9:0] next_state1;
	
	DFF	#(3)	DFF0(clk, next_state, state);
	DFF #(20)	DFF1(clk, next_sum, sum);
	DFF #(10)	DFF2(clk, next_row, row);
	DFF #(10)	DFF3(clk, next_col, col);
	DFF #(10)	DFF4(clk, next_rA, rA);
	DFF #(10)	DFF5(clk, next_rX, rX);
	DFF #(10)	DFF6(clk, next_rB, rB);
	DFF #(20)	DFF7(clk, next_rP, rP);
	DFF #(10)	DFF8(clk, next_m_n, m_n);
	DFF #(10)	DFF9(clk, next_m_r, m_r);
	DFF #(10)	DFF10(clk, next_counter, counter);
	DFF #(1)	DFF11(clk, next_idx, idx);
	DFF #(10)	DFF12(clk, next_X_col, X_col);
	DFF #(3)	DFF13(clk, next_state, opcode);
	
	assign next_m_n	= (state == `INIT)? 10'b0 : 
					  (state == `GET_N)? in_data : m_n;
	assign next_m_r = (state == `INIT)? 10'b0 : 
					  (state == `GET_R)? in_data : m_r;
	assign next_rA	= (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? 10'b0 : 
					  (state == `READ_A)? in_data : rA;
	assign next_rX	= (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? 10'b0 :
					  (state == `READ_X)? in_data : rX;
	assign next_rB	= (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? 10'b0 :
					  (state == `READ_B)? in_data : rB;
	assign next_rP	= (state == `INIT)? 20'b0 : 
					  (state == `READ_X)? rA:
					  (state == `WRITE_Y)? 20'b0 : rP;
	assign next_idx	= (state == `INIT)? 1'b0 : 
					  (state == `READ_A)? 1'b1 :
					  (state == `READ_X)? 1'b0 : 
					  (state == `WRITE_Y)? 1'b0 : idx;
	assign next_counter = (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? 10'b0 : 
					  (state == `READ_A)? counter + 10'b1 :
					  (state == `READ_X)? (counter == 2*m_r-1)? 10'b0 : 
					  counter + 10'b1 : counter;
	assign next_row	= (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? (X_col == m_n-10'b1)? row + 10'b1 :
					  row : row;
	assign next_col = (state == `INIT)? 10'b0 : 
					  (state == `READ_X)? col + 10'b1 : 
					  (state == `WRITE_Y)? 10'b0 : col;
	assign next_X_col = (state == `INIT)? 10'b0 : 
					  (state == `WRITE_Y)? (X_col == m_n-10'b1)? 10'b0 : 
					  X_col + 10'b1 : X_col;
	assign next_sum = (state == `INIT)? 20'b0 : 
					  (state == `READ_A)? sum + rP*rX: 
					  (state == `READ_B)? sum + rP*rX:
					  (state == `WRITE_Y)? 20'b0 :
					  sum;
	
	always@(*)begin	// next_state
		case(state)
			`INIT: next_state1 = `GET_N;
			`GET_N: next_state1 = `GET_R;
			`GET_R:	next_state1 = `READ_A;
			`READ_A: next_state1 = `READ_X;
			`READ_X: next_state1 = (counter == 2*m_r-10'b1)? `READ_B : `READ_A;
			`READ_B: next_state1 = `WRITE_Y;
			`WRITE_Y: next_state1 = `READ_A;
			default: next_state1 = `INIT;
		endcase
	end

	assign next_state = (reset == 1'b0)? `INIT : next_state1;
	assign fin = (state == `READ_A  && row == m_n)? 1'b1 : 1'b0;
	assign i = (state == `READ_B)?row :(idx == 1'b0)? row : col;
	assign j = (state == `READ_B)?X_col :(idx == 1'b0)? col : X_col;
	assign out_data = sum + rB;//sum;

endmodule