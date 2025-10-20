module immgen(
    input  [31:0] instr,
    output reg [31:0] immVal
);

    // assign immVal = {20'h00000,instr[31:20]};
    wire [6:0] opcode;
    
    assign opcode = instr[6:0];

    always @(*) begin 
        case (opcode)
            7'b0010011: immVal = {20'h00000, instr[31:20]}; // I type Instructions
            7'b0100011: immVal = {20'h00000, instr[31:25], instr[11:7]}; // Store Instructions
            7'b0000011: immVal = {20'h00000, instr[31:20]};  // Load Instructions
            default: immVal = 32'h00000000;
        endcase
    end

endmodule