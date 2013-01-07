--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:16:56 12/31/2012
-- Design Name:   
-- Module Name:   /home/raidenfox/Robertson/CU_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlUnit_Robertson
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
 
ENTITY CU_TB IS
END CU_TB;
 
ARCHITECTURE behavior OF CU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit_Robertson
    PORT(
         q0 : IN  std_logic;
         rstx : IN  std_logic;
         clock : IN  std_logic;
         count : IN  std_logic;
         count_in : OUT  std_logic;
         en_vect : OUT  std_logic_vector(2 downto 0);
         en_shft : OUT  std_logic;
         reset : OUT  std_logic;
         subtract : OUT  std_logic;
         mux : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal q0 : std_logic := '0';
   signal rstx : std_logic := '0';
   signal clock : std_logic := '0';
   signal count : std_logic := '0';

 	--Outputs
   signal count_in : std_logic;
   signal en_vect : std_logic_vector(2 downto 0);
   signal en_shft : std_logic;
   signal reset : std_logic;
   signal subtract : std_logic;
   signal mux : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit_Robertson PORT MAP (
          q0 => q0,
          rstx => rstx,
          clock => clock,
          count => count,
          count_in => count_in,
          en_vect => en_vect,
          en_shft => en_shft,
          reset => reset,
          subtract => subtract,
          mux => mux
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		q0 <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
