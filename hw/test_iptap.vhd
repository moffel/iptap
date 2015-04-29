--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:21:09 04/28/2015
-- Design Name:   
-- Module Name:   D:/daten/source/ISE/DS/iptap/hw/test_iptap.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: iptap
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_iptap IS
END test_iptap;
 
ARCHITECTURE behavior OF test_iptap IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT iptap
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         E_NRST : OUT  std_logic;
         E_RXD : IN  std_logic_vector(3 downto 0);
         E_RX_DV : IN  std_logic;
         E_RX_CLK : IN  std_logic;
         E_TXD : OUT  std_logic_vector(3 downto 0);
         E_TX_EN : OUT  std_logic;
         E_TX_CLK : IN  std_logic;
         led : OUT  std_logic_vector(7 downto 0);
         s_tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal E_RXD, rx_d : std_logic_vector(3 downto 0) := (others => '0');
   signal E_RX_DV : std_logic := '0';
   signal E_RX_CLK : std_logic := '0';
   signal E_TX_CLK : std_logic := '0';

 	--Outputs
   signal E_NRST : std_logic;
   signal E_TXD : std_logic_vector(3 downto 0);
   signal E_TX_EN : std_logic;
   signal led : std_logic_vector(7 downto 0);
   signal s_tx : std_logic;

   -- Clock period definitions
   constant clk_period : time := 4 ns;
   constant E_RX_CLK_period : time := 10 ns;
   constant E_TX_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: iptap PORT MAP (
          clk => clk,
          rst => rst,
          E_NRST => E_NRST,
          E_RXD => E_RXD,
          E_RX_DV => E_RX_DV,
          E_RX_CLK => E_RX_CLK,
          E_TXD => E_TXD,
          E_TX_EN => E_TX_EN,
          E_TX_CLK => E_TX_CLK,
          led => led,
          s_tx => s_tx
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   E_RX_CLK_process :process
   begin
		E_RX_CLK <= '0';
		wait for E_RX_CLK_period/2;
		E_RX_CLK <= '1';
		wait for E_RX_CLK_period/2;
   end process;
 
   E_TX_CLK_process :process
   begin
		E_TX_CLK <= '0';
		wait for E_TX_CLK_period/2;
		E_TX_CLK <= '1';
		wait for E_TX_CLK_period/2;
   end process;
 
	E_RXD <= rx_d;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
		
      wait for E_RX_CLK_period*25;

		E_RX_DV <= '1';
		rx_d <= "0101";
      wait for E_RX_CLK_period*15;
		rx_d <= "1101";
		wait for E_RX_CLK_period;
		
		-- the following is an captured arp package
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"9";
		wait for E_RX_CLK_period;
		rx_d <= x"6";
		wait for E_RX_CLK_period;
		rx_d <= x"e";
		wait for E_RX_CLK_period;
		rx_d <= x"a";
		wait for E_RX_CLK_period;
		rx_d <= x"b";
		wait for E_RX_CLK_period;
		rx_d <= x"3";
		wait for E_RX_CLK_period;
		rx_d <= x"4";
		wait for E_RX_CLK_period;
		rx_d <= x"d";
		wait for E_RX_CLK_period;
		rx_d <= x"1";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"b";
		wait for E_RX_CLK_period;
		rx_d <= x"8";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"6";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"1";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"8";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"6";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"4";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"1";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"9";
		wait for E_RX_CLK_period;
		rx_d <= x"6";
		wait for E_RX_CLK_period;
		rx_d <= x"e";
		wait for E_RX_CLK_period;
		rx_d <= x"a";
		wait for E_RX_CLK_period;
		rx_d <= x"b";
		wait for E_RX_CLK_period;
		rx_d <= x"3";
		wait for E_RX_CLK_period;
		rx_d <= x"4";
		wait for E_RX_CLK_period;
		rx_d <= x"d";
		wait for E_RX_CLK_period;
		rx_d <= x"1";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"b";
		wait for E_RX_CLK_period;
		rx_d <= x"a";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"1";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"a";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"2";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		-- arp has only 42 byte so we have to append 64-42-4 padding bytes
		wait for E_RX_CLK_period * 36;
		-- and 4b crc 0x000b74ff
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"b";
		wait for E_RX_CLK_period;
		rx_d <= x"0";
		wait for E_RX_CLK_period;
		rx_d <= x"4";
		wait for E_RX_CLK_period;
		rx_d <= x"7";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		rx_d <= x"f";
		wait for E_RX_CLK_period;
		

		E_RX_DV <= '0';
		rx_d <= (others => '0');
		
		

      -- insert stimulus here 

      wait;
   end process;

END;