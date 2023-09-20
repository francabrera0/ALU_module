`timescale 1us / 1ns

module topLevel_tb();

  parameter DATA_LEN = 8;
  parameter OP_LEN = 6;

  reg [DATA_LEN-1 : 0] i_operandSwitches;
  reg [OP_LEN-1 : 0] i_operationSwitches;
  reg i_operandABttn;
  reg i_operandBBttn;
  reg i_operationSBttn;
  reg i_resultBttn;
  reg i_clk;
  wire [DATA_LEN-1 : 0] o_resultLeds;
  wire o_zeroLed;
  wire o_overflowLed;

  topLevel #(
             .DATA_LEN(DATA_LEN),
             .OP_LEN(OP_LEN)
           ) top
           (
             .i_operandSwitches(i_operandSwitches),
             .i_operationSwitches(i_operationSwitches),
             .i_operandABttn(i_operandABttn),
             .i_operandBBttn(i_operandBBttn),
             .i_operationSBttn(i_operationSBttn),
             .i_resultBttn(i_resultBttn),
             .i_clk(i_clk),
             .o_resultLeds(o_resultLeds),
             .o_zeroLed(o_zeroLed),
             .o_overflowLed(o_overflowLed)
           );

  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR  = 6'b100101;
  localparam XOR = 6'b100110;
  localparam NOR = 6'b100111;
  localparam SRA = 6'b000011;
  localparam SRL = 6'b000010;

  reg [7:0] i;
  reg [7:0] j;
  reg [DATA_LEN-1:0] maxRandom;
  reg [31:0] seed;
  reg [DATA_LEN-1:0] temporalResult;
  reg [DATA_LEN-1 : 0] temp;


  initial
  begin
    i_clk = 0;
    #1
     i_clk = 1;
    forever
      #1 i_clk = ~i_clk;
  end


  initial
  begin
    seed = 135;
    i = 8'b0;
    j = 8'b0;
    maxRandom = 2**DATA_LEN-1;
    i_operationSwitches = ADD;
    i_operandABttn = 0;
    i_operandBBttn = 0;
    i_operationSBttn = 0;
    i_resultBttn = 0;

    #30 
    for(j = 0; j < 8; j = j + 1)
    begin

      for(i = 0; i<4; i = i + 1)
      begin

        i_operandSwitches = $random(seed);
        temp = i_operandSwitches;
        #5
         i_operandABttn = 1;
        #5
         i_operandABttn = 0;
        i_operandSwitches = $random(seed) % maxRandom;
        #5
         i_operandBBttn = 1;
        #5
         i_operandBBttn = 0;
        #5
         i_operationSBttn = 1;


        case(i_operationSwitches)
          ADD:
            temporalResult = $signed(temp) + $signed(i_operandSwitches);
          SUB:
            temporalResult = $signed(temp) - $signed(i_operandSwitches);

          AND:
            temporalResult = temp & i_operandSwitches;
          OR :
            temporalResult = temp | i_operandSwitches;
          XOR:
            temporalResult = temp ^ i_operandSwitches;
          NOR:
            temporalResult = ~(temp | i_operandSwitches);

          SRA:
            temporalResult = $signed(temp) >>> i_operandSwitches;
          SRL:
            temporalResult = temp >> i_operandSwitches;
        endcase

        #5
         i_operationSBttn = 0;
        #5
         i_resultBttn = 1;
        #5
         i_resultBttn = 0;

        if(o_resultLeds != temporalResult)
        begin
          $display("Result error %d", i);
        end
        if(o_zeroLed != (temporalResult == 0))
        begin
          $display("Zero flag error %d", i);
        end
      end //end for i

      case(i_operationSwitches)
        ADD:
          i_operationSwitches = SUB;
        SUB:
          i_operationSwitches = AND;
        AND:
          i_operationSwitches = OR;
        OR:
          i_operationSwitches = XOR;
        XOR:
          i_operationSwitches = NOR;
        NOR:
        begin
          i_operationSwitches = SRA;
          maxRandom = 3'b111;
        end
        SRA:
          i_operationSwitches = SRL;
      endcase

    end //end for j

  end //end initial


endmodule
