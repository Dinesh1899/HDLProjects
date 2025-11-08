module ExecuteMemIntf(
    input clk,
    input reset,
    input [31:0] ex_alu_out_out,
    input [31:0] ex_rv2_out,
    input ex_alu_zero_out,
    input [31:0] ex_pc_imm_out,
    input [31:0] ex_pc4_out,
    input [1:0] ex_branch_out,
    input [31:0] ex_imm_out,

    input [4:0] ex_rd_out,
    input [1:0] ex_reg_in_sel_out,
    input [3:0] ex_dwe_out,
    input [2:0] ex_func3_out,
    input ex_mem_reg_out,
    input ex_reg_wr_out,

    output reg [31:0] mem_alu_out_in,
    output reg [31:0] mem_rv2_in,
    output reg mem_alu_zero_in,
    output reg [31:0] mem_pc_imm_in,
    output reg [31:0] mem_pc4_in,
    output reg [1:0] mem_branch_in,
    output reg [31:0] mem_imm_in,

    output reg [4:0] mem_rd_in,
    output reg [1:0] mem_reg_in_sel_in,
    output reg [3:0] mem_dwe_in,
    output reg [2:0] mem_func3_in,
    output reg mem_mem_reg_in,
    output reg mem_reg_wr_in

);

    always @(posedge clk or posedge reset) begin
        if(reset) begin 
            mem_alu_out_in <= 0;
            mem_alu_zero_in <= 0;
            mem_pc_imm_in <= 0;
            mem_pc4_in <= 0;
            mem_imm_in <= 0;
            mem_rd_in <= 0;
            mem_reg_in_sel_in <= 0;
            mem_dwe_in <= 0;
            mem_func3_in <= 0;
            mem_mem_reg_in <= 0;
            mem_reg_wr_in <= 0;
            mem_rv2_in <= 0;
            mem_branch_in <= 0;
        end
        else begin 
            mem_alu_out_in <= ex_alu_out_out;
            mem_alu_zero_in <= ex_alu_zero_out;
            mem_pc_imm_in <= ex_pc_imm_out;
            mem_pc4_in <= ex_pc4_out;
            mem_imm_in <= ex_imm_out;
            mem_rd_in <= ex_rd_out;
            mem_reg_in_sel_in <= ex_reg_in_sel_out;
            mem_dwe_in <= ex_dwe_out;
            mem_func3_in <= ex_func3_out;
            mem_mem_reg_in <= ex_mem_reg_out;
            mem_reg_wr_in <= ex_reg_wr_out;
            mem_rv2_in <= ex_rv2_out;
            mem_branch_in <= ex_branch_out;        
        end
    end

endmodule