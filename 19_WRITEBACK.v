/*
    Part of WRITE BACK stage of 5 stage pipelined RISC V
    WRITEBACK is the register unit which stores the reults of 5th stage
    5th stage consistes of 2:1 MUX block
*/
`timescale 1ps/1ps
//`include "13_MUX21.v"
module WB(
    input clk,
    input reset,
    input resultsrcW,
    input regwriteW,
    input [31:0] PCplus4W,                       // check why this is here
    input [31:0] aluresultW,
    input [31:0] readdataW,
    input [4:0] RD_W,
    output [31:0] resultW
);

    MUX21 ob16(
        .A (aluresultW),
        .B (readdataW), 
        .sel (resultsrcW),
        .out (resultW)
    );
    
endmodule
