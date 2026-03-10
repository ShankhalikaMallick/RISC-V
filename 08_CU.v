/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    CU is the main control unit of the RISC V
    It sends control to different blocks 
    It consists of two sub blocks : ALU decoder and Main Decoder
*/

`timescale 1ns / 1ps
`include "06_MAIN_DECODER.v"
`include "07_ALU_DECODER.v"
 
module CU(
    input [31:0] INSTRD,
    output regwrite,
    output [3:0] alu_control,
    output resultsrc,
    output memwrite,
    output jump,
    output branch,
    output alusrc,
    output [1:0] immsrc   
);

    wire [6:0] opcode;
    wire [6:0] funct7;
    wire [2:0] funct3;
    wire [1:0] aluop;

    assign opcode = INSTRD [6:0];
    assign funct3 = INSTRD [14:12];
    assign funct7 = INSTRD [31:25];

    MAIN_DECODER ob5 (opcode, regwrite, immsrc, alusrc, resultsrc, memwrite, branch, jump, aluop);
    ALU_DECODER ob6 (aluop, funct3, funct7, opcode, alu_control);

endmodule