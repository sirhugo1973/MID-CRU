-- (C) 2001-2019 Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files from any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License Subscription 
-- Agreement, Intel FPGA IP License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Intel and sold by 
-- Intel or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.




LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY ram_s3_ram_1port_191_ef7qrwa IS
    PORT
    (
        address       : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        clock       : IN STD_LOGIC  := '1';
        data       : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        rden       : IN STD_LOGIC  := '1';
        wren       : IN STD_LOGIC;
        q       : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
END ram_s3_ram_1port_191_ef7qrwa;


ARCHITECTURE SYN OF ram_s3_ram_1port_191_ef7qrwa IS

    SIGNAL sub_wire0    : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
    q     <= sub_wire0 (63 DOWNTO 0);

    altera_syncram_component : altera_syncram
    GENERIC MAP (
            width_byteena_a  => 1,
            clock_enable_input_a  => "BYPASS",
            clock_enable_output_a  => "BYPASS",
            intended_device_family  => "Cyclone 10 GX",
            lpm_hint  => "ENABLE_RUNTIME_MOD=NO",
            lpm_type  => "altera_syncram",
            numwords_a  => 256,
            operation_mode  => "SINGLE_PORT",
            outdata_aclr_a  => "NONE",
            outdata_sclr_a  => "NONE",
            outdata_reg_a  => "CLOCK0",
            enable_force_to_zero  => "FALSE",
            power_up_uninitialized  => "FALSE",
            read_during_write_mode_port_a  => "DONT_CARE",
            widthad_a  => 8,
            width_a  => 64
    )
    PORT MAP (
        address_a => address,
        clock0 => clock,
        data_a => data,
        rden_a => rden,
        wren_a => wren,
        q_a => sub_wire0
    );



END SYN;

