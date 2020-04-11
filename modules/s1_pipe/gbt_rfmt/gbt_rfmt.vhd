-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: GBT data reformatting module (gbt_rfmt.vhd)
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: Date: 26/02/2019
--
-- version: 0.1
--
-- description: Module responsible for reformatting the data transmitted over
--              a GBT link  
--
-- dependencies: loc_rfmt.vhd; 
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

--=============================================================================
--Entity declaration for gbt_rfmt
--=============================================================================
entity gbt_rfmt is
port(
	--global input signals
	clk_i: in std_logic; --local bus clock
	reset_n_i: in std_logic; --reset =0: reset active; =1: no reset
	gbt_rfmtI: in t_gbt_rfmtI; --GBT data input signals defined in sig_defs_pkg
	
	--global output signals
	gbt_rfmtO: out t_gbt_rfmtO --GBT data output signals defined in sig_defs_pkg
	
);
end entity gbt_rfmt;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of gbt_rfmt is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================
	alias gbt_data_valid_i is gbt_rfmtI.gbt_data_valid_i;
	alias loc_rfmt_is_data_i is gbt_rfmtI.gbt_isdata_i;
	alias gbt_reg_h_i is gbt_rfmtI.gbt_data_i(79 downto 72);
	alias gbt_loc_rfmt_7_i is gbt_rfmtI.gbt_data_i(71 downto 64);
	alias gbt_loc_rfmt_6_i is gbt_rfmtI.gbt_data_i(63 downto 56);
	alias gbt_loc_rfmt_5_i is gbt_rfmtI.gbt_data_i(55 downto 48);
	alias gbt_loc_rfmt_4_i is gbt_rfmtI.gbt_data_i(47 downto 40);
	alias gbt_reg_l_i is gbt_rfmtI.gbt_data_i(39 downto 32);
	alias gbt_loc_rfmt_3_i is gbt_rfmtI.gbt_data_i(31 downto 24);
	alias gbt_loc_rfmt_2_i is gbt_rfmtI.gbt_data_i(23 downto 16);
	alias gbt_loc_rfmt_1_i is gbt_rfmtI.gbt_data_i(15 downto 8);
	alias gbt_loc_rfmt_0_i is gbt_rfmtI.gbt_data_i(7 downto 0);
	
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	signal loc_rfmt_7_i: t_loc_rfmtI;
	signal loc_rfmt_6_i: t_loc_rfmtI;
	signal loc_rfmt_5_i: t_loc_rfmtI;
	signal loc_rfmt_4_i: t_loc_rfmtI;
	signal loc_rfmt_3_i: t_loc_rfmtI;
	signal loc_rfmt_2_i: t_loc_rfmtI;
	signal loc_rfmt_1_i: t_loc_rfmtI;
	signal loc_rfmt_0_i: t_loc_rfmtI;
	
	signal loc_rfmt_7_o: t_loc_rfmtO;
	signal loc_rfmt_6_o: t_loc_rfmtO;
	signal loc_rfmt_5_o: t_loc_rfmtO;
	signal loc_rfmt_4_o: t_loc_rfmtO;
	signal loc_rfmt_3_o: t_loc_rfmtO;
	signal loc_rfmt_2_o: t_loc_rfmtO;
	signal loc_rfmt_1_o: t_loc_rfmtO;
	signal loc_rfmt_0_o: t_loc_rfmtO;
	
	type loc_rfmt_inputs is array (0 to 7) of t_loc_rfmtI; --Create array of inputs for gen statement
	signal loc_rfmt_i:  loc_rfmt_inputs;
	
	type loc_rfmt_outputs is array (0 to 7) of t_loc_rfmtO;
	signal loc_rfmt_o: loc_rfmt_outputs;
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
	
	begin
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	loc_rfmt_7_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_7_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_7_i.loc_rfmt_reg_data_i<=gbt_reg_h_i;
	loc_rfmt_7_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_7_i;
	
	loc_rfmt_6_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_6_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_6_i.loc_rfmt_reg_data_i<=gbt_reg_h_i;
	loc_rfmt_6_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_6_i;
	
	loc_rfmt_5_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_5_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_5_i.loc_rfmt_reg_data_i<=gbt_reg_h_i;
	loc_rfmt_5_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_5_i;
	
	loc_rfmt_4_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_4_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_4_i.loc_rfmt_reg_data_i<=gbt_reg_h_i;
	loc_rfmt_4_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_4_i;
	
	loc_rfmt_3_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_3_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_3_i.loc_rfmt_reg_data_i<=gbt_reg_l_i;
	loc_rfmt_3_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_3_i;
	
	loc_rfmt_2_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_2_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_2_i.loc_rfmt_reg_data_i<=gbt_reg_l_i;
	loc_rfmt_2_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_2_i;
	
	loc_rfmt_1_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_1_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_1_i.loc_rfmt_reg_data_i<=gbt_reg_l_i;
	loc_rfmt_1_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_1_i;
	
	loc_rfmt_0_i.loc_rfmt_data_valid_i<=gbt_data_valid_i;
	loc_rfmt_0_i.loc_rfmt_is_data_i<=loc_rfmt_is_data_i;
	loc_rfmt_0_i.loc_rfmt_reg_data_i<=gbt_reg_l_i;
	loc_rfmt_0_i.loc_rfmt_loc_data_i<=gbt_loc_rfmt_0_i;
	
	loc_rfmt_i(7)<=loc_rfmt_7_i;
	loc_rfmt_i(6)<=loc_rfmt_6_i;
	loc_rfmt_i(5)<=loc_rfmt_5_i;
	loc_rfmt_i(4)<=loc_rfmt_4_i;
	loc_rfmt_i(3)<=loc_rfmt_3_i;
	loc_rfmt_i(2)<=loc_rfmt_2_i;
	loc_rfmt_i(1)<=loc_rfmt_1_i;
	loc_rfmt_i(0)<=loc_rfmt_0_i;
	
	G1: for i in 7 downto 0 generate
	begin
		cmp_loc_rfmt: loc_rfmt port map(clk_i 		=> clk_i,
												  reset_n_i => reset_n_i,
												  loc_rfmtI => loc_rfmt_i(i),
												  loc_rfmtO =>loc_rfmt_o(i)
												  );
	end generate;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(7)<=loc_rfmt_o(7).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_7_o<=loc_rfmt_o(7).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_7_o<=loc_rfmt_o(7).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_7_o<=loc_rfmt_o(7).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_7_o<=loc_rfmt_o(7).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(6)<=loc_rfmt_o(6).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_6_o<=loc_rfmt_o(6).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_6_o<=loc_rfmt_o(6).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_6_o<=loc_rfmt_o(6).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_6_o<=loc_rfmt_o(6).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(5)<=loc_rfmt_o(5).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_5_o<=loc_rfmt_o(5).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_5_o<=loc_rfmt_o(5).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_5_o<=loc_rfmt_o(5).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_5_o<=loc_rfmt_o(5).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(4)<=loc_rfmt_o(4).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_4_o<=loc_rfmt_o(4).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_4_o<=loc_rfmt_o(4).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_4_o<=loc_rfmt_o(4).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_4_o<=loc_rfmt_o(4).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(3)<=loc_rfmt_o(3).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_3_o<=loc_rfmt_o(3).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_3_o<=loc_rfmt_o(3).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_3_o<=loc_rfmt_o(3).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_3_o<=loc_rfmt_o(3).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(2)<=loc_rfmt_o(2).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_2_o<=loc_rfmt_o(2).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_2_o<=loc_rfmt_o(2).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_2_o<=loc_rfmt_o(2).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_2_o<=loc_rfmt_o(2).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(1)<=loc_rfmt_o(1).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_1_o<=loc_rfmt_o(1).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_1_o<=loc_rfmt_o(1).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_1_o<=loc_rfmt_o(1).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_1_o<=loc_rfmt_o(1).loc_rfmt_mt11_data_o;
	
	gbt_rfmtO.gbt_rfmt_data_v_o(0)<=loc_rfmt_o(0).loc_rfmt_data_valid_o;
	gbt_rfmtO.gbt_rfmt_data_mt22_0_o<=loc_rfmt_o(0).loc_rfmt_mt22_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt21_0_o<=loc_rfmt_o(0).loc_rfmt_mt21_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt12_0_o<=loc_rfmt_o(0).loc_rfmt_mt12_data_o;
	gbt_rfmtO.gbt_rfmt_data_mt11_0_o<=loc_rfmt_o(0).loc_rfmt_mt11_data_o;
	--===============================================================================
	--Architecture begin
	--===============================================================================


end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================