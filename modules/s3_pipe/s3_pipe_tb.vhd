-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s3_pipe_tb.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: $Date: 07/04/2020
--
-- version: 0.1
--
-- description: Testbench for Stage 3 pipeline module
--
-- dependencies: <entity name>, ...
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

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

entity s3_pipe_tb is
end entity s3_pipe_tb;

architecture main of s3_pipe_tb is

	--================================================================
	--Signal Declaration
	--================================================================
	
	signal s_clk_i: std_logic;
	signal s_reset_n_i: std_logic:='0';
	signal s_s3_pipeI_i: t_s2_pipeO;
	signal s_s3_pipeO_i: t_s3_pipeO;
	signal s_s3_busy_o: std_logic;
	signal s_clockrunning: boolean;

	
	constant c_settling_time: time :=2 ns;
	
	--===============================================================
	--Component Declaration
	--===============================================================
	
	component s3_pipe is
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s3_pipeI: in t_s2_pipeO;
	  s3_busy_o: out std_logic;
	  s3_pipeO: out t_s3_pipeO
	);
	end component s3_pipe;
	
	begin
	
	clk_240(s_clk_i,s_clockrunning,300);
	--===============================================================
	--Component Instantiation
	--===============================================================
	
	UUT: s3_pipe
	port map(clk_i=>s_clk_i,
				reset_n_i=>s_reset_n_i,
				s3_pipeI=>s_s3_pipeI_i,
				s3_busy_o=>s_s3_busy_o,
				s3_pipeO=>s_s3_pipeO_i);
				
	input_s3_pipe: process is
		file f_s3_pipe_i: text;
		variable l_s3_pipe_i: line;
		variable v_s3_mt22_data_v_i, v_s3_mt21_data_v_i, v_s3_mt12_data_v_i, v_s3_mt11_data_v_i: std_logic;
		variable v_s3_mt22_data_i,v_s3_mt21_data_i,v_s3_mt12_data_i,v_s3_mt11_data_i: std_logic_vector(63 downto 0);
					
	
	begin
	file_open(f_s3_pipe_i,"C:/Users/natha/Desktop/mid_cru_proto/modules/s3_pipe/in_files/s3_pipe_if.txt",read_mode);
	
	while not endfile(f_s3_pipe_i) loop
	
		readline(f_s3_pipe_i, l_s3_pipe_i);
		read(l_s3_pipe_i,v_s3_mt22_data_v_i);
		read(l_s3_pipe_i,v_s3_mt21_data_v_i);
		read(l_s3_pipe_i,v_s3_mt12_data_v_i);
		read(l_s3_pipe_i,v_s3_mt11_data_v_i);
		read(l_s3_pipe_i,v_s3_mt22_data_i);
		read(l_s3_pipe_i,v_s3_mt21_data_i);
		read(l_s3_pipe_i,v_s3_mt12_data_i);
		read(l_s3_pipe_i,v_s3_mt11_data_i);
		
		wait until rising_edge(s_clk_i);
		
		s_s3_pipeI_i.s2_pipe_data_mt22_o.s23_data_v_o<=v_s3_mt22_data_v_i;
		s_s3_pipeI_i.s2_pipe_data_mt21_o.s23_data_v_o<=v_s3_mt21_data_v_i;
		s_s3_pipeI_i.s2_pipe_data_mt12_o.s23_data_v_o<=v_s3_mt12_data_v_i;
		s_s3_pipeI_i.s2_pipe_data_mt11_o.s23_data_v_o<=v_s3_mt11_data_v_i;
		
		s_s3_pipeI_i.s2_pipe_data_mt22_o.s2_data_o<=v_s3_mt22_data_i;
		s_s3_pipeI_i.s2_pipe_data_mt21_o.s2_data_o<=v_s3_mt21_data_i;
		s_s3_pipeI_i.s2_pipe_data_mt12_o.s2_data_o<=v_s3_mt12_data_i;
		s_s3_pipeI_i.s2_pipe_data_mt11_o.s2_data_o<=v_s3_mt11_data_i;
		

	end loop;
	file_close(f_s3_pipe_i);
	end process input_s3_pipe;
	
	output_s3_pipe: process
	
	file f_s3_pipe_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s3_pipe\out_files\s3_pipe_of.txt";
	variable l_s3_pipe_o: line;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s3_pipe_o, now, left, 10);
		write(l_s3_pipe_o, s_s3_busy_o, right, 5);
		write(l_s3_pipe_o, s_s3_pipeO_i.s3_pipe_data_v_o, right, 5);
		write(l_s3_pipe_o, s_s3_pipeO_i.s3_pipe_data_o, right, 70);
		
		writeline(f_s3_pipe_o, l_s3_pipe_o);
	end process output_s3_pipe;
		


end main;