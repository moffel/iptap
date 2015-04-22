library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MII4to8 is
	port (
		rst : in std_logic;
		
		in_clk : in std_logic;
		in_dv : in std_logic;
		in_d : in std_logic_vector(3 downto 0);

		out_clk : out std_logic;		
		out_d : out std_logic_vector(7 downto 0)
		
	);
end entity MII4to8;

architecture RTL of MII4to8 is
	
	component BUFGS 
		port (I: in  STD_LOGIC; 
				O: out STD_LOGIC);
	end component;

	signal int_addr : std_logic;
begin
	
	GBUF_FOR_MUX_CLOCK: BUFGS 
   port map (I => CLOCK, 
             O => CLOCK_GBUF);
	
	process(in_clk, rst)
	begin
		if rst = '1' then
			
			int_addr <= '1';
			
		elsif in_clk'event and in_clk = '1' then
		
			int_clk <= not int_clk;
			
			if in_dv = '1' then
	
				if int_addr = '1' then
					out_d(3 downto 0) <= in_d;
					int_addr <= '0';
				else
					out_d(7 downto 4) <= in_d;
					out_e <= '1';
					int_addr <= '1';
				end if;
				
			end if;
			
		end if;
	end process;	

end architecture RTL;
