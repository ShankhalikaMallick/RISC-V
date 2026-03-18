/*
    Part of Instruction Fetch stage of 5 stage pipelined RISC V
    PC MUX is the multiplexer which takes two inputs PC+4 and PCTarget
    And decides the updation of the program counter based on the value of PCsrcE
*/

`timescale 1ps/1ps

module PC_MUX(
    input [31:0] PCplus4F,               // default updation of Program counter
    input [31:0] PCtargetE,             // Program counter target for branch and jump conditions
    input PCsrcE,                       // PC select controlfrom jump and branch conditions 
    output [31:0] PCF                   // Program counter for Instruction Fetch operation 
);

    assign PCF = (PCsrcE==1)? PCtargetE : PCplus4F;

endmodule