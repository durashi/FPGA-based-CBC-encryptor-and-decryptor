----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2020 10:16:32 PM
-- Design Name: 
-- Module Name: bit_swapper - Behavioral
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

entity bit_swapper is
    Port ( byte_in : in STD_LOGIC_VECTOR (7 downto 0);
            Clk : in STD_LOGIC;
            byte_out : out STD_LOGIC_VECTOR (7 downto 0));
end bit_swapper;

architecture Behavioral of bit_swapper is

begin
process (Clk) 
--    variable MSBs : std_logic_vector(3 downto 0);
--    variable LSBs : std_logic_vector(3 downto 0);
        begin
            if ( Clk 'event and Clk= '1' ) then
--                MSBs := byte_in(7 downto 4);
--                LSBs := byte_in(3 downto 0);
                byte_out(3 downto 0) <= byte_in(7 downto 4);
                byte_out(7 downto 4) <= byte_in(3 downto 0);
            end if;
        end process;

end Behavioral;
