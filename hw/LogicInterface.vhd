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
			l_ack, l_data_in_valid : in std_logic
	 );
end LogicInterface;

architecture Behavioral of LogicInterface is

	signal it : std_logic_vector(31 downto 0);
	signal it_inc : std_logic_vector(31 downto 0);
	signal it_end : std_logic_vector(31 downto 0);
	
	
	type state_type is (IDLE, GET, PUT);
	signal state, next_state: state_type;

begin

	it_inc <= std_logic_vector(unsigned(it) + 1);

	l_addr <= it;
	l_data_out <= n_data_in;
	n_data_out <= l_data_in;
	l_we <= '1' when state = PUT and not (it = it_end) else '0';
	l_re <= '1' when state = GET and not (it = it_end) else '0';
	n_next_out <= l_data_in_valid;
	n_next_in <= l_ack when state = PUT else '0';

	m_data_out(7 downto 1) <= (others => '0');
	m_data_out(0) <= '0' when state = IDLE else '1';

	process(clk, rst)
	begin
		if rst = '1' then
			state <= IDLE;
		elsif clk'event and clk = '1' then
			state <= next_state;
			
			if l_ack = '1' then
				it <= it_inc;
			end if;
			
			if m_we = '1' then
				if m_addr(0) = '1' then
					it(31 downto 24) <= it(23 downto 16);
					it(23 downto 16) <= it(15 downto  8);
					it(15 downto  8) <= it( 7 downto  0);
					it( 7 downto  0) <= m_data_in;
				elsif m_addr(1) = '1' then
					it_end(31 downto 24) <= it_end(23 downto 16);
					it_end(23 downto 16) <= it_end(15 downto  8);
					it_end(15 downto  8) <= it_end( 7 downto  0);
					it_end( 7 downto  0) <= m_data_in;
				end if;
			end if;
			
		end if;
	end process;

	process(state, it, it_end, m_we, m_addr, m_data_in)
	begin
		next_state <= state;
	
		case state is
			when IDLE =>
				if m_we = '1' and m_addr(2) = '1' then
					if m_data_in(0) = '0' then
						next_state <= GET;
					else
						next_state <= PUT;
					end if;
				end if;
				
			when PUT =>
				if it = it_end then
					next_state <= IDLE;
				end if;

			when GET =>
				if it = it_end then
					next_state <= IDLE;
				end if;
			
		end case;
	end process;


end Behavioral;

