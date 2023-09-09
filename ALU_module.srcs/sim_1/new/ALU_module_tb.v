`timescale 1ns / 1ns


module ALU_module_tb;
    localparam DATA_LEN = 32;
    localparam OP_LEN = 6;
    
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;
    
    reg  [DATA_LEN-1 : 0] i_operandA;
    reg  [DATA_LEN-1 : 0] i_operandB;
    reg  [OP_LEN-1 : 0]   i_opSelector;
    wire [DATA_LEN-1 : 0] o_aluResult;
    wire                  o_zero;
    wire                  o_carryOut;
    
    reg [7:0] iterator;
    reg [31:0] seed;
    reg [DATA_LEN:0] temporalResult;
    
    ALU_module #(
        .DATA_LEN(DATA_LEN),
        .OP_LEN(OP_LEN)
    ) 
    alu (
        .i_operandA(i_operandA),
        .i_operandB(i_operandB),
        .i_opSelector(i_opSelector),
        .o_aluResult(o_aluResult),
        .o_zero(o_zero),
        .o_carryOut(o_carryOut)
    );


    initial 
        begin
            seed = 13;
            iterator = 8'b0;
            i_opSelector = 6'b100000;
            
            for(iterator = 0; iterator<10; iterator = iterator + 1)
                begin
                    i_operandA = $random(seed);
                    i_operandB = $random(seed);
                    
                    case(i_opSelector)
                        ADD: temporalResult = i_operandA + i_operandB;
                    endcase
                      
                    #1
                    
                    if(o_aluResult != temporalResult[DATA_LEN-1:0])
                        begin
                            $display("Result error %d", iterator);
                        end
                    if(o_zero != (temporalResult == 0))
                        begin
                            $display("Zero flag error %d", iterator);
                        end                
                    if(o_carryOut != ((temporalResult) > ((2**DATA_LEN)-1)))
                        begin
                            $display("Carry out error %d", iterator);
                        end
                    
             end

             i_operandA = {DATA_LEN{1'b0}};
             i_operandB = {DATA_LEN{1'b0}};     
                
        end
endmodule