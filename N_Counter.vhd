----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:11 12/29/2012 
-- Design Name: 
-- Module Name:    N_Counter - Behavioral 
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
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity N_Counter is
	 GENERIC(N: Integer := 8);
    Port ( count_in : in STD_LOGIC;
			  reset : in STD_LOGIC;
           clock : in  STD_LOGIC;
           sig_out : out  STD_LOGIC);
end N_Counter;

architecture Behavioral of N_Counter is
signal counter : Integer := 0;
signal uscita : std_logic := '0';
begin

sig_out <= uscita;

PROCESS(count_in,clock,reset)
BEGIN
	if reset = '1' then 
	counter <= 0;
	uscita <= '0';
	elsif rising_edge(clock) and count_in = '1' then
		counter <= counter +1;
		if counter = N-2 then
		uscita <= '1';
		counter <= 0;
		end if;
end if;

END PROCESS;

end Behavioral;

