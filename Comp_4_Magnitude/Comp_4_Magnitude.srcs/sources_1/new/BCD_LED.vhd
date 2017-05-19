----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2017 03:08:02 PM
-- Design Name: 
-- Module Name: BCD_LED - Behavioral
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

entity BCD_LED is
    Port ( SIGN : in STD_LOGIC;
           BCD : in STD_LOGIC_VECTOR (2 downto 0);
           AIN : in STD_LOGIC_VECTOR (3 downto 0);
           ANODES : out STD_LOGIC_VECTOR (3 downto 0);
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC);
end BCD_LED;

architecture Behavioral of BCD_LED is

begin
    process(SIGN,BCD)
    ANODES <= AIN;
    begin
        case BCD is
            when "000" => SEG7 <= "1000000";
            when "001" => SEG7 <= "1111001";
            when "010" => SEG7 <= "0100100";
            when "011" => SEG7 <= "0110000";
            when "100" => SEG7 <= "0011001";
            when "101" => SEG7 <= "0010010";
            when "110" => SEG7 <= "0000011";
            when "111" => SEG7 <= "1111000";
            when others => SEG7 <= "1111111";
        end case;
        if SIGN = '0' then
            DP <= '0';
        else 
            DP <= '1';
        end if;
    end process;

end Behavioral;
