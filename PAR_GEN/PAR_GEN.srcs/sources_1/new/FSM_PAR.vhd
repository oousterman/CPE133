----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 06/04/2017 12:08:54 PM
-- Design Name: 
-- Module Name: FSM_PAR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: State machine used in the parity generator to determine when to
-- shift and clear
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_PAR is
    Port (EQ, CLK, BTN : in STD_LOGIC;
          LD, CL : out STD_LOGIC;
          SH : out STD_LOGIC_VECTOR (1 downto 0));
end FSM_PAR;

architecture Behavioral of FSM_PAR is
    type state_type is (ST0, ST1, ST2, ST3, ST4);
    signal PS, NS : state_type;
begin
    process(CLK, EQ, BTN, PS)
    begin
        if (rising_edge(CLK)) then
            PS <= NS;
        end if;
        case PS is 
            --starting state--
            when ST0 =>
                SH <= "01"; 
                LD <= '0';
                CL <= '0';
                NS <= ST1;
            --shifts until the sr is empty--
            when ST1 =>
                SH <= "10";
                LD <= '1';
                CL <= '0';
                if (EQ = '0') then
                    NS <= ST1;
                else
                    NS <= ST2;
                end if;
            -- intermediate state--
            when ST2 =>
                SH <= "00";
                LD <= '1';
                CL <= '0';
                NS <= ST3;
            --holds the value until the button is pressed which resets the circuit--
            when ST3 =>
                SH <= "00";
                LD <= '0';
                CL <= '0';
                if BTN <= '0' then
                    NS <= ST3;
                else 
                    NS <= ST4;
                end if;
            --clears the circuit--
            when ST4 =>
                SH <= "00";
                CL <= '1';
                LD <= '0';
                NS <= ST0;
            when others => NS <= ST0;
        end case;
    end process;
end Behavioral;
