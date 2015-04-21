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
    Port (	RST : in std_logic;
				RX_CLK : in  STD_LOGIC;
           RX_D : in  STD_LOGIC_VECTOR (3 downto 0);
           RX_DV : in  STD_LOGIC;
           O_CLK : in  STD_LOGIC;
           O_D : out  STD_LOGIC_VECTOR (7 downto 0);
			  O_READY : out std_logic;
           O_NEXT : in  STD_LOGIC;
           O_DONE : in  STD_LOGIC);
end etherx;


architecture Behavioral of etherx is

	COMPONENT netrxram
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
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

	signal RX_ADDR: std_logic_vector(10 downto 0);
	signal O_ADDR: std_logic_vector(9 downto 0);
	signal frame_received: std_logic;
	signal next_frame: std_logic;

	signal dv: std_logic_vector(0 downto 0);
begin

	dv(0) <= RX_DV;
	
ram : netrxram
  PORT MAP (
    clka => RX_CLK,
    wea => dv,
    addra => RX_ADDR,
    dina => RX_D,
    clkb => O_CLK,
    addrb => O_ADDR,
    doutb => O_D
  );
  
-- ETHERNET clock domain
  
	process(RX_CLK, RST)
	begin
		if RST = '1' then
			state <= DONE;
			RX_ADDR <= (others => '0');
		elsif RX_CLK'event and RX_CLK = '1' then
			state <= next_state;

			if RX_DV = '1' then
				RX_ADDR <= std_logic_vector( unsigned(RX_ADDR) + 1 );
			else
				RX_ADDR <= (others => '0');
			end if;
			
			frame_received <= '0';
			if state = RECEIVING and next_state = WAITING then
				frame_received <= '1';
			end if;
		end if;
	end process;
	
	process(state, RX_DV, next_frame)
	begin
		next_state <= state;
	
		case state is
			when IDLE =>
				if RX_DV = '1' then
					next_state <= RECEIVING;
				end if;
			
			when RECEIVING =>
				if RX_DV = '0' then
					next_state <= WAITING;
				end if;
				
			when WAITING =>
				if next_frame = '1' then
					next_state <= DONE;
				end if;

			when DONE =>
				if RX_DV = '0' then
					next_state <= IDLE;
				end if;
		end case;
	end process;

-- output clock domain

	process(O_CLK, RST)
	begin
		if RST = '1' then
			O_ADDR <= (others => '0');
		elsif O_CLK'event and O_CLK = '1' then
			if O_DONE = '1' then
				O_ADDR <= (others => '0');
			elsif O_NEXT = '1' then
				O_ADDR <= std_logic_vector( unsigned(O_ADDR) + 1 );
			end if;
		end if;
	end process;

-- bridge between clock domains

	frame_done_trigger : trigger
	port map (
		IN_CLK => RX_CLK,
		IN_D => frame_received,
		OUT_CLK => O_CLK,
		OUT_D => O_READY
	);
	
	next_frame_trigger : trigger
	port map (
		IN_CLK => O_CLK,
		IN_D => O_DONE,
		OUT_CLK => RX_CLK,
		OUT_D => next_frame
	);

end Behavioral;

