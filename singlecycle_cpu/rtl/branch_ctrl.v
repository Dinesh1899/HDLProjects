module BranchDecoder(
    input [31:0] rv1, rv2,
    input [2:0] func3,
    output reg taken
);

    always @(*) begin
        case(func3) 
            3'b000 : taken = rv1 == rv2;
            3'b001 : taken = rv1 != rv2;
            3'b100 : taken = $signed(rv1) < $signed(rv2);
            3'b101 : taken = $signed(rv1) >= $signed(rv2);
            3'b110 : taken = rv1 < rv2;
            3'b111 : taken = rv1 >= rv2;            
            default: taken = 0;
        endcase
    end


endmodule