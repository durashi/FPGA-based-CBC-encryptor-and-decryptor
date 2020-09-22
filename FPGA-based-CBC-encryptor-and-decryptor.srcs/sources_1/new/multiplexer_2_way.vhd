----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2020 12:33:01 AM
-- Design Name: 
-- Module Name: multiplexer_2_way - Behavioral
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
-- 2 to 1 8bit multiplexer
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

entity multiplexer_2_way is
    Port ( a_in : in STD_LOGIC_VECTOR (7 downto 0);
           b_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC);
end multiplexer_2_way;

architecture Behavioral of multiplexer_2_way is

begin
    with selector select
        data_out <= a_in when '0',
                    b_in when others;

end Behavioral;
