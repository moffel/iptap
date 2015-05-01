library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- write ports:
-- 001: send data byte
-- 010: net crtl ( 0-reset, 1-read done, 2-send frame, 3-checksum_begin, 4-checksum_setaddr, 5-checksum_end, 6-checksum_only )
-- 100: set filter0 byte
-- 101: set filter1 byte

-- read ports:
-- XX0: receive data byte
-- XX1: net status ( 0-rx data valid, 1-tx busy )

entity ethernet_adapter is
    Port (	clk, rst : in std_logic;
	 
				port_in_data : in std_logic_vector(8 downto 0);
				port_out_data : out std_logic_vector(7 downto 0);
				port_addr : in std_logic_vector(2 downto 0);
				port_read : in std_logic;
				port_write : in std_logic;
				
				tx_clk : in std_logic;
				tx_d : out std_logic_vector(3 downto 0);
				tx_dv : out std_logic;
				rx_clk : in std_logic;
				rx_d : in std_logic_vector(3 downto 0);
				rx_dv : in std_logic;
				xx_rst : out std_logic -- MII reset signal
				
				);
end ethernet_adapter;

architecture Behavioral of ethernet_adapter is

	COMPONENT etherx
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		rx_clk : IN std_logic;
		rx_d : IN std_logic_vector(3 downto 0);
		rx_dv : IN std_logic;
		o_addr : IN std_logic_vector(10 downto 0);
		o_done : IN std_logic;          
		o_filter_data : IN std_logic_vector(8 downto 0);
		o_filter_id : IN std_logic_vector(0 to 0);
		o_filter_set : IN std_logic;          
		o_ready : OUT std_logic;
		o_data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT ethetx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		frame_addr : IN std_logic_vector(10 downto 0);
		frame_data : IN std_logic_vector(7 downto 0);
		frame_write_enable : IN std_logic;
		send_frame : IN std_logic;
		tx_clk : IN std_logic;          
		frame_sent : OUT std_logic;
		tx_dv : OUT std_logic;
		tx_d : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT ipchecksum
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		send_data : IN std_logic_vector(7 downto 0);
		send_data_valid : IN std_logic;
		send_data_pass : in std_logic;
		cs_begin : IN std_logic;
		cs_setaddr : IN std_logic;
		cs_end : IN std_logic;
		frame_next : IN std_logic;          
		frame_data : OUT std_logic_vector(7 downto 0);
		frame_addr : OUT std_logic_vector(10 downto 0);
		frame_data_valid : OUT std_logic
		);
	END COMPONENT;

	signal rx_ready : std_logic;
	signal tx_addr : std_logic_vector(10 downto 0);
	signal tx_data : std_logic_vector(7 downto 0);
	signal tx_valid : std_logic;
	signal tx_frame_sent : std_logic;
	
	signal rx_counter : std_logic_vector(10 downto 0);
	signal rx_data : std_logic_vector(7 downto 0);
	
	signal pi_send_byte : std_logic;
	signal pi_read_byte : std_logic;
	
	signal pi_reset : std_logic; -- registered input port
	signal pi_checksum_mode : std_logic; -- registered input port
	signal pi_read_done : std_logic;
	signal pi_cs_begin : std_logic;
	signal pi_cs_setaddr : std_logic;
	signal pi_cs_end : std_logic;
	
	signal pi_send_frame : std_logic;
	signal pi_set_filter : std_logic;
	
	signal po_data_valid : std_logic;
	signal po_tx_busy : std_logic;
begin

	xx_rst			<= not pi_reset;

	-- map in and out ports
	pi_set_filter	<= port_write when port_addr(2 downto 1) = "10" else '0';
	pi_send_byte	<= port_write when port_addr = "001" else '0';
	pi_read_done	<= port_in_data(1) when port_addr = "010" and port_write = '1' else '0';
	pi_send_frame	<= port_in_data(2) when port_addr = "010" and port_write = '1' else '0';
	pi_cs_begin		<= port_in_data(3) when port_addr = "010" and port_write = '1' else '0';
	pi_cs_setaddr	<= port_in_data(4) when port_addr = "010" and port_write = '1' else '0';
	pi_cs_end		<= port_in_data(5) when port_addr = "010" and port_write = '1' else '0';

	pi_read_byte 	<= port_read when port_addr(0) = '0' else '0';
	
	port_out_data	<= rx_data when port_addr(0) = '0' else
							po_data_valid & po_tx_busy & "000000";
							
	
	process(clk, rst)
	begin
		if rst = '1' then
			po_data_valid <= '0';
			po_tx_busy <= '0';
			pi_reset <= '1';
			rx_counter <= (others => '0');
		elsif clk'event and clk = '1' then
			
			if port_write = '1' and port_addr = "010" then
				pi_reset <= port_in_data(0);
				pi_checksum_mode <= not port_in_data(6);
			end if;
			
			if rx_ready = '1' then
				po_data_valid <= '1';
			elsif pi_read_done = '1' then
				po_data_valid <= '0';
			end if;
			
			if tx_frame_sent = '1' then
				po_tx_busy <= '0';
			elsif pi_send_frame = '1' then
				po_tx_busy <= '1';
			end if;
			
			if pi_read_done = '1' then
				rx_counter <= (others => '0');
			elsif pi_read_byte = '1' then
				rx_counter <= std_logic_vector( unsigned(rx_counter) + 1 );
			end if;
			
			if pi_reset = '1' then
				po_data_valid <= '0';
				po_tx_busy <= '0';
				rx_counter <= (others => '0');
			end if;
			
		end if;
	end process;


	Inst_etherx: etherx PORT MAP(
		rst => pi_reset,
		clk => clk,
		rx_clk => rx_clk,
		rx_d => rx_d,
		rx_dv => rx_dv,
		o_ready => rx_ready,
		o_addr => rx_counter,
		o_data => rx_data,
		o_done => pi_read_done,
		o_filter_data => port_in_data,
		o_filter_id => port_addr(0 downto 0),
		o_filter_set => pi_set_filter
	);

	Inst_ethetx: ethetx PORT MAP(
		clk => clk,
		rst => pi_reset,
		frame_addr => tx_addr,
		frame_data => tx_data,
		frame_write_enable => tx_valid,
		send_frame => pi_send_frame,
		frame_sent => tx_frame_sent,
		tx_clk => tx_clk,
		tx_dv => tx_dv,
		tx_d => tx_d
	);
	
	Inst_ipchecksum: ipchecksum PORT MAP(
		clk => clk,
		rst => pi_reset,
		send_data => port_in_data(7 downto 0),
		send_data_valid => pi_send_byte,
		send_data_pass => pi_checksum_mode,
		cs_begin => pi_cs_begin,
		cs_setaddr => pi_cs_setaddr,
		cs_end => pi_cs_end,
		frame_data => tx_data,
		frame_addr => tx_addr,
		frame_data_valid => tx_valid,
		frame_next => tx_frame_sent
	);

end Behavioral;

