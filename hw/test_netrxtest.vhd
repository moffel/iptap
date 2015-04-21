--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:43:12 04/21/2015
-- Design Name:   
-- Module Name:   D:/daten/source/ISE/DS/iptap/hw/test_netrxtest.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: netrxtest
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
 
ENTITY test_netrxtest IS
END test_netrxtest;
 
ARCHITECTURE behavior OF test_netrxtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT netrxtest
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         s_tx : OUT  std_logic;
         E_NRST : OUT  std_logic;
         E_RXD : IN  std_logic_vector(3 downto 0);
         E_RX_DV : IN  std_logic;
         E_RX_CLK : IN  std_logic;
         E_MDC : OUT  std_logic;
         E_MDIO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal E_RXD : std_logic_vector(3 downto 0) := (others => '0');
   signal E_RX_DV : std_logic := '0';
   signal E_RX_CLK : std_logic := '0';

 	--Outputs
   signal s_tx : std_logic;
   signal E_NRST : std_logic;
   signal E_MDC : std_logic;
   signal E_MDIO : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
   constant E_RX_CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: netrxtest PORT MAP (
          clk => clk,
          rst => rst,
          s_tx => s_tx,
          E_NRST => E_NRST,
          E_RXD => E_RXD,
          E_RX_DV => E_RX_DV,
          E_RX_CLK => E_RX_CLK,
          E_MDC => E_MDC,
          E_MDIO => E_MDIO
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;	
		RST <= '0';
      wait for E_RX_CLK_period*10;

		E_RX_DV <= '1';
		E_RXD <= "1001";
		wait for E_RX_CLK_period;
		E_RXD <= "1010";
		wait for E_RX_CLK_period;
		E_RXD <= "1011";
		wait for E_RX_CLK_period;
		E_RXD <= "1100";
		wait for E_RX_CLK_period;
		E_RXD <= "1101";
		wait for E_RX_CLK_period;
		E_RXD <= "1110";
		wait for E_RX_CLK_period;
		E_RXD <= "1111";
		wait for E_RX_CLK_period;
		E_RXD <= "0000";
		wait for E_RX_CLK_period;
		E_RX_DV <= '0';

		wait for clk_period*5;

      -- insert stimulus here 

      wait;
   end process;

END;
