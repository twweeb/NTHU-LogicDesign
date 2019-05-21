`timescale 1ns / 1ps
`define SDFFILE "./AM.sdf"
`define info  "./info.dat" 

module AM_tb();
	parameter test_n = 32;
	parameter bonus_n = 2;

	reg [3:0]A, B, Sel;
	
	reg [28:0] Mem [0:test_n+bonus_n-1];
	reg [9:0]Addr;
	wire [9:0]TCcount;
	
	reg [15:0]Ans_Out;
	reg Ans_Ovf;
	wire [15:0]Out;
	wire Ovf;
	reg got_bonus;

	AM am_000(.A(A), .B(B), .Sel(Sel), .Out(Out), .Ovf(Ovf));
	
	assign TCcount = Addr + 1'b1;
	
	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, am_000);
		`endif
	end
	
	initial begin
		$readmemb(`info, Mem);
		Addr = 10'd0;
		got_bonus = 1'b1;
		
		repeat (test_n) begin
			// Mem -> {A, B, Sel, Out, Ovf}
			A = Mem[Addr][28:25];
			B = Mem[Addr][24:21];
			Sel = Mem[Addr][20:17];
			Ans_Out = Mem[Addr][16:1];
			Ans_Ovf = Mem[Addr][0];
			
			#10;
			$display("test_case No. %d: A = %b, B = %b, Sel = %b, Out = %b, Ovf = %b", TCcount, A, B, Sel, Out, Ovf);
			if(Ovf !== Ans_Ovf)begin
				$display("\n-------------------<Wrong answer>-------------------\n");
				$display("Correct answear: Out = %b, Ovf = %b.\n", Ans_Out, Ans_Ovf);
				$finish;
			end
			else begin
				if(Ovf === 1'b0 && Out !== Ans_Out)begin
					$display("\n-------------------<Wrong answer>-------------------\n");
					$display("Correct answear: Out = %b, Ovf = %b.\n", Ans_Out, Ans_Ovf);
					$finish;
				end
			end
			
			#5;
			Addr = Addr + 1'b1;
			#5;
		end
		$display("All Correct.\n");
		$display("Test bonus...\n");
		
		repeat(bonus_n)begin
			A = Mem[Addr][28:25];
			B = Mem[Addr][24:21];
			Sel = Mem[Addr][20:17];
			Ans_Out = Mem[Addr][16:1];
			Ans_Ovf = Mem[Addr][0];
			#10;
			$display("Bonus No. %d: A = %b, B = %b, Sel = %b, Out = %b, Ovf = %b", TCcount, A, B, Sel, Out, Ovf);
			if(Ovf !== Ans_Ovf)begin
				got_bonus = 1'b0;
			end
			else begin
				if(Ovf === 1'b0 && Out !== Ans_Out)begin
					got_bonus = 1'b0;
				end
			end
			
			#5;
			Addr = Addr + 1'b1;
			#5;
		end
		if(got_bonus == 1'b1) $display("\nGet bonus.\n");
		else  $display("\nNot get bonus.\n");
		$finish;
	end

endmodule