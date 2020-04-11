-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s2_sub_pipe_tb.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: $Date: 07/04/2020
--
-- version: 0.1
--
-- description: Testbench for Stage 2 Pipeline module 
--
-- dependencies: <entity name>, ...
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@gmail.com)
--
-------------------------------------------------------------------------------
-- last changes: 07/04/2020 NB Full System Integratioon
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

entity s2_sub_pipe_tb is
end entity s2_sub_pipe_tb;

architecture main of s2_sub_pipe_tb is

	--================================================================
	--Signal Declaration
	--================================================================
	
	signal s_clk_i: std_logic;
	signal s_reset_n_i: std_logic:='0';
	signal s_s2_sub_pipeI_i: t_s2_sub_pipeI;
	signal s_s2_sub_pipeO_i: t_s2_sub_pipeO;
	signal s_s3_busy_o: std_logic;
	signal s_clockrunning: boolean;

	
	constant c_settling_time: time :=2 ns;
	
	--===============================================================
	--Component Declaration
	--===============================================================
	
	component s2_sub_pipe is
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s3_busy_o: out std_logic;
	  s2_sub_pipeI: in t_s2_sub_pipeI;
	  s2_sub_pipeO: out t_s2_sub_pipeO
	);
	end component;
	
	begin
	
	clk_240(s_clk_i,s_clockrunning,145);
	--===============================================================
	--Component Instantiation
	--===============================================================
	
	UUT: s2_sub_pipe
	port map(clk_i=>s_clk_i,
				reset_n_i=>s_reset_n_i,
				s3_busy_o=>s_s3_busy_o,
				s2_sub_pipeI=>s_s2_sub_pipeI_i,
				s2_sub_pipeO=>s_s2_sub_pipeO_i);
				
	input_s2_sub_pipe: process is
		file f_s2_sub_pipe_i: text;
		variable l_s2_sub_pipe_i: line;
		variable v_s12_data_v_i: std_logic;
		variable v_s2_sub_pipe_data_7_h_i,v_s2_sub_pipe_data_7_l_i,v_s2_sub_pipe_data_6_h_i,
					v_s2_sub_pipe_data_6_l_i,v_s2_sub_pipe_data_5_h_i,v_s2_sub_pipe_data_5_l_i,
					v_s2_sub_pipe_data_4_h_i,v_s2_sub_pipe_data_4_l_i,v_s2_sub_pipe_data_3_h_i,
					v_s2_sub_pipe_data_3_l_i,v_s2_sub_pipe_data_2_h_i,v_s2_sub_pipe_data_2_l_i,
					v_s2_sub_pipe_data_1_h_i,v_s2_sub_pipe_data_1_l_i,v_s2_sub_pipe_data_0_h_i,
					v_s2_sub_pipe_data_0_l_i: std_logic_vector(63 downto 0);
					
	
	begin
	file_open(f_s2_sub_pipe_i,"C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\s2_sub_pipe\in_files\s2_sub_pipe_if.txt",read_mode);
	
	while not endfile(f_s2_sub_pipe_i) loop
	
		readline(f_s2_sub_pipe_i, l_s2_sub_pipe_i);
		read(l_s2_sub_pipe_i,v_s12_data_v_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_7_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_7_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_6_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_6_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_5_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_5_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_4_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_4_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_3_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_3_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_2_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_2_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_1_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_1_l_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_0_h_i);
		read(l_s2_sub_pipe_i, v_s2_sub_pipe_data_0_l_i);
		
		wait until rising_edge(s_clk_i);
		
		s_s2_sub_pipeI_i.s12_data_v_i<=v_s12_data_v_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_7_h_i<=v_s2_sub_pipe_data_7_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_7_l_i<=v_s2_sub_pipe_data_7_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_6_h_i<=v_s2_sub_pipe_data_6_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_6_l_i<=v_s2_sub_pipe_data_6_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_5_h_i<=v_s2_sub_pipe_data_5_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_5_l_i<=v_s2_sub_pipe_data_5_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_4_h_i<=v_s2_sub_pipe_data_4_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_4_l_i<=v_s2_sub_pipe_data_4_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_3_h_i<=v_s2_sub_pipe_data_3_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_3_l_i<=v_s2_sub_pipe_data_3_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_2_h_i<=v_s2_sub_pipe_data_2_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_2_l_i<=v_s2_sub_pipe_data_2_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_1_h_i<=v_s2_sub_pipe_data_1_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_1_l_i<=v_s2_sub_pipe_data_1_l_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_0_h_i<=v_s2_sub_pipe_data_0_h_i;
		s_s2_sub_pipeI_i.s2_sub_pipe_data_0_l_i<=v_s2_sub_pipe_data_0_l_i;
	end loop;
	file_close(f_s2_sub_pipe_i);
	end process input_s2_sub_pipe;
	
	output_s2_sub_pipe: process
	
	file f_s2_sub_pipe_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\s2_sub_pipe\out_files\s2_sub_pipe_of.txt";
	variable l_s2_sub_pipe_o: line;
	variable v_s23_data_v_o: std_logic;
	variable s2_data_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s2_sub_pipe_o, now, left, 10);
		write(l_s2_sub_pipe_o, s_s2_sub_pipeO_i.s23_data_v_o, right, 5);
		write(l_s2_sub_pipe_o, s_s2_sub_pipeO_i.s2_data_o, right, 70);
		
		writeline(f_s2_sub_pipe_o, l_s2_sub_pipe_o);
	end process output_s2_sub_pipe;
	
--		

end main;