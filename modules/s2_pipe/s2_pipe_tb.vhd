-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s2_pipe.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 08/04/2020
--
-- version: 0.1
--
-- description: testbench for Stage 2 Pipeline module
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

entity s2_pipe_tb is
end entity s2_pipe_tb;

architecture main of s2_pipe_tb is

	--================================================================
	--Signal Declaration
	--================================================================
	
	signal s_clk_i: std_logic;
	signal s_reset_n_i: std_logic:='0';
	signal s_s2_pipeI_i: t_s2_pipeI;
	signal s_s2_pipeO_o: t_s2_pipeO;
	signal s_s2_s3_busy_i: std_logic;
	signal s_s3_busy_o: std_logic;
	signal s_gbt_sync_i: std_logic := '1';
	signal s_clockrunning: boolean;

	
	constant c_settling_time: time :=2 ns;
	
	--===============================================================
	--Component Declaration
	--===============================================================
	
	component s2_pipe is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
		  gbt_sync: in std_logic;
		  s2_s3_busy_i: in std_logic;
		  s2_pipeI: in t_s2_pipeI;
		  s2_s3_busy_o: out std_logic;
		  s2_pipeO: out t_s2_pipeO
	);
	end component;
	
	begin
	
	clk_240(s_clk_i,s_clockrunning,145);
	--===============================================================
	--Component Instantiation
	--===============================================================
	
	UUT: s2_pipe
	port map(clk_i=>s_clk_i,
		  reset_n_i=>s_reset_n_i,
		  gbt_sync =>s_gbt_sync_i,
		  s2_s3_busy_i => s_s2_s3_busy_i,
		  s2_pipeI=>s_s2_pipeI_i,
		  s2_s3_busy_o=>s_s3_busy_o,
		  s2_pipeO=>s_s2_pipeO_o
	);
				
	input_mt22_s2_pipe: process is
		file f_s2_mt22_ram_i: text;
		variable l_s2_mt22_ram_i: line;
		variable v_mt22_s12_data_v_i: std_logic;
		variable v_s2_mt22_ram_data_7_h_i,v_s2_mt22_ram_data_7_l_i,v_s2_mt22_ram_data_6_h_i,
					v_s2_mt22_ram_data_6_l_i,v_s2_mt22_ram_data_5_h_i,v_s2_mt22_ram_data_5_l_i,
					v_s2_mt22_ram_data_4_h_i,v_s2_mt22_ram_data_4_l_i,v_s2_mt22_ram_data_3_h_i,
					v_s2_mt22_ram_data_3_l_i,v_s2_mt22_ram_data_2_h_i,v_s2_mt22_ram_data_2_l_i,
					v_s2_mt22_ram_data_1_h_i,v_s2_mt22_ram_data_1_l_i,v_s2_mt22_ram_data_0_h_i,
					v_s2_mt22_ram_data_0_l_i,v_s2_mt21_ram_data_7_h_i,v_s2_mt21_ram_data_7_l_i,
					v_s2_mt21_ram_data_6_h_i,v_s2_mt21_ram_data_6_l_i,v_s2_mt21_ram_data_5_h_i,
					v_s2_mt21_ram_data_5_l_i,v_s2_mt21_ram_data_4_h_i,v_s2_mt21_ram_data_4_l_i,
					v_s2_mt21_ram_data_3_h_i,v_s2_mt21_ram_data_3_l_i,v_s2_mt21_ram_data_2_h_i,
					v_s2_mt21_ram_data_2_l_i,v_s2_mt21_ram_data_1_h_i,v_s2_mt21_ram_data_1_l_i,
					v_s2_mt21_ram_data_0_h_i,v_s2_mt21_ram_data_0_l_i,v_s2_mt12_ram_data_7_h_i,
					v_s2_mt12_ram_data_7_l_i,v_s2_mt12_ram_data_6_h_i,v_s2_mt12_ram_data_6_l_i,
					v_s2_mt12_ram_data_5_h_i,v_s2_mt12_ram_data_5_l_i,v_s2_mt12_ram_data_4_h_i,
					v_s2_mt12_ram_data_4_l_i,v_s2_mt12_ram_data_3_h_i,v_s2_mt12_ram_data_3_l_i,
					v_s2_mt12_ram_data_2_h_i,v_s2_mt12_ram_data_2_l_i,v_s2_mt12_ram_data_1_h_i,
					v_s2_mt12_ram_data_1_l_i,v_s2_mt12_ram_data_0_h_i,v_s2_mt12_ram_data_0_l_i,
					v_s2_mt11_ram_data_7_h_i,v_s2_mt11_ram_data_7_l_i,v_s2_mt11_ram_data_6_h_i,
					v_s2_mt11_ram_data_6_l_i,v_s2_mt11_ram_data_5_h_i,v_s2_mt11_ram_data_5_l_i,
					v_s2_mt11_ram_data_4_h_i,v_s2_mt11_ram_data_4_l_i,v_s2_mt11_ram_data_3_h_i,
					v_s2_mt11_ram_data_3_l_i,v_s2_mt11_ram_data_2_h_i,v_s2_mt11_ram_data_2_l_i,
					v_s2_mt11_ram_data_1_h_i,v_s2_mt11_ram_data_1_l_i,v_s2_mt11_ram_data_0_h_i,
					v_s2_mt11_ram_data_0_l_i: std_logic_vector(63 downto 0);
					
	
	begin
	file_open(f_s2_mt22_ram_i,"C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\in_files\s2_pipe_if.txt",read_mode);
	
	while not endfile(f_s2_mt22_ram_i) loop
	
		readline(f_s2_mt22_ram_i, l_s2_mt22_ram_i);
		read(l_s2_mt22_ram_i,v_mt22_s12_data_v_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_7_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_7_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_6_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_6_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_5_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_5_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_4_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_4_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_3_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_3_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_2_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_2_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_1_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_1_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_0_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt22_ram_data_0_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_7_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_7_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_6_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_6_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_5_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_5_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_4_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_4_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_3_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_3_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_2_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_2_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_1_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_1_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_0_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt21_ram_data_0_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_7_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_7_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_6_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_6_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_5_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_5_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_4_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_4_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_3_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_3_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_2_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_2_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_1_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_1_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_0_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt12_ram_data_0_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_7_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_7_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_6_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_6_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_5_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_5_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_4_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_4_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_3_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_3_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_2_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_2_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_1_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_1_l_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_0_h_i);
		read(l_s2_mt22_ram_i, v_s2_mt11_ram_data_0_l_i);
		
		
		wait until rising_edge(s_clk_i);
		
		s_s2_pipeI_i.s12_data_v_i<=v_mt22_s12_data_v_i;
		s_s2_pipeI_i.reg_7_h_mt22_data_i<=v_s2_mt22_ram_data_7_h_i;
		s_s2_pipeI_i.reg_7_l_mt22_data_i<=v_s2_mt22_ram_data_7_l_i;
		s_s2_pipeI_i.reg_6_h_mt22_data_i<=v_s2_mt22_ram_data_6_h_i;
		s_s2_pipeI_i.reg_6_l_mt22_data_i<=v_s2_mt22_ram_data_6_l_i;
		s_s2_pipeI_i.reg_5_h_mt22_data_i<=v_s2_mt22_ram_data_5_h_i;
		s_s2_pipeI_i.reg_5_l_mt22_data_i<=v_s2_mt22_ram_data_5_l_i;
		s_s2_pipeI_i.reg_4_h_mt22_data_i<=v_s2_mt22_ram_data_4_h_i;
		s_s2_pipeI_i.reg_4_l_mt22_data_i<=v_s2_mt22_ram_data_4_l_i;
		s_s2_pipeI_i.reg_3_h_mt22_data_i<=v_s2_mt22_ram_data_3_h_i;
		s_s2_pipeI_i.reg_3_l_mt22_data_i<=v_s2_mt22_ram_data_3_l_i;
		s_s2_pipeI_i.reg_2_h_mt22_data_i<=v_s2_mt22_ram_data_2_h_i;
		s_s2_pipeI_i.reg_2_l_mt22_data_i<=v_s2_mt22_ram_data_2_l_i;
		s_s2_pipeI_i.reg_1_h_mt22_data_i<=v_s2_mt22_ram_data_1_h_i;
		s_s2_pipeI_i.reg_1_l_mt22_data_i<=v_s2_mt22_ram_data_1_l_i;
		s_s2_pipeI_i.reg_0_h_mt22_data_i<=v_s2_mt22_ram_data_0_h_i;
		s_s2_pipeI_i.reg_0_l_mt22_data_i<=v_s2_mt22_ram_data_0_l_i;
		
		s_s2_pipeI_i.reg_7_h_mt21_data_i<=v_s2_mt21_ram_data_7_h_i;
		s_s2_pipeI_i.reg_7_l_mt21_data_i<=v_s2_mt21_ram_data_7_l_i;
		s_s2_pipeI_i.reg_6_h_mt21_data_i<=v_s2_mt21_ram_data_6_h_i;
		s_s2_pipeI_i.reg_6_l_mt21_data_i<=v_s2_mt21_ram_data_6_l_i;
		s_s2_pipeI_i.reg_5_h_mt21_data_i<=v_s2_mt21_ram_data_5_h_i;
		s_s2_pipeI_i.reg_5_l_mt21_data_i<=v_s2_mt21_ram_data_5_l_i;
		s_s2_pipeI_i.reg_4_h_mt21_data_i<=v_s2_mt21_ram_data_4_h_i;
		s_s2_pipeI_i.reg_4_l_mt21_data_i<=v_s2_mt21_ram_data_4_l_i;
		s_s2_pipeI_i.reg_3_h_mt21_data_i<=v_s2_mt21_ram_data_3_h_i;
		s_s2_pipeI_i.reg_3_l_mt21_data_i<=v_s2_mt21_ram_data_3_l_i;
		s_s2_pipeI_i.reg_2_h_mt21_data_i<=v_s2_mt21_ram_data_2_h_i;
		s_s2_pipeI_i.reg_2_l_mt21_data_i<=v_s2_mt21_ram_data_2_l_i;
		s_s2_pipeI_i.reg_1_h_mt21_data_i<=v_s2_mt21_ram_data_1_h_i;
		s_s2_pipeI_i.reg_1_l_mt21_data_i<=v_s2_mt21_ram_data_1_l_i;
		s_s2_pipeI_i.reg_0_h_mt21_data_i<=v_s2_mt21_ram_data_0_h_i;
		s_s2_pipeI_i.reg_0_l_mt21_data_i<=v_s2_mt21_ram_data_0_l_i;
		
		s_s2_pipeI_i.reg_7_h_mt12_data_i<=v_s2_mt12_ram_data_7_h_i;
		s_s2_pipeI_i.reg_7_l_mt12_data_i<=v_s2_mt12_ram_data_7_l_i;
		s_s2_pipeI_i.reg_6_h_mt12_data_i<=v_s2_mt12_ram_data_6_h_i;
		s_s2_pipeI_i.reg_6_l_mt12_data_i<=v_s2_mt12_ram_data_6_l_i;
		s_s2_pipeI_i.reg_5_h_mt12_data_i<=v_s2_mt12_ram_data_5_h_i;
		s_s2_pipeI_i.reg_5_l_mt12_data_i<=v_s2_mt12_ram_data_5_l_i;
		s_s2_pipeI_i.reg_4_h_mt12_data_i<=v_s2_mt12_ram_data_4_h_i;
		s_s2_pipeI_i.reg_4_l_mt12_data_i<=v_s2_mt12_ram_data_4_l_i;
		s_s2_pipeI_i.reg_3_h_mt12_data_i<=v_s2_mt12_ram_data_3_h_i;
		s_s2_pipeI_i.reg_3_l_mt12_data_i<=v_s2_mt12_ram_data_3_l_i;
		s_s2_pipeI_i.reg_2_h_mt12_data_i<=v_s2_mt12_ram_data_2_h_i;
		s_s2_pipeI_i.reg_2_l_mt12_data_i<=v_s2_mt12_ram_data_2_l_i;
		s_s2_pipeI_i.reg_1_h_mt12_data_i<=v_s2_mt12_ram_data_1_h_i;
		s_s2_pipeI_i.reg_1_l_mt12_data_i<=v_s2_mt12_ram_data_1_l_i;
		s_s2_pipeI_i.reg_0_h_mt12_data_i<=v_s2_mt12_ram_data_0_h_i;
		s_s2_pipeI_i.reg_0_l_mt12_data_i<=v_s2_mt12_ram_data_0_l_i;
		
		s_s2_pipeI_i.reg_7_h_mt11_data_i<=v_s2_mt11_ram_data_7_h_i;
		s_s2_pipeI_i.reg_7_l_mt11_data_i<=v_s2_mt11_ram_data_7_l_i;
		s_s2_pipeI_i.reg_6_h_mt11_data_i<=v_s2_mt11_ram_data_6_h_i;
		s_s2_pipeI_i.reg_6_l_mt11_data_i<=v_s2_mt11_ram_data_6_l_i;
		s_s2_pipeI_i.reg_5_h_mt11_data_i<=v_s2_mt11_ram_data_5_h_i;
		s_s2_pipeI_i.reg_5_l_mt11_data_i<=v_s2_mt11_ram_data_5_l_i;
		s_s2_pipeI_i.reg_4_h_mt11_data_i<=v_s2_mt11_ram_data_4_h_i;
		s_s2_pipeI_i.reg_4_l_mt11_data_i<=v_s2_mt11_ram_data_4_l_i;
		s_s2_pipeI_i.reg_3_h_mt11_data_i<=v_s2_mt11_ram_data_3_h_i;
		s_s2_pipeI_i.reg_3_l_mt11_data_i<=v_s2_mt11_ram_data_3_l_i;
		s_s2_pipeI_i.reg_2_h_mt11_data_i<=v_s2_mt11_ram_data_2_h_i;
		s_s2_pipeI_i.reg_2_l_mt11_data_i<=v_s2_mt11_ram_data_2_l_i;
		s_s2_pipeI_i.reg_1_h_mt11_data_i<=v_s2_mt11_ram_data_1_h_i;
		s_s2_pipeI_i.reg_1_l_mt11_data_i<=v_s2_mt11_ram_data_1_l_i;
		s_s2_pipeI_i.reg_0_h_mt11_data_i<=v_s2_mt11_ram_data_0_h_i;
		s_s2_pipeI_i.reg_0_l_mt11_data_i<=v_s2_mt11_ram_data_0_l_i;
	end loop;
	file_close(f_s2_mt22_ram_i);
	end process input_mt22_s2_pipe;
	
	output_s2_mt22_ram: process
	
	file f_s2_mt22_ram_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\out_files\s2_mt22_pipe_of.txt";
	variable l_s2_mt22_ram_o: line;
	variable v_s23_mt22_data_v_o: std_logic;
	variable s2_mt22_data_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s2_mt22_ram_o, now, left, 10);
		write(l_s2_mt22_ram_o,s_s3_busy_o, right, 5) ;
		write(l_s2_mt22_ram_o, s_s2_pipeO_o.s2_pipe_data_mt22_o.s23_data_v_o, right, 5);
		write(l_s2_mt22_ram_o, s_s2_pipeO_o.s2_pipe_data_mt22_o.s2_data_o, right, 70);
		
		writeline(f_s2_mt22_ram_o, l_s2_mt22_ram_o);
	end process output_s2_mt22_ram;
	
	output_s2_mt21_ram: process
	
	file f_s2_mt21_ram_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\out_files\s2_mt21_pipe_of.txt";
	variable l_s2_mt21_ram_o: line;
	variable v_s23_mt21_data_v_o: std_logic;
	variable s2_mt21_data_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s2_mt21_ram_o, now, left, 10);
		write(l_s2_mt21_ram_o,s_s3_busy_o, right, 5) ;
		write(l_s2_mt21_ram_o, s_s2_pipeO_o.s2_pipe_data_mt21_o.s23_data_v_o, right, 5);
		write(l_s2_mt21_ram_o, s_s2_pipeO_o.s2_pipe_data_mt21_o.s2_data_o, right, 70);
		
		writeline(f_s2_mt21_ram_o, l_s2_mt21_ram_o);
	end process output_s2_mt21_ram;
	
	output_s2_mt12_ram: process
	
	file f_s2_mt12_ram_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\out_files\s2_mt12_pipe_of.txt";
	variable l_s2_mt12_ram_o: line;
	variable v_s23_mt12_data_v_o: std_logic;
	variable s2_mt12_data_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s2_mt12_ram_o, now, left, 10);
		write(l_s2_mt12_ram_o,s_s3_busy_o, right, 5) ;
		write(l_s2_mt12_ram_o, s_s2_pipeO_o.s2_pipe_data_mt12_o.s23_data_v_o, right, 5);
		write(l_s2_mt12_ram_o, s_s2_pipeO_o.s2_pipe_data_mt12_o.s2_data_o, right, 70);
		
		writeline(f_s2_mt12_ram_o, l_s2_mt12_ram_o);
	end process output_s2_mt12_ram;
	
	output_s2_mt11_ram: process
	
	file f_s2_mt11_ram_o: text open write_mode is "C:\Users\natha\Desktop\mid_cru_proto\modules\s2_pipe\out_files\s2_mt11_pipe_td.txt";
	variable l_s2_mt11_ram_o: line;
	variable v_s23_mt11_data_v_o: std_logic;
	variable s2_mt11_data_o: std_logic_vector(63 downto 0);
	variable time_when: time;
	
	begin
		--strobe the signals 
		wait until rising_edge(s_clk_i);
		wait for c_settling_time;
		
		write(l_s2_mt11_ram_o, now, left, 10);
		write(l_s2_mt11_ram_o,s_s3_busy_o, right, 5) ;
		write(l_s2_mt11_ram_o, s_s2_pipeO_o.s2_pipe_data_mt11_o.s23_data_v_o, right, 5);
		write(l_s2_mt11_ram_o, s_s2_pipeO_o.s2_pipe_data_mt11_o.s2_data_o, right, 70);
		
		writeline(f_s2_mt11_ram_o, l_s2_mt11_ram_o);
	end process output_s2_mt11_ram;
	

end main;