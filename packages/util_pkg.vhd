-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: MID-CRU Utilities (util_pkg.vhd)
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

package util_pkg is 

	procedure clk_240(signal clk_240_o: out std_logic;
							signal clk_running_o: out boolean;
							c_NUM_CYCLES: integer:=512);

end util_pkg;

package body util_pkg is

	procedure clk_240(signal clk_240_o: out std_logic;
							signal clk_running_o: out boolean;
							c_NUM_CYCLES: integer:=512) is
							
				--~240MHz
				begin
				clk_running_o<=TRUE;
				for i in 1 to c_NUM_CYCLES loop
					clk_240_o<='1';
					wait for 2.079 ns;
					clk_240_o<='0';
					wait for 2.079 ns;
				end loop;
				clk_running_o<=FALSE;
				wait;
	end clk_240;

end util_pkg;
