----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2017 05:42:06 PM
-- Design Name: 
-- Module Name: CNTR_MULTI - Behavioral
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

entity CNTR_MULTI is
    Port ( BTN_in : in STD_LOGIC;
           CLK_in : in STD_LOGIC;
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE : out STD_LOGIC_VECTOR (3 downto 0));
end CNTR_MULTI;

architecture Behavioral of CNTR_MULTI is
    
    component UP_DOWN_CNTR
        Port ( BTN : in STD_LOGIC;
               CLK : in STD_LOGIC;
               COUNT : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component clk_div_fs
        Port ( CLK : in STD_LOGIC;
               FCLK, SCLK : out STD_LOGIC);
    end component;
    
    signal CLK_FAST, CLK_SLOW : STD_LOGIC;
    signal COUNT_OUT : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal SEG7_ANODE_1, SEG7_ANODE_2 : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    
begin

    CLK_DIV : clk_div_fs
    Port Map ( CLK => CLK_in,
               FCLK => CLK_FAST,
               SCLK => CLK_SLOW);
               
    CNTR : UP_DOWN_CNTR
    Port Map ( BTN => BTN_in,
               CLK => CLK_SLOW,
               COUNT => COUNT_OUT);
    
    process(COUNT_OUT, CLK_FAST)
    begin
        case COUNT_OUT is
            when "0000" => SEG7_ANODE_1 <= "1000000";
            when "0001" => SEG7_ANODE_1 <= "1111001";
            when "0010" => SEG7_ANODE_1 <= "0100100";
            when "0011" => SEG7_ANODE_1 <= "0110000";
            when "0100" => SEG7_ANODE_1 <= "0011001";
            when "0101" => SEG7_ANODE_1 <= "0010010";
            when "0110" => SEG7_ANODE_1 <= "0000011";
            when "0111" => SEG7_ANODE_1 <= "1111000";
            when "1000" => SEG7_ANODE_1 <= "0000000";
            when "1001" => SEG7_ANODE_1 <= "0011000";
            when others => SEG7_ANODE_1 <= "1111111";
        end case;
        
        case COUNT_OUT is 
            when "1010" => SEG7_ANODE_2 <= "1111001";
            when "1011" => SEG7_ANODE_2 <= "1111001";
            when "1100" => SEG7_ANODE_2 <= "1111001";
            when "1101" => SEG7_ANODE_2 <= "1111001";
            when "1110" => SEG7_ANODE_2 <= "1111001";
            when "1111" => SEG7_ANODE_2 <= "1111001";
            when others => SEG7_ANODE_2 <= "1111111";
        end case;
        
        if (rising_edge(CLK_FAST)) then
            SEG7 <= SEG7_ANODE_1;
            ANODE <= "1110";
        elsif (falling_edge(CLK_FAST)) then
            SEG7 <= SEG7_ANODE_2;
            ANODE <= "1101";
        end if;
    end process;

end Behavioral;
