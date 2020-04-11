-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- Unit name: Testbench for o2_h_synth.vhd
--
-- Author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- Date:  26/02/2019
--
-- Version: 0.1
--
-- description: Testbench file for O2 header synthesis module
--
-- dependencies: o2_h_synth.vhd; sig_defs_pkg.vhd; util_pkg.vhd; vars_defs_pkg.vhd
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
use std.textio.all;
use ieee.std_logic_textio.all;
use work.sig_defs_pkg.all;
use work.util_pkg.all;
use work.var_defs_pkg.all;

--=============================================================================
--Testbench entity declaration
--=============================================================================
entity o2_h_synth_tb is
end entity o2_h_synth_tb;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture behaviour of o2_h_synth_tb is

	--===============================================================================
	--Signal Aliasing
	--===============================================================================	
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	
	signal s_clk_i: std_logic;
	signal s_clk_running: boolean;
	signal s_o2_h_synthI: t_o2_h_synthI;
	signal s_o2_h_synthO: t_o2_h_synthO;
	
	constant c_SETTLING_TIME: time :=2 ns;
	
	signal s_reset_n_i: std_logic;
	
	--===============================================================================
	--Component Declaration
	--===============================================================================
	
	component o2_h_synth is
	port(
	--global input signals
	clk_i: in std_logic; --local bus clock
	reset_n_i: in std_logic; --reset =0: reset active
									 --      =1: no reset
	o2_h_synthI: in t_o2_h_synthI; --GBT data signals defined in sig_defs_pkg
	
	--global output signals
	o2_h_synthO: out t_o2_h_synthO
	);
	end component o2_h_synth;

	
begin
	
	clk_240(s_clk_i,s_clk_running, 512); --Clock generator procedure
	
	--===============================================================================
	--Component Instantiation
	--===============================================================================
	
	cmp_o2_h_synth : o2_h_synth 
		port map(
			clk_i     => s_clk_i, 
			reset_n_i => s_reset_n_i, 
			o2_h_synthI => s_o2_h_synthI,
		   o2_h_synthO => s_o2_h_synthO
		);
	--===============================================================================
	--Architecture begin
	--===============================================================================
	
	o2_h_synth_sim: process is 
		file f_o2_h_i: text;
		variable l_o2_h_i: line;
		variable v_o2_valid_i: std_logic;
		variable v_reg_id_i, v_loc_id_i:  std_logic_vector(3 downto 0);
		
	begin
	file_open(f_o2_h_i,"C:\Users\natha\Desktop\mid_cru_proto\modules\s1_pipe\gbt_rfmt\loc_rfmt\o2_h_synth\in_files\o2_h_synth_if.txt",read_mode);
	
		while not endfile(f_o2_h_i) loop
		
			readline (f_o2_h_i,l_o2_h_i);
			read(l_o2_h_i, v_o2_valid_i);
			read(l_o2_h_i,v_reg_id_i);
			read(l_o2_h_i,v_loc_id_i);
			
			wait until rising_edge(s_clk_i);
			
			s_o2_h_synthI.o2_h_synth_valid_i<=v_o2_valid_i;
			s_o2_h_synthI.o2_h_synth_reg_id_i<=v_reg_id_i;
			s_o2_h_synthI.o2_h_synth_loc_id_i<=v_loc_id_i;
		end loop;
		file_close(f_o2_h_i);
	end process o2_h_synth_sim;

end architecture behaviour;
--===============================================================================
--Architecture end
--===============================================================================