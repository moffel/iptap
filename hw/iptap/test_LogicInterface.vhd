--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:45:51 05/04/2015
-- Design Name:   
-- Module Name:   E:/mio/iptap/hw/iptap/test_LogicInterface.vhd
-- Project Name:  iptap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LogicInterface
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
 
ENTITY test_LogicInterface IS
END test_LogicInterface;
 
ARCHITECTURE behavior OF test_LogicInterface IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LogicInterface
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         m_addr : IN  std_logic_vector(7 downto 0);
         m_data_in : IN  std_logic_vector(7 downto 0);
         m_data_out : OUT  std_logic_vector(7 downto 0);
         m_we : IN  std_logic;
         m_re : IN  std_logic;
         n_data_in : IN  std_logic_vector(7 downto 0);
         n_data_out : OUT  std_logic_vector(7 downto 0);
         n_next_in : OUT  std_logic;
         n_next_out : OUT  std_logic;
         l_addr : OUT  std_logic_vector(31 downto 0);
         l_data_in : IN  std_logic_vector(7 downto 0);
         l_data_out : OUT  std_logic_vector(7 downto 0);
         l_we : OUT  std_logic;
         l_re : OUT  std_logic;
         l_ack : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal m_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal m_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal m_we : std_logic := '0';
   signal m_re : std_logic := '0';
   signal n_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal l_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal l_ack : std_logic := '0';

 	--Outputs
   signal m_data_out : std_logic_vector(7 downto 0);
   signal n_data_out : std_logic_vector(7 downto 0);
   signal n_next_in : std_logic;
   signal n_next_out : std_logic;
   signal l_addr : std_logic_vector(31 downto 0);
   signal l_data_out : std_logic_vector(7 downto 0);
   signal l_we : std_logic;
   signal l_re : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LogicInterface PORT MAP (
          clk => clk,
          rst => rst,
          m_addr => m_addr,
          m_data_in => m_data_in,
          m_data_out => m_data_out,
          m_we => m_we,
          m_re => m_re,
          n_data_in => n_data_in,
          n_data_out => n_data_out,
          n_next_in => n_next_in,
          n_next_out => n_next_out,
          l_addr => l_addr,
          l_data_in => l_data_in,
          l_data_out => l_data_out,
          l_we => l_we,
          l_re => l_re,
          l_ack => l_ack
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

	l_ack <= l_we or l_re;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

      wait for clk_period;
		
		m_addr <= "00110000";
		m_data_in <= x"0A";
		m_we <= '1';
		wait for clk_period*4;
		
		m_addr <= "01010000";
		wait for clk_period*3;
		m_data_in <= x"10";
		wait for clk_period;
		
		m_addr <= "01110000";
		m_data_in <= x"01";
		wait for clk_period;
		m_we <= '0';

		--wait for clk_period*16;

      -- insert stimulus here 

      wait;
   end process;

END;
