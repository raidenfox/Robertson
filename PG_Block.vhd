----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:35 12/28/2012 
-- Design Name: 
-- Module Name:    PG_Block - Behavioral 
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

entity PG_Block is
    Port ( x_in : in  STD_LOGIC;
           y_in : in  STD_LOGIC;
           p_out : out  STD_LOGIC;
           g_out : out  STD_LOGIC);
end PG_Block;

architecture Behavioral of PG_Block is

begin

g_out <= x_in and y_in;
p_out <= x_in or y_in;

end Behavioral;

