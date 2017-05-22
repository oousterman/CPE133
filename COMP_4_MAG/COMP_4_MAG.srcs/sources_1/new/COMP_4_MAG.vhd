----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/21/2017 04:28:32 PM
-- Design Name: 
-- Module Name: COMP_4_MAG - Behavioral
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

entity COMP_4_MAG is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);
           ANODES : out STD_LOGIC_VECTOR (3 downto 0);
           DP : out STD_LOGIC);
end COMP_4_MAG;

architecture Behavioral of COMP_4_MAG is

    component ABS_VAL
        Port ( SIGNED : in STD_LOGIC_VECTOR (3 downto 0)
               ABS_4 : out STD_LOGIC_VECTOR (3 downto 0)
    end component;
    
    component COMP_4
        Port ( A, B : in STD_LOGIC_VECTOR (3 downto 0)
               EQ : out STD_LOGIC);
    end component;
    
    signal ABS_A_OUT, ABS_B_OUT : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal EQ_OUT : STD_LOGIC := '0';
    
begin

    ABS_VAL_A : ABS_VAL
    Port Map ( SIGNED => A,
               ABS_4 => ABS_A_OUT);
               
    ABS_VAL_B : ABS_VAL
    Port Map ( SIGNED => B,
               ABS_4 => ABS_B_OUT);
               
    COMP : COMP_4
    Port Map( A => ABS_A_OUT,
              B => ABS_B_OUT,
              EQ => EQ_OUT);
              
    process(ABS_A_OUT, ABS_B_OUT, EQ_OUT, A, B)
    begin 
        DP <= not (A(3) xor B(3));
        if EQ_OUT = '0' then
            ANODES <= "1111";
        else
            ANODES <= "1110";
        end if;
        case A(2 downto 0) is
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
    end process;

end Behavioral;
