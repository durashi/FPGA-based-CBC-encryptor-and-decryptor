----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 12:28:26 AM
-- Design Name: 
-- Module Name: UART_handler_TB - Behavioral
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

entity UART_handler_TB is
--  Port ( );
end UART_handler_TB;

architecture Behavioral of UART_handler_TB is
    
  constant c_CLK_PERIOD : time := 40 ns;
    
  signal clock     : std_logic                    := '0';
  signal r_TX_DV     : std_logic                    := '0';
  signal r_TX_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_TX_Serial : std_logic;
  signal w_TX_Done   : std_logic;
  signal w_TX_Active : std_logic;
  signal w_RX_DV     : std_logic;
  signal w_RX_Byte   : std_logic_vector(7 downto 0);
  signal r_RX_Serial : std_logic := '1';
  signal w_UART_Data : std_logic;
  signal addr_to_read   : std_logic_vector(7 downto 0);
  signal addr_to_write   : std_logic_vector(7 downto 0);
  signal reset : std_logic;
  
begin
UART_TX_handler_INST : entity work.UART_TX_handeller
    port map (
      TX_DV       => r_TX_DV,
      TX_Byte     => r_TX_Byte,
      TX_Active   => w_TX_Active,
      TX_Serial   => w_TX_Serial,
      TX_Done     => w_TX_Done,
      addr_to_read => addr_to_read,
      reset => reset,
      clock   => clock
      );
 
  -- Instantiate UART Receiver
UART_RX_handler_INST : entity work.UART_RX_handeller
    port map (
      rx_serial   => w_UART_Data,
      rx_enable => w_RX_DV,
      rx_byte     => w_RX_Byte,
      addr_to_write   => addr_to_write,
      reset => reset,
      clock     => clock
      );

w_UART_Data <= w_TX_Serial when w_TX_Active = '1' else '1';
r_RX_Serial <= w_UART_Data; 
clock <= not clock after c_CLK_PERIOD/2;

process is
  begin
  
    -- Tell the UART to send a command.
    reset <= '0';
    wait until rising_edge(clock);
    r_TX_DV   <= '1';
    r_TX_Byte <= X"ab";
    wait until rising_edge(clock);
    r_TX_DV   <= '0';
    wait for 100us;
    r_TX_DV   <= '1';
    r_TX_Byte <= X"37";
    wait until rising_edge(clock);
    r_TX_DV   <= '0';    
    wait for 100us;
    r_TX_DV   <= '1';
    r_TX_Byte <= X"13";
    wait until rising_edge(clock);
    r_TX_DV   <= '0'; 
    wait for 100us;   
    r_TX_DV   <= '1';
    r_TX_Byte <= X"ab";
    wait until rising_edge(clock);
    r_TX_DV   <= '0';
    
    -- Check that corrrect byte was received
--    wait until rising_edge(w_RX_DV);
    
--    -- Check that the correct command was received
--    if w_RX_Byte = X"37" then
--      report "Test Passed - Correct Byte Received" severity note;
--    else
--      report "Test Failed - Incorrect Byte Received" severity note;
--    end if;
 
--    assert false report "Tests Complete" severity failure;
     
  end process;
  
  
end Behavioral;
