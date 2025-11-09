module ExecuteUnit(
    input [1:0] ex_alu_src_in,
    input [3:0] ex_alu_op_in,
    input [1:0] ex_branch_in,
    input [1:0] ex_reg_in_sel_in,
    input [3:0] ex_dwe_in,
    input [2:0] ex_func3_in,
    input ex_mem_reg_in,
    input ex_reg_wr_in,

    input [31:0] ex_rv1_in,
    input [31:0] ex_rv2_in,
    input [31:0] ex_imm_in,
    input [4:0] ex_rd_in,
    input [31:0] ex_pc_in,

    input [1:0] fwd_rs1_in,
    input [1:0] fwd_rs2_in,
    input [31:0] ex_fwd_alu_out_in,
    input [31:0] mem_fwd_alu_out_in,
    input [1:0] ex_is_stall,

    output [31:0] ex_alu_out_out,
    output [31:0] ex_rv2_out,
    output ex_alu_zero_out,
    output [31:0] ex_pc_imm_out,
    output [31:0] ex_pc4_out,
    output [31:0] ex_imm_out,

    output [4:0] ex_rd_out,
    output [1:0] ex_branch_out,
    output [1:0] ex_reg_in_sel_out,
    output [3:0] ex_dwe_out,
    output [2:0] ex_func3_out,
    output ex_mem_reg_out,
    output ex_reg_wr_out

);

    assign ex_rd_out = ex_rd_in;
    assign ex_reg_in_sel_out = ex_reg_in_sel_in;
    assign ex_dwe_out = ex_is_stall == 2'b10 ? 4'd0 : ex_dwe_in;
    assign ex_mem_reg_out = ex_mem_reg_in;
    assign ex_reg_wr_out = ex_is_stall == 2'b10 ? 4'd0 : ex_reg_wr_in;
    assign ex_imm_out = ex_imm_in;
    assign ex_pc_imm_out = ex_pc_in + ex_imm_in;
    assign ex_pc4_out = ex_pc_in + 4;
    assign ex_func3_out = ex_func3_in;
    assign ex_branch_out = ex_is_stall == 2'b10 ? 4'd0 : ex_branch_in;

    wire [31:0] alu_in1, alu_in2;
    wire [31:0] src_rv1, src_rv2;

    assign src_rv1 = fwd_rs1_in[1] ? ex_fwd_alu_out_in : (fwd_rs1_in[0] ? mem_fwd_alu_out_in : ex_rv1_in);

    assign src_rv2 = fwd_rs2_in[1] ? ex_fwd_alu_out_in : (fwd_rs2_in[0] ? mem_fwd_alu_out_in : ex_rv2_in);
    
    assign ex_rv2_out = src_rv2;

    assign alu_in1 = ex_alu_src_in[0] ? ex_pc_in : src_rv1;
    assign alu_in2 = ex_alu_src_in[1] ? ex_imm_in : src_rv2;

    alu u_alu(
        .in1(alu_in1),
        .in2(alu_in2),
        .alucon(ex_alu_op_in),
        .out(ex_alu_out_out),
        .zero(ex_alu_zero_out)
    );


endmodule