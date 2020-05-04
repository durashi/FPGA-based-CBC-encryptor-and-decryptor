----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 10:34:59 PM
-- Design Name: 
-- Module Name: d_flipflop - Behavioral
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

entity d_flipflop is
    Port ( data_in : in STD_LOGIC;
           data_out : out STD_LOGIC;
           clk : in STD_LOGIC);
end d_flipflop;

architecture Behavioral of d_flipflop is

component nand_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
    end component;

component not_gate
    port(a : in std_logic;
         b : out std_logic);
    end component;

signal l : std_logic;
signal m : std_logic;
signal n : std_logic;
signal o : std_logic;
signal p : std_logic;

begin
nand_1 : nand_gate
    port map (a => data_in,
              b => clk,
              F => m);

nand_2 : nand_gate
    port map (a => l,
              b => clk,
              F => n);
              
nand_3 : nand_gate
    port map (a => m,
              b => p,
              F => o);
              
nand_4 : nand_gate
    port map (a => o,
              b => n,
              F => p);
              
--nand_5 : nand_gate
--    port map (a => o,
--              b => o,
--              F => data_out);
        
not_1 : not_gate
    port map(a => data_in,
             b => l);

data_out <= o;

end Behavioral;
