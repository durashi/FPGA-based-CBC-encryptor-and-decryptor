----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 05:04:34 PM
-- Design Name: 
-- Module Name: multi_4_to_1 - Behavioral
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
-- 4 to 1 8bit multiplexer
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

entity multi_4_to_1 is
    Port ( a_in : in STD_LOGIC_VECTOR (7 downto 0);
           b_in : in STD_LOGIC_VECTOR (7 downto 0);
           c_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC_VECTOR (1 downto 0));
end multi_4_to_1;

architecture Behavioral of multi_4_to_1 is

begin
    with selector select
        data_out <= a_in when "01",
                    b_in when "10",
                    c_in when "00",
                    d_in when others;

end Behavioral;
