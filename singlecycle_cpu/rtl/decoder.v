`include "../rtl/parameters.vh"

module decoder(
    input [31:0] instr,
    output [1:0] aluSrc,
    output [1:0] reginsel,
    output reg [1:0] branch,
    output reg [3:0] aluOp,
    output [31:0] immVal,
    output reg [3:0] dwe,
    output memReg,
    output regWr
);

    wire [6:0] opcode;

    assign opcode = instr[6:0];
    // 1 --> PC; AUIPC
    assign aluSrc[0] = (opcode == `AUIPC);
    // 1 --> Immval 0 --> for rtype
    assign aluSrc[1] = (opcode == `ITYPE | opcode == `LOAD | opcode == `STORE | opcode == `AUIPC);

    assign memReg = (opcode == `LOAD); // LOAD Instruction
    
    // Reg In Sel, select among alu_out, pc4, immVal
    // pc4 for JAL, JALR; immVal for LUI; 
    assign reginsel[1] = (opcode == `JAL | opcode == `JALR | opcode == `LUI);
    assign reginsel[0] = (opcode == `JAL | opcode == `JALR);

    assign regWr = ~(opcode == `STORE | opcode == `SBTYPE); // Except for STORE Instruction
    // assign dwe = (opcode == STORE) ? 4'hf : 4'h0; // STORE Instruction

    always @(*) begin     
        case(opcode) 
            `RTYPE : aluOp = {instr[30], instr[14:12]};
            `ITYPE : aluOp = {1'b0, instr[14:12]};
            `SBTYPE: begin 
                case(instr[14:13]) 
                    2'b00: aluOp = 4'b1000;
                    2'b10: aluOp = 4'b0010;
                    2'b11: aluOp = 4'b0011;
                    default: aluOp = 4'b0000;
                endcase
            end
            default: aluOp = 4'b0000;
        endcase
    end
    

    always @(*) begin
        if(opcode == `STORE) begin 
            case(instr[14:12]) 
                3'b000:  dwe = 4'b0001;
                3'b001:  dwe = 4'b0011;
                3'b010:  dwe = 4'b1111;
                default: dwe = 4'b0000;
            endcase
        end
        else dwe = 4'b0000;
    end


    always @(*) begin
        case(opcode) 
            `SBTYPE : branch = 2'b01; // Conditional Branch
            `JAL : branch = 2'b11; // JAL
            `JALR : branch = 2'b10; // JALR
            default: branch = 2'b00;
        endcase
    end

    immgen uimm(
        .instr(instr),
        .immVal(immVal)
    );


endmodule