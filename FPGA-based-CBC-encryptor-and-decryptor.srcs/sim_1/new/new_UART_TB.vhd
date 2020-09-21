----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2020 06:03:08 PM
-- Design Name: 
-- Module Name: new_UART_TB - Behavioral
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

entity new_UART_TB is
--  Port ( );
end new_UART_TB;

architecture Behavioral of new_UART_TB is

component UART_TX_CTRL is
    Port ( SEND : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           UART_TX : out  STD_LOGIC);
end component;

signal SEND :  STD_LOGIC;
signal DATA :  STD_LOGIC_VECTOR (7 downto 0);
signal CLK :  STD_LOGIC:= '0';
signal READY : STD_LOGIC;
signal UART_TX : STD_LOGIC;

begin

uut_1 : UART_TX_CTRL
    port map ( CLK => CLK,
               SEND => SEND,
               DATA => DATA,
               READY => READY,
               UART_TX => UART_TX);

CLK <= not CLK after 10ns;

stimuli : process
    begin
    SEND <= '0';
    DATA <= "11000111";
    
    wait for 400ns;
    SEND <= '1';
    
    wait for 100000ns;
    SEND <= '0';
    
    end process;

end Behavioral;
