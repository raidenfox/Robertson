----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:09 01/09/2013 
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
    GENERIC( N: Integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           a_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
           q_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
			  total_out : out STD_LOGIC_VECTOR (2*N -1 downto 0));
end Robertson;

architecture Behavioral of Robertson is

    COMPONENT XOR_N1Bit_Block
    GENERIC( N: Integer := 8);
    PORT(
         x_in : IN  std_logic_vector(N-1 downto 0);
         y_in : IN  std_logic;
         xor_out : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT vect_mux
    GENERIC( N: Integer := 8);
    PORT(
         m_in : IN  std_logic_vector(N-1 downto 0);
         scan : IN  std_logic;
         value_out : OUT  std_logic_vector(N-1downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT ShiftRegister
    GENERIC( N: Integer := 8);
    PORT(
         d : IN  std_logic;
         data : IN  std_logic_vector(N-1 downto 0);
         enable : IN  std_logic;
         load_me : IN  std_logic;
         shift_me : IN  std_logic;
         clock : IN  std_logic;
         reset : IN  std_logic;
         data_out : OUT  std_logic_vector(N-1 downto 0);
         q : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT N_Counter
    PORT(
         count_in : IN  std_logic;
         reset : IN  std_logic;
         clock : IN  std_logic;
         sig_out : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT F_Flip
    PORT(
         clk : IN  std_logic;
         M7 : IN  std_logic;
         Q0 : IN  std_logic;
         reset : IN  std_logic;
         v_out : OUT  std_logic
        );
    END COMPONENT;
	 
    COMPONENT CLA_Parallel_Adder
    GENERIC( N: Integer := 8);
    PORT(
         x_in : IN  std_logic_vector(N-1 downto 0);
         y_in : IN  std_logic_vector(N-1 downto 0);
         c_in : IN  std_logic;
         sum : OUT  std_logic_vector(N-1 downto 0);
         c_out : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT AQ_Block
    GENERIC( N: Integer := 8);
    PORT(
         f_in : IN  std_logic;
         a_in : IN  std_logic_vector(N-1 downto 0);
         q_in : IN  std_logic_vector(N-1 downto 0);
         clock : IN  std_logic;
         load1 : IN  std_logic;
         load2 : IN  std_logic;
         enA : IN  std_logic;
         enQ : IN  std_logic;
         shft1 : IN  std_logic;
         shft2 : IN  std_logic;
         rst : IN  std_logic;
         a_out : OUT  std_logic_vector(N-1 downto 0);
         q_out : OUT  std_logic_vector(N-1 downto 0);
			q0 : OUT std_logic
        );
    END COMPONENT;

    COMPONENT ControlUnit_Robertson
    PORT(
         q0 : IN  std_logic;
         in_reset : IN  std_logic;
         clock : IN  std_logic;
         count : IN  std_logic;
         count_in : OUT  std_logic;
         en_vect : OUT  std_logic_vector(2 downto 0);
         en_shft1 : OUT  std_logic;
         en_shft2 : OUT  std_logic;
         load : OUT  std_logic;
         reset : OUT  std_logic;
         subtract : OUT  std_logic;
         mux : OUT  std_logic
        );
    END COMPONENT;

-- Signal Zone
signal load_line,sub_line,scan_line,f_line,f_real,q0_line,sft_line,sft_line2,endcount_line,startcount_line,reset_line : STD_LOGIC := '0';
signal mux_out,a_reg,q_reg,m_reg,cla_out,xor_result : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
signal en_lines : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
begin

-- Assignments
a_out <= a_reg;
q_out <= q_reg;
f_real <= f_line;
total_out <= a_reg & q_reg;
-- Port Maps

   CU: ControlUnit_Robertson PORT MAP (
          q0 => q0_line,
          in_reset => reset,
          clock => clock,
          count => endcount_line,
          count_in => startcount_line,
          en_vect => en_lines,
          en_shft1 => sft_line,
          en_shft2 => sft_line2,
          load => load_line,
          reset => reset_line,
          subtract => sub_line,
          mux => scan_line
        );


   VMX: vect_mux PORT MAP (
          m_in => m_reg,
          scan => scan_line,
          value_out => mux_out
        );

   M: ShiftRegister PORT MAP (
          d => '0',
          data => y_in,
          enable => en_lines(2),
          load_me => '0',
          shift_me => '0',
          clock => clock,
          reset => reset_line,
          data_out => m_reg,
          q => open
        );
		  
   CNT: N_Counter PORT MAP (
          count_in => startcount_line,
          reset => reset_line,
          clock => clock,
          sig_out => endcount_line
        );

   F: F_Flip PORT MAP (
          clk => clock,
          M7 => y_in(N-1),
          Q0 => q0_line,
          reset => reset_line,
          v_out => f_line
        );
		  
   CLASUM: CLA_Parallel_Adder PORT MAP (
          x_in => a_reg,
          y_in => mux_out,
          c_in => sub_line,
          sum => cla_out,
          c_out => open
        );
		  
   AQ: AQ_Block PORT MAP (
          f_in => f_real,
          a_in => cla_out,
          q_in => x_in,
          clock => clock,
          load1 => load_line,
          load2 => '0',
          enA => en_lines(0),
          enQ => en_lines(1),
          shft1 => sft_line,
          shft2 => sft_line2,
          rst => reset_line,
          a_out => a_reg,
          q_out => q_reg,
			 q0 => q0_line
        );		  

end Behavioral;

