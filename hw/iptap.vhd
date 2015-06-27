library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- out port map
-- XXXXX001	- net send byte
-- XXXXX010 - net ctrl
-- 1XXXXXXX - led
-- X1XXXXXX - uart

entity iptap is
    Port (	clk,rst : in std_logic;
				
				E_NRST : out std_logic;
				E_RXD : in std_logic_vector (3 downto 0);
				E_RX_DV : in std_logic;
				E_RX_CLK : in std_logic;
				E_TXD : out std_logic_vector(3 downto 0);
				E_TX_EN : out std_logic;
				E_TX_CLK : in std_logic;

				led : out std_logic_vector(7 downto 0)
	 );
end iptap;

architecture Behavioral of iptap is

	COMPONENT kcpsm3
	PORT(
		instruction : IN std_logic_vector(17 downto 0);
		in_port : IN std_logic_vector(7 downto 0);
		interrupt : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		address : OUT std_logic_vector(9 downto 0);
		port_id : OUT std_logic_vector(7 downto 0);
		write_strobe : OUT std_logic;
		out_port : OUT std_logic_vector(7 downto 0);
		read_strobe : OUT std_logic;
		interrupt_ack : OUT std_logic
		);
	END COMPONENT;

	COMPONENT instruction_mem
	PORT(
		address : IN std_logic_vector(9 downto 0);
		clk : IN std_logic;          
		instruction : OUT std_logic_vector(17 downto 0)
		);
	END COMPONENT;

	COMPONENT ethernet_adapter
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		port_in_data : IN std_logic_vector(8 downto 0);
		port_addr : IN std_logic_vector(2 downto 0);
		port_read : IN std_logic;
		port_write : IN std_logic;
		tx_clk : IN std_logic;
		rx_clk : IN std_logic;
		rx_d : IN std_logic_vector(3 downto 0);
		rx_dv : IN std_logic;          
		port_out_data : OUT std_logic_vector(7 downto 0);
		tx_d : OUT std_logic_vector(3 downto 0);
		tx_dv : OUT std_logic;
		xx_rst : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT LogicInterface
	Port ( 
			clk, rst : in std_logic;
		
			m_addr : in std_logic_vector(2 downto 0);
			m_data_in : in std_logic_vector(7 downto 0);
			m_data_out : out std_logic_vector(7 downto 0);
			m_we, m_re : in std_logic;
			
			n_data_in : in std_logic_vector(7 downto 0);
			n_data_out : out std_logic_vector(7 downto 0);
			n_next_in, n_next_out : out std_logic;
			
			l_addr : out std_logic_vector(31 downto 0);
			l_data_in : in std_logic_vector(7 downto 0);
			l_data_out : out std_logic_vector(7 downto 0);
			l_we, l_re : out std_logic;
			l_ack : in std_logic
	 );
	END COMPONENT;

	signal instruction_address : std_logic_vector(9 downto 0);
	signal instruction : std_logic_vector(17 downto 0);

	signal port_write, port_read : std_logic;
	signal port_out : std_logic_vector(7 downto 0);
	signal port_in : std_logic_vector(7 downto 0);
	signal port_id : std_logic_vector(7 downto 0);
	
	signal dev_nic_we, dev_nic_re : std_logic;
	signal dev_logic_we, dev_logic_re : std_logic;
	signal dev_led_we : std_logic;
	
	signal net_output : std_logic_vector(7 downto 0);
	signal nic_port_addr : std_logic_vector(2 downto 0);
	signal nic_port_data : std_logic_vector(8 downto 0);
	signal nic_port_write : std_logic;
	signal nic_port_read : std_logic;
	
	signal logic_output : std_logic_vector(7 downto 0);
	signal ln_out : std_logic_vector(7 downto 0);
	signal ln_next_out : std_logic;
	signal ln_next_in : std_logic;
	
	signal logic_addr : std_logic_vector(31 downto 0);
	signal logic_data_in : std_logic_vector(7 downto 0);
	signal logic_data_out : std_logic_vector(7 downto 0);
	signal logic_we : std_logic;
	signal logic_re : std_logic;
	signal logic_ack : std_logic;
begin

	Inst_kcpsm3: kcpsm3 PORT MAP(
		address => instruction_address,
		instruction => instruction,
		port_id => port_id,
		write_strobe => port_write,
		out_port => port_out,
		read_strobe => port_read,
		in_port => port_in,
		interrupt => '0',
--		interrupt_ack => ,
		reset => rst,
		clk => clk
	);
	
	Inst_instruction_mem: instruction_mem PORT MAP(
		address => instruction_address,
		instruction => instruction,
		clk => clk
	);
	----------------------------
	Inst_ethernet_adapter: ethernet_adapter PORT MAP(
		clk => clk,
		rst => rst,
		port_in_data => nic_port_data,
		port_out_data => net_output,
		port_addr => nic_port_addr,
		port_read => nic_port_read,
		port_write => nic_port_write,
		tx_clk => E_TX_CLK,
		tx_d => E_TXD,
		tx_dv => E_TX_EN,
		rx_clk => E_RX_CLK,
		rx_d => E_RXD,
		rx_dv => E_RX_DV,
		xx_rst => E_NRST
	);
	
	nic_port_data <=	port_id(3) & port_out when ln_next_out = '0' else
							'0' & ln_out;
	nic_port_addr <=	"000" when ln_next_in = '1' else
							"001" when ln_next_out = '1' else
							port_id(2 downto 0);
	nic_port_read <=	dev_nic_re or ln_next_in;
	nic_port_write <=	dev_nic_we or ln_next_out;
	
	-------------------------------
	LogicInterfaceInst: LogicInterface PORT MAP(
		clk => clk,
		rst => rst,
		
		m_addr => port_id(2 downto 0),
		m_data_in => port_out,
		m_data_out => logic_output,
		m_we => dev_logic_we,
		m_re => dev_logic_re,
		
		n_data_in => net_output,
		n_data_out => ln_out,
		n_next_in => ln_next_in,
		n_next_out => ln_next_out,
		
		l_addr => logic_addr,
		l_data_in => logic_data_in,
		l_data_out => logic_data_out,
		l_we => logic_we,
		l_re => logic_re,
		l_ack => logic_ack
	);
	logic_ack <= logic_re or logic_we;
	logic_data_in <= x"00";

	------------------------------------
	-- device selector
	dev_nic_we <= port_write	when port_id(7 downto 5) = "000" else '0';
	dev_nic_re <= port_read		when port_id(7 downto 5) = "000" else '0';
	dev_logic_we <= port_write	when port_id(7 downto 5) = "001" else '0';
	dev_logic_re <= port_read	when port_id(7 downto 5) = "001" else '0';
	dev_led_we <= port_write	when port_id(7 downto 5) = "010" else '0';

	port_in <=	net_output when dev_nic_re = '1' else
					logic_output;

	------------------------------------
	
	process(clk, rst)
	begin
		if rst = '1' then
			led <= (others => '0');
		elsif clk'event and clk = '1' then

			-- led
--			if dev_led_we = '1' then
--				led <= port_out;
--			end if;
			
--			if logic_we = '1' and logic_addr = x"00000010" then
			if logic_we = '1' then
				led <= logic_data_out;
			end if;
			
		end if;
	end process;

end Behavioral;

