-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: MID-CRU User logic Variable Definitions (var_defs_pkg.vhd)
--
-- author: Nathan Boyles (nathan.boyles@cern.ch)
--
-- date: $Date: 26/02/2019: $:
--
-- version: $Rev: 0.1: $:
--
-- description: <file content, behaviour, purpose, special usage notes...>
-- <further description>
--
-- dependencies: <entity name>, ...
--
-- references: <reference one>
-- <reference two> ...
--
-- modified by: $Author:: $:
--
-------------------------------------------------------------------------------
-- last changes: <date> <initials> <log>
-- <extended description>
-------------------------------------------------------------------------------
-- TODO: <next thing to do>
-- <another thing to do>
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package var_defs_pkg is

	type t_reg is 	--Regional Link Storage Variables
	record
		stat: std_logic_vector(7 downto 0);
		trig: std_logic_vector(7 downto 0);
		ibc: std_logic_vector(15 downto 0);
		cid, trck: std_logic_vector(3 downto 0);
	end record;
	
	type t_loc is 	--Local Link Storage Variables
	record
		stat: std_logic_vector(7 downto 0);
		trig: std_logic_vector(7 downto 0);
		ibc: std_logic_vector(15 downto 0);
		cid, trck: std_logic_vector(3 downto 0);
		mt22_sp: std_logic_vector(31 downto 0);
		mt21_sp: std_logic_vector(31 downto 0);
		mt12_sp: std_logic_vector(31 downto 0);
		mt11_sp: std_logic_vector(31 downto 0);
		o2_h_mt22: std_logic_vector(18 downto 0);
		o2_h_mt21: std_logic_vector(18 downto 0);
		o2_h_mt12: std_logic_vector(18 downto 0);
		o2_h_mt11: std_logic_vector(18 downto 0);
	end record;
	
	type t_s2_sub_pipe_v is --variable for s2_sub_pipe process 
	record
		s2_sub_pipe_data_7_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_6_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_5_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_4_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_3_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_2_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_1_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_0_h_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_7_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_6_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_5_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_4_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_3_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_2_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_1_l_v: std_logic_vector(63 downto 0);
		s2_sub_pipe_data_0_l_v: std_logic_vector(63 downto 0);
	end record;
	
	type t_s3_pipe_v is --variables for s3_ram process
	record
		s3_pipe_mt22_data_v: std_logic_vector(63 downto 0);
		s3_pipe_mt21_data_v: std_logic_vector(63 downto 0);
		s3_pipe_mt12_data_v: std_logic_vector(63 downto 0);
		s3_pipe_mt11_data_v: std_logic_vector(63 downto 0);
	end record;
	
end package var_defs_pkg;

