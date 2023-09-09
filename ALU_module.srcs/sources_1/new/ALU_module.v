`timescale 1ns / 1ns


module ALU_module #(
    parameter DATA_LEN  = 32,
    parameter OP_LEN    = 6
)
( 
    input wire  [DATA_LEN-1 : 0] i_operandA,
    input wire  [DATA_LEN-1 : 0] i_operandB,
    input wire    [OP_LEN-1 : 0] i_opSelector,
    output wire [DATA_LEN-1 : 0] o_aluResult,
    output wire                  o_carryOut, 
    output wire                  o_zero
); 

    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;
    
    reg [DATA_LEN : 0] tempResult;
    
    //Alu out
    assign o_aluResult = tempResult;
    
    //Zero flag
    assign o_zero = & (~ o_aluResult);
    
    //CarryOut
    assign o_carryOut = tempResult[DATA_LEN];
    
    //Calculation
    always @(*)
        begin
            case(i_opSelector)
                ADD: tempResult = i_operandA + i_operandB;
                
                default : tempResult = {DATA_LEN {1'b1}};
            endcase
        end
    
    

endmodule