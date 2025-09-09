module immgen(
    input  [31:0] instr,
    output [31:0] immVal
);

    assign immVal = {20'h00000,instr[31:20]};

endmodule