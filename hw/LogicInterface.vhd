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
		
			m_addr : in std_logic_vector(7 downto 0);
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
	l_data_out <= n_data_in;
	n_data_out <= l_data_in;
	l_we <= '1' when state = PUT else '0';
	l_re <= '1' when state = GET else '0';
	n_next_out <= '1' when state = PUT and l_ack = '1' else '0';
	n_next_in <= '1' when state = GET and l_ack = '1' else '0';

	m_data_out(7 downto 1) <= (others => '0');
	m_data_out(0) <= '0' when state = IDLE else '1';

	process(clk, rst)
	begin
		if rst = '1' then
			state <= IDLE;
		elsif clk'event and clk = '1' then
			state <= next_state;
			
			if stop = '0' and l_ack = '1' then
				it <= it_inc;
			end if;
			
			if m_we = '1' and m_addr(4) = '1' then
				if m_addr(6 downto 5) = "01" then
					it(31 downto 24) <= it(23 downto 16);
					it(23 downto 16) <= it(15 downto  8);
					it(15 downto  8) <= it( 7 downto  0);
					it( 7 downto  0) <= m_data_in;
				elsif m_addr(6 downto 5) = "10" then
					it_end(31 downto 24) <= it_end(23 downto 16);
					it_end(23 downto 16) <= it_end(15 downto  8);
					it_end(15 downto  8) <= it_end( 7 downto  0);
					it_end( 7 downto  0) <= m_data_in;
				end if;
			end if;
			
		end if;
	end process;

	process(state, stop, m_we, m_addr, m_data_in)
	begin
		next_state <= state;
	
		case state is
			when IDLE =>
				if m_we = '1' and m_addr(6 downto 4) = "111" then
					if m_data_in(0) = '0' then
						next_state <= GET;
					else
						next_state <= PUT;
					end if;
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

