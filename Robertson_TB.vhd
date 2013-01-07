--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:08 01/06/2013
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/Desktop/Robertson/Robertson_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Robertson
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
 
ENTITY Robertson_TB IS
END Robertson_TB;
 
ARCHITECTURE behavior OF Robertson_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Robertson
    PORT(
         x_in : IN  std_logic_vector(7 downto 0);
         y_in : IN  std_logic_vector(7 downto 0);
         clock : IN  std_logic;
         reset : IN  std_logic;
         a_out : OUT  std_logic_vector(7 downto 0);
         q_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(7 downto 0) := "00001001";
   signal y_in : std_logic_vector(7 downto 0) := "00000010";
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal a_out : std_logic_vector(7 downto 0);
   signal q_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Robertson PORT MAP (
          x_in => x_in,
          y_in => y_in,
          clock => clock,
          reset => reset,
          a_out => a_out,
          q_out => q_out
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

END;
