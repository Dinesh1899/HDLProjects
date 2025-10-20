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

    wire aluSrc;
    wire [31:0] immVal;
    wire [3:0] aluOp;
    wire [4:0] rs1, rs2, rd;

    wire memReg;
    wire regWr;

    decoder udec(
        .instr(idata),
        .aluSrc(aluSrc),
        .aluOp(aluOp),
        .immVal(immVal),
        .dwe(dwe),
        .memReg(memReg),
        .regWr(regWr)
    );

    assign {rs1, rs2, rd} = {idata[19:15], idata[24:20], idata[11:7]};
    // assign aluOp = {idata[30], idata[14:12]};

    wire [31:0] rv1, rv2, alu_out, r31, reg_in;

    regfile ureg(
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .indata(reg_in),
        .we(regWr),
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

    wire [31:0] mem_out;

    assign dwdata = rv2;
    assign daddr = alu_out;

    memregintf umemreg(
        .func3(idata[14:12]),
        .indata(drdata),
        .outdata(mem_out)
    );

    assign reg_in = memReg ? mem_out : alu_out;


endmodule