----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2020 11:14:38 PM
-- Design Name: 
-- Module Name: register_8bit_test - Behavioral
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

entity register_8bit_test is
--  Port ( );
end register_8bit_test;

architecture Behavioral of register_8bit_test is

component register_8bit is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk, reset : in STD_LOGIC);
end component;

signal d_in : STD_LOGIC_VECTOR (7 downto 0);
signal d_out : STD_LOGIC_VECTOR (7 downto 0);
signal clock : STD_LOGIC;
signal rst : STD_LOGIC;

begin
uut_1 : register_8bit
    port map (data_in => d_in,
              clk => clock,  
              data_out => d_out,
              reset => rst);

stimuli : process
                  begin
                      clock <= '0';
                      rst <= '0';
                      d_in <= "10100110";
                      wait for 50ns; 
                      clock <= '1';
                      d_in <= "10100110";
                      wait for 50ns; 
                      clock <= '0';
                      d_in <= "00001111";
                      wait for 50ns; 
                      clock <= '1';     
                      d_in <= "00001111";
                      wait for 50ns; 
                      clock <= '0';     
                      d_in <= "10101010";
                      wait for 50ns; 
                      clock <= '1';     
                      d_in <= "10101010";
                      wait for 50ns; 
                      clock <= '0';     
                      d_in <= "10101000";
                      wait for 50ns; 
                      clock <= '1'; 
                      rst <= '1';    
                      d_in <= "10101000";
                      wait;
                  end process;

end Behavioral;
