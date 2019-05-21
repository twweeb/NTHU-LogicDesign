`define SDFFILE "./SA.sdf"
`define TIMEOUT 1000000
`define MEM "./memory_SA.dat"
`define ANS "./ans_SA.dat"



module SA_tb;
	// parameter
	parameter cyc = 100;
	reg [9:0]mem[0:1023];
	
	reg [19:0]ans[0:1023];
	// inputs
	 reg clk;
	 reg reset;
	 reg [9:0] a1;
	 reg [9:0] a2;
	 reg [9:0] a3;
	 reg [9:0] a4;
	 reg [9:0] b1;
	 reg [9:0] b2;
	 reg [9:0] b3;
	 reg [9:0] b4;

	 // outputs
	 wire [19:0] c1;
	 wire [19:0] c2;
	 wire [19:0] c3;
	 wire [19:0] c4;
	 wire [19:0] c5;
	 wire [19:0] c6;
	 wire [19:0] c7;
	 wire [19:0] c8;
	 wire [19:0] c9;
	 wire [19:0] c10;
	 wire [19:0] c11;
	 wire [19:0] c12;
	 wire [19:0] c13;
	 wire [19:0] c14;
	 wire [19:0] c15;
	 wire [19:0] c16;
	 

	 
	 SA _40010 (
	  .clk(clk), 
	  .reset(reset), 
	  .a1(a1), 
	  .a2(a2), 
	  .a3(a3), 
	  .a4(a4), 
	  .b1(b1), 
	  .b2(b2), 
	  .b3(b3), 
	  .b4(b4), 
	  .c1(c1), 
	  .c2(c2), 
	  .c3(c3), 
	  .c4(c4), 
	  .c5(c5), 
	  .c6(c6), 
	  .c7(c7), 
	  .c8(c8), 
	  .c9(c9),
	  .c10(c10),
	  .c11(c11),
	  .c12(c12),
	  .c13(c13),
	  .c14(c14),
	  .c15(c15),
	  .c16(c16)
	 );


	always #(cyc/2) clk = ~clk;
	integer i , j, ppp;
	
	initial begin
	  $readmemb("./memory_SA.dat", mem);
	  $readmemb("./ans_SA.dat", ans);
	  //init inputs
	  
	  clk = 0;
	  reset = 0;
	  a1 = 0;
	  a2 = 0;
	  a3 = 0;
	  a4 = 0;
	  b1 = 0;
	  b2 = 0;
	  b3 = 0;
	  b4 = 0;
	  
	  @(negedge clk) reset = 1;
	  #(cyc); reset = 0;
	  //caculate for 3n-1 cyc, here n=4
	  #(cyc); a1 = mem[0]; a2 = 0; 		a3 = 0; 	 a4 = 0;	  b1 = mem[16]; b2 = 0; 	  b3 = 0; 		b4 = 0;
	  #(cyc); a1 = mem[1]; a2 = mem[4]; a3 = 0; 	 a4 = 0;	  b1 = mem[17]; b2 = mem[20]; b3 = 0; 		b4 = 0;
	  #(cyc); a1 = mem[2]; a2 = mem[5]; a3 = mem[8]; a4 = 0;	  b1 = mem[18]; b2 = mem[21]; b3 = mem[24]; b4 = 0;
	  #(cyc); a1 = mem[3]; a2 = mem[6]; a3 = mem[9]; a4 = mem[12];b1 = mem[19]; b2 = mem[22]; b3 = mem[25]; b4 = mem[28];
	  #(cyc); a1 = 0; 	   a2 = mem[7]; a3 = mem[10];a4 = mem[13];b1 = 0; 		b2 = mem[23]; b3 = mem[26]; b4 = mem[29];
	  #(cyc); a1 = 0; 	   a2 = 0; 		a3 = mem[11];a4 = mem[14];b1 = 0; 		b2 = 0; 	  b3 = mem[27]; b4 = mem[30];
	  #(cyc); a1 = 0; 	   a2 = 0; 		a3 = 0; 	 a4 = mem[15];b1 = 0; 		b2 = 0; 	  b3 = 0; 	    b4 = mem[31];
	  #(cyc); a1 = 0; 	   a2 = 0;	    a3 = 0;	   	 a4 = 0;	  b1 = 0;	    b2 = 0;	      b3 = 0;	    b4 = 0;
	  #(3*cyc);
	  if(c1!=ans[0]||c5!=ans[1]||c9!=ans[2]||c13!=ans[3]
		||c2!=ans[4]||c6!=ans[5]||c10!=ans[6]||c14!=ans[7]
		||c3!=ans[8]||c7!=ans[9]||c11!=ans[10]||c15!=ans[11]
		||c4!=ans[12]||c8!=ans[13]||c12!=ans[14]||c16!=ans[15])
		begin
			$display("output wrong!!");
		end else begin
			$display("All accept!!");
		end
	  
	  $display("your output");
	  $display("%d  %d  %d  %d", c1, c2, c3, c4);
	  $display("%d  %d  %d  %d", c5, c6, c7, c8);
	  $display("%d  %d  %d  %d", c9, c10, c11, c12);
	  $display("%d  %d  %d  %d", c13, c14, c15, c16);
	  $display("==============");
	  $display("ans:");
	  for(i=0;i<4;i=i+1)begin
		$display("%d  %d  %d  %d", ans[i+0], ans[i+1*4], ans[i+2*4], ans[i+3*4]);
	  end
	
	  $finish;
	end
	

	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, _40010);
			$fsdbDumpfile("SA_syn.fsdb");
		`else
			$fsdbDumpfile("SA.fsdb");
		`endif
		$fsdbDumpvars;
	end
	
	initial  begin
		#`TIMEOUT ;
		$display("-----------------------------------------------------\n");
		$display("Error!!! Somethings' wrong with your code ...!\n");
		$display("-------------------------FAIL------------------------\n");
		$display("-----------------------------------------------------\n");
		$finish;
	end
	initial begin
		#(cyc/2)
			
		$display("matrix size ||| n = 4, r = 4");
		$display("-----------------------------------");
	end
	
endmodule
