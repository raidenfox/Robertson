----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:02 12/28/2012 
-- Design Name: 
-- Module Name:    CLA_Parallel_Adder - Behavioral 
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

entity CLA_Parallel_Adder is
    GENERIC( N: Integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (7 downto 0);
           y_in : in  STD_LOGIC_VECTOR (7 downto 0);
			  c_in : in STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (8 downto 0));
end CLA_Parallel_Adder;

architecture Behavioral of CLA_Parallel_Adder is

    COMPONENT CLA_Network
    GENERIC(N: integer := 8);
    PORT(
         p_i : IN  std_logic_vector(N-1 downto 0);
         g_i : IN  std_logic_vector(N-1 downto 0);
			c0 : in STD_LOGIC;
         carry_out : OUT  std_logic_vector(N downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT PG_Network
    GENERIC(N: integer := 8);
    PORT(
         x_in : IN  std_logic_vector(N-1 downto 0);
         y_in : IN  std_logic_vector(N-1 downto 0);
         p_out : OUT  std_logic_vector(N-1 downto 0);
         g_out : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT FA_Network 
    GENERIC(N: integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           c_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           s_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
	 END COMPONENT;

signal p_append,g_append,c_real,sum_p : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
signal c_append,sum_tot : STD_LOGIC_VECTOR (N downto 0) := (others => '0');
begin

c_real <= c_append(N-1 downto 0);
sum_tot <= c_append(N) & sum_p;
sum <= sum_tot;

PG:PG_Network port map(x_in,y_in,p_append,g_append);
CLAN:CLA_Network port map(p_append,g_append,c_in,c_append);
FANET: FA_Network port map(x_in,y_in,c_real,sum_p);

end Behavioral;

