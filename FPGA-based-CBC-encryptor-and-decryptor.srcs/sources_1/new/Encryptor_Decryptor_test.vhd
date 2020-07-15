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

entity Encryptor_Decryptor_test is
--  Port ( );
end Encryptor_Decryptor_test;

architecture Behavioral of Encryptor_Decryptor_test is

component Encrypter_Decrypter is
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

uut_1 : Encrypter_Decrypter
    port map ( reset => reset,
               clock => clock,
               selector_mul => selector_mul,
               key_in => key_in,
               d_out => d_out,
               d_in => d_in);

clock <= not clock after 10ns;

stimuli : process
    begin
        key_in <= "00001111";
        reset <= '1';
        selector_mul <= '0';
        d_in <= "01010101";
        wait for 30ns;
        reset <= '0';
        d_in <= "01000001";
--        wait for 20ns;
--        reset <= '1';
        wait for 20ns;
        d_in <= "01111101";
        wait;
    end process;
    
end Behavioral;
