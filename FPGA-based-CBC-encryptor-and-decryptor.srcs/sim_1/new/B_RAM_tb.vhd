library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity B_RAM_wrapper_tb is
end;

architecture bench of B_RAM_wrapper_tb is

  component B_RAM_wrapper
    port (
      BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
      BRAM_PORTA_0_clk : in STD_LOGIC;
      BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_en : in STD_LOGIC;
      BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 0 to 0 )
    );
  end component;

  signal BRAM_PORTA_0_addr: STD_LOGIC_VECTOR ( 12 downto 0 );
  signal BRAM_PORTA_0_clk: STD_LOGIC := '0';
  signal BRAM_PORTA_0_din: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_dout: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_en: STD_LOGIC;
  signal BRAM_PORTA_0_we: STD_LOGIC_VECTOR ( 0 to 0 ) ;

begin

  uut: B_RAM_wrapper port map ( BRAM_PORTA_0_addr => BRAM_PORTA_0_addr,
                                BRAM_PORTA_0_clk  => BRAM_PORTA_0_clk,
                                BRAM_PORTA_0_din  => BRAM_PORTA_0_din,
                                BRAM_PORTA_0_dout => BRAM_PORTA_0_dout,
                                BRAM_PORTA_0_en   => BRAM_PORTA_0_en,
                                BRAM_PORTA_0_we   => BRAM_PORTA_0_we );

    
  BRAM_PORTA_0_clk <= not BRAM_PORTA_0_clk after 10ns;
  stimulus: process
  begin
  
    -- Put initialisation code here
    BRAM_PORTA_0_addr <= "0000000001111";
    BRAM_PORTA_0_din <= "01010101";
    BRAM_PORTA_0_en <= '1';
    BRAM_PORTA_0_we <= "1";
    wait for 90ns;
    
    BRAM_PORTA_0_addr <= "0000000001111";
    BRAM_PORTA_0_din <= "10101010";
    BRAM_PORTA_0_en <= '1';
    BRAM_PORTA_0_we <= "1";
    wait for 90ns;
    
    BRAM_PORTA_0_addr <= "0000000001111";
    BRAM_PORTA_0_din <= "00001111";
    BRAM_PORTA_0_en <= '1';
    BRAM_PORTA_0_we <= "1";
    wait for 90ns;
    
    BRAM_PORTA_0_addr <= "0000000001111";
    BRAM_PORTA_0_din <= "11110000";
    BRAM_PORTA_0_en <= '1';
    BRAM_PORTA_0_we <= "1";

    -- Put test bench stimulus code here

    wait;
  end process;


end;