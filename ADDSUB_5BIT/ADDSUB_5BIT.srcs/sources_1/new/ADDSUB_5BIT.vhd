----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 06/01/2017 05:41:42 PM
-- Design Name: 
-- Module Name: ADDSUB_5BIT - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 5 bit signed adder/subtractor with validity detection connected to a seven
-- segment display
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

entity ADDSUB_5BIT is
    Port ( A_in : in STD_LOGIC_VECTOR (4 downto 0);
           B_in : in STD_LOGIC_VECTOR (4 downto 0);
           CLK_in, BTN_in : in STD_LOGIC;
           ANODES_out : out STD_LOGIC_VECTOR (3 downto 0);
           SEGMENTS_out : out STD_LOGIC_VECTOR (7 downto 0));
end ADDSUB_5BIT;

architecture Behavioral of ADDSUB_5BIT is
    
    component RCA_8bit
        Port (A, B : in STD_LOGIC_VECTOR (4 downto 0);
              Cin : in STD_LOGIC;
              SUM : out STD_LOGIC_VECTOR (4 downto 0);
              Co : out STD_LOGIC);
    end component;
    
    component sseg_dec
        Port (ALU_VAL : in STD_LOGIC_VECTOR (7 downto 0);
              SIGN, VALID, CLK : in STD_LOGIC;
              DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
              SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal SUM_out_big : STD_LOGIC_VECTOR (7 downto 0);
    signal inter_B, inter_SUM_inv, inter_SUM, inter_SUB, SUB_final, ABS_VAL, ABS_final : STD_LOGIC_VECTOR (4 downto 0);
    signal inter_SIGN, inter_VALID, A_sm, B_sm : STD_LOGIC;
    
begin
    
    COMP2_1 : RCA_8bit
        Port Map(A => inter_B,
                 B => "00000",
                 Cin => '1',
                 SUM => inter_SUB);
    
    COMP2_2 : RCA_8bit
        Port Map(A => inter_SUM_inv,
                 B => "00000",
                 Cin => '1',
                 SUM => ABS_VAL);
    
    RCA : RCA_8bit
        Port Map(A => A_in,
                 B => SUB_final,
                 Cin => '0',
                 SUM => inter_SUM);
                
    SEG7 : sseg_dec
        Port Map(ALU_VAL => SUM_out_big,
                 SIGN => inter_SIGN,
                 VALID => inter_VALID,
                 CLK => CLK_in,
                 DISP_EN => ANODES_out,
                 SEGMENTS => SEGMENTS_out);
                 
    A_sm <= A_in(4);
    B_sm <= SUB_final(4);
    inter_B <= not B_in;
    inter_SUM_inv <= not inter_SUM;
    inter_SIGN <= inter_SUM(4);
    inter_VALID <= (((not A_sm) or (not B_sm) or inter_SIGN) and (A_sm or B_sm or (not inter_SIGN)));
    SUM_out_big <= "000" & ABS_final;
                 
    process(BTN_in, B_in, inter_SUB)
    begin
        if (BTN_in = '1') then
            SUB_final <= B_in;
        else
            SUB_final <= inter_SUB;
        end if;
    end process;
    
    process(inter_SUM, ABS_VAL, inter_SIGN)
    begin
        if (inter_SIGN = '0') then
            ABS_final <= inter_SUM;
        else
            ABS_final <= ABS_VAL;
        end if;
    end process;     


end Behavioral;
