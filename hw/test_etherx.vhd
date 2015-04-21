--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:13:50 04/21/2015
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
--USE ieee.numeric_std.ALL;
 
ENTITY test_etherx IS
END test_etherx;
 
ARCHITECTURE behavior OF test_etherx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT etherx
    PORT(
         RST : IN  std_logic;
         RX_CLK : IN  std_logic;
         RX_D : IN  std_logic_vector(3 downto 0);
         RX_DV : IN  std_logic;
         O_CLK : IN  std_logic;
         O_D : OUT  std_logic_vector(7 downto 0);
         O_READY : OUT  std_logic;
         O_NEXT : IN  std_logic;
         O_DONE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal RX_CLK : std_logic := '0';
   signal RX_D : std_logic_vector(3 downto 0) := (others => '0');
   signal RX_DV : std_logic := '0';
   signal O_CLK : std_logic := '0';
   signal O_NEXT : std_logic := '0';
   signal O_DONE : std_logic := '0';

 	--Outputs
   signal O_D : std_logic_vector(7 downto 0);
   signal O_READY : std_logic;

   -- Clock period definitions
   constant RX_CLK_period : time := 20 ns;
   constant O_CLK_period : time := 6 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: etherx PORT MAP (
          RST => RST,
          RX_CLK => RX_CLK,
          RX_D => RX_D,
          RX_DV => RX_DV,
          O_CLK => O_CLK,
          O_D => O_D,
          O_READY => O_READY,
          O_NEXT => O_NEXT,
          O_DONE => O_DONE
        );

   -- Clock process definitions
   RX_CLK_process :process
   begin
		RX_CLK <= '0';
		wait for RX_CLK_period/2;
		RX_CLK <= '1';
		wait for RX_CLK_period/2;
   end process;
 
   O_CLK_process :process
   begin
		O_CLK <= '0';
		wait for O_CLK_period/2;
		O_CLK <= '1';
		wait for O_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;	
		RST <= '0';
      wait for RX_CLK_period*10;

		RX_DV <= '1';
		RX_D <= "1001";
		wait for RX_CLK_period;
		RX_D <= "1010";
		wait for RX_CLK_period;
		RX_D <= "1011";
		wait for RX_CLK_period;
		RX_D <= "1100";
		wait for RX_CLK_period;
		RX_D <= "1101";
		wait for RX_CLK_period;
		RX_D <= "1110";
		wait for RX_CLK_period;
		RX_D <= "1111";
		wait for RX_CLK_period;
		RX_D <= "0000";
		wait for RX_CLK_period;
		RX_DV <= '0';

		wait for O_CLK_period*5;
		
		O_NEXT <= '1';
		wait for O_CLK_period*4;
		O_NEXT <= '0';
		O_DONE <= '1';
		wait for O_CLK_period;
		O_DONE <= '0';
		wait for O_CLK_period*6;
		
      -- insert stimulus here 

      wait;
   end process;

END;
