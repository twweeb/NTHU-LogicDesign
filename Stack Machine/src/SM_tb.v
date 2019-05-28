`define SDFFILE "./SM.sdf"
`define TIMEOUT 1000000
`define MEM "./info.dat"
`define PUSH 3'b000
`define ADD 3'b001
`define SUB 3'b010
`define MUL 3'b011


module SM_tb;
	// parameter
	parameter cyc = 120;

	// I/O
	reg clk, rst_n;
	reg [12:0] instr;
	wire fin;
	wire d_valid;
	wire [9:0]pc;
	wire [19:0]out_data;
	wire [2:0]err_code;

	// memeory and answer
	reg [35:0]MEM[0:1023];

	// regs
	reg [35:0]data;
	reg [10:0]maxSize;
	reg [9:0]result;
	reg correct;
	reg miss;

	SM SM_0(.clk(clk),
			.rst_n(rst_n),
			.instr(instr),
			.pc(pc),
			.d_valid(d_valid),
			.out_data(out_data),
			.err_code(err_code),
			.fin(fin)
	);

	always #(cyc/2) clk = ~clk;

	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, SM_0);
			$fsdbDumpfile("SM_syn.fsdb");
		`else
			$fsdbDumpfile("SM.fsdb");
		`endif
		$fsdbDumpvars;
	end

	initial begin
		$display(" ");

		// init values
		rst_n = 1'b1;
		clk = 1'b0;
		instr = 'hz;

		correct = 1'b1;
		maxSize = 11'd1024;
		result = 10'd0;
		miss = 1'b0;

		$readmemb (`MEM, MEM);

		// init MO
		@(negedge clk)  rst_n = 1'b0;
		#(cyc)  		rst_n = 1'b1;

		//000_0000000001_000_xxxxxxxxxx_xxxxxxxxxx(...) -> instr(push 1), err_code, out_data(don't care)
		//MEM = (36 bits) = (13 bits instr) + (3 bits err_code) + (20 bits out_data)
		while (fin === 0) begin
			if(pc < maxSize) begin
				//negedge clk
				data = MEM[pc];
				instr = data[35:23];

				#(cyc/2);

				if(instr[12:10] === `ADD || instr[12:10] === `SUB || instr[12:10] === `MUL) begin
					//d_valid
					miss = 1'b1;
					if(d_valid === 1'b1 && out_data === data[19:0] && err_code === data[22:20])begin
						$display("GET ! pc = %d , your err_code = %d , answer err_code = %d" , pc , err_code , data[22:20]);
						$display("      pc = %d , your out_data = %d , answer out_data = %d" , pc , $signed(out_data) ,$signed(data[19:0]));
						result = result + 1'b1;
						miss = 1'b0;
					end
					else if(d_valid === 1'b1 && (out_data !== data[19:0] || err_code !== data[22:20]))begin
						$display("WA ! pc = %d , your err_code = %d , answer err_code = %d" , pc , err_code , data[22:20]);
						$display("     pc = %d , your out_data = %d , answer out_data = %d" , pc , $signed(out_data) ,$signed(data[19:0]));
						correct = 1'b0;
						miss = 1'b0;
					end
				end
				else if(instr[12:10] === `PUSH)begin
					//err_code
					if(err_code !== data[22:20] && d_valid)begin
						$display("WA ! pc = %d , your err_code = %d , answer err_code = %d" , pc , err_code , data[22:20]);
						correct = 1'b0;
					end
					else if(err_code === data[22:20] && d_valid)begin
						$display("GET ! pc = %d , your err_code = %d , answer err_code = %d" , pc , err_code , data[22:20]);
						result = result + 1'b1;
					end

					if(miss == 1'b1)begin //forget to set d_valid = 1.
						$display("Miss!");
						correct = 1'b0;
						miss = 1'b0;
					end

				end
			end else begin
				data = 'hz;
				instr = data[35:23];
			end
			@(negedge clk);
		end

		//display
		$display(" ");

		//MEM[1023] = (36 bits) = (13 bits instr) + (23 bits result)
		if(correct == 1'b1 && result == MEM[1023][22:0])begin
			$display("!!!!! ACCEPTED !!!!!");
		end
		else begin
			//$display("%d %d", result, MEM[1023][22:0]);
			//$display("WRONG ANSWER QAQ , wrong_flag = %d" , wrong_flag);
		end
		$display(" ");
		$finish;
	end

	initial  begin
		#`TIMEOUT ;
		$display("-----------------------------------------------------\n");
		$display("Error!!! Somethings' wrong with your code ...!\n");
		$display("-------------------------FAIL------------------------\n");
		$display("-----------------------------------------------------\n");
		$finish;
	end

endmodule
