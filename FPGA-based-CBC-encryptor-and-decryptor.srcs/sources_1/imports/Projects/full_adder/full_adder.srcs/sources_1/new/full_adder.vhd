----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 08:21:09 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           s : out STD_LOGIC;
           c_out : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

component and_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
    end component;

component or_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
    end component;
    
component xor_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
    end component;

signal l : std_logic;
signal m : std_logic;
signal n : std_logic;
signal o : std_logic;

begin

and_1 : and_gate
    port map (a => l,
              b => c_in,
              F => n);
              
and_2 : and_gate
    port map (a => a,
              b => b,
              F => o);
              
xor_1 : xor_gate
    port map (a => a,
              b => b,
              F => l);
              
xor_2 : xor_gate
    port map (a => l,
              b => c_in,
              F => s);

or_1 : or_gate
    port map (a => n,
              b => o,
              F => c_out);

end Behavioral;
