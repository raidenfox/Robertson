----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:10:10 12/29/2012 
-- Design Name: 
-- Module Name:    vect_mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vect_mux is
    GENERIC (N: Integer := 8);
    Port ( m_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  scan : in STD_LOGIC;
           value_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
end vect_mux;

architecture Behavioral of vect_mux is
signal null_in : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

begin

with scan select
	  value_out <= m_in when '1', null_in when others; 


end Behavioral;

