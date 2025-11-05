module FetchDecodeIntf(
    input clk,
    input reset,
    input [31:0] if_idata_in,
    input [31:0] if_pc_in,
    output reg [31:0] if_idata_out,
    output reg [31:0] if_pc_out
);

    always @(posedge clk or posedge clk) begin
        if(reset) begin 
            if_idata_out <= 0;
            if_pc_out <= 0;
        end
        else begin 
            if_idata_out <= if_idata_in;
            if_pc_out <= if_pc_in;            
        end
    end

endmodule