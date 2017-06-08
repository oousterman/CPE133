----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2017 03:42:17 PM
-- Design Name: 
-- Module Name: four_4bit_sort_FSM - Behavioral
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

entity four_4bit_sort_FSM is
    Port(   high_LT,cen_LT,low_LT,BTN: in STD_LOGIC;
            A_LD_FSM,B_LD_FSM,C_LD_FSM,D_LD_FSM: out STD_LOGIC;
            A_sel_FSM,D_sel_FSM: out STD_LOGIC;
            B_sel_FSM,C_sel_FSM: out STD_LOGIC_VECTOR(1 DOWNTO 0));
end four_4bit_sort_FSM;

architecture Behavioral of four_4bit_sort_FSM is
    type state_type is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7,ST8,ST9);
    signal PS, NS : state_type;
begin
    process(PS, NS,high_LT,cen_LT,low_LT,BTN)
    begin
    case PS is
        when ST0 =>
            if BTN = '1' then
                NS <= ST1;
            else
                NS <= ST0;
            end if;
        
        when ST1 =>
            if high_LT = '1' then
                A_LD_FSM <= '1';
                A_sel_FSM <= '1';
                B_LD_FSM <= '1';
                B_sel_FSM <= "00";
            end if;
            NS <= ST2;
            
        when ST2 => 
            if cen_LT = '1' then
                B_LD_FSM <= '1';
                B_sel_FSM <= "10";
                C_LD_FSM <= '1';
                C_sel_FSM <= "00";
            end if;
            NS <= ST3;
       
        when ST3 =>
            if low_LT = '1' then
                C_LD_FSM <= '1';
                C_sel_FSM <= "10";
                D_LD_FSM <= '1';
                D_sel_FSM <= '0';
            end if;
            NS <= ST4;
        when ST4 =>
            if high_LT = '1' then
                A_LD_FSM <= '1';
                A_sel_FSM <= '1';
                B_LD_FSM <= '1';
                B_sel_FSM <= "00";
            end if;
            NS <= ST5;
            
        when ST5 => 
            if cen_LT = '1' then
                B_LD_FSM <= '1';
                B_sel_FSM <= "10";
                C_LD_FSM <= '1';
                C_sel_FSM <= "00";
            end if;
            NS <= ST6;
       
        when ST6 =>
            if low_LT = '1' then
                C_LD_FSM <= '1';
                C_sel_FSM <= "10";
                D_LD_FSM <= '1';
                D_sel_FSM <= '0';
            end if;
            NS <= ST7;
        when ST7 =>
            if high_LT = '1' then
                A_LD_FSM <= '1';
                A_sel_FSM <= '1';
                B_LD_FSM <= '1';
                B_sel_FSM <= "00";
            end if;
            NS <= ST8;
            
        when ST8 => 
            if cen_LT = '1' then
                B_LD_FSM <= '1';
                B_sel_FSM <= "10";
                C_LD_FSM <= '1';
                C_sel_FSM <= "00";
            end if;
            NS <= ST9;
       
        when ST9 =>
            if low_LT = '1' then
                C_LD_FSM <= '1';
                C_sel_FSM <= "10";
                D_LD_FSM <= '1';
                D_sel_FSM <= '0';
            end if;
            if BTN = '1' then
                NS <= ST1;
            else
                NS <= ST9;
            end if;
            
    end case;
    end process;
end Behavioral;
