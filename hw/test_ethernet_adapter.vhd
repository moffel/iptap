LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_ethernet_adapter IS
END test_ethernet_adapter;
 
ARCHITECTURE behavior OF test_ethernet_adapter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ethernet_adapter
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         port_in_data : IN  std_logic_vector(8 downto 0);
         port_out_data : OUT  std_logic_vector(7 downto 0);
         port_addr : IN  std_logic_vector(2 downto 0);
         port_read : IN  std_logic;
         port_write : IN  std_logic;
         tx_clk : IN  std_logic;
         tx_d : OUT  std_logic_vector(3 downto 0);
         tx_dv : OUT  std_logic;
         rx_clk : IN  std_logic;
         rx_d : IN  std_logic_vector(3 downto 0);
         rx_dv : IN  std_logic;
         xx_rst : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal port_in_data : std_logic_vector(8 downto 0) := (others => '0');
   signal port_addr : std_logic_vector(2 downto 0) := (others => '0');
   signal port_read : std_logic := '0';
   signal port_write : std_logic := '0';
   signal tx_clk : std_logic := '0';
   signal rx_clk : std_logic := '0';
   signal rx_d : std_logic_vector(3 downto 0) := (others => '0');
   signal rx_dv : std_logic := '0';

 	--Outputs
   signal port_out_data : std_logic_vector(7 downto 0);
   signal tx_d : std_logic_vector(3 downto 0);
   signal tx_dv : std_logic;
   signal xx_rst : std_logic;

   -- Clock period definitions
   constant clk_period : time := 5 ns;
   constant tx_clk_period : time := 22 ns;
   constant rx_clk_period : time := 22 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ethernet_adapter PORT MAP (
          clk => clk,
          rst => rst,
          port_in_data => port_in_data,
          port_out_data => port_out_data,
          port_addr => port_addr,
          port_read => port_read,
          port_write => port_write,
          tx_clk => tx_clk,
          tx_d => tx_d,
          tx_dv => tx_dv,
          rx_clk => tx_clk,
          rx_d => tx_d,
          rx_dv => tx_dv,
--          rx_clk => rx_clk,
--          rx_d => rx_d,
--          rx_dv => rx_dv,
          xx_rst => xx_rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   tx_clk_process :process
   begin
		tx_clk <= '0';
		wait for tx_clk_period/2;
		tx_clk <= '1';
		wait for tx_clk_period/2;
   end process;
 
   rx_clk_process :process
   begin
		rx_clk <= '0';
		wait for rx_clk_period/2;
		rx_clk <= '1';
		wait for rx_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
		
      wait for clk_period;
		wait for clk_period/2;

		port_write <= '1';		
		port_addr <= "010";
		port_in_data <= "000000000"; -- remove reset flag
		wait for clk_period;

		port_addr <= "001";
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"ff";
		wait for clk_period;
		port_in_data <= '0' & x"90";
		wait for clk_period;
		port_in_data <= '0' & x"e6";
		wait for clk_period;
		port_in_data <= '0' & x"ba";
		wait for clk_period;
		port_in_data <= '0' & x"43";
		wait for clk_period;
		port_in_data <= '0' & x"1d";
		wait for clk_period;
		port_in_data <= '0' & x"b0";
		wait for clk_period;
		port_in_data <= '0' & x"08";
		wait for clk_period;
		port_in_data <= '0' & x"06";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"01";
		wait for clk_period;
		port_in_data <= '0' & x"08";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"06";
		wait for clk_period;
		port_in_data <= '0' & x"04";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"01";
		wait for clk_period;
		port_in_data <= '0' & x"90";
		wait for clk_period;
		port_in_data <= '0' & x"e6";
		wait for clk_period;
		port_in_data <= '0' & x"ba";
		wait for clk_period;
		port_in_data <= '0' & x"43";
		wait for clk_period;
		port_in_data <= '0' & x"1d";
		wait for clk_period;
		port_in_data <= '0' & x"b0";
		wait for clk_period;
		port_in_data <= '0' & x"0a";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"01";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"0a";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"00";
		wait for clk_period;
		port_in_data <= '0' & x"02";
		wait for clk_period;
		
		port_in_data <= '0' & x"00";
		wait for clk_period*18;
		
		port_addr <= "010";
		port_in_data <= "000000110";
		wait for clk_period;

		port_write <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
