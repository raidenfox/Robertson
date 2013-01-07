----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:20 11/10/2012 
-- Design Name: 
-- Module Name:    MuxedFlipD - Behavioral 
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

entity MuxedFlipD is
    Port ( scan : in STD_LOGIC;
			  ws : in STD_LOGIC;
			  D : in  STD_LOGIC;
			  en : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           Q : out  STD_LOGIC
			  );
end MuxedFlipD;

architecture Behavioral of MuxedFlipD is
	 COMPONENT mux IS
    Port ( scan : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           o1 : out  STD_LOGIC);
	 END COMPONENT mux;
	 
	 COMPONENT flipflopD IS
    Port ( clock : in  STD_LOGIC;
			  en : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
	 END COMPONENT flipflopD;
	 
	 signal comm: STD_LOGIC;
	 signal outcomm: STD_LOGIC;
begin
		
	C1: mux port map(ws,D,scan,comm);
	C2: flipflopD port map(clock,en,comm,outcomm);
   
	Q <= outcomm;

end Behavioral;

