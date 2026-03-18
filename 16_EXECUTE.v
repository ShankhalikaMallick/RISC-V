/*
    Part of execute stage of 5 stage pipelined RISC V
    Execute is the register unit which stores the reults of 3rd stage
    3rd stage consistes of 3:1 MUX, 2:1 MUX, ALU, PC_ADDER blocks
*/

`timescale 1ps / 1ps
`include "12_MUX31.v"
`include "13_MUX21.v"
`include "14_ALU.v"
`include "15_PC_ADDER.v"

module EXECUTE(
    input clk,                                  
    input reset,                                
    input regwriteE,                             
    input alusrcE,
    input memwriteE,
    input resultsrcE,
    input branchE,
    input jumpE,
    input [3:0] alucontrolE,
    input [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input [4:0] RD_E,
    input [31:0] PCE, PCplus4E,
    input [31:0] resultW,                               
    input [1:0] ForwardA_E, ForwardB_E,                 
    output PCsrcE, 
    output regwriteM, memwriteM, resultsrcM,
    output [4:0] RD_M ,
    output [31:0] PCplus4M, writedataM, aluresultM,
    output [31:0] PCtargetE
);

// interin wires
    wire [31:0] SRCA_E, SRCB_E;
    wire [31:0] SRCB_inter;
    wire [31:0] aluresultE;
    wire zeroE;

// initializing registers for execute
    reg regwriteE_r, memwriteE_r, resultsrcE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCplus4E_r, RD2_E_r, aluresultE_r;

// initializing modules
    MUX31 ob10(
        .A (RD1_E),
        .B (resultW), 
        .C (aluresultM),
        .sel (ForwardA_E),
        .out (SRCA_E)
    );

    MUX31 ob11(
        .A (RD2_E),
        .B (resultW), 
        .C (aluresultM),
        .sel (ForwardB_E),
        .out (SRCB_E)
    );

    MUX21 ob12(
        .A (SRCB_inter),
        .B (Imm_Ext_E), 
        .sel (alusrcE),
        .out (SRCB_E)
    );

    ALU ob13(
        .A (SRCA_E),                              
        .B (SRCB_E),                              
        .alucontrol (alucontrolE),                     
        .result (aluresultE),                                              
        .zeroE (zeroE)                              
    );

    PC_ADDER ob14(
        .PC (PCE),                    
        .imm (Imm_Ext_E),                    
        .pc_target (PCtargetE)             
    );

    assign PCsrcE = (zeroE & branchE) | jumpE;
    assign regwriteM = regwriteE_r;
    assign memwriteM = memwriteE_r;
    assign resultsrcM = resultsrcE_r;
    assign RdM = RD_E_r;
    assign PCplus4M = PCplus4E_r;
    assign writedataM = RD2_E_r;
    assign aluresultM = aluresultE_r;

    always @(posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            regwriteE_r <= 1'b0; 
            memwriteE_r <= 1'b0; 
            resultsrcE_r <= 1'b0;
            RD_E_r <= 5'h00;
            PCplus4E_r <= 32'h00000000; 
            RD2_E_r <= 32'h00000000; 
            aluresultE_r <= 32'h00000000;
        end
        else
        begin
            regwriteE_r <= regwriteE; 
            memwriteE_r <= memwriteE; 
            resultsrcE_r <= resultsrcE;
            RD_E_r <= RD_E;
            PCplus4E_r <= PCplus4E; 
            RD2_E_r <= SRCB_inter; 
            aluresultE_r <= aluresultE;
        end
    end

endmodule