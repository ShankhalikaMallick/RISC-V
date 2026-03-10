/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    MAIN DECODER is a part of control unit where we decode the instruction into type of instruction based on the opcode
*/

module MAIN_DECODER(
    input [6:0] opcode,             // opcode as input from control unit
    output regwrite,                // for writing into register
    output [1:0] immsrc,            // for different immediate addresses required
    output alusrc,                  // alu control in execute for hazard control
    output resultsrc,               // control for result obtained write back stage
    output memwrite,                // control for writing back into memory i.e store
    output branch,                  // control for branch instructions
    output jump,                    // control for jump instructions
    output [1:0] aluop              // alu opcode for alu decoder of control unit
);

// write to register for R, I, L type instructions where RD = INSTR [11:7]
    assign regwrite = ((opcode == 7'b0110011) | (opcode == 7'b0010011) | (opcode == 7'b0000011))? 1'b1: 1'b0;

// immediate part for I , L, S, B, U, J
// for S type 1, for B type 2, for J type 3, rest all 0
    assign immsrc = (opcode == 7'b0100011) ? 2'b01 : 
                    (opcode == 7'b1100011) ? 2'b10 : 
                    (opcode == 7'b1101111) ? 2'b11 :
                                             2'b00 ;

// for load, branch, immediate types alusrc is 1 else 0
    assign alusrc = (opcode == 7'b0000011 | opcode == 7'b0100011 | opcode == 7'b0010011) ? 1'b1 : 1'b0 ;

// for load instructions resultsrc is 1 else 0
    assign resultsrc = (opcode == 7'b0000011) ? 1'b1 : 1'b0 ;

// control for writing into memory for store type instruction
    assign memwrite = (opcode == 7'b0100011) ? 1'b1 : 1'b0 ;

// branch and jump controls for B and J instructions respectively
    assign branch = (opcode == 7'b1100011) ? 1'b1 : 1'b0;
    assign jump = (opcode == 7'b1101111) ? 1'b1 : 1'b0;

// alu opcode for alu decoder R type= 2, B type=1, else 0
    assign aluop = (opcode == 7'b0110011) ? 2'b10 :
                   (opcode == 7'b1100011) ? 2'b01 :
                                            2'b00 ;

endmodule