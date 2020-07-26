----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 02:48:21 AM
-- Design Name: 
-- Module Name: Decryptor_hndlng_tb - Behavioral
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

entity Decryptor_hndlng_tb is
--  Port ( );
end Decryptor_hndlng_tb;

architecture Behavioral of Decryptor_hndlng_tb is

component decrypt_handler is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_read : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (7 downto 0);
           key : in STD_LOGIC_VECTOR (7 downto 0);
           read_enable : out STD_LOGIC;
           write_enable : out STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

signal data_in : STD_LOGIC_VECTOR (7 downto 0);
signal data_out : STD_LOGIC_VECTOR (7 downto 0);
signal addr_to_read : STD_LOGIC_VECTOR (7 downto 0);
signal addr_to_write : STD_LOGIC_VECTOR (7 downto 0);
signal key : STD_LOGIC_VECTOR (7 downto 0);
signal read_enable : STD_LOGIC;
signal write_enable : STD_LOGIC;
signal enable : STD_LOGIC;
signal clock : STD_LOGIC:= '1';
signal reset : STD_LOGIC;

begin
uut_1 : decrypt_handler
    port map ( data_in => data_in,
               data_out => data_out,
               addr_to_read => addr_to_read,
               addr_to_write => addr_to_write,
               key => key,
               read_enable => read_enable,
               write_enable => write_enable,
               enable => enable,
               clock => clock,
               reset => reset);

clock <= not clock after 10ns;

stimuli : process
    begin
    enable <= '0';
    reset <= '1';
    wait for 20 ns;
    key <= "11011110";
    reset <= '0';
    enable <= '1';
    data_in <= "11001100";
    wait for 20 ns;
    data_in <= "10001111";
    wait for 20ns;
    data_in <= "10011101";
    wait for 20ns;
    data_in <= "01011110";
    wait for 20ns;
    data_in <= "01001100";
    wait for 20ns;
    data_in <= "00001111";
    wait for 20ns;
    enable <= '0';
    wait;
    end process;

end Behavioral;
