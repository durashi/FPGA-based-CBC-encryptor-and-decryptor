----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 02:17:41 PM
-- Design Name: 
-- Module Name: count_129_tb - Behavioral
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

entity count_129_tb is
--  Port ( );
end count_129_tb;

architecture Behavioral of count_129_tb is

component count_129 is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           enable_signal : out STD_LOGIC);
end component;

signal clock : STD_LOGIC:= '1';
signal enable : STD_LOGIC;
signal enable_signal : STD_LOGIC;

begin

uut_1 : count_129
    port map ( clock => clock,
               enable => enable,
               enable_signal => enable_signal);

clock <= not clock after 10ns;

stimuli : process
    begin
    enable <= '0';
    wait for 40ns;
    enable <= '1';
    wait for 40ns;
    enable <= '0';
    wait for 40ns;
    enable <= '1';
    wait for 3000ns;
    enable <= '0';
    wait for 400ns;
    enable <= '1';
    wait;
    end process;

end Behavioral;
