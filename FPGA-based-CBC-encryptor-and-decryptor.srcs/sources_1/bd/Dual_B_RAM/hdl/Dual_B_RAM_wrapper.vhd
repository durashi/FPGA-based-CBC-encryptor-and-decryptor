--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
--Date        : Mon Jul 27 19:39:29 2020
--Host        : DESKTOP-R5L8HNJ running 64-bit major release  (build 9200)
--Command     : generate_target Dual_B_RAM_wrapper.bd
--Design      : Dual_B_RAM_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Dual_B_RAM_wrapper is
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
end Dual_B_RAM_wrapper;

architecture STRUCTURE of Dual_B_RAM_wrapper is
  component Dual_B_RAM is
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
  end component Dual_B_RAM;
begin
Dual_B_RAM_i: component Dual_B_RAM
     port map (
      BRAM_PORTA_0_addr(7 downto 0) => BRAM_PORTA_0_addr(7 downto 0),
      BRAM_PORTA_0_clk => BRAM_PORTA_0_clk,
      BRAM_PORTA_0_din(7 downto 0) => BRAM_PORTA_0_din(7 downto 0),
      BRAM_PORTA_0_dout(7 downto 0) => BRAM_PORTA_0_dout(7 downto 0),
      BRAM_PORTA_0_en => BRAM_PORTA_0_en,
      BRAM_PORTA_0_we(0) => BRAM_PORTA_0_we(0),
      BRAM_PORTB_0_addr(7 downto 0) => BRAM_PORTB_0_addr(7 downto 0),
      BRAM_PORTB_0_clk => BRAM_PORTB_0_clk,
      BRAM_PORTB_0_din(7 downto 0) => BRAM_PORTB_0_din(7 downto 0),
      BRAM_PORTB_0_dout(7 downto 0) => BRAM_PORTB_0_dout(7 downto 0),
      BRAM_PORTB_0_en => BRAM_PORTB_0_en,
      BRAM_PORTB_0_we(0) => BRAM_PORTB_0_we(0)
    );
end STRUCTURE;
