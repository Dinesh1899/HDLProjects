module (
    input clk,
    input load,
    input rstn,
    input [31:0] br_addr,
    output reg [31:0] iaddr
);

    reg [31:0] addr;

    assign iaddr = addr;

    always @(posedge clk or negedge reset) begin
        if(~rstn) addr <= '0;
        else begin 
            if(load) addr <= br_addr;
            else addr <= addr + 4;
        end
    end

endmodule