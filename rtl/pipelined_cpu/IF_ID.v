`timescale 1ns / 1ps

module IF_ID(
	 input clk,
	 input staller,
    input [31:0] PC_in,
    input [31:0] idata_in,
    output reg [31:0] PC_out,
    output reg [31:0] idata_out
    );
	 initial begin
PC_out = 0;
idata_out = 0;
end

always @(posedge clk) begin
if(~staller)begin
PC_out <= PC_in;
idata_out <= idata_in;
end
end
endmodule
