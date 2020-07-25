----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2020 07:04:42 PM
-- Design Name: 
-- Module Name: Encryptor_Decryptor_test - Behavioral
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

entity Encryptor_test is
--  Port ( );
end Encryptor_test;

architecture Behavioral of Encryptor_test is

component Encrypter is
    Port ( key_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector_mul : in STD_LOGIC);
end component;

signal clock : STD_LOGIC := '0';
signal reset : STD_LOGIC;
signal selector_mul : STD_LOGIC;
signal key_in : STD_LOGIC_VECTOR (7 downto 0);
signal d_in : STD_LOGIC_VECTOR (7 downto 0);
signal d_out : STD_LOGIC_VECTOR (7 downto 0);

begin

uut_1 : Encrypter
    port map ( reset => reset,
               clock => clock,
               selector_mul => selector_mul,
               key_in => key_in,
               d_out => d_out,
               d_in => d_in);

clock <= not clock after 10ns;

stimuli : process
    begin
        key_in <= "11011110";
        reset <= '0';
        selector_mul <= '0';
        d_in <= "00010010";
        wait for 20 ns;
        d_in <= "00110100";
        wait for 10ns;
        selector_mul <= '1';
        wait for 10ns;
        d_in <= "01010110";
        wait for 20ns;
        d_in <= "01111000";
        wait for 20ns;
        d_in <= "10011010";
        wait for 20ns;
        d_in <= "10111100";
        wait;
    end process;
    
end Behavioral;
