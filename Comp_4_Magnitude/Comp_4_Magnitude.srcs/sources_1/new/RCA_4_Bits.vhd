----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2017 02:51:34 PM
-- Design Name: 
-- Module Name: RCA_4_Bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RCA_4_Bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           SUM : out STD_LOGIC_VECTOR (3 downto 0);
           CO : out STD_LOGIC);
end RCA_4_Bits;

architecture Behavioral of RCA_4_Bits is

begin
   process(A,B,Cin)
	   variable v_res : std_logic_vector(4 downto 0); 
	begin
      v_res := ('1' & A) + ('1' & B) + Cin; 
	   SUM <= v_res(3 downto 0); 
		Co <= v_res(4); 
	end process; 
end Behavioral;
