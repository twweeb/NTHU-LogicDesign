`define SDFFILE "./PD.sdf"
`define TIMEOUT 1000000000
`define DATA "./info.dat"

module PD_tb;
	parameter cyc = 30;
	parameter ROMWidth = 11;
	parameter dataWidth = 10;
	integer wrong_flag;
	integer result;
	reg [ROMWidth - 1:0] ROM [0:1024];
	reg [dataWidth - 1:0] maxSize;
	reg clk, rst_n, correct;
	reg [ROMWidth - 1:0] data;
	wire fin, flag;
	wire [dataWidth - 1:0] addr;


	PD pd(
		.clk(clk),
		.rst_n(rst_n),
		.data(data[ROMWidth - 1:1]),
		.flag(flag),
		.fin(fin),
		.addr(addr)
	);

	always #(cyc/2) clk = ~clk;

	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, pd);
			$fsdbDumpfile("PD_syn.fsdb");
		`else
			$fsdbDumpfile("PD.fsdb");
		`endif
		$fsdbDumpvars;
	end
	initial begin
		$display(" ");
		//Init ROM
		$readmemb ("info.dat", ROM);

		maxSize = 10'd1023;
		correct = 1'b1;
		wrong_flag = 0;
		rst_n = 1'b1;
		clk = 1'b0;
		result = 0;
		//start = 1'b0;
		data = 'hz;

		@(negedge clk)  rst_n = 1'b0;
		#(cyc);    rst_n = 1'b1;
		@(negedge clk)
		while (fin == 0) begin
			//$display("clk = %b, data = %b, addr = %d", clk, data, addr);
			if(addr <= maxSize) begin
				data = ROM[addr];
				#(cyc/2);
				if(flag != data[0])begin
					$display("WA ! addr = %d , your_flag = %d , ans_flag = %d" , addr , flag , data[0]);
					correct = 1'b0;
					wrong_flag = wrong_flag + 1;
				end
				else if(data[0] == 1'b1)begin
					$display("GET ! addr = %d , your_flag = %d , ans_flag = %d" , addr , flag , data[0]);
					result = result + 1;
				end
			end else begin
				data = 'hz;
			end
			@(negedge clk);

		end
		$display(" ");
		if(correct == 1'b1 && result == ROM[1024][10:1])begin
			$display("!!!!! ACCEPTED !!!!!");
		end
		else begin
			$display("WRONG ANSWER QAQ , wrong_flag = %d" , wrong_flag);
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
