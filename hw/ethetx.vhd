library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ethetx is
	Port (	clk, rst : in std_logic;
				
				frame_addr : in std_logic_vector(10 downto 0);
				frame_data : in std_logic_vector(7 downto 0);
				frame_write_enable : in std_logic;
				
				send_frame : in std_logic;
				frame_sent : out std_logic;
				
				tx_clk : in std_logic;
				tx_dv : out std_logic;
				tx_d : out std_logic_vector(3 downto 0)
			);
end ethetx;

architecture Behavioral of ethetx is

   COMPONENT trigger
   PORT( IN_D	:	IN	STD_LOGIC; 
          IN_CLK	:	IN	STD_LOGIC; 
          OUT_CLK	:	IN	STD_LOGIC; 
          OUT_D	:	OUT	STD_LOGIC);
   END COMPONENT;

	COMPONENT crc
	PORT(
		data_in : IN std_logic_vector(7 downto 0);
		crc_en : IN std_logic;
		rst : IN std_logic;
		clk : IN std_logic;          
		crc_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	type state_type is (IDLE, PREAMBLE, DATA, CHECKSUM, WAITING);
	signal state, next_state: state_type;

	signal send_frame_trigger : std_logic;
	signal frame_sent_trigger : std_logic;
	
	signal counter : std_logic_vector(11 downto 0); -- counter counts nibbles not bytes
	
	type frame_memory_type is array(0 to 1535) of std_logic_vector(7 downto 0);
	signal frame_memory : frame_memory_type;
	signal tx_byte : std_logic_vector(7 downto 0);
	signal tx_byte_rev : std_logic_vector(7 downto 0);
	signal tx_crc : std_logic_vector(31 downto 0);
	signal tx_crc_rev : std_logic_vector(31 downto 0);
	signal tx_crc_rst : std_logic;
	signal tx_crc_en : std_logic;
begin

-- memory signals

	process(clk)
	begin
		if clk'event and clk = '1' then
			if frame_write_enable = '1' then
				frame_memory(to_integer(unsigned(frame_addr))) <= frame_data;
			end if;
		end if;
	end process;

	tx_byte <= 	"11010101" when state = PREAMBLE and next_state = DATA else
					"01010101" when state = PREAMBLE else
					not tx_crc_rev( 7 downto  0) when state = CHECKSUM and counter(2 downto 1) = "00" else
					not tx_crc_rev(15 downto  8) when state = CHECKSUM and counter(2 downto 1) = "01" else
					not tx_crc_rev(23 downto 16) when state = CHECKSUM and counter(2 downto 1) = "10" else
					not tx_crc_rev(31 downto 24) when state = CHECKSUM and counter(2 downto 1) = "11" else
					frame_memory(to_integer(unsigned(counter(11 downto 1))));

	tx_d <=	tx_byte(3 downto 0) when counter(0) = '0' else
				tx_byte(7 downto 4);

	tx_dv <= '1' when state = PREAMBLE or state = DATA or state = CHECKSUM else '0';

-- crc

	Inst_crc: crc PORT MAP(
		data_in => tx_byte_rev,
		crc_en => tx_crc_en,
		rst => tx_crc_rst,
		clk => tx_clk,
		crc_out => tx_crc
	);
	
	tx_byte_reverser : 
	for I in 0 to 7 generate
--		tx_byte_rev(7-I) <= not tx_byte(I) when unsigned(counter) < 8 else tx_byte(I);
		tx_byte_rev(7-I) <= tx_byte(I);
	end generate;
	
	tx_crc_reverser:
	for I in 0 to 31 generate
		tx_crc_rev(31-I) <= tx_crc(I);
	end generate;

	tx_crc_en <= '1' when state = DATA and counter(0) = '0' else '0';
	tx_crc_rst <= '1' when state = PREAMBLE else '0';

-- fsm

	process(tx_clk, rst)
	begin
	
		if rst = '1' then
			counter <= (others => '0');
			state <= IDLE;
		elsif tx_clk'event and tx_clk = '1' then
			state <= next_state;
			
			if state = next_state then
				counter <= std_logic_vector(unsigned(counter) + 1);
			else
				counter <= (others => '0');
			end if;
					
		end if;
	
	end process;


	process(state, send_frame_trigger, counter)
	begin
		next_state <= state;
	
		case state is
		
			when IDLE =>
				if send_frame_trigger = '1' then
					next_state <= PREAMBLE;
				end if;
		
			when PREAMBLE =>
				if counter(3 downto 0) = "1111" then
					next_state <= DATA;
				end if;
				
			when DATA =>
				if counter = frame_addr & '1' then
					next_state <= CHECKSUM;
				end if;
				
			when CHECKSUM =>
				if counter(2 downto 0) = "111" then
					next_state <= WAITING;
				end if;
				
			when WAITING =>
				if counter(4) = '1' then
					next_state <= IDLE;
				end if;
				
		end case;
	end process;


-- crossing clock domains

	out_trigger: trigger
	port map (
		IN_CLK => tx_clk,
		IN_D => frame_sent_trigger,
		OUT_CLK => clk,
		OUT_D => frame_sent
	);
	
	in_trigger: trigger
	port map (
		IN_CLK => clk,
		IN_D => send_frame,
		OUT_CLK => tx_clk,
		OUT_D => send_frame_trigger
	);

end Behavioral;

