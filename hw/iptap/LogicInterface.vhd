library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LogicInterface is
    Port ( 
			clk, rst : in std_logic;

			addr_byte : in std_logic_vector(7 downto 0);
			load_addr_begin : in std_logic;
			load_addr_end : in std_logic;
			start_put : in std_logic;
			start_get : in std_logic;

			busy : out std_logic;
			next_in, next_out : out std_logic;
			
			l_addr : out std_logic_vector(31 downto 0);
			l_we, l_re : out std_logic;
			l_ack : in std_logic
	 );
end LogicInterface;

architecture Behavioral of LogicInterface is

	signal it : std_logic_vector(31 downto 0);
	signal it_inc : std_logic_vector(31 downto 0);
	signal it_end : std_logic_vector(31 downto 0);
	
	signal stop : std_logic;
	
	type state_type is (IDLE, GET, PUT);
	signal state, next_state: state_type;

begin

	it_inc <= std_logic_vector(unsigned(it) + 1);
	stop <= '1' when state = IDLE or it_inc = it_end else '0';

	l_addr <= it;
	l_we <= '1' when state = PUT else '0';
	l_re <= '1' when state = GET else '0';
	next_out <= '1' when state = PUT and l_ack = '1' else '0';
	next_in <= '1' when state = GET and l_ack = '1' else '0';

	busy <= '0' when state = IDLE else '1';

	process(clk, rst)
	begin
		if rst = '1' then
			state <= IDLE;
		elsif clk'event and clk = '1' then
			state <= next_state;
			
			if stop = '0' and l_ack = '1' then
				it <= it_inc;
			end if;
			
			if load_addr_begin = '1' then
				it(31 downto 24) <= it(23 downto 16);
				it(23 downto 16) <= it(15 downto  8);
				it(15 downto  8) <= it( 7 downto  0);
				it( 7 downto  0) <= addr_byte;
			end if;

			if load_addr_end = '1' then
				it_end(31 downto 24) <= it_end(23 downto 16);
				it_end(23 downto 16) <= it_end(15 downto  8);
				it_end(15 downto  8) <= it_end( 7 downto  0);
				it_end( 7 downto  0) <= addr_byte;
			end if;

		end if;
	end process;

	process(state, stop, start_get, start_put)
	begin
		next_state <= state;
	
		case state is
			when IDLE =>
				if start_get = '1' then
					next_state <= GET;
				elsif start_put = '1' then
					next_state <= PUT;
				end if;
				
			when PUT =>
				if stop = '1' then
					next_state <= IDLE;
				end if;

			when GET =>
				if stop = '1' then
					next_state <= IDLE;
				end if;
			
		end case;
	end process;


end Behavioral;

