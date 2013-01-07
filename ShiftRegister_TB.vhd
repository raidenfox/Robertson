--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:49:24 12/27/2012
-- Design Name:   
-- Module Name:   C:/Users/Tony Stark/ISE/Robertson/ShiftRegister_TB.vhd
-- Project Name:  Robertson
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ShiftRegister
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
 
ENTITY ShiftRegister_TB IS
END ShiftRegister_TB;
 
ARCHITECTURE behavior OF ShiftRegister_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ShiftRegister
    PORT(
         loader : IN  std_logic_vector(3 downto 0);
         scan_in : IN  std_logic;
         en : IN  std_logic;
         write_shift : IN  std_logic;
         clock : IN  std_logic;
         scan_out : OUT  std_logic;
         loaded : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal loader : std_logic_vector(3 downto 0) := (others => '0');
   signal scan_in : std_logic := '0';
   signal en : std_logic := '0';
   signal write_shift : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal scan_out : std_logic;
   signal loaded : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftRegister PORT MAP (
          loader => loader,
          scan_in => scan_in,
          en => en,
          write_shift => write_shift,
          clock => clock,
          scan_out => scan_out,
          loaded => loaded
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
		scan_in <= '1';
		en <= '1';  
		loader <= "0000";	
      wait for 100 ns;
	
		write_shift <= '1';
		
      wait for clock_period;
				
		scan_in <= '0';
      wait for clock_period;

      
		scan_in <= '1';
      wait for clock_period;
		
		scan_in <= '1';
      wait for clock_period;
		
		
		write_shift <= '0';
		
		en <= '0';

      wait;
   end process;

END;
