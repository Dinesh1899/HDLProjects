// Control Unit and Reg File

module Decode(
    input clk,
    input [31:0] id_idata_in,
    input [31:0] id_pc_in,

    input id_reg_wr_in,
    input [4:0] id_rd_in,
    input [31:0] id_reg_data_in,
    input [1:0] id_is_stall,

    output [1:0] id_alu_src_out,
    output [3:0] id_alu_op_out,
    output [1:0] id_branch_out,
    output [1:0] id_reg_in_sel_out,
    output [3:0] id_dwe_out,
    output [2:0] id_func3_out,
    output id_mem_reg_out,
    output id_reg_wr_out,

    output [31:0] id_rv1_out,
    output [31:0] id_rv2_out,
    output [31:0] id_imm_out,
    output [4:0] id_rd_out,
    output [31:0] id_pc_out,
    output [4:0] id_rs1_out,
    output [4:0] id_rs2_out, 
    output [31:0] id_x31_out

);

    wire [3:0] dwe_out;
    wire reg_wr_out;
    wire [1:0] branch_out;

    ControlUnit cu(
        .instr(id_idata_in),
        .aluSrc(id_alu_src_out),
        .aluOp(id_alu_op_out),
        .branch(branch_out),
        .dwe(dwe_out),
        .memReg(id_mem_reg_out),
        .regWr(reg_wr_out),
        .reginsel(id_reg_in_sel_out),
        .immVal(id_imm_out)
    );

    wire [4:0] rs1, rs2, rd;

    assign {rs1, rs2, rd} = {id_idata_in[19:15], id_idata_in[24:20], id_idata_in[11:7]};
    assign id_func3_out = id_idata_in[14:12];
    assign id_rd_out = rd;

    assign id_rs1_out = rs1;
    assign id_rs2_out = rs2;

    assign id_dwe_out = |id_is_stall ? 4'd0 : dwe_out;
    assign id_reg_wr_out = |id_is_stall ? 4'd0 : reg_wr_out;
    assign id_branch_out = |id_is_stall ? 4'd0 : branch_out;
    assign id_pc_out = id_pc_in;


    regfile ureg(
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(id_rd_in),
        .indata(id_reg_data_in),
        .we(id_reg_wr_in),
        .rv1(id_rv1_out),
        .rv2(id_rv2_out),
        .x31(id_x31_out)
    );

endmodule