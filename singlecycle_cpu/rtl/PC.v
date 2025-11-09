module ProgramCounter(
    input clk,
    input reset,
    input [31:0] pc4,
    input [31:0] pc_branch,
    input [1:0] branch,
    input taken,
    output reg[31:0] pc
);

    reg [31:0] pc_next;

    always @(*) begin
        case(branch) 
            2'b01: pc_next = taken ? pc_branch : pc4; // Conditional Branch
            2'b10: pc_next = pc_branch; // JALR
            2'b11: pc_next = pc_branch; // JAL
            2'b00: pc_next = pc4;
            default: pc_next = pc4;
        endcase
    end

    always @(posedge clk) begin
        if(reset) pc <= 32'd0;
        else pc <= pc_next;
    end    

endmodule