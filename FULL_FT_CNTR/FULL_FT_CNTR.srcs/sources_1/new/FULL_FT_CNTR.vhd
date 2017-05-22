----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 05/21/2017 07:50:04 PM
-- Design Name: 
-- Module Name: FULL_FT_CNTR - Behavioral
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

entity FULL_FT_CNTR is
    Port ( HOLD_in, UP_in, RESET_in, EVEN_in, ODD_in, CLK_in : in STD_LOGIC;
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE : out STD_LOGIC_VECTOR (3 downto 0));
end FULL_FT_CNTR;

architecture Behavioral of FULL_FT_CNTR is
    
    component FSM_CNTR
        Port ( HOLD, UP, RESET, EVEN, ODD, CLK : in STD_LOGIC;
               COUNT : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    component clk_div_fs
        Port ( CLK : in STD_LOGIC;
               FCLK, SCLK : out STD_LOGIC);
    end component;
    
    signal COUNT_OUT : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal SLOW_CLK : STD_LOGIC;
    
begin
    
    ANODE <= "1110";
    
    CLK_DIV : clk_div_fs
    Port Map(CLK => CLK_in,
             SCLK => SLOW_CLK);
    
    FSM : FSM_CNTR
    Port Map(HOLD => HOLD_in,
             UP => UP_in,
             RESET => RESET_in,
             EVEN => EVEN_in,
             ODD => ODD_in,
             CLK => SLOW_CLK,
             COUNT => COUNT_OUT);
             
    process(COUNT_OUT)
    begin 
        case COUNT_OUT is 
            when "000" => SEG7 <= "1000000";
            when "001" => SEG7 <= "1111001";
            when "010" => SEG7 <= "0100100";
            when "011" => SEG7 <= "0110000";
            when "100" => SEG7 <= "0011001";
            when "101" => SEG7 <= "0010010";
            when "110" => SEG7 <= "0000011";
            when "111" => SEG7 <= "1111000";
            when others => SEG7 <= "1111111";
        end case;
    end process;

end Behavioral;
