----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2020 12:23:02 AM
-- Design Name: 
-- Module Name: bit_swapper_test - Behavioral
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

entity bit_swapper_test is
--  Port ( );
end bit_swapper_test;

architecture Behavioral of bit_swapper_test is
component bit_swapper is
   Port ( byte_in : in STD_LOGIC_VECTOR (7 downto 0);
          Clk : in STD_LOGIC;  
           byte_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal byte_in : STD_LOGIC_VECTOR (7 downto 0);
signal byte_out : STD_LOGIC_VECTOR (7 downto 0);
signal Clk : STD_LOGIC;

begin
uut_1 : bit_swapper
    port map (byte_in => byte_in,
              Clk => Clk,  
              byte_out => byte_out);
              
stimuli : process
                  begin
                      Clk <= '0';
                      byte_in <= "10100110";
                      wait for 50ns; 
                      Clk <= '1';
                      byte_in <= "10100110";
                      wait for 50ns; 
                      Clk <= '0';
                      byte_in <= "00001111";
                      wait for 50ns; 
                      Clk <= '1';     
                      byte_in <= "00001111";                
                      wait;
                  end process;

end Behavioral;
