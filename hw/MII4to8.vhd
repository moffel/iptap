library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MII4to8 is
	port (
		rst : in std_logic;
		
		in_clk : in std_logic;
		in_d : in std_logic_vector(3 downto 0);

		out_clk : out std_logic;		
		out_d : out std_logic_vector(7 downto 0)
		
	);
end entity MII4to8;

architecture RTL of MII4to8 is
	
begin
	
	process(in_clk, rst)
	begin
		if rst = '1' then
			out_clk <= '0';
		elsif in_clk'event and in_clk = '1' then
			
			out_clk <= not out_clk;
			
			if out_clk = '0' then
				out_d(3 downto 0) <= in_d;
			else
				out_d(7 downto 4) <= in_d;
			end if;
			
		end if;
	end process;	

end architecture RTL;
