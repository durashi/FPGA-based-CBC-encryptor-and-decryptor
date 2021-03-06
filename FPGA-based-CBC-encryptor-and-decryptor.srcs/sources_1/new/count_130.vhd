----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 02:07:42 PM
-- Design Name: 
-- Module Name: count_130 - Behavioral
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
-- This counter will update counter value until 130.
-- This module is used as a component of Encrypt handler.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count_130 is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           enable_signal : out STD_LOGIC);
end count_130;

architecture Behavioral of count_130 is
    signal count :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal out_sig:  STD_LOGIC := '0';
    signal sig_flag: STD_LOGIC := '1';
begin
    process (clock,enable)
    begin
        if(enable = '0')then
            out_sig <= '0';
            count <= "00000000";
            sig_flag <= '1';
        elsif(sig_flag = '0' and enable = '1')then
            out_sig <= '0';
        elsif (sig_flag = '1' and enable = '1') then
            out_sig <= '1';
            if (clock 'event and clock = '1' and enable = '1') then 
                out_sig <= '1';
                if (count = "10000010") then -- when counter value equals to 130 then it should hault and set output signal as 0.
                    out_sig <= '0';
                    count <= "10000010";
                    sig_flag <= '0';
                else
                    count <= count + '1'; --keep increasing the counter
                end if;
            end if;
        end if;
    end process;
    
    enable_signal <= out_sig;

end Behavioral;
