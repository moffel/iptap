library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ipchecksum is
    Port (	clk, rst : in std_logic;
				
				send_data : in std_logic_vector(7 downto 0);
				send_data_valid : in std_logic;
				send_data_pass : in std_logic;
				cs_begin : in std_logic;
				cs_setaddr : in std_logic;
				cs_end : in std_logic;
				
				frame_data : out std_logic_vector(7 downto 0);
				frame_addr : out std_logic_vector(10 downto 0);
				frame_data_valid : out std_logic;
				frame_next : in std_logic
	 );
end ipchecksum;

architecture Behavioral of ipchecksum is
	
	signal address : std_logic_vector(10 downto 0);
	signal checksum_address : std_logic_vector(10 downto 1); -- assume checksum to be 2b aligned
	signal sum : std_logic_vector(16 downto 0);
	signal add : std_logic_vector(15 downto 0);
	signal nibble : std_logic;
	
	signal state : unsigned(1 downto 0);
	
	signal checksum : std_logic_vector(15 downto 0);
	
begin

	frame_data <=	checksum(15 downto 8) when state = "01" else
						checksum( 7 downto 0) when state = "10" else
						send_data;
						
	frame_addr <=	address when state = "00" else
						checksum_address & state(1);
						
	frame_data_valid <=	send_data_valid and send_data_pass when state = "00" else
								'1';
	
	add <=	x"0000" when cs_end = '1' else
				send_data & x"00" when nibble = '0' else
				x"00" & send_data;
				
	checksum <= not sum(15 downto 0);

	process(clk, rst)
	begin
		if rst = '1' then
			address <= (others => '0');
			state <= "00";
		elsif clk'event and clk = '1' then
			
			if send_data_valid = '1' or cs_end = '1' then
				sum <= std_logic_vector(unsigned('0' & sum(15 downto 0)) + unsigned('0' & add) + unsigned(x"0000" & sum(16 downto 16)));
			end if;

			if send_data_valid = '1' then
				nibble <= not nibble;
				if send_data_pass = '1' then
					address <= std_logic_vector(unsigned(address) + 1);
				end if;
			end if;
			
			if cs_begin = '1' then
				nibble <= '0';
				sum <= (others => '0');
			end if;
						
			if cs_setaddr = '1' then
				checksum_address <= address(10 downto 1);
			end if;
			
			if frame_next = '1' then
				address <= (others => '0');
			end if;
			
			if cs_end = '1' then
				state <= "01";
			end if;
			
			if state = "01" then
				state <= "10";
			elsif state = "10" then
				state <= "00";
			end if;
		
		end if;
	end process;


end Behavioral;

