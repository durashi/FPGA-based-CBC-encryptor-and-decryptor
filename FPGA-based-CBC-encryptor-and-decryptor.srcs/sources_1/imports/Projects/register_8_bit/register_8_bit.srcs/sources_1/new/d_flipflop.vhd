----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 10:34:59 PM
-- Design Name: 
-- Module Name: d_flipflop - Behavioral
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

entity d_flipflop is
    Port ( data_in : in STD_LOGIC;
           data_out : out STD_LOGIC;
           clk, reset : in STD_LOGIC);
end d_flipflop;

architecture Behavioral of d_flipflop is

begin
process(clk, reset)
    begin
        if reset = '1' then
            data_out <= '0';
        elsif clk'event and clk = '1' then
            data_out <= data_in;
        end if;
    end process;

end Behavioral;
