module ForwardUnit(
    input [4:0] ex_rd_out,
    input ex_reg_wr_out,
    
    input [4:0] mem_rd_out,
    input mem_reg_wr_out,

    input [4:0] id_rs1_out,
    input [4:0] id_rs2_out,

    output reg [1:0] fwd_rs1_out,
    output reg [1:0] fwd_rs2_out
);

    always @(*) begin
        fwd_rs1_out = 2'b00;
        fwd_rs2_out = 2'b00;
        if(ex_rd_out != 0 && ex_reg_wr_out) begin 
            if(id_rs1_out == ex_rd_out) fwd_rs1_out[1] = 1;
            if(id_rs2_out == ex_rd_out) fwd_rs2_out[1] = 1;
        end
        if(mem_rd_out != 0 && mem_reg_wr_out) begin 
            if(id_rs1_out == mem_rd_out) fwd_rs1_out[0] = 1;
            if(id_rs2_out == mem_rd_out) fwd_rs2_out[0] = 1;
        end
    end

endmodule