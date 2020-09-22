----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2020 09:47:03 PM
-- Design Name: 
-- Module Name: BRAM_with_ENCRYPTOR - Behavioral
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
-- This is a test module for chech the functionality of the Encrypter with Dual port BRAM.
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

entity BRAM_with_ENCRYPTOR is
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
end BRAM_with_ENCRYPTOR;

architecture Behavioral of BRAM_with_ENCRYPTOR is

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

component multi_4_to_1 is
    Port ( a_in : in STD_LOGIC_VECTOR (7 downto 0);
           b_in : in STD_LOGIC_VECTOR (7 downto 0);
           c_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
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

signal port_a_clk : STD_LOGIC;
signal port_a_addr : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal port_a_read_enable : STD_LOGIC;
signal port_a_write_enable : STD_LOGIC_VECTOR (0 downto 0);

signal port_b_clk : STD_LOGIC;
signal port_b_addr : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_data_in : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_data_out : STD_LOGIC_VECTOR (7 downto 0);
signal port_b_read_enable : STD_LOGIC;
signal port_b_write_enable : STD_LOGIC_VECTOR (0 downto 0);

signal mode_selector : STD_LOGIC_VECTOR (1 downto 0);

signal multi_R_a : STD_LOGIC_VECTOR (7 downto 0);
signal multi_R_c : STD_LOGIC_VECTOR (7 downto 0);

signal multi_W_a : STD_LOGIC_VECTOR (7 downto 0);
signal multi_W_c : STD_LOGIC_VECTOR (7 downto 0);

signal enc_read_enable : STD_LOGIC;

signal enc_write_enable : STD_LOGIC;

begin

dual_RAM: Dual_B_RAM_wrapper port map ( BRAM_PORTA_0_addr => port_a_addr,
                                        BRAM_PORTA_0_clk  => port_a_clk,
                                        BRAM_PORTA_0_din  => port_a_data_in,
                                        BRAM_PORTA_0_dout => port_a_data_out,
                                        BRAM_PORTA_0_en   => '1',
                                        BRAM_PORTA_0_we   => port_a_write_enable,
                                        BRAM_PORTB_0_addr => port_b_addr,
                                        BRAM_PORTB_0_clk  => port_b_clk,
                                        BRAM_PORTB_0_din  => port_b_data_in,
                                        BRAM_PORTB_0_dout => port_b_data_out,
                                        BRAM_PORTB_0_en   => '1',
                                        BRAM_PORTB_0_we(0)   => enc_write_enable );

encrypt_hndlr : encrypt_handler
    port map ( data_in => port_a_data_out,
               data_out => port_b_data_in,
               addr_to_read => multi_R_a,
               addr_to_write => port_b_addr,
               key => key_in, --
               read_enable => enc_read_enable,
               write_enable => enc_write_enable,
               enable => encrypt, --
               clock => clock); --

multi_read_write : multi_4_to_1
    port map ( a_in => addr_out,
               b_in => addr_in,
               c_in => multi_R_a,
               d_in => "00000000",
               data_out => port_a_addr,
               selector => mode_selector);
               
--or_gate_we_a : or_gate
--    port map ( a => enc_read_enable,
--               b => write,
--               F => port_a_read_enable);
               
--or_gate_we_b : or_gate
--    port map ( a => enc_read_enable,
--               b => write,
--               F => port_b_read_enable);

port_a_clk <= clock;
port_b_clk <= clock;
--port_a_addr <= addr_in;
--port_b_addr <= addr_out;
port_a_data_in <= data_in;
data_out <= port_a_data_out;
mode_selector(0) <= read;
mode_selector(1) <= write;
port_a_write_enable(0) <= write;
multi_data_out <= port_a_addr;
end Behavioral;
