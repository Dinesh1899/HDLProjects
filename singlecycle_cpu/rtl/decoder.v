module decoder(
    input [31:0] instr,
    output [4:0] rs1, rs2, rd,
    output [3:0] aluOp
);

    assign {aluOp, rs1, rs2, rd} = {instr[30], instr[14:12], instr[19:15], instr[24:20], instr[11:7]};

endmodule