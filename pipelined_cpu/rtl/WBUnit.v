module WBUnit(
    input [31:0] wb_alu_out_in,
    input [31:0] wb_mem_data_in,
    input [31:0] wb_pc4_in,
    input [31:0] wb_imm_in,
    input [4:0] wb_rd_in,
    input [1:0] wb_reg_in_sel_in,
    input wb_mem_reg_in,
    input wb_reg_wr_in,
    output [4:0] wb_rd_out,
    output [31:0] wb_reg_wr_data_out,
    output wb_reg_wr_out    
);

    wire [31:0] reg_data;

    assign reg_data = wb_reg_in_sel_in[1] ? (wb_reg_in_sel_in[0] ? wb_pc4_in : wb_imm_in) : wb_alu_out_in;

    assign wb_reg_wr_data_out = wb_mem_reg_in ? wb_mem_data_in : reg_data;

    assign wb_rd_out = wb_rd_in;

    assign wb_reg_wr_out = wb_reg_wr_in;

endmodule