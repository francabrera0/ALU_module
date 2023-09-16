`timescale 1ns / 1ps

module topLevel#(
    parameter DATA_LEN  = 8,
    parameter OP_LEN    = 6
  )
  (
    input wire [DATA_LEN-1 : 0] i_operandSwitches,
    input wire [OP_LEN-1 : 0] i_operationSwitches,
    input wire i_operandABttn,
    input wire i_operandBBttn,
    input wire i_operationSBttn,
    input wire i_resultBttn,
    input wire i_clk,
    output wire [DATA_LEN-1 : 0] o_resultLeds,
    output wire o_zeroLed,
    output wire o_overflowLed
  );


  //ALU Instantiation
  reg [DATA_LEN-1 : 0] operandAReg;
  reg [DATA_LEN-1 : 0] operandBReg;
  reg [OP_LEN-1 : 0] operationReg;
  wire [DATA_LEN-1 : 0] resultWire;
  wire zeroWire;
  wire overflowWire;

  ALU_module #(
               .DATA_LEN(DATA_LEN),
               .OP_LEN(OP_LEN)
             ) alu
             (
               .i_operandA(operandAReg),
               .i_operandB(operandBReg),
               .i_opSelector(operationReg),
               .o_aluResult(resultWire),
               .o_zero(zeroWire),
               .o_overFlow(overflowWire)
             );

  reg [DATA_LEN-1 : 0] resultReg;
  reg zeroReg;
  reg overflowReg;


  assign o_resultLeds = resultReg;
  assign o_zeroLed = zeroReg;
  assign o_overflowLed = overflowReg;


  always @(posedge i_clk)
  begin
    if(i_operandABttn)
      operandAReg <= i_operandSwitches;

    if(i_operandBBttn)
      operandBReg <= i_operandSwitches;

    if(i_operationSBttn)
      operationReg <= i_operationSwitches;
  end

  always @(posedge i_clk)
  begin
    if(i_resultBttn)
    begin
      resultReg <= resultWire;
      zeroReg <= zeroWire;
      overflowReg <= overflowWire;
    end
  end


endmodule
