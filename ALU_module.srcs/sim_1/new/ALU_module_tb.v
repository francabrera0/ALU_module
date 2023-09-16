`timescale 1ns / 1ns


module ALU_module_tb;

    localparam DATA_LEN = 8;
    localparam OP_LEN = 6;
    
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam NOR = 6'b100111;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;

    
    reg  [DATA_LEN-1 : 0] i_operandA;
    reg  [DATA_LEN-1 : 0] i_operandB;
    reg  [OP_LEN-1 : 0]   i_opSelector;
    wire [DATA_LEN-1 : 0] o_aluResult;
    wire                  o_zero;
    wire                  o_overFlow; 
    
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
        .o_overFlow(o_overFlow)
    );

    reg [7:0] i;
    reg [7:0] j;
    reg [DATA_LEN-1:0] maxRandom;
    reg [31:0] seed;
    reg [DATA_LEN-1:0] temporalResult;
    
    initial 
        begin
            seed = 135;
            i = 8'b0;
            j = 8'b0;
            maxRandom = 2**DATA_LEN-1;
            i_opSelector = ADD;
            
            for(j = 0; j < 8; j = j + 1)
                begin             
                
                for(i = 0; i<4; i = i + 1)
                    begin
                        i_operandA = $random(seed);
                        i_operandB = $random(seed) % maxRandom;
                        
                        case(i_opSelector)             
                            ADD:temporalResult = $signed(i_operandA) + $signed(i_operandB);                 
                            SUB: temporalResult = $signed(i_operandA) - $signed(i_operandB);
                    
                            AND: temporalResult = i_operandA & i_operandB;
                            OR : temporalResult = i_operandA | i_operandB;
                            XOR: temporalResult = i_operandA ^ i_operandB;
                            NOR: temporalResult = ~(i_operandA | i_operandB);
                            
                            SRA: temporalResult = $signed(i_operandA) >>> i_operandB;
                            SRL: temporalResult = i_operandA >> i_operandB;
                        endcase
                          
                        #1
                        
                        if(o_aluResult != temporalResult) 
                            begin
                                $display("Result error %d", i);
                            end
                        if(o_zero != (temporalResult == 0)) 
                            begin
                                $display("Zero flag error %d", i);
                            end                
                    end //end for i                                               
                     
                     i_operandA = {DATA_LEN{1'b0}};
                     i_operandB = {DATA_LEN{1'b0}};
                     
                     #2
                
                     case(i_opSelector)
                        ADD: i_opSelector = SUB;
                        SUB: i_opSelector = AND;
                        AND: i_opSelector = OR;
                        OR:  i_opSelector = XOR;
                        XOR: i_opSelector = NOR;
                        NOR: begin 
                                i_opSelector = SRA;
                                maxRandom = 3'b111;
                             end
                        SRA: i_opSelector = SRL;
                     endcase      
                                         
                end //end for j
                        
        end //end initial
endmodule