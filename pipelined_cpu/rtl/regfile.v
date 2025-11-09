module regfile(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] indata,
    input  we,
    input clk,
    output [31:0] rv1,
    output [31:0] rv2,
	 output [31:0] x31
    );

reg [31:0] RF[0:31];


initial begin $readmemh({`TESTDIR, "/init_regfile.mem"}, RF); end

assign rv1 = (rs1 != 0) ? ((rs1 == rd && we != 4'd0) ? indata : RF[rs1]) : 0;
assign rv2 = (rs2 != 0) ? ((rs2 == rd && we != 4'd0) ? indata : RF[rs2]) : 0;
assign x31 = RF[31];

 
always @ (posedge clk) begin
  if(we)
    begin
      RF[rd] <= indata;
    end 
end

endmodule
