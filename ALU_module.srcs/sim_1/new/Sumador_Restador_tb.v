`timescale 1ns / 1ns

module Sumador_Restador_tb;

    localparam DATA_LEN = 8;
    
    reg signed [DATA_LEN-1 : 0] i_operandA;
    reg signed [DATA_LEN-1 : 0] i_operandB;
    reg                         i_substract;
    wire signed [DATA_LEN-1 : 0]o_result;
    wire                        o_overflow; 

    SumadorRestador #(
        .DATA_LEN(DATA_LEN)
    ) 
    sumadorRestador (
        .i_operandA(i_operandA),
        .i_operandB(i_operandB),
        .i_substract(i_substract),
        .o_result(o_result),
        .o_overflow(o_overflow)
    );
    
    reg [7:0] i;
    reg [7:0] j;
    reg [DATA_LEN-1:0] maxRandom;
    reg [31:0] seed;
    reg signed [DATA_LEN:0] temporalResult;
    
    initial 
        begin
            seed = 135;
            i = 8'b0;
            j = 8'b0;
            maxRandom = 2**DATA_LEN-1;
            i_substract = 0;
            
            for(j = 0; j < 8; j = j + 1)
                begin             
                
                for(i = 0; i<5; i = i + 1)
                    begin
                        i_operandA = $signed($random(seed));
                        i_operandB = $signed($random(seed) % maxRandom);
                        
                        if(i_substract) begin
                            temporalResult = i_operandA - i_operandB;
                        end else begin
                            temporalResult = i_operandA + i_operandB;
                        end

                          
                        #1
                        
                        if(o_result != temporalResult) begin
                            if (!o_overflow) begin
                                if(i_substract) begin
                                    $display("Result error %d-%d=%d != %d, i: %d", i_operandA, i_operandB, temporalResult, o_result, i);
                                end else begin
                                    $display("Result error %d+%d=%d != %d, i: %d", i_operandA, i_operandB, temporalResult, o_result, i);
                                end
                            end
                        end
 else if(o_overflow) begin
                            if(i_substract) begin
                                $display("Overflow error %d-%d=%d != %d, i: %d", i_operandA, i_operandB, temporalResult, o_result, i);
                            end else begin
                                $display("Overflow error %d+%d=%d != %d, i: %d", i_operandA, i_operandB, temporalResult, o_result, i);
                            end
                        end              
                    end //end for i                                               
                     
                     i_operandA = {DATA_LEN{1'b0}};
                     i_operandB = {DATA_LEN{1'b0}};
                     
                     #2
                
                     i_substract = !i_substract;  
                                         
                end //end for j
                    
        end //end initial
endmodule
