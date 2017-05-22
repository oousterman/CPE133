----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/21/2017 08:03:50 PM
-- Design Name: 
-- Module Name: FSM_CNTR - Behavioral
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

entity FSM_CNTR is
    Port ( HOLD, UP, RESET, EVEN, ODD, CLK : in STD_LOGIC;
           COUNT : out STD_LOGIC_VECTOR (2 downto 0));
end FSM_CNTR;

architecture Behavioral of FSM_CNTR is
    type state_type is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7);
    signal PS, NS : state_type;
begin
    
    process(CLK, HOLD, RESET, NS)
    begin
        if (RESET = '1') then
            PS <= ST0;
        elsif (rising_edge(CLK) and HOLD = '0') then
            PS <= NS;
        end if;
    end process;
    
    process(PS, EVEN, ODD, UP)
    begin
        case PS is 
            when ST0 =>
                if UP = '1' then
                    if EVEN = '1' then NS <= ST2;
                    else NS <= ST1;
                    end if;
                else
                    if EVEN = '1' then NS <= ST6;
                    else NS <= ST7;
                    end if;
                end if;
                
            when ST1 =>
                if UP = '1' then
                    if ODD = '1' then NS <= ST3;
                    else NS <= ST2;
                    end if;
                else
                    if ODD = '1' then NS <= ST7;
                    else NS <= ST0;
                    end if;
                end if;
                
            when ST2 =>
                if UP = '1' then
                    if EVEN = '1' then NS <= ST4;
                    else NS <= ST3;
                    end if;
                else
                    if EVEN = '1' then NS <= ST0;
                    else NS <= ST1;
                    end if;
                end if;

            when ST3 =>
                if UP = '1' then
                    if ODD = '1' then NS <= ST5;
                    else NS <= ST4;
                    end if;
                else
                    if ODD = '1' then NS <= ST1;
                    else NS <= ST2;
                    end if;
                end if;

            when ST4 =>
                if UP = '1' then
                    if EVEN = '1' then NS <= ST6;
                    else NS <= ST5;
                    end if;
                else
                    if EVEN = '1' then NS <= ST2;
                    else NS <= ST3;
                    end if;
                end if;

            when ST5 =>
                if UP = '1' then
                    if ODD = '1' then NS <= ST7;
                    else NS <= ST6;
                    end if;
                else
                    if ODD = '1' then NS <= ST3;
                    else NS <= ST4;
                    end if;
                end if;

            when ST6 =>
                if UP = '1' then
                    if EVEN = '1' then NS <= ST0;
                    else NS <= ST7;
                    end if;
                else
                    if EVEN = '1' then NS <= ST4;
                    else NS <= ST5;
                    end if;
                end if;

            when ST7 =>
                if UP = '1' then
                    if ODD = '1' then NS <= ST1;
                    else NS <= ST0;
                    end if;
                else
                    if ODD = '1' then NS <= ST5;
                    else NS <= ST6;
                    end if;
                end if;
            when others =>
                NS <= ST0;
        end case;
    end process;
    
    with PS select
        COUNT <= "000" when ST0,
                 "001" when ST1,
                 "010" when ST2,
                 "011" when ST3,
                 "100" when ST4,
                 "101" when ST5,
                 "110" when ST6,
                 "111" when ST7,
                 "000" when others;
  
end Behavioral;
