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

    always @(posedge clk or posedge reset) begin
        if(reset) PC <= 0;
        else PC <= PC + 4;
    end


    assign iaddr = PC;

    wire [31:0] id_idata_in, id_pc_in;

    FetchDecodeIntf ifidreg(
        .clk(clk),
        .reset(reset),
        .if_idata_in(idata),
        .if_pc_in(PC),
        .if_idata_out(id_idata_in),
        .if_pc_out(id_pc_in)
    );

    wire id_reg_wr_in;
    wire [4:0] id_rd_in;
    wire [31:0] id_reg_data_in;

    wire [1:0] id_alu_src_out;
    wire [3:0] id_alu_op_out;
    wire [1:0] id_branch_out;
    wire [1:0] id_reg_in_sel_out;
    wire [3:0] id_dwe_out;
    wire [2:0] id_func3_out;
    wire id_mem_reg_out;
    wire id_reg_wr_out;

    wire [31:0] id_rv1_out;
    wire [31:0] id_rv2_out;
    wire [31:0] id_imm_out;
    wire [4:0] id_rd_out;
    wire [31:0] id_pc_out;
    wire [31:0] id_x31_out;

    Decode udecode(
        .clk(clk),
        .id_idata_in(id_idata_in),
        .id_pc_in(id_pc_in),
        .id_reg_wr_in(id_reg_wr_in),
        .id_rd_in(id_rd_in),
        .id_reg_data_in(id_reg_data_in),
        .id_alu_src_out(id_alu_src_out),
        .id_alu_op_out(id_alu_op_out),
        .id_branch_out(id_branch_out),
        .id_reg_in_sel_out(id_reg_in_sel_out),
        .id_dwe_out(id_dwe_out),
        .id_func3_out(id_func3_out),
        .id_mem_reg_out(id_mem_reg_out),
        .id_reg_wr_out(id_reg_wr_out),
        .id_rv1_out(id_rv1_out),
        .id_rv2_out(id_rv2_out),
        .id_imm_out(id_imm_out),
        .id_rd_out(id_rd_out),
        .id_pc_out(id_pc_out),
        .id_x31_out(id_x31_out)   
    );

    wire [1:0] ex_alu_src_in;
    wire [3:0] ex_alu_op_in;
    wire [1:0] ex_branch_in;
    wire [1:0] ex_reg_in_sel_in;
    wire [3:0] ex_dwe_in;
    wire [2:0] ex_func3_in;
    wire ex_mem_reg_in;
    wire ex_reg_wr_in;

    wire [31:0] ex_rv1_in;
    wire [31:0] ex_rv2_in;
    wire [31:0] ex_imm_in;
    wire [4:0] ex_rd_in;
    wire [31:0] ex_pc_in;
    wire [31:0] ex_x31_in;

    wire [31:0] ex_alu_out_out;
    wire ex_alu_zero_out;
    wire [31:0] ex_rv2_out;

    wire [31:0] ex_pc_imm_out;
    wire [31:0] ex_imm_out;

    wire [4:0] ex_rd_out;
    wire [1:0] ex_reg_in_sel_out;
    wire [3:0] ex_dwe_out;
    wire [2:0] ex_func3_out;
    wire ex_mem_reg_out;
    wire ex_reg_wr_out;

    DecodeExecuteIntf idexreg(
        .clk(clk),
        .reset(reset),
        .id_alu_src_out(id_alu_src_out),
        .id_alu_op_out(id_alu_op_out),
        .id_branch_out(id_branch_out),
        .id_reg_in_sel_out(id_reg_in_sel_out),
        .id_dwe_out(id_dwe_out),
        .id_func3_out(id_func3_out),
        .id_mem_reg_out(id_mem_reg_out),
        .id_reg_wr_out(id_reg_wr_out),
        .id_rv1_out(id_rv1_out),
        .id_rv2_out(id_rv2_out),
        .id_imm_out(id_imm_out),
        .id_rd_out(id_rd_out),
        .id_pc_out(id_pc_out),
        .ex_alu_src_in(ex_alu_src_in),
        .ex_alu_op_in(ex_alu_op_in),
        .ex_branch_in(ex_branch_in),
        .ex_reg_in_sel_in(ex_reg_in_sel_in),
        .ex_dwe_in(ex_dwe_in),
        .ex_func3_in(ex_func3_in),
        .ex_mem_reg_in(ex_mem_reg_in),
        .ex_reg_wr_in(ex_reg_wr_in),
        .ex_rv1_in(ex_rv1_in),
        .ex_rv2_in(ex_rv2_in),
        .ex_imm_in(ex_imm_in),
        .ex_rd_in(ex_rd_in),
        .ex_pc_in(ex_pc_in)
    );

    ExecuteUnit uexec(
        .ex_alu_src_in(ex_alu_src_in),
        .ex_alu_op_in(ex_alu_op_in),
        .ex_branch_in(ex_branch_in),
        .ex_reg_in_sel_in(ex_reg_in_sel_in),
        .ex_dwe_in(ex_dwe_in),
        .ex_func3_in(ex_func3_in),
        .ex_mem_reg_in(ex_mem_reg_in),
        .ex_reg_wr_in(ex_reg_wr_in),
        .ex_rv1_in(ex_rv1_in),
        .ex_rv2_in(ex_rv2_in),
        .ex_imm_in(ex_imm_in),
        .ex_rd_in(ex_rd_in),
        .ex_pc_in(ex_pc_in),
        .ex_alu_out_out(ex_alu_out_out),
        .ex_alu_zero_out(ex_alu_zero_out),
        .ex_rv2_out(ex_rv2_out),
        .ex_pc_imm_out(ex_pc_imm_out),
        .ex_imm_out(ex_imm_out),
        .ex_rd_out(ex_rd_out),
        .ex_reg_in_sel_out(ex_reg_in_sel_out),
        .ex_dwe_out(ex_dwe_out),
        .ex_func3_out(ex_func3_out),
        .ex_mem_reg_out(ex_mem_reg_out),
        .ex_reg_wr_out(ex_reg_wr_out)        
    );
    
    ///////////////////////////
    wire [31:0] mem_alu_out_in;
    wire [31:0] mem_rv2_in;
    wire [31:0] mem_pc_imm_in;
    wire [31:0] mem_imm_in;

    wire [4:0] mem_rd_in;
    wire [1:0] mem_reg_in_sel_in;
    wire [3:0] mem_dwe_in;
    wire [2:0] mem_func3_in;
    wire mem_mem_reg_in;
    wire mem_reg_wr_in;
    ///////////////////////////

    wire [31:0] mem_alu_out_out;
    wire [31:0] mem_data_out;
    wire [31:0] mem_pc_imm_out;
    wire [31:0] mem_imm_out;
    wire [4:0] mem_rd_out;
    wire [1:0] mem_reg_in_sel_out;
    wire mem_mem_reg_out;
    wire mem_reg_wr_out;

    ExecuteMemIntf exmemreg(
        .clk(clk),
        .reset(reset),
        .ex_alu_out_out(ex_alu_out_out),
        .ex_alu_zero_out(ex_alu_zero_out),
        .ex_rv2_out(ex_rv2_out),
        .ex_pc_imm_out(ex_pc_imm_out),
        .ex_imm_out(ex_imm_out),
        .ex_rd_out(ex_rd_out),
        .ex_reg_in_sel_out(ex_reg_in_sel_out),
        .ex_dwe_out(ex_dwe_out),
        .ex_func3_out(ex_func3_out),
        .ex_mem_reg_out(ex_mem_reg_out),
        .ex_reg_wr_out(ex_reg_wr_out),
        .mem_alu_out_in(mem_alu_out_in),
        .mem_alu_zero_in(mem_alu_zero_in),
        .mem_rv2_in(mem_rv2_in),
        .mem_pc_imm_in(mem_pc_imm_in),
        .mem_imm_in(mem_imm_in),
        .mem_rd_in(mem_rd_in),
        .mem_reg_in_sel_in(mem_reg_in_sel_in),
        .mem_dwe_in(mem_dwe_in),
        .mem_func3_in(mem_func3_in),
        .mem_mem_reg_in(mem_mem_reg_in),
        .mem_reg_wr_in(mem_reg_wr_in)        
    );


    CPUMemIntf ucpumemintf(
        .mem_alu_out_in(mem_alu_out_in),
        .mem_data_in(drdata),
        .mem_rv2_in(mem_rv2_in),
        .mem_pc_imm_in(mem_pc_imm_in),
        .mem_imm_in(mem_imm_in),
        .mem_rd_in(mem_rd_in),
        .mem_reg_in_sel_in(mem_reg_in_sel_in),
        .mem_dwe_in(mem_dwe_in),
        .mem_func3_in(mem_func3_in),
        .mem_mem_reg_in(mem_mem_reg_in),
        .mem_reg_wr_in(mem_reg_wr_in),
        .mem_alu_out_out(mem_alu_out_out),
        .mem_data_out(mem_data_out),
        .mem_pc_imm_out(mem_pc_imm_out),
        .mem_imm_out(mem_imm_out),
        .mem_dwe_out(dwe),
        .mem_daddr_out(daddr),
        .mem_dwdata_out(dwdata),
        .mem_rd_out(mem_rd_out),
        .mem_reg_in_sel_out(mem_reg_in_sel_out),
        .mem_mem_reg_out(mem_mem_reg_out),
        .mem_reg_wr_out(mem_reg_wr_out)
    );

    wire [31:0] wb_alu_out_in;
    wire [31:0] wb_mem_data_in;
    wire [31:0] wb_pc_imm_in;
    wire [31:0] wb_imm_in;
    wire [4:0] wb_rd_in;
    wire [1:0] wb_reg_in_sel_in;
    wire wb_mem_reg_in;
    wire wb_reg_wr_in;

    MemWBIntf memwbreg(
        .clk(clk),
        .reset(reset),
        .mem_alu_out_out(mem_alu_out_out),
        .mem_data_out(mem_data_out),
        .mem_pc_imm_out(mem_pc_imm_out),
        .mem_imm_out(mem_imm_out),
        .mem_rd_out(mem_rd_out),
        .mem_reg_in_sel_out(mem_reg_in_sel_out),
        .mem_mem_reg_out(mem_mem_reg_out),
        .mem_reg_wr_out(mem_reg_wr_out),

        .wb_alu_out_in(wb_alu_out_in),
        .wb_mem_data_in(wb_mem_data_in),
        .wb_pc_imm_in(wb_pc_imm_in),
        .wb_imm_in(wb_imm_in),
        .wb_rd_in(wb_rd_in),
        .wb_reg_in_sel_in(wb_reg_in_sel_in),
        .wb_mem_reg_in(wb_mem_reg_in),
        .wb_reg_wr_in(wb_reg_wr_in)
    );

    wire [4:0] wb_rd_out;
    wire [31:0] wb_reg_wr_data_out;
    wire wb_reg_wr_out;

    WBUnit uwbunit(
        .wb_alu_out_in(wb_alu_out_in),
        .wb_mem_data_in(wb_mem_data_in),
        .wb_pc_imm_in(wb_pc_imm_in),
        .wb_imm_in(wb_imm_in),
        .wb_rd_in(wb_rd_in),
        .wb_reg_in_sel_in(wb_reg_in_sel_in),
        .wb_mem_reg_in(wb_mem_reg_in),
        .wb_reg_wr_in(wb_reg_wr_in),
        .wb_rd_out(wb_rd_out),
        .wb_reg_wr_data_out(wb_reg_wr_data_out),
        .wb_reg_wr_out(wb_reg_wr_out)
    );

    assign id_reg_wr_in = wb_reg_wr_out;
    assign id_rd_in = wb_rd_out;
    assign id_reg_data_in = wb_reg_wr_data_out;


endmodule