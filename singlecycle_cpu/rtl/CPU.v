module cpu(
    input clk,
    input reset,
    input [31:0] idata,
    input [31:0] drdata,
    output reg [31:0] iaddr,
    output reg [31:0] wrdata,
    output reg [3:0] dwe
);

    reg [31:0] PC;

    always @(posedge clk) begin
        if(reset) PC <= '0;
        else PC <= PC + 4;
    end

    assign iaddr = PC;
    assign wrdata = '0;
    assign dwe = '0;

    reg [3:0] aluOp;
    reg [4:0] rs1, rs2, rd;

    decoder udec(
        .instr(idata),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .aluOp(aluOp)
    );

    reg [31:0] rv1, rv2, alu_out, r31;

    regfile ureg(
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .indata(alu_out),
        .we(1'b1),
        .rv1(rv1),
        .rv2(rv2),
        .x31(r31)
    );

    reg alu_zero;

    alu u_alu(
        .in1(rv1),
        .in2(rv2),
        .alucon(aluOp),
        .out(alu_out),
        .zero(alu_zero)
    );

    

endmodule