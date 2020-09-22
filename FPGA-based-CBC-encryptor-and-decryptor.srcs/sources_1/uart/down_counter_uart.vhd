----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 11:29:04 PM
-- Design Name: 
-- Module Name: down_counter_uart - Behavioral
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

-- Count from 255 to 128 downwards and give the output in binary as the address for BRAM

entity down_counter_uart is
    Port ( enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end down_counter_uart;

architecture Behavioral of down_counter_uart is
    signal count :  STD_LOGIC_VECTOR (7 downto 0) := "11111111";  --initialize the counter
    
begin
    process (enable,reset,clock)
    begin
        if reset = '1' then
            count <= "11111111";  -- initialize the counter
        elsif rising_edge(clock) and enable = '1' then
            if (count = "10000000") then
                count <= "11111111"; --skip to 255 again after complete 128
            else
                count <= count - '1';
            end if;
        end if;
    end process;
    counter_out <= count;

end Behavioral;
