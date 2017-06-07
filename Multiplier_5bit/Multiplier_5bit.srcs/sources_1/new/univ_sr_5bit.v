----------------------------------------------------------------------------------
-- Company: Barefoot Engineering
-- Engineer: James Ratner
-- 
-- Create Date: 05/22/2016 01:10:33 PM
-- Design Name: 
-- Module Name: univ_sr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Universal Shift Register; the four functions are: 
--
--      SEL  |  Operation   
--   -----------------------------------------------
--       00  |  Hold
--       01  |  Load         (input DP_IN)
--       10  |  Shift right  (input D_IN on left)
--       11  |  Shift left   (input D_IN on right)
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

--------------------------------------------------------------------------
-- Model for a universal shift register
--------------------------------------------------------------------------
entity univ_sr is
    port (    CLR : in std_logic;
	          SEL : in std_logic_vector(1 downto 0);
            DP_IN : in std_logic_vector(4 downto 0); -- parallel input
                Q : out std_logic_vector(4 downto 0);
              CLK : in std_logic;
             D_IN : in std_logic);                  -- input for shifts 
end univ_sr;

architecture my_sr of univ_sr is
   signal s_Q : std_logic_vector(4 downto 0); 
begin

   process (CLK,SEL,D_IN,DP_IN,s_Q,CLR) 
   begin
     -- asynchronous clear
     if (CLR = '1') then 
	    s_Q <= (others => '0'); 
     elsif (rising_edge(CLK)) then 
 
         case SEL is 
            -- do nothing (don't change state) --------------
            when "00" =>  s_Q <= s_Q;   
            
            -- parallel load --------------------------------
            when "01" =>  s_Q <= DP_IN; 
            
            -- shift right ----------------------------------
            when "10" =>  s_Q <= D_IN & s_Q(4 downto 1);
            
            -- shift left ----------------------------------- 
            when "11" =>  s_Q <= s_Q(3 downto 0) & D_IN;
            
            -- default case ---------------------------------
            when others => s_Q <= (others => '0'); 
         end case; 
 
      end if; 
   end process; 

   Q <= s_Q; 

end my_sr;