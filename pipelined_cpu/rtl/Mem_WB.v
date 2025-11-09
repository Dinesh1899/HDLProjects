module MemWBIntf(
    input clk,
    input reset,
    input [31:0] mem_alu_out_out,
    input [31:0] mem_data_out,
    // input [31:0] mem_pc_imm_out,
    input [31:0] mem_pc4_out,
    input [31:0] mem_imm_out,
    input [4:0] mem_rd_out,
    input [1:0] mem_reg_in_sel_out,
    input mem_mem_reg_out,
    input mem_reg_wr_out,

    output reg [31:0] wb_alu_out_in,
    output reg [31:0] wb_mem_data_in,
    // output reg [31:0] wb_pc_imm_in,
    output reg [31:0] wb_pc4_in,
    output reg [31:0] wb_imm_in,
    output reg [4:0] wb_rd_in,
    output reg [1:0] wb_reg_in_sel_in,
    output reg wb_mem_reg_in,
    output reg wb_reg_wr_in   
);

    always @(posedge clk or posedge reset) begin
        if(reset) begin 
            wb_alu_out_in <= 0;
            wb_mem_data_in <= 0;
            // wb_pc_imm_in <= 0;
            wb_pc4_in <= 0;
            wb_imm_in <= 0;
            wb_rd_in <= 0;
            wb_reg_in_sel_in <= 0;
            wb_mem_reg_in <= 0;
            wb_reg_wr_in <= 0;
        end
        else begin 
            wb_alu_out_in <= mem_alu_out_out;
            wb_mem_data_in <= mem_data_out;
            // wb_pc_imm_in <= mem_pc_imm_out;
            wb_pc4_in <= mem_pc4_out;
            wb_imm_in <= mem_imm_out;
            wb_rd_in <= mem_rd_out;
            wb_reg_in_sel_in <= mem_reg_in_sel_out;
            wb_mem_reg_in <= mem_mem_reg_out;
            wb_reg_wr_in <= mem_reg_wr_out;     
        end
    end

endmodule