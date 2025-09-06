`timescale 1ns / 1ps

module imem_tb;

	// Inputs
	reg [31:0] iaddr;
	reg clk;

	// Outputs
	wire [31:0] idata;

	initial 
	clk =0;
	always
	#5 clk = ~clk;
	// Instantiate the Unit Under Test (UUT)
	imem uut (
		.iaddr(iaddr), 
		.idata(idata),
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		iaddr = 0;

		// Wait 100 ns for global reset to finish
		#100;
      iaddr=500;
		// Add stimulus here
		#100;
      iaddr=100;
		#100;
      iaddr=1000;
	end
      
endmodule

