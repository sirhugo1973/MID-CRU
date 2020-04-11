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

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY fifo_fifo_191_nveaihq IS
    PORT
    (
        clock       : IN STD_LOGIC;
        data       : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        rdreq       : IN STD_LOGIC;
        sclr       : IN STD_LOGIC;
        wrreq       : IN STD_LOGIC;
        empty       : OUT STD_LOGIC;
        q       : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
END fifo_fifo_191_nveaihq;


ARCHITECTURE SYN OF fifo_fifo_191_nveaihq IS

    SIGNAL sub_wire0    : STD_LOGIC ;
    SIGNAL sub_wire1    : STD_LOGIC_VECTOR (63 DOWNTO 0);



    COMPONENT  scfifo
    GENERIC (
        add_ram_output_register  : STRING;
        enable_ecc  : STRING;
        intended_device_family  : STRING;
        lpm_hint  : STRING;
        lpm_numwords  : NATURAL;
        lpm_showahead  : STRING;
        lpm_type  : STRING;
        lpm_width  : NATURAL;
        lpm_widthu  : NATURAL;
        overflow_checking  : STRING;
        underflow_checking  : STRING;
        use_eab  : STRING
    );
    PORT (
        clock   : IN STD_LOGIC;
        data   : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
        rdreq   : IN STD_LOGIC;
        sclr   : IN STD_LOGIC;
        wrreq   : IN STD_LOGIC;
        empty   : OUT STD_LOGIC;
        q   : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    );
    END COMPONENT;

BEGIN
    empty     <= sub_wire0;
    q     <= sub_wire1 (63 DOWNTO 0);

    scfifo_component : scfifo
    GENERIC MAP (
            add_ram_output_register  => "ON",
            enable_ecc  => "FALSE",
            intended_device_family  => "Cyclone 10 GX",
            lpm_hint  => "RAM_BLOCK_TYPE=MLAB",
            lpm_numwords  => 8,
            lpm_showahead  => "OFF",
            lpm_type  => "scfifo",
            lpm_width  => 64,
            lpm_widthu  => 3,
            overflow_checking  => "ON",
            underflow_checking  => "ON",
            use_eab  => "ON"
    )
    PORT MAP (
        clock => clock,
        data => data,
        rdreq => rdreq,
        sclr => sclr,
        wrreq => wrreq,
        empty => sub_wire0,
        q => sub_wire1
    );



END SYN;

