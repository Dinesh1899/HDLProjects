module FetchDecode(
    input clk,
    input reset,
    input [31:0] if_idata_in,
    input [31:0] if_pc_in,
    output reg [31:0] id_idata_out,
    output reg [31:0] id_pc_out
);

    always @(posedge clk) begin
        if(reset) begin 
            id_idata_out <= '0;
            id_pc_out <= '0;
        end
        else begin 
            id_idata_out <= if_idata_in;
            id_pc_out <= if_pc_in;            
        end
    end

endmodule