----------------------------------------------------------------------------------
-- Company: Cal Poly SLO
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/09/2017 08:10:29 PM
-- Design Name: 
-- Module Name: RCA - Behavioral
-- Project Name: Lab 2
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

entity RCA is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           SUM : out STD_LOGIC_VECTOR (4 downto 0);
           CO : out STD_LOGIC);
end RCA;

architecture Behavioral of RCA is
    
    component Half_Adder is
        Port ( A,B : in STD_LOGIC;
               SUM,CO : out STD_LOGIC);
    end component;
    
    component Full_Adder is
        Port ( A,B,Cin : in STD_LOGIC;
               SUM,CO : out STD_LOGIC);
    end component;
    
    signal CO_0, CO_1, CO_2, CO_3 : STD_LOGIC;
    
begin
    HA: Half_Adder
    port map (A => A(0),
              B => B(0),
              SUM => SUM(0),
              CO => CO_0);
    
    FA_1: Full_Adder
    port map (A => A(1),
              B => B(1),
              Cin => CO_0,
              SUM => SUM(1),
              CO => CO_1);
              
    FA_2: Full_Adder
    port map (A => A(2),
              B => B(2),
              Cin => CO_1,
              SUM => SUM(2),
              CO => CO_2);
              
    FA_3: Full_Adder
    port map (A => A(3),
              B => B(3),
              Cin => CO_2,
              SUM => SUM(3),
              CO => CO_3);
              
    FA_4: Full_Adder
    port map (A => A(4),
              B => B(4),
              Cin => CO_3,
              SUM => SUM(4),
              CO => CO);
end Behavioral;
