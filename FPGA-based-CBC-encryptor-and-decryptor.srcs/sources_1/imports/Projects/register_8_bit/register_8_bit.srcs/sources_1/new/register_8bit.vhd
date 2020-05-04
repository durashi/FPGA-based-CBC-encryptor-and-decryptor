----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 10:34:59 PM
-- Design Name: 
-- Module Name: register_8bit - Behavioral
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

entity register_8bit is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC);
end register_8bit;

architecture Behavioral of register_8bit is

component d_flipflop
    port(data_in : in std_logic;
         clk : in std_logic;
         data_out : out std_logic);
    end component;

begin
d_flipflop_0 : d_flipflop
    port map (data_in => data_in(0),
              data_out => data_out(0),
              clk => clk);
              
d_flipflop_1 : d_flipflop
    port map (data_in => data_in(1),
              data_out => data_out(1),
              clk => clk);
              
d_flipflop_2 : d_flipflop
    port map (data_in => data_in(2),
              data_out => data_out(2),
              clk => clk);
              
d_flipflop_3 : d_flipflop
    port map (data_in => data_in(3),
              data_out => data_out(3),
              clk => clk);
              
d_flipflop_4 : d_flipflop
    port map (data_in => data_in(4),
              data_out => data_out(4),
              clk => clk);
              
d_flipflop_5 : d_flipflop
    port map (data_in => data_in(5),
              data_out => data_out(5),
              clk => clk);
              
d_flipflop_6 : d_flipflop
    port map (data_in => data_in(6),
              data_out => data_out(6),
              clk => clk);
              
d_flipflop_7 : d_flipflop
    port map (data_in => data_in(7),
              data_out => data_out(7),
              clk => clk);

end Behavioral;
