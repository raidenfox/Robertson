----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:35 01/06/2013 
-- Design Name: 
-- Module Name:    Robertson - Behavioral 
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

entity Robertson is
	 GENERIC(N: Integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  clock: in STD_LOGIC;
			  reset: in STD_LOGIC;
           a_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
           q_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
end Robertson;

architecture Behavioral of Robertson is

    COMPONENT ControlUnit_Robertson
    PORT(
         q0 : IN  std_logic;
         rstx : IN  std_logic;
         clock : IN  std_logic;
         count : IN  std_logic;
         count_in : OUT  std_logic;
         en_vect : OUT  std_logic_vector(2 downto 0);
         en_shft : OUT  std_logic;
         reset : OUT  std_logic;
         subtract : OUT  std_logic;
         mux : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT AQ_Block
	 GENERIC(N: Integer := 8);
    PORT(
         F_in : IN  std_logic;
         clock : IN  std_logic;
         en_load1 : IN  std_logic;
         en_load2 : IN  std_logic;
         en_shift : IN  std_logic;
         A_in : IN  std_logic_vector(N-1 downto 0);
         Q_in : IN  std_logic_vector(N-1 downto 0);
         A_out : OUT  std_logic_vector(N-1 downto 0);
         Q_out : OUT  std_logic_vector(N-1 downto 0);
         Q0_out : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT F_Flip
    PORT(
         clk : IN  std_logic;
         M7 : IN  std_logic;
         Q0 : IN  std_logic;
         v_out : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT ShiftRegister
	 GENERIC(N: Integer := 8);
    PORT(
         loader : IN  std_logic_vector(N-1 downto 0);
         scan_in : IN  std_logic;
         en : IN  std_logic;
         write_shift : IN  std_logic;
         clock : IN  std_logic;
         scan_out : OUT  std_logic;
         loaded : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;

	 COMPONENT N_Counter is
    Port ( en : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           clock : in  STD_LOGIC;
           sig_out : out  STD_LOGIC);
    END COMPONENT;

    COMPONENT vect_mux
	 GENERIC(N: Integer := 8);
    PORT(
         m_in : IN  std_logic_vector(N-1 downto 0);
         clock : IN  std_logic;
         scan : IN  std_logic;
         value_out : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT CLA_Parallel_Adder
	 GENERIC(N: Integer := 8);
    PORT(
         x_in : IN  std_logic_vector(N-1 downto 0);
         y_in : IN  std_logic_vector(N-1 downto 0);
			c_in : in STD_LOGIC;
         sum : OUT  std_logic_vector(N downto 0)
        );
    END COMPONENT;

-- SIGNAL DEFINITIONS
signal scan_cu,q0_out,start_flag,stop_flag,enshift : STD_LOGIC := '0';
signal reset_count,subline,f_out,scan_out_A : STD_LOGIC := '0';
signal A_out_vect,Q_out_vect,M_out_vect : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
signal mux_out,CLA_out,CLA_out2,xor_result,xor_add : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
signal CLA_sum : STD_LOGIC_VECTOR (N downto 0) := (others => '0');
signal enload : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal null_vect : STD_LOGIC_VECTOR(N-2 downto 0) := (others => '0');
begin

CLA_out <= CLA_sum(N-1 downto 0);

xor_add <= null_vect & subline; 

xor_result <= xor_add xor mux_out;
A_out <= A_out_vect;
Q_out <= Q_out_vect;
q0_out <= Q_out_vect(0);

M:ShiftRegister PORT MAP (
	loader => y_in,
	scan_in => '0',
   en => enload(2),
   write_shift => '0',
   clock => clock,
   scan_out => open,
   loaded => M_out_vect);
	
VMX:vect_mux PORT MAP(
	m_in => M_out_vect,
	clock => clock,
	scan => scan_cu,
	value_out => mux_out);
	
CU:ControlUnit_Robertson PORT MAP(
	q0 => q0_out,
   rstx => reset,
   clock => clock,
   count => stop_flag,
   count_in => start_flag,
   en_vect => enload,
   en_shft => enshift,
   reset => reset_count,
   subtract => subline,
   mux => scan_cu
	);

CNT: N_Counter PORT MAP ( 
	en => start_flag,
	reset => reset_count,
   clock => clock,
   sig_out => stop_flag
	);	

F:F_Flip PORT MAP (
   clk => clock,
	M7 => y_in(N-1),
	Q0 => q0_out,
	v_out => f_out
	);
	
	A:ShiftRegister PORT MAP (
	loader => CLA_out,
	scan_in => f_out,
   en => enload(0),
   write_shift => enshift,
   clock => clock,
   scan_out => scan_out_A,
   loaded => A_out_vect);
	
	Q:ShiftRegister PORT MAP (
	loader => x_in,
	scan_in => scan_out_A,
   en => enload(1),
   write_shift => enshift,
   clock => clock,
   scan_out => open,
   loaded => Q_out_vect);
		  
CLA: CLA_Parallel_Adder PORT MAP(
         x_in => A_out_vect,
         y_in => xor_result,
			c_in => subline,
         sum => CLA_sum
        );
end Behavioral;

