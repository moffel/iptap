-- Vhdl test bench created from schematic D:\daten\source\ISE\DS\iptap\hw\trigger.sch - Tue Apr 21 21:00:31 2015
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY trigger_trigger_sch_tb IS
END trigger_trigger_sch_tb;
ARCHITECTURE behavioral OF trigger_trigger_sch_tb IS 

   COMPONENT trigger
   PORT( IN_D	:	IN	STD_LOGIC; 
          IN_CLK	:	IN	STD_LOGIC; 
          OUT_CLK	:	IN	STD_LOGIC; 
          OUT_D	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL IN_D	:	STD_LOGIC;
   SIGNAL IN_CLK	:	STD_LOGIC;
   SIGNAL OUT_CLK	:	STD_LOGIC;
   SIGNAL OUT_D	:	STD_LOGIC;

BEGIN

   UUT: trigger PORT MAP(
		IN_D => IN_D, 
		IN_CLK => IN_CLK, 
		OUT_CLK => OUT_CLK, 
		OUT_D => OUT_D
   );

-- *** Test Bench - User Defined Section ***
	process
	begin
		IN_CLK <= '0';
		wait for 10ns;
		IN_CLK <= '1';
		wait for 10ns;
	end process;

	process
	begin
		OUT_CLK <= '0';
		wait for 19ns;
		OUT_CLK <= '1';
		wait for 19ns;
	end process;
	
   tb : PROCESS
   BEGIN
	
		IN_D <= '0';
		wait for 20ns;
		IN_D <= '1';
		wait for 20ns;
		IN_D <= '0';
	
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
