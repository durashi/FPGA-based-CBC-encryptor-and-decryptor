----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 10:34:59 PM
-- Design Name: 
-- Module Name: nand_gate - Behavioral
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

entity nand_gate is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           F : out STD_LOGIC);
end nand_gate;

architecture Behavioral of nand_gate is

component and_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
    end component;
    
component not_gate
    port(a : in std_logic;
         b : out std_logic);
    end component;

signal m : std_logic;

begin
and_1 : and_gate
    port map (a => A,
              b => B,
              F => m);
              
not_1 : not_gate
    port map(a => m,
             b => F);

end Behavioral;
