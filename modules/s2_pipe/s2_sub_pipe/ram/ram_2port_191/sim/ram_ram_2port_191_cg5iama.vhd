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

ENTITY ram_ram_2port_191_cg5iama IS
    PORT
    (
        address_a       : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        address_b       : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        clock       : IN STD_LOGIC  := '1';
        data_a       : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        data_b       : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        rden_a       : IN STD_LOGIC  := '1';
        rden_b       : IN STD_LOGIC  := '1';
        wren_a       : IN STD_LOGIC  := '0';
        wren_b       : IN STD_LOGIC  := '0';
        q_a       : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        q_b       : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
END ram_ram_2port_191_cg5iama;


ARCHITECTURE SYN OF ram_ram_2port_191_cg5iama IS

    SIGNAL sub_wire0    : STD_LOGIC_VECTOR (63 DOWNTO 0);
    SIGNAL sub_wire1    : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
    q_a     <= sub_wire0 (63 DOWNTO 0);
    q_b     <= sub_wire1 (63 DOWNTO 0);

    altera_syncram_component : altera_syncram
    GENERIC MAP (
            address_reg_b  => "CLOCK0",
            clock_enable_input_a  => "BYPASS",
            clock_enable_input_b  => "BYPASS",
            clock_enable_output_a  => "BYPASS",
            clock_enable_output_b  => "BYPASS",
            indata_reg_b  => "CLOCK0",
            intended_device_family  => "Cyclone 10 GX",
            lpm_type  => "altera_syncram",
            numwords_a  => 16,
            numwords_b  => 16,
            operation_mode  => "BIDIR_DUAL_PORT",
            outdata_aclr_a  => "NONE",
            outdata_sclr_a  => "NONE",
            outdata_aclr_b  => "NONE",
            outdata_sclr_b  => "NONE",
            outdata_reg_a  => "CLOCK0",
            outdata_reg_b  => "CLOCK0",
            power_up_uninitialized  => "FALSE",
            ram_block_type  => "M20K",
            read_during_write_mode_mixed_ports  => "OLD_DATA",
            read_during_write_mode_port_a  => "NEW_DATA_NO_NBE_READ",
            read_during_write_mode_port_b  => "NEW_DATA_NO_NBE_READ",
            widthad_a  => 4,
            widthad_b  => 4,
            width_a  => 64,
            width_b  => 64,
            width_byteena_a  => 1,
            width_byteena_b  => 1
    )
    PORT MAP (
        address_a => address_a,
        address_b => address_b,
        clock0 => clock,
        data_a => data_a,
        data_b => data_b,
        rden_a => rden_a,
        rden_b => rden_b,
        wren_a => wren_a,
        wren_b => wren_b,
        q_a => sub_wire0,
        q_b => sub_wire1
    );



END SYN;

