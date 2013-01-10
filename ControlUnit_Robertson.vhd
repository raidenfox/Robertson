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
			  in_reset : in  STD_LOGIC;
			  clock : in  STD_LOGIC;
           count : in  STD_LOGIC;
           count_in : out  STD_LOGIC;
           en_vect : out  STD_LOGIC_VECTOR (2 downto 0);
           en_shft1 : out  STD_LOGIC;
           en_shft2 : out  STD_LOGIC;
			  load : out STD_LOGIC;
           reset : out  STD_LOGIC;
           subtract : out  STD_LOGIC;
           mux : out  STD_LOGIC);
end ControlUnit_Robertson;

architecture Behavioral of ControlUnit_Robertson is

type state is (RST,INIT,SC,LOAD0,LOADM,ADD,RSHIFT,VERIFY,SUBTK,OUTPUT);
signal stato_corrente, stato_prossimo: state;
signal fine,correggi : STD_LOGIC := '0';
begin


STATE_ENHANCE:PROCESS(clock)
BEGIN
	if rising_edge(clock) then
		stato_corrente <= stato_prossimo;
	end if;
END PROCESS;

STATE_SELECT:PROCESS(clock,q0,in_reset,count, stato_corrente)
BEGIN
	CASE stato_corrente IS
		WHEN RST =>
         en_vect(0) <= '1'; -- A
         en_vect(1) <= '1'; -- Q 
         en_vect(2) <= '1'; -- M		
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
			subtract <= '0';
			correggi <= '0';
		  	stato_prossimo <= INIT;
			load <= '0';
		WHEN INIT =>
		   reset <= '0';
		   count_in <= '0';
		   stato_prossimo <= SC;
		WHEN SC =>
		   count_in <= '0';
         en_vect(0) <= '0';	
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
         en_vect(1) <= '0';
         en_vect(2) <= '0';
		   if q0 = '0' then
			   mux <= '0'; 
				stato_prossimo <= LOAD0;
				elsif count = '1' then
				   fine <= '1';
					stato_prossimo <= VERIFY;
			else
			   mux <= '1';
				stato_prossimo <= LOADM;
			end if;			
		WHEN LOAD0 =>
         en_vect(0) <= '1';	
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
			stato_prossimo <= ADD;			
		WHEN LOADM =>
			stato_prossimo <= OUTPUT;
         en_vect(0) <= '1';	
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
			stato_prossimo <= ADD;
		WHEN ADD =>	
         en_vect(0) <= '0';
		   stato_prossimo <= RSHIFT;
		WHEN RSHIFT =>
         en_vect(0) <= '0';
		   count_in <= '1';	
		   en_shft1 <= '1';	
		   en_shft2 <= '1';
				if count = '0' then 
				stato_prossimo <= SC;
				elsif fine = '1' then	
				en_shft1 <= '0';	
				en_shft2 <= '1';
				load <= '1';
				stato_prossimo <= OUTPUT;
				else				
				count_in <= '0';
				stato_prossimo <= OUTPUT;
			end if;
		WHEN VERIFY =>
			en_vect(0) <= '0';
         en_vect(1) <= '0';
		   count_in <= '0';	
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
			if q0 = '1' then
			stato_prossimo <= SUBTK;
			elsif fine = '1' then			
         en_vect(0) <= '0';
         en_vect(1) <= '0';
			stato_prossimo <= SC;
			else
			stato_prossimo <= RSHIFT;
			end if;
		WHEN SUBTK =>		
         en_vect(0) <= '1';		
		   subtract <= '1';
			stato_prossimo <= RSHIFT;
		WHEN OUTPUT =>
			load <= '0';	
		   en_shft1 <= '0';	
		   en_shft2 <= '0';
		   if in_reset = '1' then
			stato_prossimo <= RST;
			else
			stato_prossimo <= OUTPUT;
			end if; 			
END CASE;
END PROCESS;
end Behavioral;

