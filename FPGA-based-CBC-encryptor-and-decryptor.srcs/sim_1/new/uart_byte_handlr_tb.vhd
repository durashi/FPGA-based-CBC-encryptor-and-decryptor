----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 07:58:26 PM
-- Design Name: 
-- Module Name: uart_byte_handlr_tb - Behavioral
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

entity uart_byte_handlr_tb is
--  Port ( );
end uart_byte_handlr_tb;

architecture Behavioral of uart_byte_handlr_tb is
component uatr_tx_byte_counter is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           tx_done : in STD_LOGIC;
           enable_signal : out STD_LOGIC);
end component;

signal clock : STD_LOGIC:= '1';
signal enable : STD_LOGIC:= '0' ;
signal tx_done : STD_LOGIC:= '0' ;
signal enable_signal : STD_LOGIC;

begin
uut_1 : uatr_tx_byte_counter
    port map ( clock => clock,
               enable => enable,
               tx_done => tx_done,
               enable_signal => enable_signal);

clock <= not clock after 10ns;

stimuli : process
    begin
    enable <= '0';
    wait for 40ns;
    enable <= '1';
    wait for 40ns;
    tx_done <= '1';
    wait for 40ns;
    tx_done <= '0';
    wait for 300ns;
    tx_done <= '1';
    wait for 40ns;
    tx_done <= '0';
    wait;
    end process;
end Behavioral;
