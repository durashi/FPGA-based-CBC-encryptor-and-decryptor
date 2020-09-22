----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 12:55:40 AM
-- Design Name: 
-- Module Name: decrypt_handler - Behavioral
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
-- This module is responsble for control the decrypt module properly with controling input and output signals.
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

entity decrypt_handler is
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
end decrypt_handler;

architecture Behavioral of decrypt_handler is

-- basic decryptor module.
component decryptor is
    Port ( key_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector : in STD_LOGIC);
end component;

-- up counter is used for selecting the proper address to read data from the block memory.
component up_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- down counter is used for selecting the propoer address to write decrypted data to the block memory.
component down_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- data register for store temporary data.
component register_8bit
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk, reset : in STD_LOGIC);
end component;

-- data flipflop for store temporary signals.
component d_flipflop is
    Port ( data_in : in STD_LOGIC;
           data_out : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end component;

component or_gate is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           F : out STD_LOGIC);
end component;

component and_gate
    port(a : in std_logic;
         b : in std_logic;
         F : out std_logic);
end component;

component not_gate
    port(a : in std_logic;
         b : out std_logic);
end component;

-- count_129 used for keep up the enable signal until operation is done.
component count_129 is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           enable_signal : out STD_LOGIC);
end component;

signal ff_c_selector : std_logic;
signal ff_a_b: std_logic;
signal ff_b_c: std_logic;
signal ff_c_d: std_logic;
signal enable_signal : std_logic;
signal clock_signal : std_logic;
signal reset_signal : std_logic;
signal down_counter_to_reg : STD_LOGIC_VECTOR (7 downto 0);
signal reg_a_b : STD_LOGIC_VECTOR (7 downto 0);
signal reg_b_c : STD_LOGIC_VECTOR (7 downto 0);

begin
decrypt_module : decryptor
    port map (key_in => key,
              d_in => data_in,
              d_out => data_out,
              clock => clock_signal,
              reset => reset_signal,
              selector => ff_c_selector);

up_count : up_counter
    port map (clock => clock_signal,
              reset => reset_signal,
              counter_out => addr_to_read);

down_count : down_counter
    port map (clock => clock_signal,
              reset => reset_signal,
              counter_out => down_counter_to_reg);

reg_a : register_8bit
    Port map ( data_in => down_counter_to_reg,
               data_out => reg_a_b,
               clk  => clock_signal,
               reset => reset_signal);
               
reg_b : register_8bit
    Port map ( data_in => reg_a_b,
               data_out => reg_b_c,
               clk  => clock_signal,
               reset => reset_signal);
               
reg_c : register_8bit
    Port map ( data_in => reg_b_c,
               data_out => addr_to_write,
               clk  => clock_signal,
               reset => reset_signal);
              
dff_a : d_flipflop
    port map (data_in => enable_signal,
              data_out => ff_a_b,
              clk => clock_signal,
              reset => reset_signal);
dff_b : d_flipflop
    port map (data_in => ff_a_b,
              data_out => ff_b_c,
              clk => clock_signal,
              reset => reset_signal);

dff_c : d_flipflop
    port map (data_in => ff_b_c,
              data_out => ff_c_d,
              clk => clock_signal,
              reset => reset_signal);
              
dff_d : d_flipflop
    port map (data_in => ff_c_d,
              data_out => ff_c_selector,
              clk => clock_signal,
              reset => reset_signal);
              
not_gate_en : not_gate
    port map (a => enable_signal,
              b => reset_signal);

and_gate_clock : and_gate
    port map(a => clock,
             b => enable_signal,
             F => clock_signal);
             
en_counter : count_129
    port map ( clock => clock,
               enable => enable,
               enable_signal => enable_signal);

read_enable <= enable_signal;
write_enable <= ff_c_d;
end Behavioral;
