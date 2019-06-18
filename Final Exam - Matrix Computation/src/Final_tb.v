`define SDFFILE "./Final.sdf"
`define TIMEOUT 1000000
`define MEM1_1 "./testcase/4x4/memory4x4_1.dat"
`define MEM1_2 "./testcase/4x4/memory4x4_2.dat"
`define MEM2_1 "./testcase/8x8/memory8x8_1.dat"
`define MEM2_2 "./testcase/8x8/memory8x8_2.dat"
`define MEM3_1 "./testcase/12x12/memory12x12_1.dat"
`define MEM3_2 "./testcase/12x12/memory12x12_2.dat"
`define ANS1_1 "./testcase/4x4/ans4x4_1.dat"
`define ANS1_2 "./testcase/4x4/ans4x4_2.dat"
`define ANS2_1 "./testcase/8x8/ans8x8_1.dat"
`define ANS2_2 "./testcase/8x8/ans8x8_2.dat"
`define ANS3_1 "./testcase/12x12/ans12x12_1.dat"
`define ANS3_2 "./testcase/12x12/ans12x12_2.dat"

// decode
`define GET_N 3'b000
`define READ_Y 3'b001
`define READ_A 3'b010
`define READ_X 3'b011
`define WRITE_X 3'b100

module Final_tb();
	reg num;
	
	// parameter
	parameter cyc = 100;
	
	// I/O
	reg clk, rst_n;
	reg signed[19:0] in_data;
	wire fin;
	wire [19:0] i, j;
	wire [2:0] opcode;
	wire signed[19:0] out_data;
	
	// memeory and answer
	reg signed[19:0]mem[0:1023];
	reg signed[19:0]X[0:1023];
	reg signed[19:0]ans[0:1023];
	integer row;
	
	// saved values
	reg [9:0] n;
	
	Final final_0(
		.clk(clk),
		.rst_n(rst_n),
		.in_data(in_data),
		.i(i),
		.j(j),
		.opcode(opcode),
		.out_data(out_data),
		.fin(fin)
	);

	always #(cyc/2) clk = ~clk;
	initial begin 
		`ifdef CASE1
			num = 0;
		`else
			num = 1;
		`endif
	end

	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, final_0);
			$fsdbDumpfile("Final_syn.fsdb");
		`else
			$fsdbDumpfile("Final.fsdb");
		`endif
		$fsdbDumpvars;
	end
	
	initial begin
		$display(" ");

		// init values
		rst_n = 1'b1;
		clk = 1'b0;
		in_data = 'hz;
		
		`ifdef TEST1
			if(num === 1'b0) $readmemb (`MEM1_1, mem);
			else $readmemb (`MEM1_2, mem);
		`elsif TEST2
			if(num === 1'b0) $readmemb(`MEM2_1, mem);
			else $readmemb (`MEM2_2, mem);
		`else
			if(num === 1'b0) $readmemb(`MEM3_1, mem);
			else $readmemb (`MEM3_2, mem);
		`endif
		
		`ifdef TEST1
			if(num === 1'b0) $readmemb(`ANS1_1, ans);
			else $readmemb (`ANS1_2, ans);
		`elsif TEST2
			if(num === 1'b0) $readmemb(`ANS2_1, ans);
			else $readmemb (`ANS2_2, ans);
		`else
			if(num === 1'b0) $readmemb(`ANS3_1, ans);
			else $readmemb (`ANS3_2, ans);
		`endif
		// init MO
		@(negedge clk)  rst_n = 1'b0;
		#(cyc)  		rst_n = 1'b1;
		
		#(`TIMEOUT)
		$display("-----------------------------------");
		$display("Oh,something wrong!!!");
		$finish;
		
	end

	initial begin
		#(cyc/2)
			n = mem[0];
		if(num == 1'b0) $display("test number ||| num = 1");
		else $display("test number ||| num = 2");
		$display("matrix size ||| n = %d, n = %d", n, n);
		$display("-----------------------------------");
	end
	
	//operation control
	always@(negedge clk)begin
		case(opcode)
			`GET_N: begin
				in_data <= mem[0];// n
			end
			`READ_Y: begin
				in_data <= mem[i + 2 + (n*n)];// Y
			end
			`READ_A: begin
				in_data <= mem[i*n + j + 2];// A
			end
			`READ_X: begin
				in_data <= X[i];
			end
			`WRITE_X: begin
				in_data <= 'hz;
				X[i] <= out_data;
			end
			default: begin
				in_data <= 'hz;
			end
		endcase
	end
	
	//examine
	always@(posedge fin)begin
		for(row=0 ; row<n ; row=row+1)begin
			if(ans[row] === X[row])begin
				$display("Row:%d is correct.", row);
			end
			else begin
				$display("-----------------------------------");
				$display("Row:%d is wrong.", row);
				$display("Your answer is:%d,and the correct answer is:%d", X[row], ans[row]);
				$finish;
			end
		end
		
		$display("-----------------------------------");
		$display("Congratulation!!!\n");
		$finish;
	end
	
endmodule
