`timescale 1ps/1ps
`include "05_FETCH.v"
`include "11_DECODE.v"
`include "16_EXECUTE.v"
`include "18_MEMORY.v"
`include "19_WRITEBACK.v"
`include "20_HAZARD.v"

`timescale 1ps/1ps

module TOP(
    input clk,          
    input reset );    

wire PCsrcE, regwriteE, alusrcE, memwriteE, resultsrcE, branchE, jumpE;
wire [3:0] alucontrolE;
wire [31:0] PCtargetE, RD1_E, RD2_E, Imm_Ext_E, PCE, PCplus4E;
wire [4:0] RS1_E, RS2_E, RD_E;
wire [1:0] ForwardA_E, ForwardB_E;
wire [31:0] INSTRD, PC_D, PCplus4D;  
wire regwriteW;
wire [4:0] RD_W;
wire [31:0] resultW;
wire resultsrcW; 
wire [31:0] PCplus4W, aluresultW, readdataW;
wire regwriteM, memwriteM, resultsrcM;
wire [4:0] RD_M ;
wire [31:0] PCplus4M, writedataM, aluresultM;

//05 FETCH
    FETCH ob20(clk, reset, PCsrcE, PCtargetE, INSTRD, PC_D, PCplus4D );

//11 DECODE
    DECODE ob21( clk, reset,  regwriteW, RD_W,  INSTRD,  PC_D, PCplus4D, resultW, regwriteE, alusrcE, memwriteE, resultsrcE,
                branchE, jumpE, alucontrolE, RD1_E, RD2_E, Imm_Ext_E, RS1_E, RS2_E, RD_E, PCE, PCplus4E  );

//16 EXECUTE
    EXECUTE ob22(clk, reset,regwriteE,alusrcE,memwriteE,resultsrcE,branchE,jumpE,alucontrolE,RD1_E, RD2_E, Imm_Ext_E,RD_E,PCE, PCplus4E,
    resultW,  ForwardA_E, ForwardB_E,PCsrcE, regwriteM, memwriteM, resultsrcM,RD_M ,PCplus4M, writedataM, aluresultM,PCtargetE );

//18 MEMORY
    MEM ob23(clk,reset, regwriteM,resultsrcM,memwriteM,RD_M,PCplus4M, writedataM, aluresultM,resultsrcW,regwriteW,PCplus4W, aluresultW,
    RD_W,readdataW);

//19 WRITEBACK
    WB ob24(clk,reset,resultsrcW,regwriteW,PCplus4W,aluresultW,readdataW,RD_W,resultW);

//20 HAZARD 
    HAZARD ob25( reset,regwriteM, regwriteW,RD_M, RD_W, RS1_E, RS2_E,ForwardA_E,ForwardB_E ); 

endmodule