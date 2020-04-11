	component ram_s3 is
		port (
			data    : in  std_logic_vector(63 downto 0) := (others => 'X'); -- datain
			q       : out std_logic_vector(63 downto 0);                    -- dataout
			address : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- address
			wren    : in  std_logic                     := 'X';             -- wren
			clock   : in  std_logic                     := 'X';             -- clk
			rden    : in  std_logic                     := 'X'              -- rden
		);
	end component ram_s3;

	u0 : component ram_s3
		port map (
			data    => CONNECTED_TO_data,    --    data.datain
			q       => CONNECTED_TO_q,       --       q.dataout
			address => CONNECTED_TO_address, -- address.address
			wren    => CONNECTED_TO_wren,    --    wren.wren
			clock   => CONNECTED_TO_clock,   --   clock.clk
			rden    => CONNECTED_TO_rden     --    rden.rden
		);

