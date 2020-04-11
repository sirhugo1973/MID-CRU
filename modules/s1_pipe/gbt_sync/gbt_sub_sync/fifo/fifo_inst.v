	fifo u0 (
		.data  (_connected_to_data_),  //   input,  width = 64,  fifo_input.datain
		.wrreq (_connected_to_wrreq_), //   input,   width = 1,            .wrreq
		.rdreq (_connected_to_rdreq_), //   input,   width = 1,            .rdreq
		.clock (_connected_to_clock_), //   input,   width = 1,            .clk
		.sclr  (_connected_to_sclr_),  //   input,   width = 1,            .sclr
		.q     (_connected_to_q_),     //  output,  width = 64, fifo_output.dataout
		.empty (_connected_to_empty_)  //  output,   width = 1,            .empty
	);

