----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 05:43:53 PM
-- Design Name: 
-- Module Name: Dual_B_RAM_tb - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Dual_B_RAM_wrapper_tb is
end;

architecture bench of Dual_B_RAM_wrapper_tb is

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

  signal BRAM_PORTA_0_addr: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_clk: STD_LOGIC := '1';
  signal BRAM_PORTA_0_din: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_dout: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_en: STD_LOGIC;
  signal BRAM_PORTA_0_we: STD_LOGIC_VECTOR ( 0 to 0 );
  signal BRAM_PORTB_0_addr: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTB_0_clk: STD_LOGIC := '1';
  signal BRAM_PORTB_0_din: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTB_0_dout: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTB_0_en: STD_LOGIC;
  signal BRAM_PORTB_0_we: STD_LOGIC_VECTOR ( 0 to 0 ) ;

begin

  uut: Dual_B_RAM_wrapper port map ( BRAM_PORTA_0_addr => BRAM_PORTA_0_addr,
                                     BRAM_PORTA_0_clk  => BRAM_PORTA_0_clk,
                                     BRAM_PORTA_0_din  => BRAM_PORTA_0_din,
                                     BRAM_PORTA_0_dout => BRAM_PORTA_0_dout,
                                     BRAM_PORTA_0_en   => BRAM_PORTA_0_en,
                                     BRAM_PORTA_0_we   => BRAM_PORTA_0_we,
                                     BRAM_PORTB_0_addr => BRAM_PORTB_0_addr,
                                     BRAM_PORTB_0_clk  => BRAM_PORTB_0_clk,
                                     BRAM_PORTB_0_din  => BRAM_PORTB_0_din,
                                     BRAM_PORTB_0_dout => BRAM_PORTB_0_dout,
                                     BRAM_PORTB_0_en   => BRAM_PORTB_0_en,
                                     BRAM_PORTB_0_we   => BRAM_PORTB_0_we );

BRAM_PORTA_0_clk <= not BRAM_PORTA_0_clk after 10ns;
BRAM_PORTB_0_clk <= not BRAM_PORTB_0_clk after 10ns;

  stimulus: process
  begin
  
    -- Put initialisation code here
    BRAM_PORTB_0_addr <= "00000000";
    BRAM_PORTB_0_din <= "00000000";
    BRAM_PORTB_0_en <= '0';
    BRAM_PORTB_0_we <= "0";
    
    BRAM_PORTA_0_en <= '1';
    BRAM_PORTA_0_we <= "1";
    BRAM_PORTA_0_addr <= "00000000";
    BRAM_PORTA_0_din <= X"11";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000001";
    BRAM_PORTA_0_din <= X"22";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000010";
    BRAM_PORTA_0_din <= X"a3";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000011";
    BRAM_PORTA_0_din <= X"a9";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000100";
    BRAM_PORTA_0_din <= X"fc";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000101";
    BRAM_PORTA_0_din <= X"be";
    wait for 20 ns;
    
    BRAM_PORTA_0_addr <= "00000110";
    BRAM_PORTA_0_din <= X"56";
    wait for 20 ns;
    
    --#############################################
    BRAM_PORTB_0_en <= '1';
    BRAM_PORTB_0_we <= "0";
    
    BRAM_PORTA_0_en <= '0';
    BRAM_PORTA_0_we <= "0";
    
    BRAM_PORTB_0_addr <= "00000000";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000001";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000010";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000011";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000100";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000101";
    wait for 20 ns;
    
    BRAM_PORTB_0_addr <= "00000110";
    --wait for 20 ns;
    
    -- Put test bench stimulus code here

    wait;
  end process;


end;
