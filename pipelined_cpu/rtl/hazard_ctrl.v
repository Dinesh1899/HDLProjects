module HazardDetector(
    input [1:0] branch,
    input [31:0] pc_imm,
    input [31:0] alu_out,
    input alu_zero,
    input [2:0] func3,
    input ex_mem_reg_in,
    input [4:0] ex_rd_in,
    input [4:0] id_rs1_out,
    input [4:0] id_rs2_out,
    input [1:0] id_alu_src_out,
    output [1:0] is_stall,
    output [31:0] pc_branch
);

    reg cb_taken; // Conditional Branch Taken
    reg [31:0] pc_next;
    wire is_branch_stall;
    wire is_load_stall;

    assign pc_branch = pc_next;

    assign is_branch_stall = (cb_taken & branch[0]) | branch[1];
    assign is_load_stall = (ex_mem_reg_in) & (((id_rs1_out == ex_rd_in) & ~id_alu_src_out[0]) | (((id_rs2_out == ex_rd_in) & ~id_alu_src_out[1])));

    assign is_stall = {is_branch_stall, is_load_stall};

    always @(*) begin
        case(func3) 
            3'b000 : cb_taken = alu_zero;
            3'b001 : cb_taken = ~alu_zero;
            3'b100 : cb_taken = ~alu_zero;
            3'b101 : cb_taken = alu_zero;
            3'b110 : cb_taken = ~alu_zero;
            3'b111 : cb_taken = alu_zero;            
            default: cb_taken = 0;
        endcase
    end

    always @(*) begin
        case(branch) 
            2'b01: pc_next = cb_taken ? pc_imm : 0; // Conditional Branch
            2'b10: pc_next = alu_out; // JALR
            2'b11: pc_next = pc_imm; // JAL
            2'b00: pc_next = 0;
            default: pc_next = 0;
        endcase
    end    


endmodule