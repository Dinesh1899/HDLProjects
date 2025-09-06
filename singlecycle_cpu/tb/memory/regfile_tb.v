`timescale 1ns / 1ps


module regfile_tb;

	// Inputs
	reg [4:0] rs1;
	reg [4:0] rs2;
	reg [4:0] rd;
	reg [31:0] indata;
	reg we;
	reg clk;

	// Outputs
	wire [31:0] rv1;
	wire [31:0] rv2;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.indata(indata), 
		.we(we), 
		.clk(clk), 
		.rv1(rv1), 
		.rv2(rv2)
	);

	always #10 clk = !clk;
	initial begin
		clk=1;
		// Initialize Inputs
		rs1 = 0;
		rs2 = 0;
		rd = 0;
		indata = 0;
		we = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

