----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:36:26 12/28/2012 
-- Design Name: 
-- Module Name:    CLA_Module - Behavioral 
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

entity CLA_Module is
    Port ( p : in  STD_LOGIC;
           g : in  STD_LOGIC;
           c_i : in  STD_LOGIC;
           c_i1 : out  STD_LOGIC);
end CLA_Module;

architecture Behavioral of CLA_Module is

begin

c_i1 <= g or (c_i and p);

end Behavioral;

