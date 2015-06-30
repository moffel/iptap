library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity iptap_dummyuser is
    Port ( 
				clk, rst : in std_logic;
			
				E_NRST : out std_logic;
				E_RXD : in std_logic_vector (3 downto 0);
				E_RX_DV : in std_logic;
				E_RX_CLK : in std_logic;
				E_TXD : out std_logic_vector(3 downto 0);
				E_TX_EN : out std_logic;
				E_TX_CLK : in std_logic;

				LED : out std_logic_vector(7 downto 0);
				S_TX : out  STD_LOGIC
			
			);
end iptap_dummyuser;

architecture Behavioral of iptap_dummyuser is

	COMPONENT iptap
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		E_RXD : IN std_logic_vector(3 downto 0);
		E_RX_DV : IN std_logic;
		E_RX_CLK : IN std_logic;
		E_TX_CLK : IN std_logic;
		L_DATA_IN : IN std_logic_vector(7 downto 0);
		L_ACK, L_DATA_VALID : IN std_logic;          
		E_NRST : OUT std_logic;
		E_TXD : OUT std_logic_vector(3 downto 0);
		E_TX_EN : OUT std_logic;
		L_ADDR : OUT std_logic_vector(31 downto 0);
		L_DATA_OUT : OUT std_logic_vector(7 downto 0);
		L_WE : OUT std_logic;
		L_RE : OUT std_logic
		);
	END COMPONENT;

	component kcuart_tx 
    Port (        data_in : in std_logic_vector(7 downto 0);
           send_character : in std_logic;
             en_16_x_baud : in std_logic;
               serial_out : out std_logic;
              Tx_complete : out std_logic;
                      clk : in std_logic);
    end component;

	signal L_ADDR : std_logic_vector(31 downto 0);
	signal L_DATA_IN : std_logic_vector(7 downto 0);
	signal L_DATA_OUT : std_logic_vector(7 downto 0);
	signal L_WE, L_RE : std_logic;
	signal L_ACK, L_DATA_VALID : std_logic;

	signal tx_clk_en : std_logic_vector(8 downto 0);
	signal baud16 : std_logic;
	signal serial_ack : std_logic;
	signal serial_send : std_logic;
	
	type memory_type is array (0 to 2047) of std_logic_vector(7 downto 0);
	signal memory : memory_type;

	signal serial_cs : std_logic;
	signal led_cs : std_logic;
	signal ram_cs : std_logic;
	
	signal read_delay : std_logic;
begin

	Inst_iptap: iptap PORT MAP(
		clk => clk,
		rst => rst,
		E_NRST => E_NRST,
		E_RXD => E_RXD,
		E_RX_DV => E_RX_DV,
		E_RX_CLK => E_RX_CLK,
		E_TXD => E_TXD,
		E_TX_EN => E_TX_EN,
		E_TX_CLK => E_TX_CLK,
		L_ADDR => L_ADDR,
		L_DATA_IN => L_DATA_IN,
		L_DATA_OUT => L_DATA_OUT,
		L_WE => L_WE,
		L_RE => L_RE,
		L_ACK => L_ACK,
		L_DATA_VALID => L_DATA_VALID
	);
	
	serial_cs <= L_WE when L_ADDR(31 downto 30) = "10" else '0';
	led_cs <= L_WE when L_ADDR(31 downto 30) = "00" else '0';
	ram_cs <= L_WE when L_ADDR(31 downto 30) = "11" else '0';
	
	L_ACK <= ram_cs or led_cs or (serial_cs and serial_ack) or L_RE;
	
	Inst_kcuart_tx: kcuart_tx PORT MAP(
		data_in => L_DATA_OUT,
		send_character => serial_cs,
		en_16_x_baud => baud16,
		serial_out => S_TX,
		Tx_complete => serial_ack,
		clk => clk
	);

	process(clk, rst)
	begin
		if rst = '1' then
			LED <= x"00";
			tx_clk_en <= (others => '0');
		elsif clk'event and clk = '1' then
			
			if led_cs = '1' then
				LED <= L_DATA_OUT;
			end if;
			
			L_DATA_IN <= memory(to_integer(unsigned(L_ADDR(10 downto 0))));
			L_DATA_VALID <= L_RE;
			
			if ram_cs = '1' then
				memory(to_integer(unsigned(L_ADDR(10 downto 0)))) <= L_DATA_OUT;
			end if;
			
			if unsigned(tx_clk_en) = 325 then
				tx_clk_en <= (others => '0');
				baud16 <= '1';
			else
				tx_clk_en <= std_logic_vector( unsigned(tx_clk_en) + 1 );
				baud16 <= '0';
			end if;

		end if;
	end process;

end Behavioral;

