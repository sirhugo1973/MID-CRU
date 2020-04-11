-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: gbt_sync.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: 07/04/2020
--
-- version: 0.1
--
-- description: GBT data synchronization module
--
-- dependencies: gbt_sub_sync.vhd; var_defs_pkg.vhd; util_pkg.vhd;sig_defs_pkg.vhd;
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
-- TODO: Change device to Cyclone 10 GX for MLAB's
-- <another thing to do>
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

entity gbt_sync is
port(
	  --global input signals 
	  clk_i: in std_logic; --local bus clock
	  reset_n_i: in std_logic; --reset =0: reset active
	  gbt_s2_busy_i: in std_logic;
	  gbt_syncI: in t_gbt_rfmtO;
	  
	  --global output signals
	  gbt_syncO: out t_gbt_syncO
);
end entity gbt_sync;

architecture main of gbt_sync is
	
	--==============================================================
	--Signal Declaration
	--==============================================================
	type gbt_sync_data_arr_i is array (0 to 3) of t_gbt_sub_syncI;
	signal s_gbt_sync_data_arr_i: gbt_sync_data_arr_i;

	type gbt_sync_data_arr_o is array (0 to 3) of t_gbt_sub_syncO;
	signal s_gbt_sync_data_arr_o: gbt_sync_data_arr_o;


	--==============================================================
	--Component Declaration
	--==============================================================

	
	component gbt_sub_sync is
	port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  gbt_s2_busy_i: in std_logic;
	  gbt_sub_syncI: in t_gbt_sub_syncI;
	  gbt_sub_syncO: out t_gbt_sub_syncO
	);
	end component;


begin
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_7_i<=gbt_syncI.gbt_rfmt_data_mt22_7_o; --connect input ports into signal array for generate
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_6_i<=gbt_syncI.gbt_rfmt_data_mt22_6_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_5_i<=gbt_syncI.gbt_rfmt_data_mt22_5_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_4_i<=gbt_syncI.gbt_rfmt_data_mt22_4_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_3_i<=gbt_syncI.gbt_rfmt_data_mt22_3_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_2_i<=gbt_syncI.gbt_rfmt_data_mt22_2_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_1_i<=gbt_syncI.gbt_rfmt_data_mt22_1_o;
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_0_i<=gbt_syncI.gbt_rfmt_data_mt22_0_o;
	
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_7_i<=gbt_syncI.gbt_rfmt_data_mt21_7_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_6_i<=gbt_syncI.gbt_rfmt_data_mt21_6_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_5_i<=gbt_syncI.gbt_rfmt_data_mt21_5_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_4_i<=gbt_syncI.gbt_rfmt_data_mt21_4_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_3_i<=gbt_syncI.gbt_rfmt_data_mt21_3_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_2_i<=gbt_syncI.gbt_rfmt_data_mt21_2_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_1_i<=gbt_syncI.gbt_rfmt_data_mt21_1_o;
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_0_i<=gbt_syncI.gbt_rfmt_data_mt21_0_o;
	
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_7_i<=gbt_syncI.gbt_rfmt_data_mt12_7_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_6_i<=gbt_syncI.gbt_rfmt_data_mt12_6_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_5_i<=gbt_syncI.gbt_rfmt_data_mt12_5_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_4_i<=gbt_syncI.gbt_rfmt_data_mt12_4_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_3_i<=gbt_syncI.gbt_rfmt_data_mt12_3_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_2_i<=gbt_syncI.gbt_rfmt_data_mt12_2_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_1_i<=gbt_syncI.gbt_rfmt_data_mt12_1_o;
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_0_i<=gbt_syncI.gbt_rfmt_data_mt12_0_o;
	
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_7_i<=gbt_syncI.gbt_rfmt_data_mt11_7_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_6_i<=gbt_syncI.gbt_rfmt_data_mt11_6_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_5_i<=gbt_syncI.gbt_rfmt_data_mt11_5_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_4_i<=gbt_syncI.gbt_rfmt_data_mt11_4_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_3_i<=gbt_syncI.gbt_rfmt_data_mt11_3_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_2_i<=gbt_syncI.gbt_rfmt_data_mt11_2_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_1_i<=gbt_syncI.gbt_rfmt_data_mt11_1_o;
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_0_i<=gbt_syncI.gbt_rfmt_data_mt11_0_o;

	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(7)<=gbt_syncI.gbt_rfmt_data_v_o(7);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(7)<=gbt_syncI.gbt_rfmt_data_v_o(7);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(7)<=gbt_syncI.gbt_rfmt_data_v_o(7);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(7)<=gbt_syncI.gbt_rfmt_data_v_o(7);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(6)<=gbt_syncI.gbt_rfmt_data_v_o(6);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(6)<=gbt_syncI.gbt_rfmt_data_v_o(6);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(6)<=gbt_syncI.gbt_rfmt_data_v_o(6);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(6)<=gbt_syncI.gbt_rfmt_data_v_o(6);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(5)<=gbt_syncI.gbt_rfmt_data_v_o(5);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(5)<=gbt_syncI.gbt_rfmt_data_v_o(5);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(5)<=gbt_syncI.gbt_rfmt_data_v_o(5);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(5)<=gbt_syncI.gbt_rfmt_data_v_o(5);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(4)<=gbt_syncI.gbt_rfmt_data_v_o(4);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(4)<=gbt_syncI.gbt_rfmt_data_v_o(4);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(4)<=gbt_syncI.gbt_rfmt_data_v_o(4);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(4)<=gbt_syncI.gbt_rfmt_data_v_o(4);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(3)<=gbt_syncI.gbt_rfmt_data_v_o(3);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(3)<=gbt_syncI.gbt_rfmt_data_v_o(3);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(3)<=gbt_syncI.gbt_rfmt_data_v_o(3);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(3)<=gbt_syncI.gbt_rfmt_data_v_o(3);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(2)<=gbt_syncI.gbt_rfmt_data_v_o(2);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(2)<=gbt_syncI.gbt_rfmt_data_v_o(2);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(2)<=gbt_syncI.gbt_rfmt_data_v_o(2);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(2)<=gbt_syncI.gbt_rfmt_data_v_o(2);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(1)<=gbt_syncI.gbt_rfmt_data_v_o(1);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(1)<=gbt_syncI.gbt_rfmt_data_v_o(1);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(1)<=gbt_syncI.gbt_rfmt_data_v_o(1);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(1)<=gbt_syncI.gbt_rfmt_data_v_o(1);
	
	s_gbt_sync_data_arr_i(3).gbt_rfmt_data_v_i(0)<=gbt_syncI.gbt_rfmt_data_v_o(0);
	s_gbt_sync_data_arr_i(2).gbt_rfmt_data_v_i(0)<=gbt_syncI.gbt_rfmt_data_v_o(0);
	s_gbt_sync_data_arr_i(1).gbt_rfmt_data_v_i(0)<=gbt_syncI.gbt_rfmt_data_v_o(0);
	s_gbt_sync_data_arr_i(0).gbt_rfmt_data_v_i(0)<=gbt_syncI.gbt_rfmt_data_v_o(0);
	
	
	gbt_syncO.gbt_sync_data_mt22_o<=s_gbt_sync_data_arr_o(3).gbt_sub_sync_data_o; --connect output signal array to output ports for generate
	gbt_syncO.gbt_sync_data_mt21_o<=s_gbt_sync_data_arr_o(2).gbt_sub_sync_data_o;
	gbt_syncO.gbt_sync_data_mt12_o<=s_gbt_sync_data_arr_o(1).gbt_sub_sync_data_o;
	gbt_syncO.gbt_sync_data_mt11_o<=s_gbt_sync_data_arr_o(0).gbt_sub_sync_data_o;
	
	gbt_syncO.gbt_sync_sync_o<=s_gbt_sync_data_arr_o(3).gbt_sub_sync_sync_o and s_gbt_sync_data_arr_o(2).gbt_sub_sync_sync_o and s_gbt_sync_data_arr_o(1).gbt_sub_sync_sync_o and s_gbt_sync_data_arr_o(0).gbt_sub_sync_sync_o;
	gbt_syncO.gbt_sync_data_v_o<=s_gbt_sync_data_arr_o(3).gbt_sub_sync_data_v_o and s_gbt_sync_data_arr_o(2).gbt_sub_sync_data_v_o and s_gbt_sync_data_arr_o(1).gbt_sub_sync_data_v_o and s_gbt_sync_data_arr_o(0).gbt_sub_sync_data_v_o;
	
	--==============================================================
	--Component Instantiation
	--==============================================================
	gbt_sync: for i in 3 downto 0 generate
	begin
		gbt_sync_inst: gbt_sub_sync port map(clk_i=>clk_i,
														 reset_n_i=>reset_n_i,
														 gbt_s2_busy_i=>gbt_s2_busy_i,
														 gbt_sub_syncI=>s_gbt_sync_data_arr_i(i),
														 gbt_sub_syncO=>s_gbt_sync_data_arr_o(i));
	end generate;
	
--	process(clk_i,gbt_syncI,s_gbt_sync_data_arr_o) is
--	begin
--	end process;

end main;
