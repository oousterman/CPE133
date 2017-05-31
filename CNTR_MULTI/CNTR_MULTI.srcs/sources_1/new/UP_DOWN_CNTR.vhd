----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/21/2017 05:44:54 PM
-- Design Name: 
-- Module Name: UP_DOWN_CNTR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Module implemented in the display file, used to actually increment the count
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

entity UP_DOWN_CNTR is
    Port ( BTN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           COUNT : out STD_LOGIC_VECTOR (3 downto 0));
end UP_DOWN_CNTR;

architecture Behavioral of UP_DOWN_CNTR is
    
    signal inter_count : STD_LOGIC_VECTOR (3 downto 0);
    
begin
    process (CLK, BTN)
    begin 
        if (rising_edge(CLK)) then
            if BTN = '1' then
                inter_count <= inter_count + 1;
            else 
                inter_count <= inter_count - 1;
            end if;
        end if;
    end process;
    COUNT <= inter_count;
end Behavioral;
