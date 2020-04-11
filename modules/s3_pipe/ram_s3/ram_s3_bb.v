module ram_s3 (
		input  wire [63:0] data,    //    data.datain
		output wire [63:0] q,       //       q.dataout
		input  wire [7:0]  address, // address.address
		input  wire        wren,    //    wren.wren
		input  wire        clock,   //   clock.clk
		input  wire        rden     //    rden.rden
	);
endmodule

