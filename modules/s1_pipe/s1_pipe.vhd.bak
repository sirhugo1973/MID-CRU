-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s1_pipe.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com)
--
-- date: $Date: 08/04/2020
--
-- version: 0.1
--
-- description: Stage 1 pipeline module i.e. reformatting and synchronization
--
-- dependencies: <entity name>, ...
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: Nathan Boyles (nathanh.boyles@gmail.com)
--
-------------------------------------------------------------------------------
-- last changes: 08/04/2020
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: <next thing to do>
-- <another thing to do>
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.sig_defs_pkg.all;
use work.var_defs_pkg.all;

entity s1_pipe is 
port(
	  clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s2_busy_i: in std_logic;
	  s1_pipeI: in t_gbt_rfmtI;
	  s1_pipeO: out t_gbt_syncO);
end entity s1_pipe;

architecture main of s1_pipe is

	--==============================================================
	--Signal Declaration
	--==============================================================
	
	signal s_s1_pipe: t_gbt_rfmtO;
	signal s_s2_busy_i: std_logic;
	
	--==============================================================
	--Component Declaration
	--==============================================================
	
	component gbt_rfmt is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
		  gbt_rfmtI: in t_gbt_rfmtI;
		  gbt_rfmtO: out t_gbt_rfmtO);
	end component gbt_rfmt;
	
	component gbt_sync is
	port(clk_i: in std_logic;
		  reset_n_i: in std_logic;
	     gbt_s2_busy_i: in std_logic;
	     gbt_fifoI: in t_gbt_rfmtO;
		  gbt_fifoO: out t_gbt_fifoO);
	end component gbt_fifo;

	
	begin
	
	
	gbt_rfmt_inst: gbt_rfmt port map(clk_i=>clk_i,
											   reset_n_i=>reset_n_i,
												gbt_rfmtI=>s1_pipeI,
												gbt_rfmtO=>s_s1_pipe);
												
	gbt_sync_inst: gbt_sync port map(clk_i=>clk_i,
												reset_n_i=>reset_n_i,
												gbt_s2_busy_i=>s2_busy_i,
												gbt_syncI=>s_s1_pipe,
												gbt_syncO=>s1_pipeO);
												

end main;