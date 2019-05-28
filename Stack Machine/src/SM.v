module SM(clk, rst_n, instr, pc, d_valid, out_data, err_code, fin);
    input clk;
    input rst_n;
    input [12:0] instr;
    output [9:0] pc
    output d_valid;
    output [19:0] out_data;
    output [2:0] err_code;
    output fin;
    // your code here, remember to instantiate your SM_Mem
endmodule
module SM_Mem(clk, rst_n, cntrl, w_data, r_data, full, empty);
    input clk;
    input rst_n;
    input [1:0] cntrl;
    input [19:0] w_data;
    output [19:0] r_data;
    output full;
    output empty;
    // your code
endmodule
