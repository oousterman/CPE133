----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 06/04/2017 01:24:31 PM
-- Design Name: 
-- Module Name: CNTR_5BIT - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: simple 5 bit counter
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

entity CNTR_5BIT is
    Port ( EN, CL, CLK : in STD_LOGIC; --uses slow clock--
           CNT : out STD_LOGIC_VECTOR (4 downto 0));
end CNTR_5BIT;

architecture Behavioral of CNTR_5BIT is
    signal inter_cnt : STD_LOGIC_VECTOR (4 downto 0);
begin
    process(CLK, CL, EN)
    begin 
        if (rising_edge(CLK) and EN = '1') then
            inter_cnt <= inter_cnt + 1;
        end if;
        if (CL = '1') then
            inter_cnt <= "00000";
        end if;
    end process;
    CNT <= inter_cnt;
end Behavioral;
