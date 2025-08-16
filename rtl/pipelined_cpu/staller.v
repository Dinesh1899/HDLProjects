`timescale 1ns / 1ps

module staller(
    input memread_EX,
	 input [31:0] idata_EX,
    input [31:0] idata_ID,
    output staller
    );
	 

	assign staller = ( memread_EX && ((idata_EX[11:7] == idata_ID[19:15]) || ((idata_EX[11:7] == idata_ID[24:20]) && (idata_ID[6:0] != 7'b0000011))));

endmodule
