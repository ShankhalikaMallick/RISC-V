/*
    Part of execute stage of 5 stage pipelined RISC V
    Execute is the register unit which stores the reults of 3rd stage
    3rd stage consistes of 3:1 MUX, 2:1 MUX, ALU, PC_ADDER blocks
*/

`timescale 1ns / 1ps
`include "12_MUX31.v"
`include "13_MUX21.v"
`include "14_ALU.v"
`include "15_PC_ADDER.v"

module EXECUTE(
    input clk,                                  // input from top module
    input reset,                                // input from top module
    input regwriteE,                            // pipelined from Decode module 
    input alusrcE,
    input memwriteE,
    input resultsrcE,
    input branchE,
    input jumpE,
    input [3:0] alucontrolE,
    input [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input [4:0] RD_E,
    input [31:0] PCE, PCplus4E,
    input [31:0] ResultW,                               // result from write back block
    input [1:0] ForwardA_E, ForwardB_E,                 // input from hazard unit
    output PCSrcE, regwriteM, memwrite, ResultSrcM,
    output [4:0] RD_M 
    output [31:0] PCPlus4M, WriteDataM, ALU_ResultM
    output [31:0] PCTargetE
);
    MUX31 ob10(
        .A (RD1_E),
        .B, 
        .C,
        .sel,
        .out
    );

    MUX31 ob11(
        .A,
        .B, 
        .C,
        .sel,
        .out
    );

    MUX21 ob12(
    .A,
    .B, 
    .sel,
    .out
);
endmodule