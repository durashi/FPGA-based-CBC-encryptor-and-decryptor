----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2020 10:38:00 PM
-- Design Name: 
-- Module Name: BRAM_ENC_TEST - Behavioral
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

entity BRAM_ENC_TEST is
--  Port ( );
end BRAM_ENC_TEST;

architecture Behavioral of BRAM_ENC_TEST is

component BRAM_with_ENCRYPTOR is
    Port (clock : in STD_LOGIC;
          read : in STD_LOGIC;
          write : in STD_LOGIC;
          addr_in : in STD_LOGIC_VECTOR (7 downto 0);
          addr_out : in STD_LOGIC_VECTOR (7 downto 0);
          data_in : in STD_LOGIC_VECTOR (7 downto 0);
          data_out : out STD_LOGIC_VECTOR (7 downto 0);
          encrypt : in STD_LOGIC;
          key_in : in STD_LOGIC_VECTOR (7 downto 0);
          multi_data_out : out STD_LOGIC_VECTOR (7 downto 0)
          );
end component;

signal addr_in : STD_LOGIC_VECTOR (7 downto 0);
signal addr_out : STD_LOGIC_VECTOR (7 downto 0);
signal data_in : STD_LOGIC_VECTOR (7 downto 0);
signal data_out : STD_LOGIC_VECTOR (7 downto 0);
signal key_in : STD_LOGIC_VECTOR (7 downto 0);
signal clock : STD_LOGIC := '1';
signal read : STD_LOGIC;
signal write : STD_LOGIC;
signal encrypt : STD_LOGIC;
signal multi_data_out : STD_LOGIC_VECTOR (7 downto 0);

begin
uut_1 : BRAM_with_ENCRYPTOR
    port map ( clock => clock,
          read => read,
          write => write,
          addr_in => addr_in,
          addr_out => addr_out,
          data_in => data_in,
          data_out => data_out,
          multi_data_out => multi_data_out,
          encrypt => encrypt,
          key_in => key_in);

clock <= not clock after 10ns;

stimuli : process
    begin
    addr_in <= "00000000";
    addr_out <= "00000000";
    key_in <= "10101010";
    data_in <= "01000001";
    encrypt <= '0';
    read <= '0';
    write <= '1';
    
    wait for 20 ns;
    addr_in <= "00000001";
    data_in <= "00000010";
    
    wait for 20 ns;
    addr_in <= "00000010";
    data_in <= "00000010";
    
    wait for 20 ns;
    addr_in <= "00000011";
    data_in <= "00000100";
    
    wait for 20 ns;
    addr_in <= "00000100";
    data_in <= "00000100";
    
    wait for 20 ns;
    addr_in <= "00000101";
    data_in <= "00000100";
    
    wait for 20 ns;
    addr_in <= "00000110";
    data_in <= "00000100";
    
    wait for 20 ns;
    addr_in <= "00000111";
    data_in <= "00000100";
    
    wait for 20 ns;
    addr_in <= "00001000";
    data_in <= "00001000";
    
    wait for 20 ns;
    addr_in <= "00001001";
    data_in <= "00010000";
    
    wait for 20 ns;
    addr_in <= "00001010";
    data_in <= "00100000";
    
    wait for 20 ns;
    read <= '1';
    write <= '0';
    addr_out <= "00000001";
    
    wait for 20 ns;
    addr_out <= "00000010";
    
    wait for 20 ns;
    addr_out <= "00000011";
    
    wait for 20 ns;
    addr_out <= "00000100";
    
    wait for 20 ns;
    addr_out <= "00000101";
    
    wait for 60 ns;
    read <= '0';
    write <= '0';
    encrypt <= '1';
    
    wait for 300 ns;
    
    read <= '1';
    write <= '0';
    encrypt <= '0';
    addr_out <= "11111111";
    
    wait for 20 ns;
    addr_out <= "11111110";
    
    wait for 20 ns;
    addr_out <= "11111101";
    
    wait for 20 ns;
    addr_out <= "11111100";
    
    wait for 20 ns;
    addr_out <= "11111011";
    
    wait for 20 ns;
    addr_out <= "11111010";
    
    wait for 20 ns;
    addr_out <= "11111001";
    
    wait for 20 ns;
    addr_out <= "11111000";
    
    wait for 20 ns;
    addr_out <= "11110111";
    
    end process;

end Behavioral;
