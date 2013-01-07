--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:17:56 01/06/2013
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/Desktop/Robertson/F_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: F_Flip
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
 
ENTITY F_TB IS
END F_TB;
 
ARCHITECTURE behavior OF F_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT F_Flip
    PORT(
         clk : IN  std_logic;
         M7 : IN  std_logic;
         Q0 : IN  std_logic;
         v_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal M7 : std_logic := '1';
   signal Q0 : std_logic := '0';

 	--Outputs
   signal v_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: F_Flip PORT MAP (
          clk => clk,
          M7 => M7,
          Q0 => Q0,
          v_out => v_out
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

      wait for clk_period;
		
		q0 <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
