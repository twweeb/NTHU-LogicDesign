`define PUSH 3'b000
`define ADD 3'b001
`define SUB 3'b010
`define MUL 3'b011
`define INIT 3'b000
`define READ1 3'b001
`define READ2 3'b010
`define WRITE 3'b011
`define FIN   3'b100
`define ERR   3'b101
`define UND   3'b110

`define NO_OP 2'b00
`define DO_PUSH 2'b01
`define DO_POP 2'b10
`define STK0 4'b0000
`define STK1 4'b0001
`define STK2 4'b0010
`define STK3 4'b0011
`define STK4 4'b0100
`define STK5 4'b0101
`define STK6 4'b0110
`define STK7 4'b0111
`define STK8 4'b1000

module DFF(clk, next, out);
	parameter n = 1;
	input clk;
	input [n-1:0] next;
	output reg [n-1:0] out;
	always@(posedge clk) begin
		out = next;
	end
endmodule

module SM(clk, rst_n, instr, pc, d_valid, out_data, err_code, fin);
	input clk;
	input rst_n;
	input [12:0] instr;
	output [9:0] pc;
	output d_valid;
	output [19:0] out_data;
	output [2:0] err_code;
	output fin;
	
	wire 		cnt,next_cnt, restore, next_restore, full, empty, invalid, next_invalid;
	wire [2:0]	oper,state, next_state;
	wire [9:0]	next_pc, next_len, len;
	wire [19:0]	data,data2, next_data, next_data2, r_data, w_data;
	reg 		next_cnt1, next_restore1, next_invalid1;
	reg  [1:0]	cntrl;
	reg  [2:0] 	next_state1;
	
	assign next_pc = (rst_n == 0)? 10'd1023 : (state == `INIT)? 10'b0 : (state == `WRITE || state == `UND) ? pc + 1'b1 : (state == `ERR && restore == 0) ? pc + 1'b1 : pc;
	assign next_len = (rst_n == 0)? 4'b0 : (state == `INIT)? instr[9:0] : len;
	assign next_data = (rst_n == 0) ? 20'b0 : (state == `READ1) ? r_data[19:0] : data;
	assign next_data2 = (rst_n == 0) ? 20'b0 : (state == `READ2) ? r_data[19:0] : data2;
	assign next_state = (rst_n == 0) ? `INIT : next_state1;
	assign next_restore = (rst_n == 0) ? 0 : next_restore1;
	assign next_invalid = (rst_n == 0) ? 0 : next_invalid1;
	assign next_cnt = (rst_n == 0) ? 0 : next_cnt1;
	assign d_valid =  (state == `WRITE && cnt == 1) ? 1 : (state == `ERR || state == `UND) ? 1 : 0;
	assign err_code =  (invalid == 1) ? 3'b100 : (state == `ERR) ? 3'b001 : (state == `UND) ? 3'b010 : 3'b0;
	assign fin = (pc == len)? 1 : 0;
	assign oper = instr[12:10];
	assign out_data = (restore == 1) ? 20'b0 : (state == `WRITE) ? w_data : 20'b0;
	assign w_data = (state == `WRITE) ? (restore == 1) ? data : (cnt == 0) ? {{10{instr[9]}},instr[9:0]} : 
	                (oper == `ADD) ? (data + data2) : (oper == `SUB) ? (data - data2) : (oper == `MUL) ? (data * data2) : 20'b0 : 20'b0;

    always@(*) begin
	    case(state)
	    	`INIT: begin
	    		cntrl = `NO_OP;
	    		next_cnt1 = 0;
	    		next_restore1 = 0;
	    		next_invalid1 = 0;
	    	end

	    	`READ1: begin
	    		cntrl = `DO_POP;
	    		next_cnt1 = 1;
	    		next_restore1 = 0;
	    		next_invalid1 = (empty == 1) ? 1 : 0;
	    	end

	    	`READ2: begin
	    		cntrl = (empty == 1) ? `NO_OP : `DO_POP;
	    		next_cnt1 = 1;
	    		next_restore1 = (empty == 1) ? 1 : 0;
	    		next_invalid1 = (empty == 1) ? 1 : 0;
	    	end

	    	`WRITE: begin
	    		cntrl = `DO_PUSH;
	    		next_cnt1 = 0;
	    		next_restore1 = 0;
	    		next_invalid1 = 0;
	    	end

	    	`FIN: begin
	    		cntrl = `NO_OP;
	    		next_cnt1 = 0;
	    		next_restore1 = 0;
	    		next_invalid1 = 0;
	    	end

	    	`ERR: begin
	    		cntrl = `NO_OP;
	    		next_cnt1 = 0;
	    		next_restore1 = restore;
	    		next_invalid1 = invalid;
	    	end

	    	`UND: begin
	    		cntrl = `NO_OP;
	    		next_cnt1 = 0;
	    		next_restore1 = 0;
	    		next_invalid1 = 0;
	    	end
	    	default:begin
	    	end
	    endcase
    end
	
    always@(*) begin
	    case(state)
	    	`INIT: next_state1 = `FIN;
	    	`READ1: next_state1 = (empty == 1) ? `ERR : `READ2;
	    	`READ2: next_state1 = (empty == 1) ? `ERR : `WRITE;
	    	`WRITE: next_state1 = `FIN;
	    	`FIN: next_state1 = (oper == `PUSH) ? ((full == 0) ? `WRITE : `ERR) : ((oper == `ADD || oper == `SUB || oper == `MUL) ? `READ1 : `UND);
	    	`ERR: next_state1 = (restore == 1) ? `WRITE : `FIN;
	    	`UND: next_state1 = `FIN;
	    	default: next_state1 = `INIT;
	    endcase
    end
	
	DFF #(10)	DFF1(clk, next_pc, pc);
	DFF #(10)	DFF2(clk, next_len, len);
	DFF #(1)	DFF3(clk, next_cnt, cnt);
	DFF #(1)	DFF4(clk, next_restore, restore);
	DFF #(1)	DFF5(clk, next_invalid, invalid);
	DFF #(20)	DFF6(clk, next_data, data);
	DFF #(20)	DFF7(clk, next_data2, data2);
	DFF #(3)	DFF8(clk, next_state, state);
	
	SM_Mem SM(clk, rst_n, cntrl, w_data, r_data, full, empty);
endmodule

module SM_Mem(clk, rst_n, cntrl, w_data, r_data, full, empty);
	input clk;
	input rst_n;
	input [1:0] cntrl;
	input [19:0] w_data;
	output [19:0] r_data;
	output full;
	output empty;
	
	wire [3:0]	top,next_top;
	wire [19:0]	next_num1,next_num2,next_num3,next_num4,next_num5,next_num6,next_num7,next_num8,
	            num1,num2,num3,num4,num5,num6,num7,num8;
	reg  [19:0]	pop_data;
	
	assign next_top = (rst_n == 0) ? `STK0 :
	                  (cntrl == `DO_PUSH) ? ((top == `STK8) ? top : top + 1'b1) :
	                  (cntrl == `DO_POP) ? ((top == `STK0) ? top : top - 1'b1) : top;
	assign full = (rst_n == 0) ? 0 : (top == `STK8) ? 1 : 0;
	assign empty = (rst_n == 0) ? 1 : (top == `STK0) ? 1 : 0;
	assign next_num1 = (top == `STK0 && cntrl == `DO_PUSH) ? w_data : num1;
	assign next_num2 = (top == `STK1 && cntrl == `DO_PUSH) ? w_data : num2;
	assign next_num3 = (top == `STK2 && cntrl == `DO_PUSH) ? w_data : num3;
	assign next_num4 = (top == `STK3 && cntrl == `DO_PUSH) ? w_data : num4;
	assign next_num5 = (top == `STK4 && cntrl == `DO_PUSH) ? w_data : num5;
	assign next_num6 = (top == `STK5 && cntrl == `DO_PUSH) ? w_data : num6;
	assign next_num7 = (top == `STK6 && cntrl == `DO_PUSH) ? w_data : num7;
	assign next_num8 = (top == `STK7 && cntrl == `DO_PUSH) ? w_data : num8;
	assign r_data = (cntrl == `DO_POP) ? ((top == `STK1) ? num1 : (top == `STK2) ? num2 : (top == `STK3) ? num3 : (top == `STK4) ? num4 :
	                (top == `STK5) ? num5 : (top == `STK6) ? num6 : (top == `STK7) ? num7 : (top == `STK8) ? num8 : 20'b0):20'b0;

	DFF #(20) DFF1(clk, next_num1, num1);
	DFF #(20) DFF2(clk, next_num2, num2);
	DFF #(20) DFF3(clk, next_num3, num3);
	DFF #(20) DFF4(clk, next_num4, num4);
	DFF #(20) DFF5(clk, next_num5, num5);
	DFF #(20) DFF6(clk, next_num6, num6);
	DFF #(20) DFF7(clk, next_num7, num7);
	DFF #(20) DFF8(clk, next_num8, num8);
	DFF #(4)  DFF9(clk, next_top, top);
endmodule
