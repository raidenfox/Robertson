--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:33:30 01/06/2013
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/Desktop/Robertson/VMX_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vect_mux
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
 
ENTITY VMX_TB IS
END VMX_TB;
 
ARCHITECTURE behavior OF VMX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vect_mux
    PORT(
         m_in : IN  std_logic_vector(7 downto 0);
         clock : IN  std_logic;
         scan : IN  std_logic;
         value_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal m_in : std_logic_vector(7 downto 0) := "00101100";
   signal clock : std_logic := '0';
   signal scan : std_logic := '0';

 	--Outputs
   signal value_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vect_mux PORT MAP (
          m_in => m_in,
          clock => clock,
          scan => scan,
          value_out => value_out
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
      wait for 100 ns;	

      wait for clock_period*10;
		scan <= '1';
      wait for clock_period*10;
		scan <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
