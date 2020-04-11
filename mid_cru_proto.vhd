-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: mid_cru_proto.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 08/04/2020
--
-- version: 0.1
--
-- description: Top Level Entity for MID CRU User Logic
--
-- dependencies: <entity name>, ...
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@gmail.com)
--
-------------------------------------------------------------------------------
-- last changes: <date> <initials> <log>
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: 08/04/2020 NB Full System Integration
-- <another thing to do>
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.sig_defs_pkg.all;

--=============================================================================
--Entity declaration for mid
--=============================================================================
entity mid_cru_proto is
port(
	--global input signals
	clk_i: in std_logic; --local bus clock
	reset_n_i: in std_logic; --reset =0: reset active
									 --      =1: no reset
	midI: in t_midI; --GBT data signals defined in sig_defs_pkg
	midO: out t_s3_pipeO
	--global output signals
	
);
end entity mid_cru_proto;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of mid_cru_proto is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================
	alias a_reg_7_h_data_valid_i is midI.gbt_data_valid_i(15);
	alias a_reg_7_h_isdata_i is midI.gbt_isdata_i(15);
	alias a_reg_7_h_data_i is  midI.gbt_data_i(1279 downto 1200);
	
	alias a_reg_7_l_data_valid_i is midI.gbt_data_valid_i(14);
	alias a_reg_7_l_isdata_i is midI.gbt_isdata_i(14);
	alias a_reg_7_l_data_i is  midI.gbt_data_i(1199 downto 1120);
	
	alias a_reg_6_h_data_valid_i is midI.gbt_data_valid_i(13);
	alias a_reg_6_h_isdata_i is midI.gbt_isdata_i(13);
	alias a_reg_6_h_data_i is  midI.gbt_data_i(1119 downto 1040);
	
	alias a_reg_6_l_data_valid_i is midI.gbt_data_valid_i(12);
	alias a_reg_6_l_isdata_i is midI.gbt_isdata_i(12);
	alias a_reg_6_l_data_i is  midI.gbt_data_i(1039 downto 960);
	
	alias a_reg_5_h_data_valid_i is midI.gbt_data_valid_i(11);
	alias a_reg_5_h_isdata_i is midI.gbt_isdata_i(11);
	alias a_reg_5_h_data_i is  midI.gbt_data_i(959 downto 880);
	
	alias a_reg_5_l_data_valid_i is midI.gbt_data_valid_i(10);
	alias a_reg_5_l_isdata_i is midI.gbt_isdata_i(10);
	alias a_reg_5_l_data_i is  midI.gbt_data_i(879 downto 800);
	
	alias a_reg_4_h_data_valid_i is midI.gbt_data_valid_i(9);
	alias a_reg_4_h_isdata_i is midI.gbt_isdata_i(9);
	alias a_reg_4_h_data_i is  midI.gbt_data_i(799 downto 720);
	
	alias a_reg_4_l_data_valid_i is midI.gbt_data_valid_i(8);
	alias a_reg_4_l_isdata_i is midI.gbt_isdata_i(8);
	alias a_reg_4_l_data_i is  midI.gbt_data_i(719 downto 640);
	
	alias a_reg_3_h_data_valid_i is midI.gbt_data_valid_i(7);
	alias a_reg_3_h_isdata_i is midI.gbt_isdata_i(7);
	alias a_reg_3_h_data_i is  midI.gbt_data_i(639 downto 560);
	
	alias a_reg_3_l_data_valid_i is midI.gbt_data_valid_i(6);
	alias a_reg_3_l_isdata_i is midI.gbt_isdata_i(6);
	alias a_reg_3_l_data_i is  midI.gbt_data_i(559 downto 480);
	
	alias a_reg_2_h_data_valid_i is midI.gbt_data_valid_i(5);
	alias a_reg_2_h_isdata_i is midI.gbt_isdata_i(5);
	alias a_reg_2_h_data_i is  midI.gbt_data_i(479 downto 400);
	
	alias a_reg_2_l_data_valid_i is midI.gbt_data_valid_i(4);
	alias a_reg_2_l_isdata_i is midI.gbt_isdata_i(4);
	alias a_reg_2_l_data_i is  midI.gbt_data_i(399 downto 320);
	
	alias a_reg_1_h_data_valid_i is midI.gbt_data_valid_i(3);
	alias a_reg_1_h_isdata_i is midI.gbt_isdata_i(3);
	alias a_reg_1_h_data_i is  midI.gbt_data_i(319 downto 240);
	
	alias a_reg_1_l_data_valid_i is midI.gbt_data_valid_i(2);
	alias a_reg_1_l_isdata_i is midI.gbt_isdata_i(2);
	alias a_reg_1_l_data_i is  midI.gbt_data_i(239 downto 160);
	
	alias a_reg_0_h_data_valid_i is midI.gbt_data_valid_i(1);
	alias a_reg_0_h_isdata_i is midI.gbt_isdata_i(1);
	alias a_reg_0_h_data_i is  midI.gbt_data_i(159 downto 80);
	
	alias a_reg_0_l_data_valid_i is midI.gbt_data_valid_i(0);
	alias a_reg_0_l_isdata_i is midI.gbt_isdata_i(0);
	alias a_reg_0_l_data_i is  midI.gbt_data_i(79 downto 0);
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	
	type s1_pipe_arr_i is array (0 to 15) of t_gbt_rfmtI;
	signal s_s1_pipe_arr_i: s1_pipe_arr_i;
	
	type s1_pipe_arr_o is array (0 to 15) of t_gbt_syncO;
	signal s_s1_pipe_arr_o: s1_pipe_arr_o;
	
	signal s_s1_data_v_o: std_logic_vector(15 downto 0);
	
	---------------------------------------------------------------------------------
	signal s_s2_pipeI: t_s2_pipeI;
	
	signal s2_s3_int: t_s2_pipeO;
	
	signal s_gbt_sync: std_logic;
	signal s_s2_s3_busy_o: std_logic;
	signal s_s3_busy_o: std_logic;
	
	--===============================================================================
	--Component Declaration
	--===============================================================================
	
	component s1_pipe is 
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s2_busy_i: in std_logic;
	  s1_pipeI: in t_gbt_rfmtI;
	  --s1_data_v_o: out std_logic;
	  s1_pipeO: out t_gbt_syncO);
	end component s1_pipe;
	
	component s2_pipe is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
		  gbt_sync: in std_logic;
		  s2_s3_busy_i: in std_logic;
		  s2_pipeI: in t_s2_pipeI;
		  s2_s3_busy_o: out std_logic;
		  s2_pipeO: out t_s2_pipeO
	);
	end component s2_pipe;
	
	component s3_pipe is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
		  s3_pipeI: in t_s2_pipeO;
	     s3_busy_o: out std_logic;
		  s3_pipeO: out t_s3_pipeO
	);
	end component s3_pipe;
	
	
	--===============================================================================
	--Architecture begin
	--===============================================================================
	begin
		
	s_s1_pipe_arr_i(15).gbt_data_valid_i<=a_reg_7_h_data_valid_i;
	s_s1_pipe_arr_i(15).gbt_isdata_i<=a_reg_7_h_isdata_i;
	s_s1_pipe_arr_i(15).gbt_data_i<=a_reg_7_h_data_i;
	
	s_s1_pipe_arr_i(14).gbt_data_valid_i<=a_reg_7_l_data_valid_i;
	s_s1_pipe_arr_i(14).gbt_isdata_i<=a_reg_7_l_isdata_i;
	s_s1_pipe_arr_i(14).gbt_data_i<=a_reg_7_l_data_i;
	
	s_s1_pipe_arr_i(13).gbt_data_valid_i<=a_reg_6_h_data_valid_i;
	s_s1_pipe_arr_i(13).gbt_isdata_i<=a_reg_6_h_isdata_i;
	s_s1_pipe_arr_i(13).gbt_data_i<=a_reg_6_h_data_i;
	
	s_s1_pipe_arr_i(12).gbt_data_valid_i<=a_reg_6_l_data_valid_i;
	s_s1_pipe_arr_i(12).gbt_isdata_i<=a_reg_6_l_isdata_i;
	s_s1_pipe_arr_i(12).gbt_data_i<=a_reg_6_l_data_i;
	
	s_s1_pipe_arr_i(11).gbt_data_valid_i<=a_reg_5_h_data_valid_i;
	s_s1_pipe_arr_i(11).gbt_isdata_i<=a_reg_5_h_isdata_i;
	s_s1_pipe_arr_i(11).gbt_data_i<=a_reg_5_h_data_i;
	
	s_s1_pipe_arr_i(10).gbt_data_valid_i<=a_reg_5_l_data_valid_i;
	s_s1_pipe_arr_i(10).gbt_isdata_i<=a_reg_5_l_isdata_i;
	s_s1_pipe_arr_i(10).gbt_data_i<=a_reg_5_l_data_i;
	
	s_s1_pipe_arr_i(9).gbt_data_valid_i<=a_reg_4_h_data_valid_i;
	s_s1_pipe_arr_i(9).gbt_isdata_i<=a_reg_3_h_isdata_i;
	s_s1_pipe_arr_i(9).gbt_data_i<=a_reg_3_h_data_i;
	
	s_s1_pipe_arr_i(8).gbt_data_valid_i<=a_reg_4_l_data_valid_i;
	s_s1_pipe_arr_i(8).gbt_isdata_i<=a_reg_2_l_isdata_i;
	s_s1_pipe_arr_i(8).gbt_data_i<=a_reg_2_l_data_i;
	
	s_s1_pipe_arr_i(7).gbt_data_valid_i<=a_reg_3_h_data_valid_i;
	s_s1_pipe_arr_i(7).gbt_isdata_i<=a_reg_3_h_isdata_i;
	s_s1_pipe_arr_i(7).gbt_data_i<=a_reg_3_h_data_i;
	
	s_s1_pipe_arr_i(6).gbt_data_valid_i<=a_reg_3_l_data_valid_i;
	s_s1_pipe_arr_i(6).gbt_isdata_i<=a_reg_3_l_isdata_i;
	s_s1_pipe_arr_i(6).gbt_data_i<=a_reg_3_l_data_i;
	
	s_s1_pipe_arr_i(5).gbt_data_valid_i<=a_reg_2_h_data_valid_i;
	s_s1_pipe_arr_i(5).gbt_isdata_i<=a_reg_2_h_isdata_i;
	s_s1_pipe_arr_i(5).gbt_data_i<=a_reg_2_h_data_i;
	
	s_s1_pipe_arr_i(4).gbt_data_valid_i<=a_reg_2_l_data_valid_i;
	s_s1_pipe_arr_i(4).gbt_isdata_i<=a_reg_2_l_isdata_i;
	s_s1_pipe_arr_i(4).gbt_data_i<=a_reg_2_l_data_i;
	
	s_s1_pipe_arr_i(3).gbt_data_valid_i<=a_reg_1_h_data_valid_i;
	s_s1_pipe_arr_i(3).gbt_isdata_i<=a_reg_1_h_isdata_i;
	s_s1_pipe_arr_i(3).gbt_data_i<=a_reg_1_h_data_i;
	
	s_s1_pipe_arr_i(2).gbt_data_valid_i<=a_reg_1_l_data_valid_i;
	s_s1_pipe_arr_i(2).gbt_isdata_i<=a_reg_1_l_isdata_i;
	s_s1_pipe_arr_i(2).gbt_data_i<=a_reg_1_l_data_i;
	
	s_s1_pipe_arr_i(1).gbt_data_valid_i<=a_reg_0_h_data_valid_i;
	s_s1_pipe_arr_i(1).gbt_isdata_i<=a_reg_0_h_isdata_i;
	s_s1_pipe_arr_i(1).gbt_data_i<=a_reg_0_h_data_i;
	
	s_s1_pipe_arr_i(0).gbt_data_valid_i<=a_reg_0_l_data_valid_i;
	s_s1_pipe_arr_i(0).gbt_isdata_i<=a_reg_0_l_isdata_i;
	s_s1_pipe_arr_i(0).gbt_data_i<=a_reg_0_l_data_i;
	---------------------------------------------------------------------------
	s_s2_pipeI.reg_7_h_mt22_data_i<=s_s1_pipe_arr_o(15).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_7_h_mt21_data_i<=s_s1_pipe_arr_o(15).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_7_h_mt12_data_i<=s_s1_pipe_arr_o(15).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_7_h_mt11_data_i<=s_s1_pipe_arr_o(15).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_7_l_mt22_data_i<=s_s1_pipe_arr_o(14).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_7_l_mt21_data_i<=s_s1_pipe_arr_o(14).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_7_l_mt12_data_i<=s_s1_pipe_arr_o(14).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_7_l_mt11_data_i<=s_s1_pipe_arr_o(14).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_6_h_mt22_data_i<=s_s1_pipe_arr_o(13).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_6_h_mt21_data_i<=s_s1_pipe_arr_o(13).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_6_h_mt12_data_i<=s_s1_pipe_arr_o(13).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_6_h_mt11_data_i<=s_s1_pipe_arr_o(13).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_6_l_mt22_data_i<=s_s1_pipe_arr_o(12).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_6_l_mt21_data_i<=s_s1_pipe_arr_o(12).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_6_l_mt12_data_i<=s_s1_pipe_arr_o(12).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_6_l_mt11_data_i<=s_s1_pipe_arr_o(12).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_5_h_mt22_data_i<=s_s1_pipe_arr_o(11).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_5_h_mt21_data_i<=s_s1_pipe_arr_o(11).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_5_h_mt12_data_i<=s_s1_pipe_arr_o(11).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_5_h_mt11_data_i<=s_s1_pipe_arr_o(11).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_5_l_mt22_data_i<=s_s1_pipe_arr_o(10).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_5_l_mt21_data_i<=s_s1_pipe_arr_o(10).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_5_l_mt12_data_i<=s_s1_pipe_arr_o(10).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_5_l_mt11_data_i<=s_s1_pipe_arr_o(10).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_4_h_mt22_data_i<=s_s1_pipe_arr_o(9).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_4_h_mt21_data_i<=s_s1_pipe_arr_o(9).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_4_h_mt12_data_i<=s_s1_pipe_arr_o(9).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_4_h_mt11_data_i<=s_s1_pipe_arr_o(9).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_4_l_mt22_data_i<=s_s1_pipe_arr_o(8).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_4_l_mt21_data_i<=s_s1_pipe_arr_o(8).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_4_l_mt12_data_i<=s_s1_pipe_arr_o(8).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_4_l_mt11_data_i<=s_s1_pipe_arr_o(8).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_3_h_mt22_data_i<=s_s1_pipe_arr_o(7).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_3_h_mt21_data_i<=s_s1_pipe_arr_o(7).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_3_h_mt12_data_i<=s_s1_pipe_arr_o(7).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_3_h_mt11_data_i<=s_s1_pipe_arr_o(7).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_3_l_mt22_data_i<=s_s1_pipe_arr_o(6).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_3_l_mt21_data_i<=s_s1_pipe_arr_o(6).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_3_l_mt12_data_i<=s_s1_pipe_arr_o(6).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_3_l_mt11_data_i<=s_s1_pipe_arr_o(6).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_2_h_mt22_data_i<=s_s1_pipe_arr_o(5).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_2_h_mt21_data_i<=s_s1_pipe_arr_o(5).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_2_h_mt12_data_i<=s_s1_pipe_arr_o(5).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_2_h_mt11_data_i<=s_s1_pipe_arr_o(5).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_2_l_mt22_data_i<=s_s1_pipe_arr_o(4).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_2_l_mt21_data_i<=s_s1_pipe_arr_o(4).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_2_l_mt12_data_i<=s_s1_pipe_arr_o(4).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_2_l_mt11_data_i<=s_s1_pipe_arr_o(4).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_1_h_mt22_data_i<=s_s1_pipe_arr_o(3).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_1_h_mt21_data_i<=s_s1_pipe_arr_o(3).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_1_h_mt12_data_i<=s_s1_pipe_arr_o(3).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_1_h_mt11_data_i<=s_s1_pipe_arr_o(3).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_1_l_mt22_data_i<=s_s1_pipe_arr_o(2).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_1_l_mt21_data_i<=s_s1_pipe_arr_o(2).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_1_l_mt12_data_i<=s_s1_pipe_arr_o(2).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_1_l_mt11_data_i<=s_s1_pipe_arr_o(2).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_0_h_mt22_data_i<=s_s1_pipe_arr_o(1).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_0_h_mt21_data_i<=s_s1_pipe_arr_o(1).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_0_h_mt12_data_i<=s_s1_pipe_arr_o(1).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_0_h_mt11_data_i<=s_s1_pipe_arr_o(1).gbt_sync_data_mt11_o;
	s_s2_pipeI.reg_0_l_mt22_data_i<=s_s1_pipe_arr_o(0).gbt_sync_data_mt22_o;
	s_s2_pipeI.reg_0_l_mt21_data_i<=s_s1_pipe_arr_o(0).gbt_sync_data_mt21_o;
	s_s2_pipeI.reg_0_l_mt12_data_i<=s_s1_pipe_arr_o(0).gbt_sync_data_mt12_o;
	s_s2_pipeI.reg_0_l_mt11_data_i<=s_s1_pipe_arr_o(0).gbt_sync_data_mt11_o;
	
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	
	gbt : for i in 15 downto 0 generate
	begin
	 gbt_inst : s1_pipe
					port map(clk_i=>clk_i,
								reset_n_i=>reset_n_i,
								s2_busy_i=>s_s2_s3_busy_o,
								s1_pipeI=>s_s1_pipe_arr_i(i),
								--s1_data_v_o=>s_s1_data_v_o(i),
								s1_pipeO=>s_s1_pipe_arr_o(i)
					);
	end generate gbt;
	
	s2_inst : s2_pipe 
				 port map(clk_i=>clk_i,
							 reset_n_i=>reset_n_i,
							 gbt_sync=>s_gbt_sync,
							 s2_s3_busy_i=>s_s3_busy_o,
							 s2_pipeI=>s_s2_pipeI,
							 s2_s3_busy_o=>s_s2_s3_busy_o,
							 s2_pipeO=>s2_s3_int
							);
	s3_inst : s3_pipe
				 port map(clk_i=>clk_i,
							 reset_n_i=>reset_n_i,
							 s3_pipeI=>s2_s3_int,
							 s3_busy_o=>s_s3_busy_o,
							 s3_pipeO=>midO
							);		
							
							
	process(clk_i,reset_n_i,s_s1_pipe_arr_o,midI) is 
	begin
		--Assert global GBT sync signal when local modules are all in sync
		if s_s1_pipe_arr_o(15).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(14).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(13).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(12).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(11).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(10).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(9).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(8).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(7).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(6).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(5).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(4).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(3).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(2).gbt_sync_sync_o='1'
			and s_s1_pipe_arr_o(1).gbt_sync_sync_o='1' and s_s1_pipe_arr_o(0).gbt_sync_sync_o='1' then
			
			s_gbt_sync<='1';
		end if;
		
		--Assert global GBT data valid signal when local data valid signals are all asserted 
		if s_s1_pipe_arr_o(15).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(14).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(13).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(12).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(11).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(10).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(9).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(8).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(7).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(6).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(5).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(4).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(3).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(2).gbt_sync_data_v_o='1'
			and s_s1_pipe_arr_o(1).gbt_sync_data_v_o='1'  and s_s1_pipe_arr_o(0).gbt_sync_data_v_o='1' then
			
			s_s2_pipeI.s12_data_v_i<='1';
		
		else
			s_s2_pipeI.s12_data_v_i<='0';
		end if;	
	end process;

end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================