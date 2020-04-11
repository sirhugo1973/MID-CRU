-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s1_pipe_tb.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: $Date: 07/04/2020
--
-- version: 0.1
--
-- description: Testbench for Stage 1 Pipeline
--
-- dependencies: o2_h_syn.vhd sig_defs_pkg.vhd
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@hotmail.com)
--
-------------------------------------------------------------------------------
-- last changes: 07/04/2020 NB Full System Integration
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: Change file paths to relative paths
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
entity s1_pipe_tb is
end entity s1_pipe_tb;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of s1_pipe_tb is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================	
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	signal s_clk_i: std_logic;
	signal s_reset_n_i: std_logic;
	signal s_s2_busy_i: std_logic;
	signal s_clk_running: boolean;
	signal s_s1_pipeI: t_gbt_rfmtI;
	signal s_s1_pipeO: t_gbt_fifoO;
	signal s_s1_data_v_o: std_logic;
	
	constant c_SETTLING_TIME: time :=2 ns;
		
	--===============================================================================
	--Component Declaration
	--===============================================================================
	component s1_pipe is
	port
	(
	  clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s2_busy_i: in std_logic;
	  s1_pipeI: in t_gbt_rfmtI;
	  s1_pipeO: out t_gbt_fifoO);
	end component s1_pipe;

	--===============================================================================
	--Architecture begin
	--===============================================================================
begin

	clk_240(s_clk_i,s_clk_running, 60); --Clock generator procedure
	
		
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	UUT : s1_pipe
		port map(
			clk_i=>s_clk_i,
			reset_n_i=>s_reset_n_i,
			s2_busy_i=>s_s2_busy_i,
			s1_pipeI=>s_s1_pipeI,
			s1_pipeO=>s_s1_pipeO
		);
		
	s1_pipe_sim: process is
		file f_s1_pipe_i: text;
		variable l_s1_pipe_i: line;
		variable v_v_gbt_data_valid_i: std_logic;
		variable v_gbt_isdata_i: std_logic;
		variable v_gbt_data_i: std_logic_vector(79 downto 0);
		
	begin
	file_open(f_s1_pipe_i,"C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\in_files\s1_pipe_if.txt",read_mode);
	
	while not endfile(f_s1_pipe_i) loop
		readline(f_s1_pipe_i,l_s1_pipe_i);
		read(l_s1_pipe_i,v_v_gbt_data_valid_i);
		read(l_s1_pipe_i,v_gbt_isdata_i);
		read(l_s1_pipe_i,v_gbt_data_i);
		
		wait until rising_edge(s_clk_i);
		
		s_s1_pipeI.gbt_data_valid_i<=v_v_gbt_data_valid_i;
		s_s1_pipeI.gbt_isdata_i<=v_gbt_isdata_i;
		s_s1_pipeI.gbt_data_i<=v_gbt_data_i;
	end loop;
	file_close(f_s1_pipe_i);
	end process s1_pipe_sim;

	s2:process is
	begin
		wait until rising_edge(s_clk_i);
		if s_s1_pipeO.gbt_fifo_sync_o='1' then
			s_s2_busy_i<='1';
		end if;
	end process s2;
	
	output_s1_pipe_mt22: process
	
	file f_s1_pipe_mt22_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\out_files\s1_pipe_mt22_td.txt";
	variable l_s1_pipe_mt22_o: line;
	variable v_s23_data_v_o: std_logic;
	variable v_s1_pipe_sync_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s1_pipe_mt22_o, now, left, 10);
		write(l_s1_pipe_mt22_o,s_s1_pipeO.gbt_fifo_sync_o, right,5);
		write(l_s1_pipe_mt22_o, s_s1_pipeO.gbt_fifo_data_v_o, right, 5);
		write(l_s1_pipe_mt22_o, s_s1_pipeO.gbt_fifo_data_mt22_o, right, 70);
		
		writeline(f_s1_pipe_mt22_o, l_s1_pipe_mt22_o);
	end process output_s1_pipe_mt22;
	
	output_s1_pipe_mt21: process
	
	file f_s1_pipe_mt21_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\out_files\s1_pipe_mt21_td.txt";
	variable l_s1_pipe_mt21_o: line;
	variable v_s23_data_v_o: std_logic;
	variable v_s1_pipe_sync_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s1_pipe_mt21_o, now, left, 10);
		write(l_s1_pipe_mt21_o,s_s1_pipeO.gbt_fifo_sync_o, right,5);
		write(l_s1_pipe_mt21_o, s_s1_pipeO.gbt_fifo_data_v_o, right, 5);
		write(l_s1_pipe_mt21_o, s_s1_pipeO.gbt_fifo_data_mt21_o, right, 70);
		
		writeline(f_s1_pipe_mt21_o, l_s1_pipe_mt21_o);
	end process output_s1_pipe_mt21;
	
	output_s1_pipe_mt12: process
	
	file f_s1_pipe_mt12_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\out_files\s1_pipe_mt12_td.txt";
	variable l_s1_pipe_mt12_o: line;
	variable v_s23_data_v_o: std_logic;
	variable v_s1_pipe_sync_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s1_pipe_mt12_o, now, left, 10);
		write(l_s1_pipe_mt12_o,s_s1_pipeO.gbt_fifo_sync_o, right,5);
		write(l_s1_pipe_mt12_o, s_s1_pipeO.gbt_fifo_data_v_o, right, 5);
		write(l_s1_pipe_mt12_o, s_s1_pipeO.gbt_fifo_data_mt12_o, right, 70);
		
		writeline(f_s1_pipe_mt12_o, l_s1_pipe_mt12_o);
	end process output_s1_pipe_mt12;
	
	output_s1_pipe_mt11: process
	
	file f_s1_pipe_mt11_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\out_files\s1_pipe_mt11_td.txt";
	variable l_s1_pipe_mt11_o: line;
	variable v_s23_data_v_o: std_logic;
	variable v_s1_pipe_sync_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s1_pipe_mt11_o, now, left, 10);
		write(l_s1_pipe_mt11_o,s_s1_pipeO.gbt_fifo_sync_o, right,5);
		write(l_s1_pipe_mt11_o, s_s1_pipeO.gbt_fifo_data_v_o, right, 5);
		write(l_s1_pipe_mt11_o, s_s1_pipeO.gbt_fifo_data_mt11_o, right, 70);
		
		writeline(f_s1_pipe_mt11_o, l_s1_pipe_mt11_o);
	end process output_s1_pipe_mt11;

end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================