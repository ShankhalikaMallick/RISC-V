/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    DECODE is the register unit which stores the reults of 2nd stage
    2nd stage consistes of control unit, registers and extend blocks
*/

`timescale 1ps / 1ps
`include "08_CU.v"
`include "09_REG_FILE.v"
`include "10_EXTEND.v"
module DECODE(
    input clk,                                  // input from top module
    input reset,                                // input from top module
    input regwriteW,
    input [4:0] RD_W,                            // DESTINATION REGISTER ADDRESS FROM WRITE BACK BLOCK
    input [31:0] INSTRD, 
    input [31:0] PC_D,
    input [31:0] PCplus4D,
    input [31:0] resultW,
    output regwriteE,
    output alusrcE,
    output memwriteE,
    output resultsrcE,
    output branchE,
    output jumpE,
    output [3:0] alucontrolE,
    output [31:0] RD1_E, RD2_E, Imm_Ext_E,
    output [4:0] RS1_E, RS2_E, RD_E,                // check why is rs1 and rs2 required
    output [31:0] PCE, PCplus4E
);


// interim wires
    wire regwriteD;
    wire alusrcD;
    wire memwriteD;
    wire resultsrcD;
    wire branchD;
    wire jumpD;
    wire [1:0] immsrcD;                         // immediate value control from Main _decoder in control unit
    wire [3:0] alucontrolD;                     // alu control signal 
    wire [31:0] RD1_D, RD2_D;                   // data in source register 1 and 2
    wire [31:0] Imm_Ext_D;                      // 32 bit extended immediate value

// interim register
    reg regwriteD_r, alusrcD_r, memwriteD_r, resultsrcD_r;                      // output of control unit stored in decode register
    reg branchD_r, jumpD_r;                                                     // output of control unit stored in decode register
    reg [3:0] alucontrolD_r;                                                    // alu control signals stored in decode register
    reg [31:0] RD1_D_r, RD2_D_r;                                                // data in source register 1 and 2 stored in decode register
    reg [31:0] Imm_Ext_D_r;                                                     // 32 bit immediate extended value stored in decode register
    reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;                                         // destination register address, source register 1 & 2 address stored in decode register
    reg [31:0] PCD_r, PCplus4D_r;                                               // PC current and PC + 4  stored in decode register

// instantiate control unit module
    CU ob7 ( 
        .INSTRD(INSTRD),
        .regwrite (regwriteD),
        .alu_control (alucontrolD),
        .resultsrc (resultsrcD),
        .memwrite (memwriteD),
        .jump (jumpD),
        .branch (branchD),
        .alusrc (alusrcD),
        .immsrc (immsrcD)
        );

// instantiate register file module
    REG_FILE ob8(
        .clk (clk),
        .reset (reset),
        .A1 (INSTRD [19:15]),               
        .A2 (INSTRD [24:20]),               
        .A3 (RD_W),                              // CHECK!!
        .WD3 (resultW),
        .WE3 (regwriteW),
        .RD1 (RD1_D),
        .RD2 (RD2_D)
    );

// instantiate sign extend module
    EXTEND ob9(
    .In (INSTRD [31:0]),
    .immsrc (immsrcD),
    .immexD (Imm_Ext_D)            
);

// storing values in decode registers
    always @(posedge clk, posedge reset)
    begin
        if (reset==1'b1)                    // reset condition
        begin
            regwriteD_r <= 1'b0;
            alusrcD_r <= 1'b0;
            memwriteD_r <= 1'b0;
            resultsrcD_r <= 1'b0;
            branchD_r <= 1'b0;
            jumpD_r <= 1'b0;
            alucontrolD_r <= 4'b0;
            RD1_D_r <= 32'b0;
            RD2_D_r <= 32'b0;
            Imm_Ext_D_r <= 32'b0;
            RD_D_r <= 5'b0;
            RS1_D_r <= 5'b0;
            RS2_D_r <= 5'b0;
            PCD_r <= 32'b0;
            PCplus4D_r <= 32'b0;
        end
        else
        begin                                  // normal condition
            regwriteD_r <= regwriteD;
            alusrcD_r <= alusrcD;
            memwriteD_r <= memwriteD;
            resultsrcD_r <= resultsrcD;
            branchD_r <= branchD;
            jumpD_r <= jumpD;
            alucontrolD_r <= alucontrolD;
            RD1_D_r <= RD1_D;
            RD2_D_r <= RD2_D;
            Imm_Ext_D_r <= Imm_Ext_D;
            RD_D_r <= INSTRD [11:7];
            RS1_D_r <= INSTRD [19:15];
            RS2_D_r <= INSTRD [24:20];
            PCD_r <= PC_D;
            PCplus4D_r <= PCplus4D;
        end
    end

// outputs of the decode register
    assign regwriteE = regwriteD_r;
    assign alusrcE = alusrcD_r;
    assign memwriteE = memwriteD_r;
    assign resultsrcE = resultsrcD_r;
    assign branchE = branchD_r;
    assign jumpE = jumpD_r;
    assign alucontrolE =alucontrolD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = Imm_Ext_D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r; 
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCplus4E = PCplus4D_r;

endmodule