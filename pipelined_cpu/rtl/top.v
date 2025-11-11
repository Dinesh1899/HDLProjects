module top_module(
    input clk,
    input reset
);

    wire [31:0] iaddr, idata, daddr, drdata, dwdata;
    wire [3:0] dwe;

    // Instantiate the CPU
    cpu u1(
        .clk(clk),
        .reset(reset),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .dwe(dwe)
    );

    imem u2(
        .iaddr(iaddr),
        .idata(idata)
    );

    dmem u3(
        .clk(clk),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .dwe(dwe)
    );


endmodule