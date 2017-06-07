----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2017 03:25:39 PM
-- Design Name: 
-- Module Name: Multiplier_5bit_FSM - Behavioral
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

entity Multiplier_5bit_FSM is
  Port (    BTN: in std_logic;
            Eq: in std_logic;
            FSM_Sel_A: out std_logic_vector(1 downto 0);
            FSM_Sel_B: out std_logic_vector(1 downto 0);
            LD: out std_logic );
end Multiplier_5bit_FSM;

architecture Behavioral of Multiplier_5bit_FSM is
    type state_type is (ST0,ST1,ST2);
    signal PS,NS: state_type;
    
begin
    process(PS,BTN,Eq)
    begin 
        case PS is
            when ST0 =>
                FSM_Sel_A <= "00";
                FSM_Sel_B <= "00";
                LD <= '0';
                if BTN = '0' then
                    NS <= ST0;
                else
                    NS <= ST1;
                end if;
            when ST1 =>
                FSM_Sel_A <= "01";
                FSM_Sel_B <= "01";
                LD <= '0';
                NS <= ST2;
                
            when ST2 =>
                FSM_Sel_A <= "11";
                FSM_Sel_B <= "10";
                LD <= '1';
                if Eq = '0' then
                    NS <= ST2;
                else
                    NS <= ST0;
                end if;
            when others =>
                NS <= ST0;
        end case;
    end process;
                

end Behavioral;
