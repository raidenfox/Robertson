----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:01:48 12/31/2012 
-- Design Name: 
-- Module Name:    ControlUnit_Robertson - Behavioral 
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

entity ControlUnit_Robertson is
    GENERIC(N: Integer := 8);
    Port ( q0 : in  STD_LOGIC;
			  rstx : in  STD_LOGIC;
			  clock : in  STD_LOGIC;
           count : in  STD_LOGIC;
           count_in : out  STD_LOGIC;
           en_vect : out  STD_LOGIC_VECTOR (2 downto 0);
           en_shft : out  STD_LOGIC;
           reset : out  STD_LOGIC;
           subtract : out  STD_LOGIC;
           mux : out  STD_LOGIC);
end ControlUnit_Robertson;

architecture Behavioral of ControlUnit_Robertson is

type state is (RST,SETUP,LOAD0,LOADM,RSHIFT,VERIFY,SUBTK,RSHIFT2,OUTPUT);
signal stato_corrente, stato_prossimo: state;
signal subt : STD_LOGIC := '0';
begin

subtract <= subt;

STATE_ENHANCE:PROCESS(clock)
BEGIN
	if rising_edge(clock) then
		stato_corrente <= stato_prossimo;
	end if;
END PROCESS;

STATE_SELECT:PROCESS(clock,q0,rstx,count, stato_corrente)
BEGIN
	CASE stato_corrente IS
		WHEN RST =>
			en_vect(0) <= '1';
			en_vect(1) <= '1';
			en_vect(2) <= '1';
			en_shft <= '0';
			reset <= '0';
			subt <= not(subt);
			count_in <= '0';
			mux <= '0';
			stato_prossimo <= SETUP;
		WHEN SETUP =>
			if q0 = '0' then
			stato_prossimo <= LOAD0;
			else
			stato_prossimo <= LOADM;
			end if;
		WHEN LOAD0 =>
			mux <= '0';
			stato_prossimo <= RSHIFT;
		WHEN LOADM =>
			mux <= '1';
			stato_prossimo <= RSHIFT;
		WHEN RSHIFT =>
			en_vect(0) <= '0';
			en_vect(1) <= '0';
			en_vect(2) <= '0';
			count_in <= '1';
			en_shft <= '1';
			if count = '1' then
			en_shft <= '0';
			stato_prossimo <= VERIFY;
			else
			stato_prossimo <= RSHIFT;
			end if;
		WHEN VERIFY =>
			if q0 = '1' then
			stato_prossimo <= SUBTK;
			else
			stato_prossimo <= RSHIFT2;
			end if;
		WHEN SUBTK =>
		   subt <= not(subt);
			stato_prossimo <= RSHIFT2;
		WHEN RSHIFT2 =>
			en_shft <= '1';
			stato_prossimo <= OUTPUT;
		WHEN OUTPUT =>
		   if rstx = '1' then
			stato_prossimo <= RST;
			else
			stato_prossimo <= OUTPUT;
			end if; 			
END CASE;
END PROCESS;
end Behavioral;

