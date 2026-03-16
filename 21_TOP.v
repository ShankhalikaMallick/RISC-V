`timescale 1ps/1ps
`include "05_FETCH.v"
`include "11_DECODE.v"
`include "16_EXECUTE.v"
`include "18_MEMORY.v"
`include "19_WRITEBACK.v"
`include "20_HAZARD.v"

module TOP(
    input clk,          
    input reset );    



//05 FETCH
    FETCH(
        .clk,        
        .reset,         
        .PCsrcE,            
        .PCtargetE,    
        .INSTRD, 
        .PC_D,  
        .PCplus4D     
    );

//11 DECODE
    DECODE(
        .clk,                           
        .reset,                         
        .regwriteW,
        .RDW,                       
        .INSTRD, 
        .PCD,
        .PCplus4D,
        .resultW,
        .regwriteE,
        .alusrcE,
        .memwriteE,
        .resultsrcE,
        .branchE,
        .jumpE,
        .alucontrolE,
        .RD1_E, RD2_E, Imm_Ext_E,
        .RS1_E, RS2_E, RD_E,         
        .PCE, PCplus4E
    );

//16 EXECUTE
    EXECUTE(
        .clk,                                  
        .reset,                                
        .regwriteE,                             
        .alusrcE,
        .memwriteE,
        .resultsrcE,
        .branchE,
        .jumpE,
        .alucontrolE,
        .RD1_E, RD2_E, Imm_Ext_E,
        .RD_E,
        .PCE, PCplus4E,
        .resultW,                               
        .ForwardA_E, ForwardB_E,                 
        .PCSrcE, 
        .regwriteM, memwriteM, resultsrcM,
        .RD_M ,
        .PCplus4M, writedataM, aluresultM,
        .pc_targetE
    );

//18 MEMORY
    MEM(
        .clk,
        .reset, 
        .regwriteM,
        .resultsrcM,
        .memwriteM,
        .RD_M,
        .PCplus4M, writedataM, aluresultM,
        .resultsrcW,
        .regwriteW,
        .PCplus4W, aluresultW,
        .RD_W,
        .readdataW                                 
    );

//19 WRITEBACK
    WB(
        .clk,
        .reset,
        .resultsrcW,
        .regwriteW,
        .PCplus4W,                 
        .aluresultW,
        .readdataW,
        .RD_W,
        .resultW
    );

//20 HAZARD 
    HAZARD(
        .reset,
        .regwriteM,
        .regwriteW,
        .RD_M, RD_W, Rs1_E, Rs2_E,
        .ForwardA_E,
        .ForwardB_E
    );

endmodule