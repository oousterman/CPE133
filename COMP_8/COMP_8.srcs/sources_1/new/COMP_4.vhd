----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/10/2017 02:45:57 PM
-- Design Name: 
-- Module Name: COMP_4 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMP_4 is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           EQ,LT,GT : out STD_LOGIC);
end COMP_4;

architecture Behavioral of COMP_4 is
begin
    process(A,B)
    begin
        EQ <= '0'; LT <= '0'; GT <= '0';
        if (A = B) then 
            EQ <= '1';
        elsif (A < B) then
            LT <= '1';
        else
            GT <= '1';
        end if;
    end process;
 end Behavioral;

