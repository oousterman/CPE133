----------------------------------------------------------------------------------
-- Company: Cal Poly CPE 133
-- Engineer: Cole Cummins, Oliver Ousterman
-- 
-- Create Date: 06/04/2017 11:47:47 AM
-- Design Name: 
-- Module Name: PAR_GEN - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Counts the number of set bits in a given 16 bit word, also describes
-- whether it is even or odd parity
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

entity PAR_GEN is
    Port ( WORD_in : in STD_LOGIC_VECTOR (15 downto 0);
           CLK_in, BTN_in : in STD_LOGIC;
           SEG7_out : out STD_LOGIC_VECTOR (6 downto 0);
           ANODES_out : out STD_LOGIC_VECTOR (3 downto 0));
end PAR_GEN;

architecture Behavioral of PAR_GEN is
    --provided shift register--
    component univ_sr
        Port (CLR, CLK, D_IN : in STD_LOGIC;
              SEL : in STD_LOGIC_VECTOR (1 downto 0);
              DP_IN : in STD_LOGIC_VECTOR (15 downto 0);
              Q : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    --state machine--
    component FSM_PAR
        Port (EQ, CLK, BTN : in STD_LOGIC;
              LD, CL : out STD_LOGIC;
              SH : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    --5 bit counter--
    component CNTR_5BIT
        Port ( EN, CL, CLK : in STD_LOGIC;
               CNT : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    --clock divider--
    component clk_div_fs
        Port (CLK : in STD_LOGIC;
              SCLK, FCLK : out STD_LOGIC);
    end component;
    --7 segment display, also displays parity--
    component SEG7_PAR 
        Port ( SEG_IN : in STD_LOGIC_VECTOR (4 downto 0);
               F_CLK : in STD_LOGIC;
               SEGMENTS : out STD_LOGIC_VECTOR (6 downto 0);
               ANODES : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal fsm_ld, fsm_cl, eq_inter, lsb, clk_s, clk_f  : STD_LOGIC;
    signal fsm_sel : STD_LOGIC_VECTOR (1 downto 0); -- select for sr --
    signal cntr_out : STD_LOGIC_VECTOR (4 downto 0);
    signal reg_out_big : STD_LOGIC_VECTOR (6 downto 0); --bit stuffed counter output--
    signal comp_in : STD_LOGIC_VECTOR (15 downto 0);
   
begin
    SH_REG : univ_sr
    Port Map(DP_IN => WORD_in,
             D_IN => '0',
             CLK => CLK_s,
             SEL => fsm_sel,
             Q => comp_in,
             CLR => '0');
             
    CNTR : CNTR_5BIT
    Port Map(EN => lsb,
             CL => fsm_cl,
             CLK => CLK_s,
             CNT => cntr_out);
             
    FSM : FSM_PAR
    Port Map(EQ => eq_inter,
             BTN => BTN_in,
             CLK => CLK_s,
             LD => fsm_ld,
             SH => fsm_sel,
             CL => fsm_cl);
             
    CLK_DIV : clk_div_fs
    Port Map(CLK => CLK_in,
             FCLK => clk_f,
             SCLK => clk_s);
    
    SEG7 : SEG7_PAR
    Port Map(F_CLK => clk_f,
             SEG_IN => cntr_out,
             SEGMENTS => SEG7_out,
             ANODES => ANODES_out);
             
    --used for fsm, once word is read clears the circuit--
    process(comp_in)
    begin
        if (comp_in = "0000000000000000") then
            eq_inter <= '1';
        else
            eq_inter <= '0';
        end if;
    end process;
    
    --register and bit stuffing--
    process(cntr_out, fsm_ld)
    begin
        if fsm_ld = '1' then
            reg_out_big <= "00" & cntr_out;
        end if;
    end process;
    
    --used for parity--
    lsb <= comp_in(0);
end Behavioral;
