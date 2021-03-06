----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 10:12:44 PM
-- Design Name: 
-- Module Name: uart_up_counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Count from 0 to 127 downwards and give the output in binary as the address for BRAM

entity uart_up_counter is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end uart_up_counter;

architecture Behavioral of uart_up_counter is
    signal count :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";  --initialize the counter
    
begin
    process (enable,reset, clock)
    begin
        if reset = '1' then
            count <= "00000000";  --initialize the counter
        elsif rising_edge(clock) and enable = '1' then
            if (count = "01111111") then
                count <= "00000000";  --skip to 0 again after complete 128
            else
                count <= count + '1';
            end if;
        end if;
        
    end process;
    
    counter_out <= count;

end Behavioral;
