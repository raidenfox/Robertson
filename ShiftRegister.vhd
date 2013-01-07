----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:47:52 11/11/2012 
-- Design Name: 
-- Module Name:    ShiftRegister - Behavioral 
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

entity ShiftRegister is
    GENERIC(N: Integer := 8);
    Port ( loader: STD_LOGIC_VECTOR (N-1 downto 0);
			  scan_in : in  STD_LOGIC;
			  en : in STD_LOGIC;
           write_shift : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           scan_out : out  STD_LOGIC;
			  loaded: out STD_LOGIC_VECTOR (N-1 downto 0)
			  );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
	 COMPONENT MuxedFlipD IS
	 Port ( scan : in STD_LOGIC;
			  ws : in STD_LOGIC;
			  D : in  STD_LOGIC;
			  en : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           Q : out  STD_LOGIC
			  );
	 END COMPONENT MuxedFlipD;
	 
	 signal comm: STD_LOGIC_VECTOR (N downto 0) := "000000000";
begin
	 comm(N) <= scan_in;
	 scan_out <= comm(0);
	 
	 GENC1: for i in N - 1 downto 0 GENERATE
	 begin
		CX1: MuxedFlipD port map(comm(i+1),write_shift,loader(i),en,clock,comm(i));
	 END GENERATE;
	 
	 loaded <= comm(N-1 downto 0);

end Behavioral;

