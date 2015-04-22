library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity etherx is
    Port (	rst, clk : in std_logic;
				
				rx_clk : in std_logic;
				rx_d : in std_logic_vector (7 downto 0);
				rx_dv : in std_logic;

				o_ready : out std_logic; -- frame is available for reading
				o_addr : in std_logic_vector(9 downto 0);
				o_data : out std_logic_vector(7 downto 0);
				o_done : in std_logic); -- frame reading done
end etherx;

architecture Behavioral of etherx is

	COMPONENT netrxram
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
   COMPONENT trigger
   PORT( IN_D	:	IN	STD_LOGIC; 
          IN_CLK	:	IN	STD_LOGIC; 
          OUT_CLK	:	IN	STD_LOGIC; 
          OUT_D	:	OUT	STD_LOGIC);
   END COMPONENT;

	type state_type is (IDLE, RECEIVING, WAITING, DONE);
	signal state, next_state: state_type;

	signal o_next_trigger : std_logic;
	signal o_ready_trigger : std_logic;

	signal write_addr : std_logic_vector(9 downto 0);
	signal write_enable : std_logic_vector(0 downto 0);
begin
	
ram : netrxram
  PORT MAP (
    clka => rx_clk,
    wea => write_enable,
    addra => write_addr,
    dina => rx_d,
    clkb => clk,
    addrb => o_addr,
    doutb => o_data
  );
  
-- ETHERNET clock domain

	write_enable(0) <=	'1' when state = RECEIVING and rx_dv = '1' else
								'0';
	o_ready_trigger <=	'1' when state = RECEIVING and next_state = WAITING else
								'0';

	process(RX_CLK, RST)
	begin
		if RST = '1' then
			state <= DONE;
			write_addr <= (others => '0');
		elsif RX_CLK'event and RX_CLK = '1' then
			state <= next_state;

			if write_enable(0) = '1' then
				write_addr <= std_logic_vector( unsigned(write_addr) + 1 );
			else
				write_addr <= (others => '0');
			end if;
			
		end if;
	end process;
	
	process(state, rx_dv, rx_d, o_next_trigger)
	begin
		next_state <= state;
	
		case state is
			when IDLE =>
				if rx_dv = '1' and rx_d = "01010101" then
					next_state <= RECEIVING;
				end if;
			
			when RECEIVING =>
				if rx_dv = '0' then
					next_state <= WAITING;
				end if;
				
			when WAITING =>
				if o_next_trigger = '1' then
					next_state <= DONE;
				end if;

			when DONE =>
				if rx_dv = '0' then
					next_state <= IDLE;
				end if;
		end case;
	end process;

-- bridge between clock domains

	frame_done_trigger : trigger
	port map (
		IN_CLK => rx_clk,
		IN_D => o_ready_trigger,
		OUT_CLK => clk,
		OUT_D => o_ready
	);
	
	next_frame_trigger : trigger
	port map (
		IN_CLK => clk,
		IN_D => o_done,
		OUT_CLK => rx_clk,
		OUT_D => o_next_trigger
	);

end Behavioral;

