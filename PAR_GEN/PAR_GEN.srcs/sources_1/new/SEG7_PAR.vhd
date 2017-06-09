----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 06/05/2017 02:52:51 PM
-- Design Name: 
-- Module Name: SEG7_PAR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Displays the number of set bits and parity
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

entity SEG7_PAR is
    Port ( SEG_IN : in STD_LOGIC_VECTOR (4 downto 0);
           F_CLK : in STD_LOGIC;
           SEGMENTS : out STD_LOGIC_VECTOR (6 downto 0);
           ANODES : out STD_LOGIC_VECTOR (3 downto 0));
end SEG7_PAR;

architecture Behavioral of SEG7_PAR is
    signal cnt : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal inter_in : STD_LOGIC_VECTOR (4 downto 0);
    signal lsb : STD_LOGIC;
begin
    lsb <= SEG_IN(0);
    process(F_CLK, cnt)
    begin 
        if(rising_edge(F_CLK)) then
            cnt <= cnt + 1;
        end if;
        case cnt is
            when "00" => ANODES <= "1110";
            when "01" => ANODES <= "1101";
            when "10" => ANODES <= "1011";
            when "11" => ANODES <= "0111";
            when others => ANODES <= "1111";
        end case;
    end process;
    
    --"magic circuit"--
    process(inter_in, cnt)
    begin
        if (cnt = "00") then
            case SEG_IN is 
                when "00000" => SEGMENTS <= "0000001";
                when "00001" => SEGMENTS <= "1001111";
                when "00010" => SEGMENTS <= "0010010";
                when "00011" => SEGMENTS <= "0000110";
                when "00100" => SEGMENTS <= "1001100";
                when "00101" => SEGMENTS <= "0100100";
                when "00110" => SEGMENTS <= "0100000";
                when "00111" => SEGMENTS <= "0001111";
                when "01000" => SEGMENTS <= "0000000";
                when "01001" => SEGMENTS <= "0000100";
                when "01010" => SEGMENTS <= "0000001";
                when "01011" => SEGMENTS <= "1001111";
                when "01100" => SEGMENTS <= "0010010";
                when "01101" => SEGMENTS <= "0000110";
                when "01110" => SEGMENTS <= "1001100";
                when "01111" => SEGMENTS <= "0100100";
                when "10000" => SEGMENTS <= "0100000";
                when others => SEGMENTS <= "1111111";
            end case;
        elsif (cnt = "01") then
            if (SEG_IN < "01010") then
                SEGMENTS <= "1111111";
            else 
                SEGMENTS <= "1001111";
            end if;
        else
            if (lsb = '0') then
                SEGMENTS <= "0110000"; --EE--
            else
                SEGMENTS <= "1100010"; --oo--
            end if;
        end if;
    end process;  
end Behavioral;
