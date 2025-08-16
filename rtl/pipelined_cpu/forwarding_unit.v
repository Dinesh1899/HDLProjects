`timescale 1ns / 1ps

module forwarding_unit(
    input [31:0] idata_EX,
    input [31:0] idata_MEM,
    input [31:0] idata_WB,
    input regwrite_MEM,
    input regwrite_WB,
    output [1:0] forwardA,
    output [1:0] forwardB
    );
	 

assign forwardA = (regwrite_MEM && ~(idata_MEM[11:7]==0) && (idata_MEM[11:7] == idata_EX[19:15])) ? 2'b10 :
						(regwrite_WB && ~(idata_WB[11:7] == 0) && (idata_WB[11:7] == idata_EX[19:15])) ? 2'b01 : 2'b00;
						
assign forwardB = (regwrite_MEM && ~(idata_MEM[11:7] == 0) && (idata_MEM[11:7] == idata_EX[24:20])) ? 2'b10 :
						(regwrite_WB && ~(idata_WB[11:7] == 0) && (idata_WB[11:7] == idata_EX[24:20])) ? 2'b01 : 2'b00;
						
endmodule
