----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2017 03:08:35 PM
-- Design Name: 
-- Module Name: Test_Bench - Behavioral
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

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is
    Component Comp_4_Magnitude 
        Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
               SEG7_big : out STD_LOGIC_VECTOR (6 downto 0);
               DP_big : out STD_LOGIC;
               ANODES_big : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal sA : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal sB : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal sSEG7_big : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    signal sANODES_big : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal sDP_big : STD_LOGIC := '0';

begin

    COMP_4 : Comp_4_Magnitude 
    Port Map (A => sA,
              B => sB,
              SEG7_big => sSEG7_big,
              ANODES_big => sANODES_big,
              DP_big => sDP_big);
    
    process
        begin
            sA <= "0001";
            sB <= "0001";
            wait for 5 ns;
            sA <= "0001";
            sB <= "0000";
            wait for 5 ns;
            sA <= "1001";
            sB <= "0001";
            wait for 5 ns;
            sA <= "1001";
            sB <= "1001";
            wait for 5 ns;
            sA <= "1000";
            sB <= "0001";
            wait for 5 ns;
    end process;
    
end Behavioral;
