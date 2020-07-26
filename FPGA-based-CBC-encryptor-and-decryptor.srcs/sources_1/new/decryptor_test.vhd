----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2020 04:18:39 PM
-- Design Name: 
-- Module Name: decryptor_test - Behavioral
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

entity decryptor_test is
--  Port ( );
end decryptor_test;

architecture Behavioral of decryptor_test is

component decryptor is
    Port ( key_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector : in STD_LOGIC);
end component;

signal clock : STD_LOGIC := '1';
signal reset : STD_LOGIC;
signal selector : STD_LOGIC;
signal key_in : STD_LOGIC_VECTOR (7 downto 0);
signal d_in : STD_LOGIC_VECTOR (7 downto 0);
signal d_out : STD_LOGIC_VECTOR (7 downto 0);

begin

uut_1 : decryptor
    port map ( reset => reset,
               clock => clock,
               selector => selector,
               key_in => key_in,
               d_out => d_out,
               d_in => d_in);

clock <= not clock after 10ns;

stimuli : process
    begin
--        wait for 50ns;
--        key_in <= "00001111";
--        reset <= '0';
--        selector <= '0';
--        d_in <= "11100100";
--        wait for 30ns;
--        reset <= '0';
--        d_in <= "01000001";
----        wait for 20ns;
----        reset <= '1';
--        wait for 20ns;
--        d_in <= "01011010";
--        wait for 100ns;
--        selector <= '1';
--        wait;
        
        key_in <= "11011110";
        reset <= '0';
        selector <= '0';
        --wait for 20ns;
        --reset <= '0';
        d_in <= "11001100";
        wait for 20 ns;
        d_in <= "10001111";
        wait for 20ns;
        d_in <= "10011101";
        selector <= '1';
        wait for 20ns;
        d_in <= "01011110";
        wait for 20ns;
        d_in <= "01001100";
        wait for 20ns;
        d_in <= "00001111";
        wait;
    end process;

end Behavioral;
