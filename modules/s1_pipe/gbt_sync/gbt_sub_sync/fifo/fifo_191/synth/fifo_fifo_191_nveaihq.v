// (C) 2001-2019 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module  fifo_fifo_191_nveaihq  (
    clock,
    data,
    rdreq,
    sclr,
    wrreq,
    empty,
    q);

    input    clock;
    input  [63:0]  data;
    input    rdreq;
    input    sclr;
    input    wrreq;
    output   empty;
    output [63:0]  q;

    wire  sub_wire0;
    wire [63:0] sub_wire1;
    wire  empty = sub_wire0;
    wire [63:0] q = sub_wire1[63:0];

    scfifo  scfifo_component (
                .clock (clock),
                .data (data),
                .rdreq (rdreq),
                .sclr (sclr),
                .wrreq (wrreq),
                .empty (sub_wire0),
                .q (sub_wire1),
                .aclr (),
                .almost_empty (),
                .almost_full (),
                .eccstatus (),
                .full (),
                .usedw ());
    defparam
        scfifo_component.add_ram_output_register  = "ON",
        scfifo_component.enable_ecc  = "FALSE",
        scfifo_component.intended_device_family  = "Cyclone 10 GX",
        scfifo_component.lpm_hint  = "RAM_BLOCK_TYPE=MLAB",
        scfifo_component.lpm_numwords  = 8,
        scfifo_component.lpm_showahead  = "OFF",
        scfifo_component.lpm_type  = "scfifo",
        scfifo_component.lpm_width  = 64,
        scfifo_component.lpm_widthu  = 3,
        scfifo_component.overflow_checking  = "ON",
        scfifo_component.underflow_checking  = "ON",
        scfifo_component.use_eab  = "ON";


endmodule


