----------------------------------------------------------------------------------
-- Company: Ratner Engineering
-- Engineer: james ratner
-- 
-- Create Date:    21:06:45 02/04/2011 
-- Design Name: 
-- Module Name:    RCA
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 8-bit Ripple Carry Adder Model
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created 10-25-2011
-- Revision 1.00 - Change 9th bit x(8) to copy 8th bit for inputs
-- Additional Comments: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RCA_8bit is
   port (   A,B : in std_logic_vector(4 downto 0); 
            Cin : in std_logic; 
	          Co : out std_logic; 
			   SUM : out std_logic_vector(4 downto 0)); 
end RCA_8bit;

architecture Behavioral of RCA_8bit is

begin
   process(A,B,Cin)
	   variable v_res : std_logic_vector(5 downto 0); 
	begin
      v_res := ('1' & A) + ('1' & B) + Cin; 
	   SUM <= v_res(4 downto 0); 
		Co <= v_res(5); 
	end process; 

end Behavioral;
