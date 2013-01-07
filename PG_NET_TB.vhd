--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:33:05 12/28/2012
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/ISE/Robertson/PG_NET_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PG_Network
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
 
ENTITY PG_NET_TB IS
END PG_NET_TB;
 
ARCHITECTURE behavior OF PG_NET_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PG_Network
    PORT(
         x_in : IN  std_logic_vector(7 downto 0);
         y_in : IN  std_logic_vector(7 downto 0);
         p_out : OUT  std_logic_vector(7 downto 0);
         g_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(7 downto 0) := "10100110";
   signal y_in : std_logic_vector(7 downto 0) := "11000100";

 	--Outputs
   signal p_out : std_logic_vector(7 downto 0);
   signal g_out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PG_Network PORT MAP (
          x_in => x_in,
          y_in => y_in,
          p_out => p_out,
          g_out => g_out
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
