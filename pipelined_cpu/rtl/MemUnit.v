module CPUMemIntf(
    
    input [31:0] mem_alu_out_in,
    input [31:0] mem_data_in,
    input [31:0] mem_rv2_in,
    input [31:0] mem_pc_imm_in,
    input [31:0] mem_pc4_in,
    input [31:0] mem_imm_in,

    input [4:0] mem_rd_in,
    input [1:0] mem_reg_in_sel_in,
    input [3:0] mem_dwe_in,
    input [2:0] mem_func3_in,
    input mem_mem_reg_in,
    input mem_reg_wr_in,
    
    output [31:0] mem_alu_out_out,
    output [31:0] mem_data_out,
    // output [31:0] mem_pc_imm_out,
    output [31:0] mem_pc4_out,
    output [31:0] mem_imm_out,
    output [3:0] mem_dwe_out,
    output [31:0] mem_daddr_out,
    output [31:0] mem_dwdata_out,  
    output [4:0] mem_rd_out,
    output [1:0] mem_reg_in_sel_out,
    output mem_mem_reg_out,
    output mem_reg_wr_out
);


    assign mem_dwe_out = mem_dwe_in;
    assign mem_daddr_out = mem_alu_out_in;
    assign mem_dwdata_out = mem_rv2_in; 

    memregintf umemreg(
        .func3(mem_func3_in),
        .indata(mem_data_in),
        .outdata(mem_data_out)
    );

    assign mem_alu_out_out = mem_alu_out_in;
    // assign mem_pc_imm_out = mem_pc_imm_in;
    assign mem_pc4_out = mem_pc4_in;
    assign mem_imm_out = mem_imm_in;
    assign mem_rd_out = mem_rd_in;
    assign mem_reg_in_sel_out = mem_reg_in_sel_in;
    assign mem_mem_reg_out = mem_mem_reg_in;
    assign mem_reg_wr_out = mem_reg_wr_in;

endmodule