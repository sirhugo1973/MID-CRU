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
-- date: 07/04/2020
--
-- version: 0.1
--
-- description: Stage 3 Pipeline module 
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

entity s2_pipe is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
		  gbt_sync: in std_logic;
		  s2_s3_busy_i: in std_logic;
		  s2_pipeI: in t_s2_pipeI;
		  s2_s3_busy_o: out std_logic;
		  s2_pipeO: out t_s2_pipeO
	);
end s2_pipe;

architecture main of s2_pipe is

	--================================================================
	--Signal Declaration
	--================================================================
	type s2_sub_pipe_arr_i is array (0 to 3) of t_s2_sub_pipeI;
	signal s_s2_sub_pipe_arr_i: s2_sub_pipe_arr_i;
	
	type s2_sub_pipe_arr_o is array (0 to 3) of t_s2_sub_pipeO;
	signal s_s2_sub_pipe_arr_o: s2_sub_pipe_arr_o;
	
	signal s_s3_sub_ram_busy_o: std_logic_vector(3 downto 0);
	
	--================================================================
	--Component Declaration
	--================================================================
	component s2_sub_pipe is
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s3_busy_o: out std_logic;
	  s2_sub_pipeI: in t_s2_sub_pipeI;
	  s2_sub_pipeO: out t_s2_sub_pipeO
	);
	end component;
	
	begin
	
	s_s2_sub_pipe_arr_i(3).s12_data_v_i<=s2_pipeI.s12_data_v_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_7_h_i<=s2_pipeI.reg_7_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_7_l_i<=s2_pipeI.reg_7_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_6_h_i<=s2_pipeI.reg_6_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_6_l_i<=s2_pipeI.reg_6_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_5_h_i<=s2_pipeI.reg_5_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_5_l_i<=s2_pipeI.reg_5_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_4_h_i<=s2_pipeI.reg_4_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_4_l_i<=s2_pipeI.reg_4_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_3_h_i<=s2_pipeI.reg_3_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_3_l_i<=s2_pipeI.reg_3_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_2_h_i<=s2_pipeI.reg_2_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_2_l_i<=s2_pipeI.reg_2_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_1_h_i<=s2_pipeI.reg_1_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_1_l_i<=s2_pipeI.reg_1_l_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_0_h_i<=s2_pipeI.reg_0_h_mt22_data_i;
	s_s2_sub_pipe_arr_i(3).s2_sub_pipe_data_0_l_i<=s2_pipeI.reg_0_l_mt22_data_i;
	
	s_s2_sub_pipe_arr_i(2).s12_data_v_i<=s2_pipeI.s12_data_v_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_7_h_i<=s2_pipeI.reg_7_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_7_l_i<=s2_pipeI.reg_7_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_6_h_i<=s2_pipeI.reg_6_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_6_l_i<=s2_pipeI.reg_6_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_5_h_i<=s2_pipeI.reg_5_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_5_l_i<=s2_pipeI.reg_5_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_4_h_i<=s2_pipeI.reg_4_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_4_l_i<=s2_pipeI.reg_4_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_3_h_i<=s2_pipeI.reg_3_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_3_l_i<=s2_pipeI.reg_3_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_2_h_i<=s2_pipeI.reg_2_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_2_l_i<=s2_pipeI.reg_2_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_1_h_i<=s2_pipeI.reg_1_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_1_l_i<=s2_pipeI.reg_1_l_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_0_h_i<=s2_pipeI.reg_0_h_mt21_data_i;
	s_s2_sub_pipe_arr_i(2).s2_sub_pipe_data_0_l_i<=s2_pipeI.reg_0_l_mt21_data_i;
	
	s_s2_sub_pipe_arr_i(1).s12_data_v_i<=s2_pipeI.s12_data_v_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_7_h_i<=s2_pipeI.reg_7_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_7_l_i<=s2_pipeI.reg_7_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_6_h_i<=s2_pipeI.reg_6_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_6_l_i<=s2_pipeI.reg_6_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_5_h_i<=s2_pipeI.reg_5_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_5_l_i<=s2_pipeI.reg_5_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_4_h_i<=s2_pipeI.reg_4_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_4_l_i<=s2_pipeI.reg_4_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_3_h_i<=s2_pipeI.reg_3_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_3_l_i<=s2_pipeI.reg_3_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_2_h_i<=s2_pipeI.reg_2_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_2_l_i<=s2_pipeI.reg_2_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_1_h_i<=s2_pipeI.reg_1_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_1_l_i<=s2_pipeI.reg_1_l_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_0_h_i<=s2_pipeI.reg_0_h_mt12_data_i;
	s_s2_sub_pipe_arr_i(1).s2_sub_pipe_data_0_l_i<=s2_pipeI.reg_0_l_mt12_data_i;
	
	s_s2_sub_pipe_arr_i(0).s12_data_v_i<=s2_pipeI.s12_data_v_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_7_h_i<=s2_pipeI.reg_7_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_7_l_i<=s2_pipeI.reg_7_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_6_h_i<=s2_pipeI.reg_6_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_6_l_i<=s2_pipeI.reg_6_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_5_h_i<=s2_pipeI.reg_5_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_5_l_i<=s2_pipeI.reg_5_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_4_h_i<=s2_pipeI.reg_4_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_4_l_i<=s2_pipeI.reg_4_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_3_h_i<=s2_pipeI.reg_3_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_3_l_i<=s2_pipeI.reg_3_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_2_h_i<=s2_pipeI.reg_2_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_2_l_i<=s2_pipeI.reg_2_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_1_h_i<=s2_pipeI.reg_1_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_1_l_i<=s2_pipeI.reg_1_l_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_0_h_i<=s2_pipeI.reg_0_h_mt11_data_i;
	s_s2_sub_pipe_arr_i(0).s2_sub_pipe_data_0_l_i<=s2_pipeI.reg_0_l_mt11_data_i;
	
	s2_pipeO.s2_pipe_data_mt22_o<=s_s2_sub_pipe_arr_o(3);
	s2_pipeO.s2_pipe_data_mt21_o<=s_s2_sub_pipe_arr_o(2);
	s2_pipeO.s2_pipe_data_mt12_o<=s_s2_sub_pipe_arr_o(1);
	s2_pipeO.s2_pipe_data_mt11_o<=s_s2_sub_pipe_arr_o(0);
	--================================================================
	--Component Instantiation
	--================================================================
	
	s2_sub_pipe_inst: for i in 3 downto 0 generate
	begin
		s2_sub_pipe_inst: s2_sub_pipe 
		port map(clk_i=>clk_i,
					reset_n_i=>reset_n_i,
					s3_busy_o=>s_s3_sub_ram_busy_o(i),
					s2_sub_pipeI=>s_s2_sub_pipe_arr_i(i),
					s2_sub_pipeO=>s_s2_sub_pipe_arr_o(i)
				  );
	end generate;
	
	process(clk_i,reset_n_i,s2_pipeI,gbt_sync,s2_s3_busy_i) is 
	
	begin
		if rising_edge(clk_i) then
			if gbt_sync='1' or s2_s3_busy_i='1' then
				s2_s3_busy_o<='1';
			else
				s2_s3_busy_o<='0';
			end if;	
		end if;
	end process;
	
end main;

