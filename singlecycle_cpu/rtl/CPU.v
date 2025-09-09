module cpu(
    input clk,
    input reset,
    input [31:0] idata,
    input [31:0] drdata,
    output [31:0] iaddr,
    output [31:0] daddr,
    output [31:0] dwdata,
    output [3:0] dwe
);

    reg [31:0] PC;

    always @(posedge clk) begin
        if(reset) PC <= 32'd0;
        else PC <= PC + 32'd4;
    end

    assign iaddr = PC;
    assign dwdata = 32'd0;
    assign daddr = 32'd0;
    assign dwe = 32'd0;

    wire aluSrc;

    decoder udec(
        .instr(idata),
        .aluSrc(aluSrc)
    );

    wire [31:0] immVal;

    immgen uimmgen(
        .instr(idata),
        .immVal(immVal)
    );

    wire [3:0] aluOp;
    wire [4:0] rs1, rs2, rd;

    assign {rs1, rs2, rd} = {idata[30], idata[14:12], idata[19:15], idata[24:20], idata[11:7]};
    assign aluOp = {idata[30], idata[14:12]};

    wire [31:0] rv1, rv2, alu_out, r31;

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

    wire alu_zero;
    wire [31:0] alu_in1, alu_in2;

    assign alu_in1 = rv1;
    assign alu_in2 = aluSrc ? rv2 : immVal;
    

    alu u_alu(
        .in1(alu_in1),
        .in2(alu_in2),
        .alucon(aluOp),
        .out(alu_out),
        .zero(alu_zero)
    );

    

endmodule