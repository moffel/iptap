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
				
				led : out std_logic_vector(7 downto 0);
				s_tx : out std_logic
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

	COMPONENT uart_tx
	PORT(
		data_in : IN std_logic_vector(7 downto 0);
		write_buffer : IN std_logic;
		reset_buffer : IN std_logic;
		en_16_x_baud : IN std_logic;
		clk : IN std_logic;          
		serial_out : OUT std_logic;
		buffer_full : OUT std_logic;
		buffer_half_full : OUT std_logic
		);
	END COMPONENT;

	signal instruction_address : std_logic_vector(9 downto 0);
	signal instruction : std_logic_vector(17 downto 0);

	signal port_write : std_logic;
	signal port_out : std_logic_vector(7 downto 0);
	signal port_id : std_logic_vector(7 downto 0);
	
	signal uart_write : std_logic;
	signal uart_counter : std_logic_vector(8 downto 0);
	signal uart_baud16 : std_logic;

begin

	Inst_kcpsm3: kcpsm3 PORT MAP(
		address => instruction_address,
		instruction => instruction,
		port_id => port_id,
		write_strobe => port_write,
		out_port => port_out,
--		read_strobe => ,
		in_port => (others => '0'),
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
	
	Inst_uart_tx: uart_tx PORT MAP(
		data_in => port_out,
		write_buffer => uart_write,
		reset_buffer => rst,
		en_16_x_baud => uart_baud16,
		serial_out => s_tx,
--		buffer_full => ,
--		buffer_half_full => ,
		clk => clk
	);

	uart_write <= port_id(6) when port_write = '1' else '0';
	
	process(clk, rst)
	begin
		if rst = '1' then
			led <= (others => '0');
		elsif clk'event and clk = '1' then

			-- led
			if port_write = '1' and port_id(7) = '1' then
				led <= port_out;
			end if;
			
			-- uart
			if unsigned(uart_counter) = 325 then
				uart_counter <= (others => '0');
				uart_baud16 <= '1';
			else
				uart_counter <= std_logic_vector( unsigned(uart_counter) + 1 );
				uart_baud16 <= '0';
			end if;
			
		end if;
	end process;

end Behavioral;

