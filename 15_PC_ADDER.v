/*
    Part of Execute stage of 5 stage pipelined RISC V
    PC_ADDER adds the program counter to immediate value
    This is required for branch and jump (only jal) type of instructions 
    Target Address = PC + sign-extended immediate
*/

`timescale 1ns / 1ps
module PC_ADDER(
    input [31:0] PC,                    // current program counter
    input [31:0] imm,                   // the sign extended immediate address to be added 
    output [31:0] pc_target             // target adress 
);
    assign pc_target = PC + imm;
endmodule