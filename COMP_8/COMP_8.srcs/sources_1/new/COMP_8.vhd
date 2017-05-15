----------------------------------------------------------------------------------
-- Company: Cal Poly SLO
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/10/2017 02:43:43 PM
-- Design Name: 
-- Module Name: COMP_8 - Behavioral
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

entity COMP_8 is
    Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           EQ,LT,GT : out STD_LOGIC);
end COMP_8;

architecture Behavioral of COMP_8 is
    
    component COMP_4 is 
        Port (A,B : in STD_LOGIC_VECTOR (3 downto 0);
              EQ,LT,GT : out STD_LOGIC);
    end component;
    
    signal EQ_0, EQ_1, LT_0, LT_1, GT_0, GT_1 : STD_LOGIC; 
    
begin
    COMP_4_BIG : COMP_4
    port map (A => A(7 downto 4),
              B => B(7 downto 4),
              EQ => EQ_1,
              LT => LT_1,
              GT => GT_1);

    COMP_4_SMALL : COMP_4
    port map (A => A(3 downto 0),
              B => B(3 downto 0),
              EQ => EQ_0,
              LT => LT_0,
              GT => GT_0);
              
    process(EQ_0, EQ_1, LT_0, LT_1, GT_0, GT_1)
    begin
    
        EQ <= '0'; GT <= '0'; LT <= '0';
        
        if (EQ_1 = '1' and EQ_0 = '1') then 
            EQ <= '1';
        elsif (EQ_1 = '1') then
            if (LT_0 = '1') then
                LT <= '1';
            else
                GT <= '1';
            end if;
        elsif (LT_1 = '1') then
            LT <= '1';
        else
            GT <= '1';
        end if;
    end process;
end Behavioral;
