----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 10:53:20 PM
-- Design Name: 
-- Module Name: UART_TX_handeller - Behavioral
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

entity UART_TX_handeller is
    Port ( TX_DV : in STD_LOGIC;
           TX_Byte : in STD_LOGIC_VECTOR (7 downto 0);
           TX_Active : out STD_LOGIC;
           TX_Serial : out STD_LOGIC;
           TX_Done : out STD_LOGIC;
           addr_to_read : out STD_LOGIC_VECTOR (7 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end UART_TX_handeller;

architecture Behavioral of UART_TX_handeller is

component UART_TX is
  generic (
    g_CLKS_PER_BIT : integer := 217     
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end component;

component down_counter_uart is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal en : std_logic;

begin

uart_tx_module: UART_TX
    port map (i_Clk => clock,
              i_TX_DV => TX_DV,
              i_TX_Byte => TX_Byte,
              o_TX_Active => TX_Active,
              o_TX_Serial => TX_Serial,
              o_TX_Done => en);
              
down_counter : down_counter_uart
    port map (clock => clock,
              enable => en,
              reset => reset,
              counter_out => addr_to_read);

TX_Done <= en;
end Behavioral;
