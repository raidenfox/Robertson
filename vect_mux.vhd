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
    Port ( m_in : in  STD_LOGIC_VECTOR (7 downto 0);
			  clock : STD_LOGIC;
			  scan : in STD_LOGIC;
           value_out : out  STD_LOGIC_VECTOR (7 downto 0));
end vect_mux;

architecture Behavioral of vect_mux is
signal null_in : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

begin

PROCESS(clock,scan)
begin
if rising_edge(clock) then
CASE scan IS
	 WHEN '1' =>
		value_out <= m_in;
	 WHEN '0' =>
		value_out <= null_in ;
	 WHEN others =>
		value_out <= null_in ;
END CASE;
end if;
end process;
end Behavioral;

