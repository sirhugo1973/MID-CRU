-------------------------------------------------------------------------------
-- --
-- University of Cape Town, Electrical Engineering Department--
-- --
-------------------------------------------------------------------------------
--
-- unit name: s2_sub_pipe.vhd
--
-- author: Nathan Boyles (nathanh.boyles@gmail.com
--
-- date: 07/04/2020
--
-- version: 0.1
--
-- description: Stage 2 Pipeline module
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
use ieee.std_logic_unsigned.all;
use work.sig_defs_pkg.all;
use work.var_defs_pkg.all;
use work.util_pkg.all;

--=============================================================================
--Entity declaration for gbt_rfmt
--=============================================================================
entity s2_sub_pipe is
port(clk_i: in std_logic;
	  reset_n_i: in std_logic;
	  s3_busy_o: out std_logic;
	  s2_sub_pipeI: in t_s2_sub_pipeI;
	  s2_sub_pipeO: out t_s2_sub_pipeO
);
end s2_sub_pipe;

--===============================================================================
--Architecture declaration
--===============================================================================

architecture main of s2_sub_pipe is
	--===============================================================================
	--Signal Aliasing
	--===============================================================================
	
	--===============================================================================
	--Signal Declaration
	--===============================================================================
	
	type data_port_arr_a_i is array (0 to 7) of std_logic_vector(63 downto 0);
	signal s_data_port_arr_a_i: data_port_arr_a_i := (others => x"0000000000000000");
	
	type data_port_arr_b_i is array(0 to 7) of std_logic_vector(63 downto 0);
	signal s_data_port_arr_b_i: data_port_arr_b_i:= (others => x"0000000000000000");
	
	type data_port_arr_a_o is array (0 to 7) of std_logic_vector(63 downto 0);
	signal s_data_port_arr_a_o: data_port_arr_a_o;--:= (others => x"0000000000000000");
	
	type data_port_arr_b_o is array (0 to 7) of std_logic_vector(63 downto 0);
	signal s_data_port_arr_b_o: data_port_arr_b_o;--:= (others => x"0000000000000000");
	
	type addr_port_arr_a_i is array (0 to 7) of std_logic_vector(3 downto 0);
	signal s_addr_port_arr_a_i: addr_port_arr_a_i:=(others =>"0000");
	
	type addr_port_arr_b_i is array (0 to 7) of std_logic_vector(3 downto 0);
	signal s_addr_port_arr_b_i: addr_port_arr_b_i:= (others => "1000");
	
	signal s_sub_pipe_rden_a_i: std_logic_vector(7 downto 0):=x"00";
	signal s_sub_pipe_rden_b_i: std_logic_vector(7 downto 0):=x"00";
	signal s_sub_pipe_wren_a_i: std_logic_vector(7 downto 0):=x"00";
	signal s_sub_pipe_wren_b_i: std_logic_vector(7 downto 0):=x"00";

	--===============================================================================
	--Component Declaration
	--===============================================================================
	
	
    component ram is
        port (
            data_a    : in  std_logic_vector(63 downto 0) := (others => 'X'); -- datain_a
            q_a       : out std_logic_vector(63 downto 0);                    -- dataout_a
            data_b    : in  std_logic_vector(63 downto 0) := (others => 'X'); -- datain_b
            q_b       : out std_logic_vector(63 downto 0);                    -- dataout_b
            address_a : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- address_a
            address_b : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- address_b
            wren_a    : in  std_logic                     := 'X';             -- wren_a
            wren_b    : in  std_logic                     := 'X';             -- wren_b
            clock     : in  std_logic                     := 'X';             -- clk
            rden_a    : in  std_logic                     := 'X';             -- rden_a
            rden_b    : in  std_logic                     := 'X'               -- clk
        );
    end component ram;	
	 

	begin
	

	--===============================================================================
	--Component Instantiation
	--===============================================================================
	
	s_ram: for i in 7 downto 0 generate
	
	begin
	u0 : component ram
        port map (
            data_a    => s_data_port_arr_a_i(i),    --    data_a.datain_a
            q_a       => s_data_port_arr_a_o(i),       --       q_a.dataout_a
            data_b    => s_data_port_arr_b_i(i),    --    data_b.datain_b
            q_b       => s_data_port_arr_b_o(i),       --       q_b.dataout_b
            address_a => s_addr_port_arr_a_i(i), -- address_a.address_a
            address_b => s_addr_port_arr_b_i(i), -- address_b.address_b
            wren_a    => s_sub_pipe_wren_a_i(i),    --    wren_a.wren_a
            wren_b    => s_sub_pipe_wren_b_i(i),    --    wren_b.wren_b
            clock     => clk_i,     --     clock.clk
            rden_a    => s_sub_pipe_rden_a_i(i),    --    rden_a.rden_a
            rden_b    => s_sub_pipe_rden_b_i(i)     --    rden_b.rden_b
        );
	end generate s_ram;
	
	process(clk_i,reset_n_i,s2_sub_pipeI) is
	
		variable s2_sub_pipe_v: t_s2_sub_pipe_v;

		variable s2_flag: integer range 0 to 9:=0;
		variable s12_data_v_rx_v: boolean:=false;
		variable ro_flag: std_logic:='0';
		--========================================================
		variable address: std_logic_vector(3 downto 0):="0000";
		variable s3_flag: integer range 0 to 17:=0;
		variable ram_counter: integer range 0 to 8:=0;
		variable ro_addr_counter: integer range 0 to 25:=0;
		
	begin
		if rising_edge(clk_i) then
			if s2_sub_pipeI.s12_data_v_i='1' then
				s3_busy_o<='1';
				s_sub_pipe_wren_a_i<=x"ff";
				s_sub_pipe_wren_b_i<=x"ff";
				--Store input data temporarily into variables
				s2_sub_pipe_v.s2_sub_pipe_data_7_h_v:=s2_sub_pipeI.s2_sub_pipe_data_7_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_7_l_v:=s2_sub_pipeI.s2_sub_pipe_data_7_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_6_h_v:=s2_sub_pipeI.s2_sub_pipe_data_6_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_6_l_v:=s2_sub_pipeI.s2_sub_pipe_data_6_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_5_h_v:=s2_sub_pipeI.s2_sub_pipe_data_5_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_5_l_v:=s2_sub_pipeI.s2_sub_pipe_data_5_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_4_h_v:=s2_sub_pipeI.s2_sub_pipe_data_4_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_4_l_v:=s2_sub_pipeI.s2_sub_pipe_data_4_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_3_h_v:=s2_sub_pipeI.s2_sub_pipe_data_3_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_3_l_v:=s2_sub_pipeI.s2_sub_pipe_data_3_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_2_h_v:=s2_sub_pipeI.s2_sub_pipe_data_2_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_2_l_v:=s2_sub_pipeI.s2_sub_pipe_data_2_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_1_h_v:=s2_sub_pipeI.s2_sub_pipe_data_1_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_1_l_v:=s2_sub_pipeI.s2_sub_pipe_data_1_l_i;
				s2_sub_pipe_v.s2_sub_pipe_data_0_h_v:=s2_sub_pipeI.s2_sub_pipe_data_0_h_i;
				s2_sub_pipe_v.s2_sub_pipe_data_0_l_v:=s2_sub_pipeI.s2_sub_pipe_data_0_l_i;
				
				s_data_port_arr_a_i(7)<=s2_sub_pipe_v.s2_sub_pipe_data_7_h_v;
				s_data_port_arr_a_i(6)<=s2_sub_pipe_v.s2_sub_pipe_data_6_h_v;
				s_data_port_arr_a_i(5)<=s2_sub_pipe_v.s2_sub_pipe_data_5_h_v;
				s_data_port_arr_a_i(4)<=s2_sub_pipe_v.s2_sub_pipe_data_4_h_v;
				s_data_port_arr_a_i(3)<=s2_sub_pipe_v.s2_sub_pipe_data_3_h_v;
				s_data_port_arr_a_i(2)<=s2_sub_pipe_v.s2_sub_pipe_data_2_h_v;
				s_data_port_arr_a_i(1)<=s2_sub_pipe_v.s2_sub_pipe_data_1_h_v;
				s_data_port_arr_a_i(0)<=s2_sub_pipe_v.s2_sub_pipe_data_0_h_v;
				
				s_data_port_arr_b_i(7)<=s2_sub_pipe_v.s2_sub_pipe_data_7_l_v;
				s_data_port_arr_b_i(6)<=s2_sub_pipe_v.s2_sub_pipe_data_6_l_v;
				s_data_port_arr_b_i(5)<=s2_sub_pipe_v.s2_sub_pipe_data_5_l_v;
				s_data_port_arr_b_i(4)<=s2_sub_pipe_v.s2_sub_pipe_data_4_l_v;
				s_data_port_arr_b_i(3)<=s2_sub_pipe_v.s2_sub_pipe_data_3_l_v;
				s_data_port_arr_b_i(2)<=s2_sub_pipe_v.s2_sub_pipe_data_2_l_v;
				s_data_port_arr_b_i(1)<=s2_sub_pipe_v.s2_sub_pipe_data_1_l_v;
				s_data_port_arr_b_i(0)<=s2_sub_pipe_v.s2_sub_pipe_data_0_l_v;
				

				if s2_flag < 8 then --Initiate s1 => s2 Readout
					if s2_flag=0 then
						s_sub_pipe_wren_a_i<=x"ff";
						s_sub_pipe_wren_b_i<=x"ff";
						s2_flag := s2_flag +1; --increment counter
					
					else
						--Increment address ports of RAM modules
						s_addr_port_arr_a_i<= (others => (s_addr_port_arr_a_i(7) + 1));
						s_addr_port_arr_b_i<= (others => (s_addr_port_arr_b_i(7) + 1));
						
						--Write new data to data ports of RAM modules
						s_data_port_arr_a_i(7)<=s2_sub_pipe_v.s2_sub_pipe_data_7_h_v;
						s_data_port_arr_a_i(6)<=s2_sub_pipe_v.s2_sub_pipe_data_6_h_v;
						s_data_port_arr_a_i(5)<=s2_sub_pipe_v.s2_sub_pipe_data_5_h_v;
						s_data_port_arr_a_i(4)<=s2_sub_pipe_v.s2_sub_pipe_data_4_h_v;
						s_data_port_arr_a_i(3)<=s2_sub_pipe_v.s2_sub_pipe_data_3_h_v;
						s_data_port_arr_a_i(2)<=s2_sub_pipe_v.s2_sub_pipe_data_2_h_v;
						s_data_port_arr_a_i(1)<=s2_sub_pipe_v.s2_sub_pipe_data_1_h_v;
						s_data_port_arr_a_i(0)<=s2_sub_pipe_v.s2_sub_pipe_data_0_h_v;
						
						s_data_port_arr_b_i(7)<=s2_sub_pipe_v.s2_sub_pipe_data_7_l_v;
						s_data_port_arr_b_i(6)<=s2_sub_pipe_v.s2_sub_pipe_data_6_l_v;
						s_data_port_arr_b_i(5)<=s2_sub_pipe_v.s2_sub_pipe_data_5_l_v;
						s_data_port_arr_b_i(4)<=s2_sub_pipe_v.s2_sub_pipe_data_4_l_v;
						s_data_port_arr_b_i(3)<=s2_sub_pipe_v.s2_sub_pipe_data_3_l_v;
						s_data_port_arr_b_i(2)<=s2_sub_pipe_v.s2_sub_pipe_data_2_l_v;
						s_data_port_arr_b_i(1)<=s2_sub_pipe_v.s2_sub_pipe_data_1_l_v;
						s_data_port_arr_b_i(0)<=s2_sub_pipe_v.s2_sub_pipe_data_0_l_v;
						--increment counter
						s2_flag := s2_flag +1; 
					end if;
				end if;
				
				elsif s2_flag = 8 then
					ro_flag:='1';
					s_sub_pipe_wren_a_i<=x"00";
				   s_sub_pipe_wren_b_i<=x"00";
					s_addr_port_arr_a_i<= (others =>"0000");
					s_addr_port_arr_b_i<= (others =>"1000");
				
				else -- if s2_flag=8 then --Flag end on s1 => s2 Readout
					s_sub_pipe_wren_a_i<=x"00";
					s_sub_pipe_wren_b_i<=x"00";
					s_addr_port_arr_a_i<= (others =>"0000");
					s_addr_port_arr_b_i<= (others =>"1000");
					--s2_sub_pipeO.s23_data_v_o<='1';
				end if;
--========================================================================						
			if ro_flag='1' then
--				s2_sub_pipeO.s23_data_v_o<='1';
				case ram_counter is
					when 0 =>
						s_sub_pipe_rden_a_i<=x"01"; --Read enable on port a of ram 1
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(0); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(0)<="0000";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(0)<="0001";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(0)<="0010";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s2_sub_pipeO.s23_data_v_o<='1';
								s_addr_port_arr_a_i(0)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(0)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(0)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(0)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(0)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(0)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(0)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(0)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(0)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(0)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								s_addr_port_arr_a_i(0)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 14 =>
								s_addr_port_arr_a_i(0)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 15 =>
								s_addr_port_arr_a_i(0)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 16 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"02"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(1)<="0000";
							when 17 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"02"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(1)<="0001";
							when 18 =>
								ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"02"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(1)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 1 =>
						s_sub_pipe_rden_a_i<=x"02"; --Read enable on port a of ram 2
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(1); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(1)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(1)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(1)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(1)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(1)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(1)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(1)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(1)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(1)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(1)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(1)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(1)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(1)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"04"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(2)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"04"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(2)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"04"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(2)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 2 =>
						s_sub_pipe_rden_a_i<=x"04"; --Read enable on port a of ram 3
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(2); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(2)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(2)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(2)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(2)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(2)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(2)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(2)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(2)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(2)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(2)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(2)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(2)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(2)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"08"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(3)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"08"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(3)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"08"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(3)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 3 =>
						s_sub_pipe_rden_a_i<=x"08"; --Read enable on port a of ram 4
					   s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(3); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(3)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(3)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(3)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(3)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(3)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(3)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(3)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(3)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(3)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(3)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(3)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(3)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(3)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"10"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(4)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"10"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(4)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"10"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(4)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 4 =>
						s_sub_pipe_rden_a_i<=x"10"; --Read enable on port a of ram 5
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(4); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(4)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(4)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(4)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(4)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(4)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(4)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(4)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(4)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(4)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(4)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(4)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(4)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(4)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"20"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(5)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"20"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(5)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"20"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(5)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 5 =>
						s_sub_pipe_rden_a_i<=x"20"; --Read enable on port a of ram 6
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(5); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(5)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(5)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(5)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(5)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(5)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(5)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(5)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(5)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(5)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(5)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(5)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(5)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(5)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"40"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(6)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"40"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(6)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"40"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(6)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 6 =>
						s_sub_pipe_rden_a_i<=x"40"; --Read enable on port a of ram 7
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(6); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(6)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(6)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(6)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(6)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(6)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(6)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(6)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(6)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(6)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(6)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(6)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(6)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(6)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"80"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(7)<="0000";
							when 14 =>
								ro_addr_counter := ro_addr_counter + 1;
								s_sub_pipe_rden_a_i<=x"80"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(7)<="0001";
							when 15 =>
							ro_addr_counter := 0;
								s_sub_pipe_rden_a_i<=x"80"; --Read enable on port a of ram 2
								s_addr_port_arr_a_i(7)<="0010";
								ram_counter:= ram_counter + 1; --Increment RAM counter
							when others =>
						end case;
					when 7 =>
						s_sub_pipe_rden_a_i<=x"80"; --Read enable on port a of ram 8
						s2_sub_pipeO.s2_data_o<=s_data_port_arr_a_o(7); --Direct output data to sub ram data out
						case ro_addr_counter is 
							when 0 =>
								s_addr_port_arr_a_i(7)<="0011";
								ro_addr_counter := ro_addr_counter + 1;
							when 1 =>
								s_addr_port_arr_a_i(7)<="0100";
								ro_addr_counter := ro_addr_counter + 1;
							when 2 =>
								s_addr_port_arr_a_i(7)<="0101";
								ro_addr_counter := ro_addr_counter + 1;
							when 3 =>
								s_addr_port_arr_a_i(7)<="0110";
								ro_addr_counter := ro_addr_counter + 1;
							when 4 =>
								s_addr_port_arr_a_i(7)<="0111";
								ro_addr_counter := ro_addr_counter + 1;
							when 5 =>
								s_addr_port_arr_a_i(7)<="1000";
								ro_addr_counter := ro_addr_counter + 1;
							when 6 =>
								s_addr_port_arr_a_i(7)<="1001";
								ro_addr_counter := ro_addr_counter + 1;
							when 7 =>
								s_addr_port_arr_a_i(7)<="1010";
								ro_addr_counter := ro_addr_counter + 1;
							when 8 =>
								s_addr_port_arr_a_i(7)<="1011";
								ro_addr_counter := ro_addr_counter + 1;
							when 9 =>
								s_addr_port_arr_a_i(7)<="1100";
								ro_addr_counter := ro_addr_counter + 1;
							when 10 =>
								s_addr_port_arr_a_i(7)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 11 =>
								s_addr_port_arr_a_i(7)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 12 =>
								s_addr_port_arr_a_i(7)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
							when 13 =>
								s_sub_pipe_rden_a_i<=x"00"; --Read enable on port a of ram 1	
--								s_addr_port_arr_a_i(7)<="1101";
								ro_addr_counter := ro_addr_counter + 1;
							when 14 =>
--								s_addr_port_arr_a_i(7)<="1110";
								ro_addr_counter := ro_addr_counter + 1;
							when 15 =>
--								s2_sub_pipeO.s23_data_v_o<='0';
--								s_addr_port_arr_a_i(7)<="1111";
								ro_addr_counter := ro_addr_counter + 1;
								--ram_counter:= ram_counter + 1; --Increment RAM counter
							when 16 =>
								s2_sub_pipeO.s23_data_v_o<='0';
								ro_addr_counter := 0;
							when others =>
						end case;
					when others =>
				end case;
			end if;
		end if;
	end process;
end main;