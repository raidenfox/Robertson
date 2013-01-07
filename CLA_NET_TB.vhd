--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:47:55 12/28/2012
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/ISE/Robertson/CLA_NET_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CLA_Network
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
 
ENTITY CLA_NET_TB IS
END CLA_NET_TB;
 
ARCHITECTURE behavior OF CLA_NET_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CLA_Network
    PORT(
         p_i : IN  std_logic_vector(7 downto 0);
         g_i : IN  std_logic_vector(7 downto 0);
         carry_out : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal p_i : std_logic_vector(7 downto 0) := "11001111";
   signal g_i : std_logic_vector(7 downto 0) := "00111101";

 	--Outputs
   signal carry_out : std_logic_vector(8 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLA_Network PORT MAP (
          p_i => p_i,
          g_i => g_i,
          carry_out => carry_out
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
