----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2017 03:00:26 PM
-- Design Name: 
-- Module Name: Comp_4_Magnitude - Behavioral
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

entity Comp_4_Magnitude is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           SEG7_big : out STD_LOGIC_VECTOR (6 downto 0);
           DP_big : out STD_LOGIC;
           ANODES_big : out STD_LOGIC_VECTOR (3 downto 0));
end Comp_4_Magnitude;

architecture Behavioral of Comp_4_Magnitude is
    
    component Abs_4 
        Port ( SIGNED : in STD_LOGIC_VECTOR (3 downto 0);
               ABS_val : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Comp_4
        Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
               EQ,LT,GT : out STD_LOGIC);
    end component;
    
    component BCD_LED
        Port ( SIGN : in STD_LOGIC;
               BCD : in STD_LOGIC_VECTOR (2 downto 0);
               ANODES : out STD_LOGIC_VECTOR (3 downto 0);
               SEG7 : out STD_LOGIC_VECTOR (6 downto 0);
               DP : out STD_LOGIC);
    end component;
    
    signal Abs_1, Abs_2 : STD_LOGIC_VECTOR (3 downto 0);
    signal Eq, SIGN : STD_LOGIC;
    
begin

    Abs_A : Abs_4
    Port Map( SIGNED => A,
              ABS_val => Abs_1);
              
    Abs_B : Abs_4
    Port Map( SIGNED => B,
              ABS_val => Abs_2);
              
    COMP : Comp_4 
    Port Map( A => Abs_1,
              B => Abs_2,
              EQ => Eq);
    
    LED : BCD_LED
    Port Map ( SIGN => SIGN,
               BCD => A(2 downto 0),
               ANODES => ANODES_big,
               SEG7 => SEG7_big,
               DP => DP_big);
    
    process(A, B, EQ)
    begin 
        SIGN <= not (A(3) xor B(3));
        if Eq = '0' then
            ANODES_big <= "1111";
        else
            ANODES_big <= "1110";
        end if;
    end process;

end Behavioral;
