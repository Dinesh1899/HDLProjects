`include "../rtl/parameters.vh"

module immgen(
    input  [31:0] instr,
    output reg [31:0] immVal
);

    // assign immVal = {20'h00000,instr[31:20]};
    wire [6:0] opcode;
    
    assign opcode = instr[6:0];

    always @(*) begin 
        case (opcode)
            `ITYPE: immVal = {{20{instr[31]}}, instr[31:20]}; // I type Instructions
            `STORE: immVal = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // Store Instructions
            `LOAD: immVal = {{20{instr[31]}}, instr[31:20]};  // Load Instructions
            `SBTYPE: immVal = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; 
                        // Branch Instructions
            `JAL : immVal = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21] ,1'b0};
                        // imm[20|10:1|11|19:12]; // JAL
            `JALR : immVal = {{20{instr[31]}}, instr[31:20]};
                        // imm[11:0]; // JALR
            `AUIPC : immVal = {instr[31:12], 12'h000}; // AUIPC
            `LUI : immVal = {instr[31:12], 12'h000}; // LUI    
            default: immVal = 32'h00000000;
        endcase
    end

endmodule