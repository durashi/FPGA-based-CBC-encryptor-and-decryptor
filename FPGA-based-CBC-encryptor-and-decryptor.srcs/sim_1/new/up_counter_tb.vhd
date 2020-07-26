----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2020 11:55:04 PM
-- Design Name: 
-- Module Name: up_counter_tb - Behavioral
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

entity up_counter_tb is
--  Port ( );
end up_counter_tb;

architecture Behavioral of up_counter_tb is

component up_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clock : STD_LOGIC:= '1';
signal reset : STD_LOGIC;
signal counter_out : STD_LOGIC_VECTOR (7 downto 0);

begin

uut_1 : up_counter
    port map ( clock => clock,
               reset => reset,
               counter_out => counter_out);

clock <= not clock after 10ns;

stimuli : process
    begin
    reset <= '0';
    wait for 160ns;
    reset <= '1';
    wait for 10ns;
    reset <= '0';
    wait;
    end process;

end Behavioral;
