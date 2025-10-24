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
    wire [31:0] pc4;
    wire [31:0] PC_Next;

    wire taken; 
    wire[1:0] branch;

    wire [31:0] rv1, rv2, alu_out, r31, reg_in, reg_data;

    ProgramCounter upc1(
        .pc(PC),
        .alu_out(alu_out),
        .branch(branch),
        .taken(taken),
        .pc_next(PC_Next),
        .pc4(pc4)
    );

    always @(posedge clk) begin
        if(reset) PC <= 32'd0;
        else PC <= PC_Next;
    end

    assign iaddr = PC;

    wire [1:0] aluSrc;
    wire [1:0] regsel;

    wire [31:0] immVal;
    wire [3:0] aluOp;
    wire [4:0] rs1, rs2, rd;

    wire memReg;
    wire regWr;

    decoder udec(
        .instr(idata),
        .aluSrc(aluSrc),
        .reginsel(regsel),
        .branch(branch),
        .aluOp(aluOp),
        .immVal(immVal),
        .dwe(dwe),
        .memReg(memReg),
        .regWr(regWr)
    );

    assign {rs1, rs2, rd} = {idata[19:15], idata[24:20], idata[11:7]};
    // assign aluOp = {idata[30], idata[14:12]};


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

    assign alu_in1 = aluSrc[0] ? PC : rv1;
    assign alu_in2 = aluSrc[1] ? immVal : rv2;

    // assign alu_in1 = branch[0] ? PC : rv1;
    // assign alu_in2 = aluSrc ? rv2 : immVal;
    

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

    assign reg_data = regsel[1] ? (regsel[0] ? pc4 : immVal) : alu_out;
    assign reg_in = memReg ? mem_out : reg_data;
    
    // assign reg_in = memReg ? mem_out : (branch[1] ? pc4 : alu_out);


    BranchDecoder ubd1(
        .rv1(rv1),
        .rv2(rv2),
        .func3(idata[14:12]),
        .taken(taken)
    );


endmodule