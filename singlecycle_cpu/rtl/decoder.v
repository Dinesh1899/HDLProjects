module decoder(
    input [31:0] instr,
    output aluSrc,
    output [3:0] aluOp,
    output [31:0] immVal,
    output reg [3:0] dwe,
    output memReg,
    output regWr
);

    wire [6:0] opcode;

    assign opcode = instr[6:0];

    assign aluSrc = (opcode == 7'b0110011); // R-Type Instructions
    assign aluOp[2:0] = (opcode[4:0] == 5'b10011) ? instr[14:12] : 3'b000;
    assign aluOp[3] = aluSrc ? instr[30] : 1'b0;

    assign memReg = (opcode == 7'b0000011); // LOAD Instruction
    assign regWr = ~(opcode == 7'b0100011); // Except for STORE Instruction
    // assign dwe = (opcode == 7'b0100011) ? 4'hf : 4'h0; // STORE Instruction


    always @(*) begin
        if(opcode == 7'b0100011) begin 
            case(instr[14:12]) 
                3'b000:  dwe = 4'b0001;
                3'b001:  dwe = 4'b0011;
                3'b010:  dwe = 4'b1111;
                default: dwe = 4'b0000;
            endcase
        end
        else dwe = 4'b0000;
    end

    immgen uimm(
        .instr(instr),
        .immVal(immVal)
    );
    // assign {aluOp, rs1, rs2, rd} = {instr[30], instr[14:12], instr[19:15], instr[24:20], instr[11:7]};

endmodule