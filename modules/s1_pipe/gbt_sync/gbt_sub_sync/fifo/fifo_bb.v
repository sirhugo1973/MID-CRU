module fifo (
		input  wire [63:0] data,  //  fifo_input.datain
		input  wire        wrreq, //            .wrreq
		input  wire        rdreq, //            .rdreq
		input  wire        clock, //            .clk
		input  wire        sclr,  //            .sclr
		output wire [63:0] q,     // fifo_output.dataout
		output wire        empty  //            .empty
	);
endmodule

