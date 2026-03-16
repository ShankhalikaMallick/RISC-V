/*
    Part of memory stage of 5 stage pipelined RISC V
    MEMORY is the register unit which stores the reults of 4th stage
    4th stage consistes of DATA MEMORY UNIT
*/

`timescale 1ps/1ps
`include "17_DMU.v"
module mem(
    input clk,
    input reset, 
    input regwriteM,
    input resultsrcM,
    input memwriteM,
    input [4:0] RD_M,
    input [31:0] PCplus4M, writedataM, aluresultM,
    output resultsrcW,
    output regwriteW,
    output [31:0] PCplus4W, aluresultW,
    output [4:0] RD_W,
    output [31:0] readdataW                                 // output from DMU
);

    wire [31:0] readdataM;
    reg resultsrcM_r;
    reg regwriteM_r;
    reg [31:0] PCplus4M_r, aluresultM_r;
    reg [31:0] readdataM_r;  
    reg [4:0] RD_M_r;

    DMU ob15(
        .clk (clk),
        .reset (reset),
        .mem_wr (memwriteM),
        .mem_add (aluresultM),                              // check thre working of this address
        .wr_data (writedataM),
        .rd_data (readdataM)
    );

    always @ (posedge clk or posedge reset)
    begin
        if (reset == 1'b1)
        begin
            resultsrcM_r = 1'b0;
            regwriteM_r = 1'b0;
            PCplus4M_r = 32'b0;
            aluresultM_r = 32'b0;
            readdataM_r = 32'b0;  
            RD_M_r = 5'b0;
        end
        else
        begin
            resultsrcM_r = resultsrcM;
            regwriteM_r = regwriteM;
            PCplus4M_r = PCplus4M;
            aluresultM_r = aluresultM;
            readdataM_r = readdataM;  
            RD_M_r = RD_M;
        end
    end

    assign resultsrcW = resultsrcM_r;
    assign regwriteW = regwriteM_r;
    assign PCplus4W = PCplus4M_r;
    assign aluresultW = aluresultM_r;
    assign readdataW = readdataM_r;  
    assign RD_W = RD_M_r;
endmodule