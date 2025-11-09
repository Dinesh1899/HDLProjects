module BranchDecoder(
    input alu_zero,
    input [2:0] func3,
    output reg taken
);

    always @(*) begin
        case(func3) 
            3'b000 : taken = alu_zero;
            3'b001 : taken = ~alu_zero;
            3'b100 : taken = ~alu_zero;
            3'b101 : taken = alu_zero;
            3'b110 : taken = ~alu_zero;
            3'b111 : taken = alu_zero;            
            default: taken = 0;
        endcase
    end


endmodule