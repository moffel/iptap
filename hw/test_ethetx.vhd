--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:08:05 04/25/2015
-- Design Name:   
-- Module Name:   D:/daten/source/ISE/DS/iptap/hw/test_ethetx.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ethetx
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
 
ENTITY test_ethetx IS
END test_ethetx;
 
ARCHITECTURE behavior OF test_ethetx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ethetx
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         frame_addr : IN  std_logic_vector(10 downto 0);
         frame_data : IN  std_logic_vector(7 downto 0);
         frame_write_enable : IN  std_logic;
         send_frame : IN  std_logic;
         frame_sent : OUT  std_logic;
         tx_clk : IN  std_logic;
         tx_dv : OUT  std_logic;
         tx_d : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
	COMPONENT etherx
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		rx_clk : IN std_logic;
		rx_d : IN std_logic_vector(3 downto 0);
		rx_dv : IN std_logic;
		o_addr : IN std_logic_vector(10 downto 0);
		o_done : IN std_logic;          
		o_ready : OUT std_logic;
		o_data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal frame_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal frame_data : std_logic_vector(7 downto 0) := (others => '0');
   signal frame_write_enable : std_logic := '0';
   signal send_frame : std_logic := '0';
   signal tx_clk : std_logic := '0';

 	--Outputs
   signal frame_sent : std_logic;
   signal tx_dv : std_logic;
   signal tx_d : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 6 ns;
   constant tx_clk_period : time := 20 ns;
 

	signal rx_ready, rx_done : std_logic;
	signal rx_data : std_logic_vector(7 downto 0);
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ethetx PORT MAP (
          clk => clk,
          rst => rst,
          frame_addr => frame_addr,
          frame_data => frame_data,
          frame_write_enable => frame_write_enable,
          send_frame => send_frame,
          frame_sent => frame_sent,
          tx_clk => tx_clk,
          tx_dv => tx_dv,
          tx_d => tx_d
        );

	Inst_etherx: etherx PORT MAP(
		rst => rst,
		clk => clk,
		rx_clk => tx_clk,
		rx_d => tx_d,
		rx_dv => tx_dv,
		o_ready => rx_ready,
		o_addr => (others => '0'),
		o_data => rx_data,
		o_done => rx_done
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

		-- setup memory
		frame_write_enable <= '1';
		
		frame_addr <= (others => '0');
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ff";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"90";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"e6";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ba";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"43";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"1d";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"b0";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"08";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"06";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"01";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"08";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"06";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"04";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"01";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"90";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"e6";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"ba";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"43";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"1d";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"b0";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"0a";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"01";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"0a";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"00";
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		frame_data <= x"04";
		wait for clk_period;
		
		frame_data <= x"00";
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_addr <= std_logic_vector(unsigned(frame_addr) + 1);
		wait for clk_period;
		frame_write_enable <= '0';
		
		send_frame <= '1';
		wait for clk_period;
		send_frame <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
