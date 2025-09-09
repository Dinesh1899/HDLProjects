module decoder(
    input [31:0] instr,
    output aluSrc
);

    assign aluSrc = (instr[6:5] == 2'b01);
    // assign {aluOp, rs1, rs2, rd} = {instr[30], instr[14:12], instr[19:15], instr[24:20], instr[11:7]};

endmodule