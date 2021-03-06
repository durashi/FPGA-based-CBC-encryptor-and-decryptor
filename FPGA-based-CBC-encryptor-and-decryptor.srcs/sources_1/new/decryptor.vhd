----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2020 02:26:00 AM
-- Design Name: 
-- Module Name: decryptor - Behavioral
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
-- This is the basic decryptor module. This module can decrypt input data with the key
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

entity decryptor is
    Port ( d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           key_in : in STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector : in STD_LOGIC);
end decryptor;

architecture Behavioral of decryptor is

-- XOR gate is used for xor input data with the key
component xor_gate_8_bit
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           F : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- register is used for store temporary data
component register_8bit
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk, reset : in STD_LOGIC);
end component;

-- Bit swapper swaps the two nibbles of the data byte
component bit_swapper
    Port ( byte_in : in STD_LOGIC_VECTOR (7 downto 0);
            Clk : in STD_LOGIC;
            byte_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Multiplexer is used for select key or previousely decrypted data
component multiplexer_2_way
    Port ( a_in : in STD_LOGIC_VECTOR (7 downto 0);
           b_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC);
end component;

component not_gate
    Port ( a : in STD_LOGIC;
           b : out STD_LOGIC);
end component;

signal not_data_reg : STD_LOGIC;
signal input_a_b : STD_LOGIC_VECTOR (7 downto 0);
signal input_b_c : STD_LOGIC_VECTOR (7 downto 0);
signal input_xor_a : STD_LOGIC_VECTOR (7 downto 0);
signal input_xor_b : STD_LOGIC_VECTOR (7 downto 0);
signal output_xor : STD_LOGIC_VECTOR (7 downto 0);
signal xor_bit_swapper : STD_LOGIC_VECTOR (7 downto 0);
signal bit_swapper_output : STD_LOGIC_VECTOR (7 downto 0);
signal output_reg_out : STD_LOGIC_VECTOR (7 downto 0);

begin

not_clock : not_gate
    Port map ( a => clock,
               b => not_data_reg);

input_register_a : register_8bit
    Port map ( data_in => d_in,
               data_out => input_a_b,
               clk  => clock,
               reset => reset);
               
input_register_b : register_8bit
    Port map ( data_in => input_a_b,
               data_out => input_b_c,
               clk  => not_data_reg,
               reset => reset);

input_register_c : register_8bit
    Port map ( data_in => input_b_c,
               data_out => xor_bit_swapper,
               clk  => clock,
               reset => reset);

--output_register : register_8bit
--    Port map ( data_in => output_xor,
--               data_out => output_reg_out,
--               clk  => clock,
--               reset => reset);

xor_gate : xor_gate_8_bit
    port map (a => bit_swapper_output,
              b => input_xor_b,
              F => output_xor);

bit_swap : bit_swapper
    port map (byte_in => d_in,
              Clk => clock,
              byte_out => bit_swapper_output);

multi_2_to_1 : multiplexer_2_way
    port map ( a_in => key_in,
               b_in => xor_bit_swapper,
               data_out => input_xor_b,
               selector => selector);

d_out <= output_xor;

end Behavioral;
