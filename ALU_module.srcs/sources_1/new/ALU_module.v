`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2023 06:29:40 PM
// Design Name: 
// Module Name: ALU_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_module ( 
  input wire inA, 
  input wire inB, 
  input wire inC,
  input wire inD,
  output wire outA, 
  output wire outB 
); 

  wire AB; 
  wire AB_C; 
  wire n_AB_C; 
  wire CD;

  assign AB = inA & inB; 
  assign AB_C = AB | inC; 
  assign n_AB_C = ~AB_C; 
  assign CD = inC & inD; 
  assign outA = n_AB_C | CD; 
  assign outB = inC & inD & CD; 

endmodule