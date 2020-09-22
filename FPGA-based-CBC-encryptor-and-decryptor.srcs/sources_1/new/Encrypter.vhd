----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2020 11:54:44 PM
-- Design Name: 
-- Module Name: Encrypter - Behavioral
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
-- This is the basic decryptor module. This module can encrypt input data with the key
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

entity Encrypter is
    Port ( key_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector_mul : in STD_LOGIC);
end Encrypter;

architecture Behavioral of Encrypter is

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

signal input_xor_a : STD_LOGIC_VECTOR (7 downto 0);
signal input_xor_b : STD_LOGIC_VECTOR (7 downto 0);
signal output_xor : STD_LOGIC_VECTOR (7 downto 0);
signal xor_bit_swapper : STD_LOGIC_VECTOR (7 downto 0);
signal bit_swapper_output : STD_LOGIC_VECTOR (7 downto 0);
--signal output_reg_out : STD_LOGIC_VECTOR (7 downto 0);

begin

input_register : register_8bit
    Port map ( data_in => d_in,
               data_out => input_xor_a,
               clk  => clock,
               reset => reset);

--output_register : register_8bit
--    Port map ( data_in => bit_swapper_output,
--               data_out => output_reg_out,
--               clk  => clock,
--               reset => reset);

xor_gate : xor_gate_8_bit
    port map (a => input_xor_a,
              b => input_xor_b,
              F => xor_bit_swapper);

--bit_swap : bit_swapper
--    port map (byte_in => xor_bit_swapper,
--              Clk => clock,
--              byte_out => bit_swapper_output);

bit_swap : bit_swapper
    port map (byte_in => xor_bit_swapper,
              Clk => clock,
              byte_out => bit_swapper_output);

multi_2_to_1 : multiplexer_2_way
    port map ( a_in => key_in,
               b_in => bit_swapper_output,
               data_out => input_xor_b,
               selector => selector_mul);

--d_out <= output_reg_out;
d_out <= bit_swapper_output;
end Behavioral;
