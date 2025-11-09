module memregintf(
    input  [2:0] func3,
    input  [31:0] indata,
    output reg [31:0] outdata
);

    // assign immVal = {20'h00000,instr[31:20]};
    // wire [2:0] func3;
    
    // assign func3 = instr[14:12];

    always @(*) begin 
        case (func3)
            3'b000: outdata = {{25{indata[7]}}, indata[6:0]}; // LB type Instructions
            3'b001: outdata = {{17{indata[15]}},   indata[14:0]}; // LH type Instructions
            3'b100: outdata = {24'h000000, indata[7:0]}; // LBU type Instructions
            3'b101: outdata = {16'h0000, indata[15:0]}; // LHU type Instructions
            default: outdata = indata;
        endcase
    end

endmodule