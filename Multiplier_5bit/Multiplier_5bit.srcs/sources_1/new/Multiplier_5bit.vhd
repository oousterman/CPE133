----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2017 03:25:39 PM
-- Design Name: 
-- Module Name: Multiplier_5bit - Behavioral
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

entity Multiplier_5bit is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           BTN : in STD_LOGIC;
           DISP_EN : in STD_LOGIC_VECTOR (3 downto 0);
           SEGMENTS : in STD_LOGIC_VECTOR (7 downto 0));
end Multiplier_5bit;

architecture Behavioral of Multiplier_5bit is

    component RCA_10bit
        port (  A,B : in std_logic_vector(9 downto 0); 
                Cin : in std_logic; 
                Co : out std_logic; 
                SUM : out std_logic_vector(9 downto 0));
    end component;
    
    component univ_sr_10bit
        port (  CLR : in std_logic;
                SEL_A : in std_logic_vector(1 downto 0);
                DP_IN : in std_logic_vector(9 downto 0); -- parallel input
                Q : out std_logic_vector(9 downto 0);
                CLK : in std_logic;
                D_IN : in std_logic);
    end component;
    
    component univ_sr_5bit
        Port (    CLR : in std_logic;
                  SEL_B : in std_logic_vector(1 downto 0);
                  DP_IN : in std_logic_vector(4 downto 0); -- parallel input
                  Q : out std_logic_vector(4 downto 0);
                  CLK : in std_logic;
                  D_IN : in std_logic);  
    end component;
    
    component sseg_dec_uni 
        Port ( COUNT1 : in std_logic_vector(13 downto 0); 
               COUNT2 : in std_logic_vector(7 downto 0);
               SEL : in std_logic_vector(1 downto 0);
               dp_oe : in std_logic;
               dp : in std_logic_vector(1 downto 0);                       
               CLK : in std_logic;
               SIGN : in std_logic;
               VALID : in std_logic;
               DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
    end component;
    
    component Multiplier_5bit_FSM
        Port( BTN: in std_logic;
              Eq: in std_logic;
              FSM_Sel_A: out std_logic_vector(1 downto 0);
              FSM_Sel_B: out std_logic_vector(1 downto 0);
              LD: out std_logic);
    end component;
    
    signal A_LG,A_incoming: std_logic_vector(9 downto 0);
    signal ZERO: std_logic_vector(9 downto 0);
    signal Equals: std_logic;
    signal B_inter: std_logic_vector(4 downto 0);
    signal RCA_A: std_logic_vector(9 downto 0);
    signal RCA_Sum: std_logic_vector(9 downto 0);
    signal Result: std_logic_vector(9 downto 0);
    signal Load: std_logic;
    signal Sel_A_inter, Sel_B_inter: std_logic_vector(1 downto 0);
    
    
begin
    
    FSM: Multiplier_5bit_FSM
    port Map(   BTN => BTN,
                Eq => Equals,
                FSM_Sel_A => Sel_A_inter, 
                FSM_Sel_B => Sel_B_inter,
                LD => Load);
                
    A_SH: univ_sr_10bit
    port Map(   CLR=> '0',
                Sel_A => Sel_A_inter,
                DP_IN => A_incoming,
                Q => A_LG,
                CLK => '0',------------------------------------------
                D_IN => '0');
    
    B_SH: univ_sr_5bit
    port Map(   CLR => '0',
                Sel_B => Sel_B_inter,
                DP_IN => B,
                Q => B_inter,
                CLK => '0',---------------------------------------------
                D_IN => '0');
                
    RCA:RCA_10bit
    port Map(   A => RCA_A,
                B => Result,
                Cin => '0',
                SUM => RCA_Sum);
    
--    SEG:sseg_dec_uni
--    port Map(   


--component sseg_dec_uni 
--        Port ( COUNT1 : in std_logic_vector(13 downto 0); 
--               COUNT2 : in std_logic_vector(7 downto 0);
--               SEL : in std_logic_vector(1 downto 0);
--               dp_oe : in std_logic;
--               dp : in std_logic_vector(1 downto 0);                       
--               CLK : in std_logic;
--               SIGN : in std_logic;
--               VALID : in std_logic;
--               DISP_EN : out std_logic_vector(3 downto 0);
--               SEGMENTS : out std_logic_vector(7 downto 0));
--    end component;

process (Load,RCA_Sum) -- Register for the output of the circuit
begin
    if( Load = '0') then
        Result <= RCA_Sum;
    end if;
end process;

process(B_inter,A_LG,ZERO) -- Mux to determine what gets put in the RCA
begin
    if(B_inter(0) = '0') then
        RCA_A <= ZERO;
    else
        RCA_A <= A_LG;
    end if;
end process;

process(B_inter)    --Comparator to find when to stop the ciruit
begin
    if (B_inter = "00000") then
        Equals <= '1';
    else
        Equals <= '0';
    end if;
end process;

end Behavioral;
