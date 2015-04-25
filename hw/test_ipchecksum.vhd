--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:42:35 04/25/2015
-- Design Name:   
-- Module Name:   D:/daten/source/ISE/DS/iptap/hw/test_ipchecksum.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ipchecksum
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
 
ENTITY test_ipchecksum IS
END test_ipchecksum;
 
ARCHITECTURE behavior OF test_ipchecksum IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ipchecksum
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         send_data : IN  std_logic_vector(7 downto 0);
         send_data_valid : IN  std_logic;
         cs_begin : IN  std_logic;
         cs_setaddr : IN  std_logic;
         cs_end : IN  std_logic;
         frame_data : OUT  std_logic_vector(7 downto 0);
         frame_addr : OUT  std_logic_vector(10 downto 0);
         frame_data_valid : OUT  std_logic;
         frame_next : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal send_data : std_logic_vector(7 downto 0) := (others => '0');
   signal send_data_valid : std_logic := '0';
   signal cs_begin : std_logic := '0';
   signal cs_setaddr : std_logic := '0';
   signal cs_end : std_logic := '0';
   signal frame_next : std_logic := '0';

 	--Outputs
   signal frame_data : std_logic_vector(7 downto 0);
   signal frame_addr : std_logic_vector(10 downto 0);
   signal frame_data_valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ipchecksum PORT MAP (
          clk => clk,
          rst => rst,
          send_data => send_data,
          send_data_valid => send_data_valid,
          cs_begin => cs_begin,
          cs_setaddr => cs_setaddr,
          cs_end => cs_end,
          frame_data => frame_data,
          frame_addr => frame_addr,
          frame_data_valid => frame_data_valid,
          frame_next => frame_next
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for clk_period;
		rst <= '0';
		
		
		cs_begin <= '1';
      wait for clk_period;
		cs_begin <= '0';
      wait for clk_period;

		send_data_valid <= '1';
		send_data <= x"45";
      wait for clk_period;
		send_data <= x"00";
      wait for clk_period;
		send_data <= x"00";
      wait for clk_period;
		send_data <= x"3c";
      wait for clk_period;
		send_data <= x"1c";
      wait for clk_period;
		send_data <= x"46";
      wait for clk_period;
		send_data <= x"40";
      wait for clk_period;
		send_data <= x"00";
      wait for clk_period;
		send_data <= x"40";
      wait for clk_period;
		send_data <= x"06";
      wait for clk_period;

		send_data_valid <= '0';
		cs_setaddr <= '1';
      wait for clk_period;
		cs_setaddr <= '0';
      wait for clk_period;

		send_data_valid <= '1';
		send_data <= x"00";
      wait for clk_period;
		send_data <= x"00";
      wait for clk_period;
		send_data <= x"ac";
      wait for clk_period;
		send_data <= x"10";
      wait for clk_period;
		send_data <= x"0a";
      wait for clk_period;
		send_data <= x"63";
      wait for clk_period;
		send_data <= x"ac";
      wait for clk_period;
		send_data <= x"10";
      wait for clk_period;
		send_data <= x"0a";
      wait for clk_period;
		send_data <= x"0c";
      wait for clk_period;
		send_data_valid <= '0';
      wait for clk_period*2;

		cs_end <= '1';
      wait for clk_period;
		cs_end <= '0';
      wait for clk_period*100;
		

      -- insert stimulus here 

      wait;
   end process;

END;
