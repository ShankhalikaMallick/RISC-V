/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    ALU DECODER is a part of control unit where we decode the Arithmetic logical operations
*/

module ALU_DECODER(
    input [1:0] aluop,                  // input from main decoder
    input [2:0] funct3,                 // function 3 input from control unit
    input [6:0] funct7,                 // function 7 input from control unit 
    input [6:0] opcode,                 // opcode input from control unit
    output [3:0] alu_control            // output for alu control 4 bit
);

/*  
    If we have R type instruction (i.e. aluop= 2) perform ALU operations 
    based on funct3 values: INSTR[14:12] 
    NOTE: i have left out SRL ANS SRA instructions
    B type=1, else 0 
*/
    assign ALUControl = (aluop == 2'b00) ? 4'b0000 :                                                                     // remaining instructions
                        (aluop == 2'b01) ? 4'b1111 :                                                                     // branch instructions
                        ((aluop == 2'b10) & (funct3 == 3'b000) & ({opcode[5],funct7[5]} == 2'b11)) ? 4'b0010 :           // SUB
                        ((aluop == 2'b10) & (funct3 == 3'b000) & ({opcode[5],funct7[5]} != 2'b11)) ? 4'b0001 :           // ADD
                        ((aluop == 2'b10) & (funct3 == 3'b001)) ? 4'b0011 :                                              // SLL
                        ((aluop == 2'b10) & (funct3 == 3'b010)) ? 4'b0100 :                                              // SLT
                        ((aluop == 2'b10) & (funct3 == 3'b011)) ? 4'b0101 :                                              // SLTU
                        ((aluop == 2'b10) & (funct3 == 3'b100)) ? 4'b0110 :                                              // XOR
                        ((aluop == 2'b10) & (funct3 == 3'b101) & ({opcode[5],funct7[5]} == 2'b11)) ? 4'b1000 :           // SRA
                        ((aluop == 2'b10) & (funct3 == 3'b101) & ({opcode[5],funct7[5]} != 2'b11)) ? 4'b0111 :           // SRL
                        ((aluop == 2'b10) & (funct3 == 3'b110)) ? 4'b1001 :                                              // OR
                        ((aluop == 2'b10) & (funct3 == 3'b111)) ? 4'b1010 :                                              // AND
                                                                  4'b0000 ;                                              // rest cases

endmodule 