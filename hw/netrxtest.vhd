library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity netrxtest is
    Port ( clk : in  STD_LOGIC;
				rst : in std_logic;
           s_tx : out  STD_LOGIC;
			  E_NRST : out std_logic;
           E_RXD : in  STD_LOGIC_VECTOR (3 downto 0);
           E_RX_DV : in  STD_LOGIC;
           E_RX_CLK : in  STD_LOGIC;
			  E_MDC : out std_logic;
			  E_MDIO : out std_logic);
end netrxtest;

architecture Behavioral of netrxtest is
	signal tx_clk_en : std_logic_vector(8 downto 0);
	signal baud16 : std_logic;
	
	COMPONENT kcuart_tx
	PORT(
		data_in : IN std_logic_vector(7 downto 0);
		send_character : IN std_logic;
		en_16_x_baud : IN std_logic;
		clk : IN std_logic;          
		serial_out : OUT std_logic;
		Tx_complete : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT etherx
	PORT(
		RST : IN std_logic;
		RX_CLK : IN std_logic;
		RX_D : IN std_logic_vector(3 downto 0);
		RX_DV : IN std_logic;
		O_CLK : IN std_logic;
		O_NEXT : IN std_logic;
		O_DONE : IN std_logic;          
		O_D : OUT std_logic_vector(7 downto 0);
		O_READY : OUT std_logic
		);
	END COMPONENT;

	signal data_dummy : std_logic_vector(7 downto 0);
	signal data : std_logic_vector(7 downto 0);
	signal data_send : std_logic; -- send byte to uart
	signal data_send_req : std_logic; -- send byte to uart
	signal data_sent : std_logic; -- byte sent by uart
	signal data_counter : std_logic_vector(3 downto 0);
	signal data_ready : std_logic; -- frame received
	signal data_done : std_logic; -- processing of frame done
begin

	E_NRST <= not rst;
	E_MDC <= '0';
	E_MDIO <= '0';
	data_dummy <= "1001" & data_counter;

	Inst_kcuart_tx: kcuart_tx PORT MAP(
		data_in => data,
		send_character => data_send,
		en_16_x_baud => baud16,
		serial_out => s_tx,
		Tx_complete => data_sent,
		clk => clk
	);

	Inst_etherx: etherx PORT MAP(
		RST => rst,
		RX_CLK => E_RX_CLK,
		RX_D => E_RXD,
		RX_DV => E_RX_DV,
		O_CLK => clk,
		O_D => data,
		O_READY => data_ready,
		O_NEXT => data_sent,
		O_DONE => data_done
	);

	process(clk)
	begin
		if rst = '1' then
			tx_clk_en <= (others => '0');
			data_counter <= (others => '0');
			data_send_req <= '0';
			data_send <= '0';
		elsif clk'event and clk = '1' then
		
			data_send <= data_send;
		
			if unsigned(tx_clk_en) = 325 then
				tx_clk_en <= (others => '0');
				baud16 <= '1';
			else
				tx_clk_en <= std_logic_vector( unsigned(tx_clk_en) + 1 );
				baud16 <= '0';
			end if;
			
			data_done <= '0';
			data_counter <= data_counter;
			if (data_sent = '1' and unsigned(data_counter) /= 0) or data_ready = '1' then
				data_send <= '1';
				data_counter <= std_logic_vector( unsigned(data_counter) + 1 );
			end if;
			
			if data_sent = '1' and unsigned(data_counter) = 0 then
				data_send <= '0';
				data_done <= '1';
			end if;
				
		end if;
	end process;


end Behavioral;

