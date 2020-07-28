----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 12:55:40 AM
-- Design Name: 
-- Module Name: encrypt_handler - Behavioral
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

entity encrypt_handler is
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
end encrypt_handler;

architecture Behavioral of encrypt_handler is

component Encrypter is
    Port ( key_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_in : in STD_LOGIC_VECTOR (7 downto 0);
           d_out : out STD_LOGIC_VECTOR (7 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           selector_mul : in STD_LOGIC);
end component;

component up_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component down_counter is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component register_8bit
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk, reset : in STD_LOGIC);
end component;

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

--signal select_mul : std_logic;
signal wen_a_b : std_logic;
signal wen_b_c : std_logic;
signal wen_c_d : std_logic;
signal wen : std_logic;
signal clock_signal : std_logic;
signal reset_signal : std_logic;
signal input_a_b : STD_LOGIC_VECTOR (7 downto 0);
signal input_b_c : STD_LOGIC_VECTOR (7 downto 0);
signal input_c_d : STD_LOGIC_VECTOR (7 downto 0);
signal down_counter_to_reg : STD_LOGIC_VECTOR (7 downto 0);

begin
encrypt_module : Encrypter
    port map (key_in => key,
              d_in => data_in,
              d_out => data_out,
              clock => clock_signal,
              reset => reset_signal,
              selector_mul => wen);

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
               data_out => input_a_b,
               clk  => clock_signal,
               reset => reset_signal);

reg_b : register_8bit
    Port map ( data_in => input_a_b,
               data_out => input_b_c,
               clk  => clock_signal,
               reset => reset_signal);
               
reg_c : register_8bit
    Port map ( data_in => input_b_c,
               data_out => input_c_d,
               clk  => clock_signal,
               reset => reset_signal);
               
reg_d : register_8bit
    Port map ( data_in => input_c_d,
               data_out => addr_to_write,
               clk  => clock_signal,
               reset => reset_signal);
              
dff_a : d_flipflop
    port map (data_in => enable,
              data_out => wen_a_b,
              clk => clock_signal,
              reset => reset_signal);
              
dff_b : d_flipflop
    port map (data_in => wen_a_b,
              data_out => wen_b_c,
              clk => clock_signal,
              reset => reset_signal);

dff_c : d_flipflop
    port map (data_in => wen_b_c,
              data_out => wen_c_d,
              clk => clock_signal,
              reset => reset_signal);
              
dff_d : d_flipflop
    port map (data_in => wen_c_d,
              data_out => wen,
              clk => clock_signal,
              reset => reset_signal);

not_gate_en : not_gate
    port map (a => enable,
              b => reset_signal);

and_gate_clock : and_gate
    port map(a => clock,
             b => enable,
             F => clock_signal);

read_enable <= enable;
write_enable <= wen;
end Behavioral;
