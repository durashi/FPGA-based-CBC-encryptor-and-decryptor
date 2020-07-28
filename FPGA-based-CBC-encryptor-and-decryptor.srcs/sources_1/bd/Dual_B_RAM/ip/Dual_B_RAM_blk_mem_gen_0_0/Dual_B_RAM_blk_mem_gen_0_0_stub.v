// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Jul 28 21:50:08 2020
// Host        : DESKTOP-R5L8HNJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Xilinx/Projects/FPGA-based-CBC-encryptor-and-decryptor/FPGA-based-CBC-encryptor-and-decryptor.srcs/sources_1/bd/Dual_B_RAM/ip/Dual_B_RAM_blk_mem_gen_0_0/Dual_B_RAM_blk_mem_gen_0_0_stub.v
// Design      : Dual_B_RAM_blk_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module Dual_B_RAM_blk_mem_gen_0_0(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[7:0],dina[7:0],douta[7:0],clkb,enb,web[0:0],addrb[7:0],dinb[7:0],doutb[7:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [7:0]addra;
  input [7:0]dina;
  output [7:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [7:0]addrb;
  input [7:0]dinb;
  output [7:0]doutb;
endmodule
