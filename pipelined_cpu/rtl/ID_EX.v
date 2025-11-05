module DecodeExecuteIntf(
    input clk,
    input reset,
    input [31:0] id_pc_out,
    
    input [1:0] id_alu_src_out,
    input [3:0] id_alu_op_out,
    input [1:0] id_branch_out,
    input [1:0] id_reg_in_sel_out,
    input [3:0] id_dwe_out,
    input [2:0] id_func3_out,
    input id_mem_reg_out,
    input id_reg_wr_out,
    
    input [31:0] id_rv1_out,
    input [31:0] id_rv2_out,
    input [31:0] id_imm_out,
    input [4:0] id_rd_out,

    output reg [1:0] ex_alu_src_in,
    output reg [3:0] ex_alu_op_in,
    output reg [1:0] ex_branch_in,
    output reg [1:0] ex_reg_in_sel_in,
    output reg [3:0] ex_dwe_in,
    output reg [2:0] ex_func3_in,
    output reg ex_mem_reg_in,
    output reg ex_reg_wr_in,

    output reg [31:0] ex_rv1_in,
    output reg [31:0] ex_rv2_in,
    output reg [31:0] ex_imm_in,
    output reg [4:0] ex_rd_in,
    output reg [31:0] ex_pc_in
);

    always @(posedge clk) begin
        if(reset) begin 
            ex_alu_src_in <= 0;
            ex_alu_op_in <= 0;
            ex_branch_in <= 0;
            ex_reg_in_sel_in <= 0;
            ex_dwe_in <= 0;
            ex_mem_reg_in <= 0;
            ex_reg_wr_in <= 0;
            ex_rv1_in <= 0;
            ex_rv2_in <= 0;
            ex_imm_in <= 0;
            ex_rd_in <= 0;
            ex_pc_in <= 0;
            ex_func3_in <= 0;            
        end
        else begin 
            ex_alu_src_in <= id_alu_src_out;
            ex_alu_op_in <= id_alu_op_out;
            ex_branch_in <= id_branch_out;
            ex_reg_in_sel_in <= id_reg_in_sel_out;
            ex_dwe_in <= id_dwe_out;
            ex_mem_reg_in <= id_mem_reg_out;
            ex_reg_wr_in <= id_reg_wr_out;
            ex_rv1_in <= id_rv1_out;
            ex_rv2_in <= id_rv2_out;
            ex_imm_in <= id_imm_out;
            ex_rd_in <= id_rd_out;
            ex_pc_in <= id_pc_out;
            ex_func3_in <= id_func3_out; 
        end
    end

endmodule