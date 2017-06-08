----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2017 03:45:03 PM
-- Design Name: 
-- Module Name: four_4bit_sort - Behavioral
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

entity four_4bit_sort is
    Port (  A_in,B_in,C_in,D_in : in STD_LOGIC_VECTOR (4 downto 0);
            BTN_in :in STD_LOGIC);
end four_4bit_sort;

architecture Behavioral of four_4bit_sort is

    component sseg_dec_sort
        Port(FIRST,SECOND,THIRD,FOURTH: in STD_LOGIC_VECTOR(3 DOWNTO 0));
    end component;
    
    component four_4bit_sort_FSM
        Port(   high_LT,cen_LT,low_LT,BTN: in STD_LOGIC;
                A_LD_FSM,B_LD_FSM,C_LD_FSM,D_LD_FSM: out STD_LOGIC;
                A_sel_FSM,D_sel_FSM: out STD_LOGIC;
                B_sel_FSM,C_sel_FSM: out STD_LOGIC_VECTOR(1 DOWNTO 0));
    end component;
    
    signal A_mux,B_mux,C_mux,D_mux: STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal A_out,B_out,C_out,D_out: STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal top_LT,mid_LT,bot_LT: STD_LOGIC;
    signal A_LD,B_LD,C_LD,D_LD: STD_LOGIC;
    signal A_sel,D_sel: STD_LOGIC;
    signal B_sel,C_sel: STD_LOGIC_VECTOR(1 DOWNTO 0);

begin

    display: sseg_dec_sort
    Port Map(   FIRST => A_out,
                SECOND => B_out,
                THIRD => C_out,
                FOURTH => D_out);
              
    FSM: four_4bit_sort_FSM
    Port Map(   high_LT => top_LT,
                cen_LT => mid_LT,
                low_LT => bot_LT,
                BTN => BTN_in,
                A_LD_FSM => A_LD,
                B_LD_FSM => B_LD,
                C_LD_FSM => C_LD,
                D_LD_FSM => D_LD,
                A_sel_FSM => A_sel,
                B_sel_FSM => B_sel,
                C_sel_FSM => C_sel,
                D_sel_FSM => D_sel);
                
    process(A_LD,B_LD,C_LD,D_LD)--all of the registers
    begin
        if (A_LD = '1') then
            A_out <= A_mux;
        end if;
        if (B_LD = '1') then
            B_out <= B_mux;
        end if;
        if (C_LD = '1') then
            C_out <= C_mux;
        end if;
        if (D_LD = '1') then
            D_out <= D_mux;
        end if;
    end process;
    
    process(A_sel,B_sel,C_sel,D_sel)--all of the muxes
    begin
        if (A_sel = '0') then
            A_mux <= A_in;
        else
            A_mux <= B_out;
        end if;
        
        if (B_sel = "00") then
            B_mux <= A_out;
        else if (B_sel <= "01") then
            B_mux <= B_in;
        else 
            B_mux <= C_out;
        end if;
        end if;
        
        if (C_sel = "00") then
            C_mux <= B_out;
        else if (C_sel <= "01") then
            C_mux <= C_in;
        else 
            C_mux <= D_out;
        end if;
        end if;
        
        if (D_sel = '0') then
            D_mux <= C_out;
        else
            D_mux <= D_in;
        end if;
    end process;
    
    process(A_out,B_out,C_out,D_out)--the 3 comparators
    begin
        if (A_out < B_out) then
            top_LT <= '1';
        else
            top_LT <= '0';
        end if;
        
        if (B_out < C_out) then
            mid_LT <= '1';
        else
            mid_LT <= '0';
        end if;
        
        if (C_out < D_out) then
            bot_LT <= '1';
        else
            bot_LT <= '0';
        end if;
    end process;

end Behavioral;
