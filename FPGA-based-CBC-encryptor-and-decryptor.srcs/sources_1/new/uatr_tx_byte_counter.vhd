----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 07:20:25 PM
-- Design Name: 
-- Module Name: uatr_tx_byte_counter - Behavioral
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

entity uatr_tx_byte_counter is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           tx_done : in STD_LOGIC;
           enable_signal : out STD_LOGIC);
end uatr_tx_byte_counter;

architecture Behavioral of uatr_tx_byte_counter is

constant c_BIT_PERIOD : time := 100 us;
constant c_CLK_PERIOD : time := 40 ns;
signal out_sig:  STD_LOGIC := '0';

begin
    process (clock,enable,tx_done)
    begin
        if(enable = '0')then
            enable_signal <= '0';
        elsif(enable = '1')then   
            out_sig <= '1';
        end if;    
        if (out_sig = '1' and tx_done = '1') then
            enable_signal <= '1';
        elsif tx_done = '0'  then
            enable_signal <= '0';      
        end if;
    end process;    
end Behavioral;
