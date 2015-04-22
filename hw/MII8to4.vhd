library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MII8to4 is
	port (
		rst : in std_logic;
		
		in_clk : in std_logic;
		in_d : in std_logic_vector(7 downto 0);
		
		out_clk : out std_logic;
		out_d : out std_logic_vector(3 downto 0)
		
	);
end entity MII8to4;

architecture RTL of MII8to4 is
	
begin

	process(rst, in_clk)
	begin
		if rst = '1' then
			out_clk <= '0';
		elsif in_clk'event and in_clk = '1' then
			out_clk <= not out_clk;
			
			if out_clk = '0' then
				out_d <= in_d(3 downto 0);
			else
				out_d <= in_d(7 downto 4);
			end if;
			
		end if;
	end process;


end architecture RTL;
