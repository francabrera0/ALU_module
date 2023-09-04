`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2023 06:30:15 PM
// Design Name: 
// Module Name: ALU_module_tb
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


module ALU_module_tb;
    reg inA, inB, inC, inD;
    wire outA, outB;

    // Instancia del módulo multi_compuerta
    multi_compuerta uut (
        .inA(inA),
        .inB(inB),
        .inC(inC),
        .inD(inD),
        .outA(outA),
        .outB(outB)
    );

    initial begin
        // Abrir el archivo VCD
        $dumpfile("tb_multi_compuerta.vcd");
        $dumpvars(0, tb_multi_compuerta);

        // Inicializar entradas
        inA = 0; inB = 0; inC = 0; inD = 0; #10;
        inA = 0; inB = 0; inC = 0; inD = 1; #10;
          inA = 0; inB = 0; inC = 1; inD = 0; #10;
          inA = 0; inB = 0; inC = 1; inD = 1; #10;
          inA = 0; inB = 1; inC = 0; inD = 0; #10;
        inA = 0; inB = 1; inC = 0; inD = 1; #10;
          inA = 0; inB = 1; inC = 1; inD = 0; #10;
          inA = 0; inB = 1; inC = 1; inD = 1; #10;
          inA = 1; inB = 0; inC = 0; inD = 0; #10;
        inA = 1; inB = 0; inC = 0; inD = 1; #10;
          inA = 1; inB = 0; inC = 1; inD = 0; #10;
          inA = 1; inB = 0; inC = 1; inD = 1; #10;
          inA = 1; inB = 1; inC = 0; inD = 0; #10;
        inA = 1; inB = 1; inC = 0; inD = 1; #10;
          inA = 1; inB = 1; inC = 1; inD = 0; #10;
          inA = 1; inB = 1; inC = 1; inD = 1; #10;


        $finish;
    end
endmodule