----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2020 04:44:18 PM
-- Design Name: 
-- Module Name: CYPHER_SYSTEM - Behavioral
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

entity CYPHER_SYSTEM is
    Port ( clock : in STD_LOGIC;
           Encrypt : in STD_LOGIC;
           Decrypt : in STD_LOGIC;
           uart_rx_rst : in STD_LOGIC;
           uart_tx_rst : in STD_LOGIC;
           rx_serial : in STD_LOGIC;
           tx_serial : out STD_LOGIC;
           tx_done : out STD_LOGIC;
           key_in : in STD_LOGIC_VECTOR (7 downto 0));
end CYPHER_SYSTEM;

architecture Behavioral of CYPHER_SYSTEM is

component encrypt_handler is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_read : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (7 downto 0);
           key : in STD_LOGIC_VECTOR (7 downto 0);
           read_enable : out STD_LOGIC;
           write_enable : out STD_LOGIC;
           enable : in STD_LOGIC;
           --reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component decrypt_handler is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_read : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (7 downto 0);
           key : in STD_LOGIC_VECTOR (7 downto 0);
           read_enable : out STD_LOGIC;
           write_enable : out STD_LOGIC;
           enable : in STD_LOGIC;
           --reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component UART_RX_handeller is
    Port ( rx_serial : in STD_LOGIC;
           rx_enable : out STD_LOGIC;
           rx_byte : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (7 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component UART_TX_handeller is
    Port ( TX_DV : in STD_LOGIC;
           TX_Byte : in STD_LOGIC_VECTOR (7 downto 0);
           TX_Active : out STD_LOGIC;
           TX_Serial : out STD_LOGIC;
           TX_Done : out STD_LOGIC;
           addr_to_read : out STD_LOGIC_VECTOR (7 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component multi_4_to_1 is
    Port ( a_in : in STD_LOGIC_VECTOR (7 downto 0);
           b_in : in STD_LOGIC_VECTOR (7 downto 0);
           c_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC_VECTOR (1 downto 0));
end component;

component multi_4_to_1_1bit is
    Port ( a_in : in STD_LOGIC;
           b_in : in STD_LOGIC;
           c_in : in STD_LOGIC;
           d_in : in STD_LOGIC;
           data_out : out STD_LOGIC;
           selector : in STD_LOGIC_VECTOR (1 downto 0));
end component;

component Dual_B_RAM_wrapper
    port (
      BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_clk : in STD_LOGIC;
      BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_en : in STD_LOGIC;
      BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 );
      BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTB_0_clk : in STD_LOGIC;
      BRAM_PORTB_0_din : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTB_0_en : in STD_LOGIC;
      BRAM_PORTB_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
    );
  end component;

component or_gate is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           F : out STD_LOGIC);
end component;

-------------------------------------------------------------------------
signal common_clock : STD_LOGIC;

signal port_a_addr : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_read_enable : STD_LOGIC;
signal port_a_write_enable : STD_LOGIC_VECTOR (0 downto 0);

signal port_b_addr : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_read_enable : STD_LOGIC;
signal port_b_write_enable : STD_LOGIC_VECTOR (0 downto 0);

signal mode_selector : STD_LOGIC_VECTOR (1 downto 0);

signal enc_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal enc_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal enc_address_to_read : STD_LOGIC_VECTOR (7 downto 0);
signal enc_address_to_write : STD_LOGIC_VECTOR (7 downto 0);
signal enc_read_enable : STD_LOGIC;
signal enc_write_enable : STD_LOGIC;

signal dec_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal dec_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal dec_address_to_read : STD_LOGIC_VECTOR (7 downto 0);
signal dec_address_to_write : STD_LOGIC_VECTOR (7 downto 0);
signal dec_read_enable : STD_LOGIC;
signal dec_write_enable : STD_LOGIC;

signal uart_rx_enable : STD_LOGIC;
signal uart_rx_byte : STD_LOGIC_VECTOR (7 downto 0);
signal uart_rx_addr : STD_LOGIC_VECTOR (7 downto 0);

signal uart_tx_enable : STD_LOGIC;
signal uart_tx_byte : STD_LOGIC_VECTOR (7 downto 0);
signal uart_tx_addr : STD_LOGIC_VECTOR (7 downto 0);

begin

dual_RAM: Dual_B_RAM_wrapper port map ( BRAM_PORTA_0_addr => port_b_addr,
                                     BRAM_PORTA_0_clk  => common_clock,
                                     BRAM_PORTA_0_din  => port_a_data_in,
                                     BRAM_PORTA_0_dout => port_a_data_out,
                                     BRAM_PORTA_0_en   => port_a_read_enable,
                                     BRAM_PORTA_0_we   => port_a_write_enable,
                                     BRAM_PORTB_0_addr => port_b_addr,
                                     BRAM_PORTB_0_clk  => common_clock,
                                     BRAM_PORTB_0_din  => port_b_data_in,
                                     BRAM_PORTB_0_dout => port_b_data_out,
                                     BRAM_PORTB_0_en   => port_b_read_enable,
                                     BRAM_PORTB_0_we   => port_b_write_enable );

uart_rx_module: UART_RX_handeller
    port map ( rx_serial => rx_serial,
               rx_enable => uart_rx_enable,
               rx_byte => uart_rx_byte,
               addr_to_write => uart_rx_addr,
               reset => uart_rx_rst,
               clock => clock);

uart_tx_module: UART_TX_handeller
    port map ( TX_DV => in STD_LOGIC,
               TX_Byte => port_b_data_out,
               TX_Active => uart_tx_enable,
               TX_Serial => tx_serial,
               TX_Done => tx_done,
               addr_to_read => uart_tx_addr,       
               reset => uart_tx_rst,
               clock => clock);
           
encrypt_hndlr : encrypt_handler
    port map ( data_in => enc_data_in,
               data_out => enc_data_out,
               addr_to_read => enc_address_to_read,
               addr_to_write => enc_address_to_write,
               key => key_in,
               read_enable => enc_read_enable,
               write_enable => enc_write_enable,
               enable => Encrypt,
               clock => clock);

decrypt_hndlr : decrypt_handler
    port map ( data_in => dec_data_in,
               data_out => dec_data_out,
               addr_to_read => dec_address_to_read,
               addr_to_write => dec_address_to_write,
               key => key_in,
               read_enable => dec_read_enable,
               write_enable => dec_write_enable,
               enable => Decrypt,
               clock => clock);
           
multi_rx : multi_4_to_1
    port map ( a_in => enc_address_to_read,
               b_in => dec_address_to_read,
               c_in => uart_rx_addr,
               d_in => "00000000",
               data_out => port_a_addr,
               selector => mode_selector);

multi_tx : multi_4_to_1
    port map ( a_in => enc_address_to_write,
               b_in => dec_address_to_write,
               c_in => uart_tx_addr,
               d_in => "00000000",
               data_out => port_b_addr,
               selector => mode_selector);

multi_rx_1_bit : multi_4_to_1_1bit
    port map ( a_in => enc_read_enable,
               b_in => dec_read_enable,
               c_in => uart_rx_enable,
               d_in => '0',
               data_out => port_a_read_enable,
               selector => mode_selector);

multi_tx_1_bit : multi_4_to_1_1bit
    port map ( a_in => enc_write_enable,
               b_in => dec_write_enable,
               c_in => uart_tx_enable,
               d_in => '0',
               data_out => port_a_read_enable,
               selector => mode_selector);

we_or:  or_gate
    port map ( a => enc_write_enable,
               b => dec_write_enable,
               F => port_b_write_enable(0));

port_a_write_enable(0) <= uart_rx_enable;
mode_selector(0) <= Encrypt;
mode_selector(1) <= Decrypt;

end Behavioral;
