`timescale 1ps/1ps
`include "05_FETCHv"
`include "11_DECODEv"
`include "16_EXECUTEv"
`include "18_MEMORYv"
`include "19_WRITEBACKv"
`include "20_HAZARDv"

module TOP(
    input clk,          
    input reset );    

wire PCsrcE, regwriteE, alusrcE, memwriteE, resultsrcE, branchE, jumpE, alucontrolE;
wire [31:0] PCtargetE;
wire RD1_E, RD2_E, Imm_Ext_E, RS1_E, RS2_E, RD_E, PCE, PCplus4E, ForwardA_E, ForwardB_E;
wire [31:0] INSTRD, PC_D, PCplus4D;  
wire regwriteW;
wire [4:0] RD_W;
wire [31:0] resultW, 
wire resultsrcW, PCplus4W, aluresultW, readdataW;
wire regwriteM, memwriteM, resultsrcM, RD_M , PCplus4M, writedataM, aluresultM;

//05 FETCH
    FETCH(
        clk, 
        reset,         
        PCsrcE,            
        PCtargetE,    
        INSTRD, 
        PC_D,  
        PCplus4D     
    );

//11 DECODE
    DECODE(
        clk,                           
        reset,                         
        regwriteW,
        RD_W,                       
        INSTRD, 
        PC_D,
        PCplus4D,
        resultW,
        regwriteE,
        alusrcE,
        memwriteE,
        resultsrcE,
        branchE,
        jumpE,
        alucontrolE,
        RD1_E, RD2_E, Imm_Ext_E,
        RS1_E, RS2_E, RD_E,         
        PCE, PCplus4E
    );

//16 EXECUTE
    EXECUTE(
        clk,                                  
        reset,                                
        regwriteE,                             
        alusrcE,
        memwriteE,
        resultsrcE,
        branchE,
        jumpE,
        alucontrolE,
        RD1_E, RD2_E, Imm_Ext_E,
        RD_E,
        PCE, PCplus4E,
        resultW,                               
        ForwardA_E, ForwardB_E,                 
        PCsrcE, 
        regwriteM, memwriteM, resultsrcM,
        RD_M ,
        PCplus4M, writedataM, aluresultM,
        PCtargetE
    );

//18 MEMORY
    MEM(
        clk,
        reset, 
        regwriteM,
        resultsrcM,
        memwriteM,
        RD_M,
        PCplus4M, writedataM, aluresultM,
        resultsrcW,
        regwriteW,
        PCplus4W, aluresultW,
        RD_W,
        readdataW                                 
    );

//19 WRITEBACK
    WB(
        clk,
        reset,
        resultsrcW,
        regwriteW,
        PCplus4W,                 
        aluresultW,
        readdataW,
        RD_W,
        resultW
    );

//20 HAZARD 
    HAZARD(
        reset,
        regwriteM,
        regwriteW,
        RD_M, RD_W, RS1_E, RS2_E,
        ForwardA_E,
        ForwardB_E
    );

endmodule