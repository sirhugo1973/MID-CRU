-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: loc_rfmt_tb
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 26/02/2019
--
-- version: 0.1
--
-- description: Testbench file for local card data reformatting module 
--
-- dependencies: loc_rfmt.vhd ; o2_h_syn.vhd; sig_defs_pkg.vhd; util_pkg.vhd
--					loc_rfmt_if.txt;
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@gmail.com)
--
-------------------------------------------------------------------------------
-- last changes: 07/04/2020 NB Full System Integration
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: <next thing to do>
-- <another thing to do>
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;

--=============================================================================
--Testbench entity declaration
--=============================================================================
entity loc_rfmt_tb is
end entity loc_rfmt_tb;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of loc_rfmt_tb is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================	
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	signal s_clk_i: std_logic;
	signal s_clk_running: boolean;
	signal s_loc_rfmtI: t_loc_rfmtI;
	signal s_loc_rfmtO: t_loc_rfmtO;
	
	constant c_SETTLING_TIME: time :=2 ns;
	
	signal s_reset_n_i: std_logic;
	
	--===============================================================================
	--Component Declaration
	--===============================================================================
	component loc_rfmt is
	port(
	--global input signals
	clk_i: in std_logic; --local bus clock
	reset_n_i: in std_logic; --reset =0: reset active
									 --      =1: no reset
	loc_rfmtI: in t_loc_rfmtI; --GBT data signals defined in sig_defs_pkg
	
	--global output signals
	loc_rfmtO: out t_loc_rfmtO
	);
	end component loc_rfmt;

	--===============================================================================
	--Architecture begin
	--===============================================================================
begin

	clk_240(s_clk_i,s_clk_running, 25); --Clock generator procedure
	
		
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	cmp_loc_rfmt : loc_rfmt
		port map(
			clk_i     => s_clk_i, 
			reset_n_i => s_reset_n_i, 
			loc_rfmtI => s_loc_rfmtI,
		   loc_rfmtO => s_loc_rfmtO
		);
		
	loc_rfmt_sim: process is
		file f_loc_rfmt_i: text;
		variable l_loc_rfmt_i: line;
		variable v_loc_rfmt_data_valid_i: std_logic;
		variable	v_loc_rfmt_isdata_i: std_logic;
		variable v_loc_rfmt_reg_data_i: std_logic_vector(7 downto 0);
		variable v_loc_rfmt_loc_data_i: std_logic_vector(7 downto 0);
		
	begin
	file_open(f_loc_rfmt_i,"C:\Users\natha\Documents\mid_cru_proto\modules\s1_pipe\gbt_rfmt\loc_rfmt\in_files\loc_rfmt_if.txt",read_mode);
	
	while not endfile(f_loc_rfmt_i) loop
		readline(f_loc_rfmt_i,l_loc_rfmt_i);
		read(l_loc_rfmt_i,v_loc_rfmt_data_valid_i);
		read(l_loc_rfmt_i,v_loc_rfmt_isdata_i);
		read(l_loc_rfmt_i,v_loc_rfmt_reg_data_i);
		read(l_loc_rfmt_i,v_loc_rfmt_loc_data_i);
		
		wait until rising_edge(s_clk_i);
		
		s_loc_rfmtI.loc_rfmt_data_valid_i<=v_loc_rfmt_data_valid_i;
		s_loc_rfmtI.loc_rfmt_is_data_i<=v_loc_rfmt_isdata_i;
		s_loc_rfmtI.loc_rfmt_reg_data_i<=v_loc_rfmt_reg_data_i;
		s_loc_rfmtI.loc_rfmt_loc_data_i<=v_loc_rfmt_loc_data_i;
	end loop;
	file_close(f_loc_rfmt_i);
	end process loc_rfmt_sim;

end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================