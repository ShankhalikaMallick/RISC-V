/*
    Part of Instruction Fetch stage of 5 stage pipelined RISC V
    PC_ADD is the multiplexer which takes two inputs PC+4 and PCTarget
*/

`timescale 1ns/1ps

module PC_ADD(
    input [31:0] PC_F,                 // PC_F program counter from PC
    output [31:0] PCplus4F             // default updation of program counter
);
    assign PCplus4F = PC_F + 32'h00000004; 

endmodule