----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:39:31 12/28/2012 
-- Design Name: 
-- Module Name:    CLA_Network - Behavioral 
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

entity CLA_Network is
    GENERIC(N: Integer := 8);
    Port ( p_i : in  STD_LOGIC_VECTOR (7 downto 0);
           g_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  c0 : in STD_LOGIC;
           carry_out : out  STD_LOGIC_VECTOR (8 downto 0));
end CLA_Network;

architecture Behavioral of CLA_Network is

COMPONENT CLA_Module is
    Port ( p : in  STD_LOGIC;
           g : in  STD_LOGIC;
           c_i : in  STD_LOGIC;
           c_i1 : out  STD_LOGIC);
END COMPONENT;

signal comm_carry : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
begin

carry_out <= comm_carry;

comm_carry(0) <= c0;
CLANET: for i in 0 to N-1 generate
CLM: CLA_Module port map(p_i(i),g_i(i),comm_carry(i),comm_carry(i+1));
end generate;

end Behavioral;

