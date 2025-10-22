module ProgramCounter(
    input [31:0] pc,
    input [31:0] alu_out,
    input [1:0] branch,
    input taken,
    output reg[31:0] pc_next,
    output [31:0] pc4
);

    assign pc4 = pc + 32'd4;

    always @(*) begin
        // if(~branch) pc_next = pc + 32'd4;
        // else begin
        //     if(branch[1]) pc_next = alu_out;
        //     else if(~taken) pc_next = pc + 32'd4;
        //     else begin 
        //         pc_next = alu_out;
        //     end
        // end

        case(branch) 
            2'b00: pc_next = pc4; // Not a Branch
            2'b01: pc_next = taken ? alu_out : pc4; // Conditional Branch
            2'b10: pc_next = alu_out; // JALR
            2'b11: pc_next = alu_out; // JAL
            default: pc_next = pc4;
        endcase
    end

endmodule