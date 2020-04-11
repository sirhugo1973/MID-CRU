-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: gbt_sub_sync_tb.vhd)
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 09/04/2020
--
-- version: 0.1
--
-- description: Testbench for GBT Sub Synchronization Module
--
-- dependencies: gbt_sync.vhd; util_pkg.vhd; sig_defs_pkg.vhd; var_defs_pkg.vhd;
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@gmail.com)
--
-------------------------------------------------------------------------------
-- last changes: 08/04/2020 NB Full System Integration
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: Change file paths to relative paths
-- <another thing to do>
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

entity gbt_sub_sync_tb is
end entity gbt_sub_sync_tb;

architecture main of gbt_sub_sync_tb is

	--================================================================
	--Signal Declaration
	--================================================================
	
	signal s_clk_i: std_logic;
	signal s_reset_n_i: std_logic;
	signal s_gbt_sub_syncI_i: t_gbt_sub_syncI;
	signal s_gbt_sub_syncO_i: t_gbt_sub_syncO;
	signal s_gbt_s2_busy_i: std_logic;
	signal s_clockrunning: boolean;

	
	constant c_settling_time: time :=2 ns;
	
	--===============================================================
	--Component Declaration
	--===============================================================
	
	component gbt_sub_sync is
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  gbt_s2_busy_i: in std_logic;
	  gbt_sub_syncI: in t_gbt_sub_syncI;
	  gbt_sub_syncO: out t_gbt_sub_syncO
	);
	end component gbt_sub_sync;
	
	begin
	
	clk_240(s_clk_i,s_clockrunning,25);
	--===============================================================
	--Component Instantiation
	--===============================================================
	
	UUT: gbt_sub_sync
	port map(clk_i=>s_clk_i,
				reset_n_i=>s_reset_n_i,
				gbt_s2_busy_i=>s_gbt_s2_busy_i,
				gbt_sub_syncI=>s_gbt_sub_syncI_i,
				gbt_sub_syncO=>s_gbt_sub_syncO_i);
				
	input_gbt_sub_sync: process is
		file f_gbt_sub_sync_i: text;
		variable l_gbt_sub_sync_i: line;
		variable v_gbt_rfmt_data_v_i: std_logic_vector(7 downto 0);
		variable v_gbt_rfmt_data_7_i,
					v_gbt_rfmt_data_6_i,
					v_gbt_rfmt_data_5_i,
					v_gbt_rfmt_data_4_i,
					v_gbt_rfmt_data_3_i,
					v_gbt_rfmt_data_2_i,
					v_gbt_rfmt_data_1_i,
					v_gbt_rfmt_data_0_i: std_logic_vector(63 downto 0);

	begin
	file_open(f_gbt_sub_sync_i,"C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\gbt_sync\gbt_sub_sync\in_files\gbt_sub_sync_if.txt",read_mode);
	
	while not endfile(f_gbt_sub_sync_i) loop
	
		readline(f_gbt_sub_sync_i, l_gbt_sub_sync_i);
		read(l_gbt_sub_sync_i,v_gbt_rfmt_data_v_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_7_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_6_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_5_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_4_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_3_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_2_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_1_i);
		read(l_gbt_sub_sync_i, v_gbt_rfmt_data_0_i);
		
		wait until rising_edge(s_clk_i);
		
		s_gbt_sub_syncI_i.gbt_rfmt_data_v_i<=v_gbt_rfmt_data_v_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_7_i<=v_gbt_rfmt_data_7_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_6_i<=v_gbt_rfmt_data_6_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_5_i<=v_gbt_rfmt_data_5_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_4_i<=v_gbt_rfmt_data_4_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_3_i<=v_gbt_rfmt_data_3_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_2_i<=v_gbt_rfmt_data_2_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_1_i<=v_gbt_rfmt_data_1_i;
		s_gbt_sub_syncI_i.gbt_rfmt_data_0_i<=v_gbt_rfmt_data_0_i;
	end loop;
	file_close(f_gbt_sub_sync_i);
	end process input_gbt_sub_sync;
	
	s2:process is
	begin
		wait until rising_edge(s_clk_i);
		if s_gbt_sub_syncO_i.gbt_sub_sync_sync_o='1' then
			s_gbt_s2_busy_i<='1';
		end if;
	end process;
	
	output_gbt_sub_sync: process
	
	file f_gbt_sub_sync_o: text open write_mode is "C:\Users\natha\Documents\mid_cru_proto\modules\s1_pipe\gbt_sync\gbt_sub_sync\out_files\gbt_sub_sync_of.txt";
	variable l_gbt_sub_sync_o: line;
	variable v_s23_data_v_o: std_logic;
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_gbt_sub_sync_o, now, left, 10);
		write(l_gbt_sub_sync_o, s_gbt_sub_syncO_i.gbt_sub_sync_data_v_o, right, 5);
		write(l_gbt_sub_sync_o, s_gbt_sub_syncO_i.gbt_sub_sync_data_o, right, 70);
		
		writeline(f_gbt_sub_sync_o, l_gbt_sub_sync_o);
	end process output_gbt_sub_sync;
	
end main;