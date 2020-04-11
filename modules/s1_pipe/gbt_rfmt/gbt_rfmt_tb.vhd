-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: gbt_rfmt_tb
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 26/02/2019
--
-- version: 0.1
--
-- description: Testbench for GBT Reformatting module 
--
-- dependencies: o2_h_syn.vhd sig_defs_pkg.vhd
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
-- TODO: Change file paths to relative paths
-- 
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

--=============================================================================
--Testbench entity declaration
--=============================================================================
entity gbt_rfmt_tb is
end entity gbt_rfmt_tb;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of gbt_rfmt_tb is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================	
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	signal s_clk_i: std_logic;
	signal s_clk_running: boolean;
	signal s_gbt_rfmtI: t_gbt_rfmtI;
	signal s_gbt_rfmtO: t_gbt_rfmtO;
	
	constant c_SETTLING_TIME: time :=2 ns;
	
	signal s_reset_n_i: std_logic;
	
	--===============================================================================
	--Component Declaration
	--===============================================================================
	component gbt_rfmt is
	port(
	--global input signals
	clk_i: in std_logic; --local bus clock
	reset_n_i: in std_logic; --reset =0: reset active
									 --      =1: no reset
	gbt_rfmtI: in t_gbt_rfmtI; --GBT data signals defined in sig_defs_pkg
	
	--global output signals
	gbt_rfmtO: out t_gbt_rfmtO
	);
	end component gbt_rfmt;

	--===============================================================================
	--Architecture begin
	--===============================================================================
begin

	clk_240(s_clk_i,s_clk_running, 25); --Clock generator procedure
	
		
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	cmp_gbt_rfmt : gbt_rfmt
		port map(
			clk_i     => s_clk_i, 
			reset_n_i => s_reset_n_i, 
			gbt_rfmtI => s_gbt_rfmtI,
		   gbt_rfmtO => s_gbt_rfmtO
		);
		
	gbt_rfmt_sim: process is
		file f_gbt_rfmt_i: text;
		variable l_gbt_rfmt_i: line;
		variable v_v_gbt_rfmt_gbt_data_valid_i: std_logic;
		variable v_gbt_rfmt_isdata_i: std_logic;
		variable v_gbt_rfmt_gbt_data_i: std_logic_vector(79 downto 0);
		
	begin
	file_open(f_gbt_rfmt_i,"C:\Users\natha\Documents\mid_cru_proto\modules\s1_pipe\gbt_rfmt\in_files\gbt_rfmt_if.txt",read_mode);
	
	while not endfile(f_gbt_rfmt_i) loop
		readline(f_gbt_rfmt_i,l_gbt_rfmt_i);
		read(l_gbt_rfmt_i,v_v_gbt_rfmt_gbt_data_valid_i);
		read(l_gbt_rfmt_i,v_gbt_rfmt_isdata_i);
		read(l_gbt_rfmt_i,v_gbt_rfmt_gbt_data_i);
		
		wait until rising_edge(s_clk_i);
		
		s_gbt_rfmtI.gbt_data_valid_i<=v_v_gbt_rfmt_gbt_data_valid_i;
		s_gbt_rfmtI.gbt_isdata_i<=v_gbt_rfmt_isdata_i;
		s_gbt_rfmtI.gbt_data_i<=v_gbt_rfmt_gbt_data_i;
	end loop;
	file_close(f_gbt_rfmt_i);
	end process gbt_rfmt_sim;

		output_gbt_rfmt: process
		
		file f_gbt_rfmt_o: text open write_mode is "C:\Users\natha\Documents\mid_cru_proto\modules\s1_pipe\gbt_rfmt\out_files\gbt_rfmt_of.txt";
		variable l_gbt_rfmt_o: line;
		
		begin
			--strobe the signals
			wait until rising_edge(s_clk_i);
			wait for c_SETTLING_TIME;
			
			write(l_gbt_rfmt_o, now, left, 10);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_v_o,right,20);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_7_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_7_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_7_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_7_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_6_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_6_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_6_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_6_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_5_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_5_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_5_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_5_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_4_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_4_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_4_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_4_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_3_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_3_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_3_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_3_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_2_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_2_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_2_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_2_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_1_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_1_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_1_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_1_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt22_0_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt21_0_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt12_0_o,right,70);
			write(l_gbt_rfmt_o,s_gbt_rfmtO.gbt_rfmt_data_mt11_0_o,right,70);
			
			writeline(f_gbt_rfmt_o, l_gbt_rfmt_o);
		end process output_gbt_rfmt;
			
		
end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================