----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2017 03:13:34 PM
-- Design Name: 
-- Module Name: Abs_4 - Behavioral
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

entity Abs_4 is
    Port ( SIGNED : in STD_LOGIC_VECTOR (3 downto 0);
           ABS_val : out STD_LOGIC_VECTOR (3 downto 0));
end Abs_4;

architecture Behavioral of Abs_4 is

    component RCA_4_Bits
        Port (A,B : in STD_LOGIC_VECTOR (3 downto 0);
              Cin : in STD_LOGIC;
              SUM : out STD_LOGIC_VECTOR (3 downto 0);
              CO : out STD_LOGIC);
    end component;
    
    signal SEL : STD_LOGIC;
    signal NOT_INV, SUM_OUT, INTER : STD_LOGIC_VECTOR (3 downto 0);

begin 

    RCA : RCA_4_Bits
    Port Map(A => INTER,
             B => "0000",
             Cin => '1',
             SUM => SUM_OUT);
             
    process (SIGNED)
    begin
        SEL <= SIGNED(3);
        INTER <= not SIGNED;
    end process;
    
    process (SEL)
    begin
        if (SEL = '1') then
            ABS_val <= SUM_OUT;
        else
            ABS_val <= SIGNED;
        end if;
    end process;
    
end Behavioral;
