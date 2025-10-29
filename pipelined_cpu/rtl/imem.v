module imem(
    input [31:0] iaddr,
    output [31:0] idata
);
    reg [31:0] m [0:127];
    initial begin 
        $readmemh({`TESTDIR, "/idata.mem"}, m); 
    end

    assign idata = m[iaddr[31:2]];
	 
endmodule
