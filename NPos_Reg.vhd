----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:13:32 11/10/2012 
-- Design Name: 
-- Module Name:    NPos_Reg - Behavioral 
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

entity NPos_Reg is
	 GENERIC(N:Integer := 4);
    Port ( data_in : in  STD_LOGIC_VECTOR (N - 1 downto 0);
           clock : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (N - 1 downto 0));
end NPos_Reg;

architecture Structural of NPos_Reg is
	COMPONENT flipflopD IS
		Port ( clock : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
	END COMPONENT;
	
	signal comm : STD_LOGIC_VECTOR (N - 1 downto 0);
begin
   
	GEN1: FOR i IN N-1 downto 0 GENERATE
	begin
	FFD: flipflopD port map(clock,data_in(i),comm(i));
	END GENERATE;
   
	data_out <= comm;
	
end Structural;

