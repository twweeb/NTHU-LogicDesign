`define SDFFILE "./MO.sdf"
`define TIMEOUT 1000000
`define MEM "./memory.dat"
`define ANS "./ans.dat"

// decode
`define GET_N 3'b000
`define GET_R 3'b001
`define READ_A 3'b010
`define READ_X 3'b011
`define READ_B 3'b100
`define WRITE_Y 3'b101

module PD_tb;
	// parameter
	parameter cyc = 100;
	
	// I/O
	reg clk, reset;
	reg [9:0] in_data;
	wire fin;
	wire [9:0] i, j;
	wire [2:0] opcode;
	wire [19:0] out_data;
	
	// memeory and answer
	reg [9:0]mem[0:1023];
	reg [19:0]_mem[0:1023];
	reg [19:0]ans[0:1023];
	integer f,row,col;
	
	// saved values
	reg [9:0] n, r;
	
	MO mo_0(
		.clk(clk),
		.reset(reset),
		.in_data(in_data),
		.i(i),
		.j(j),
		.opcode(opcode),
		.out_data(out_data),
		.fin(fin)
	);

	always #(cyc/2) clk = ~clk;

	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, mo_0);
			$fsdbDumpfile("MO_syn.fsdb");
		`else
			$fsdbDumpfile("MO.fsdb");
		`endif
		$fsdbDumpvars;
	end
	
	initial begin
		$display(" ");

		// init values
		reset = 1'b1;
		clk = 1'b0;
		in_data = 'hz;
		$readmemb (`MEM, mem);
		$readmemb(`ANS, ans);
		f=$fopen(`MEM, "w");
		
		// init MO
		@(negedge clk)  reset = 1'b0;
		#(cyc)  		reset = 1'b1;
		
		#(`TIMEOUT)
		$fclose(f);
		$writememb(`MEM, mem);
		$display("-----------------------------------");
		$display("Oh,something wrong!!!");
		$finish;
	end

	initial begin
		#(cyc/2)
			n = mem[0];
			r = mem[1];
		$display("matrix size ||| n = %d, r = %d", n, r);
		$display("-----------------------------------");
	end
	
	//operation control
	always@(negedge clk)begin
		case(opcode)
			`GET_N: begin
				in_data = mem[0];// n
			end
			`GET_R: begin
				in_data = mem[1];// r
			end
			`READ_A: begin
				in_data = mem[i*r + j + 2];// A
			end
			`READ_X: begin
				in_data = mem[i*n + j + 2 + (n*r)];// X
			end
			`READ_B: begin
				in_data = mem[i*n + j + 2 + (2*n*r)];// B
			end
			`WRITE_Y: begin
				in_data = 'hz;
				$fwrite(f, "%b\n", out_data);
			end
			default: begin
				in_data = 'hz;
			end
		endcase
	end
	
	//examine
	always@(posedge fin)begin
		$fclose(f);
		$readmemb(`MEM, _mem);
		
		for(row=0 ; row<n ; row=row+1)begin
			for(col=0 ; col<n ; col=col+1)begin
				if(ans[row*n+col] === _mem[row*n+col])begin
					$display("Row:%d Column:%d is correct.", row, col);
				end
				else begin
					$display("-----------------------------------");
					$display("Row:%d Column:%d is wrong.", row, col);
					$display("Your answer is:%d,and the correct answer is:%d", _mem[row*n+col], ans[row*n+col]);
					
					$fclose(f);
					$writememb(`MEM, mem);
					$finish;
				end
			end
		end
		$fclose(f);
		$writememb(`MEM, mem);
		$display("-----------------------------------");
		$display("Congratulation!!!\n");
		$finish;
	end
	
endmodule
