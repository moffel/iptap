--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:59:25 04/22/2015
-- Design Name:   
-- Module Name:   D:/daten/source/ISE/DS/iptap/hw/test_etherx.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: etherx
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
USE ieee.numeric_std.ALL;
 
ENTITY test_etherx IS
END test_etherx;
 
ARCHITECTURE behavior OF test_etherx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT etherx
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         rx_clk : IN  std_logic;
         rx_d : IN  std_logic_vector(3 downto 0);
         rx_dv : IN  std_logic;
         o_ready : OUT  std_logic;
         o_addr : IN  std_logic_vector(9 downto 0);
         o_data : OUT  std_logic_vector(7 downto 0);
         o_done : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal rx_clk : std_logic := '0';
   signal rx_d : std_logic_vector(3 downto 0) := (others => '0');
   signal rx_dv : std_logic := '0';
   signal o_addr : std_logic_vector(9 downto 0) := (others => '0');
   signal o_done : std_logic := '0';

 	--Outputs
   signal o_ready : std_logic;
   signal o_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 6 ns;
   constant rx_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: etherx PORT MAP (
          rst => rst,
          clk => clk,
          rx_clk => rx_clk,
          rx_d => rx_d,
          rx_dv => rx_dv,
          o_ready => o_ready,
          o_addr => o_addr,
          o_data => o_data,
          o_done => o_done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
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
      wait for clk_period*10;

		rx_dv <= '1';
		rx_d <= "0101";
      wait for rx_clk_period*15;
		rx_d <= "1101";
		wait for rx_clk_period;
		
		-- the following is an captured arp package
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"9";
		wait for rx_clk_period;
		rx_d <= x"6";
		wait for rx_clk_period;
		rx_d <= x"e";
		wait for rx_clk_period;
		rx_d <= x"a";
		wait for rx_clk_period;
		rx_d <= x"b";
		wait for rx_clk_period;
		rx_d <= x"3";
		wait for rx_clk_period;
		rx_d <= x"4";
		wait for rx_clk_period;
		rx_d <= x"d";
		wait for rx_clk_period;
		rx_d <= x"1";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"b";
		wait for rx_clk_period;
		rx_d <= x"8";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"6";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"1";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"8";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"6";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"4";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"1";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"9";
		wait for rx_clk_period;
		rx_d <= x"6";
		wait for rx_clk_period;
		rx_d <= x"e";
		wait for rx_clk_period;
		rx_d <= x"a";
		wait for rx_clk_period;
		rx_d <= x"b";
		wait for rx_clk_period;
		rx_d <= x"3";
		wait for rx_clk_period;
		rx_d <= x"4";
		wait for rx_clk_period;
		rx_d <= x"d";
		wait for rx_clk_period;
		rx_d <= x"1";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"b";
		wait for rx_clk_period;
		rx_d <= x"a";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"1";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"a";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"2";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		-- arp has only 42 byte so we have to append 64-42-4 padding bytes
		wait for rx_clk_period * 36;
		-- and 4b crc 0x000b74ff
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"b";
		wait for rx_clk_period;
		rx_d <= x"0";
		wait for rx_clk_period;
		rx_d <= x"4";
		wait for rx_clk_period;
		rx_d <= x"7";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		rx_d <= x"f";
		wait for rx_clk_period;
		

		rx_dv <= '0';
		rx_d <= (others => '0');
		
		-- wait for trigger propagate
		wait for clk_period*8;
		
		o_addr <= "0000000000";
		wait for clk_period;
		o_addr <= "0000000001";
		wait for clk_period;
		o_addr <= "0000000011";
		wait for clk_period;
		o_addr <= "0000000100";
		wait for clk_period;
		
		o_done <= '1';
		wait for clk_period;
		o_done <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
