--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:02:04 12/29/2012
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/ISE/Robertson/CLA_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CLA_Parallel_Adder
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
 
ENTITY CLA_TB IS
END CLA_TB;
 
ARCHITECTURE behavior OF CLA_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CLA_Parallel_Adder
    PORT(
         x_in : IN  std_logic_vector(7 downto 0);
         y_in : IN  std_logic_vector(7 downto 0);
			c_in : in STD_LOGIC;
         sum : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(7 downto 0) := "11111100";
   signal y_in : std_logic_vector(7 downto 0) := "00000001";
	signal c_in : std_logic := '1';

 	--Outputs
   signal sum : std_logic_vector(8 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLA_Parallel_Adder PORT MAP (
          x_in => x_in,
          y_in => y_in,
          c_in => c_in,
          sum => sum
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
