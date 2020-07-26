----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2020 11:38:41 PM
-- Design Name: 
-- Module Name: up_counter - Behavioral
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

entity up_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end up_counter;

architecture Behavioral of up_counter is
    signal count :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    
begin
    process (clock,reset)
    begin
        if reset = '1' then
            count <= "00000000";
        elsif (clock 'event and clock = '1') then
            if (count = "01111111") then
                count <= "00000000";
            else
                count <= count + '1';
            end if;
        end if;
        
    end process;
    
    counter_out <= count;

end Behavioral;
