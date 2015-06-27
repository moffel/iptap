library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

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

				LED : out std_logic_vector(7 downto 0)
			
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
		L_ACK : IN std_logic;          
		E_NRST : OUT std_logic;
		E_TXD : OUT std_logic_vector(3 downto 0);
		E_TX_EN : OUT std_logic;
		L_ADDR : OUT std_logic_vector(31 downto 0);
		L_DATA_OUT : OUT std_logic_vector(7 downto 0);
		L_WE : OUT std_logic;
		L_RE : OUT std_logic
		);
	END COMPONENT;

	signal L_ADDR : std_logic_vector(31 downto 0);
	signal L_DATA_IN : std_logic_vector(7 downto 0);
	signal L_DATA_OUT : std_logic_vector(7 downto 0);
	signal L_WE, L_RE : std_logic;
	signal L_ACK : std_logic;

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
		L_ACK => L_ACK
	);
	
	L_ACK <= L_WE; -- no delay ack
	L_DATA_IN <= x"00";
	
	process(clk, rst)
	begin
		if rst = '1' then
			LED <= x"00";
		elsif clk'event and clk = '1' then
			
			if L_WE = '1' then
				LED <= L_DATA_OUT;
			end if;
			
		end if;
	end process;

end Behavioral;

