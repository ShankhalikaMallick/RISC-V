/*
    Part of Instruction Fetch stage of 5 stage pipelined RISC V
    FETCH is the register unit which stores the reults of 1st stage
    1st stage module fetches the next instruction based on the updated program counter
*/

`timescale 1ps / 1ps
`include "01_PC_MUX.v"
`include "02_PC.v"
`include "03_IMU.v"
`include "04_PC_ADD.v"

module FETCH(
    input clk,                  // input from top module
    input reset,                // input from top module
    input PCsrcE,               // PC control from execute stage
    input [31:0] PCtargetE,     // target PC for jump and branch from Execute stage 
    output [31:0] INSTRD,       // 32 bit instruction of ID stage
    output [31:0] PC_D,         // program counter for ID stage
    output [31:0] PCplus4D      // normal incrementing pc for ID stage
);
    wire [31:0] INSTRF;        // 32 bit instruction from IMU of IF stage
    wire [31:0] PC_F;          // the new program counter on which operation is to be done
    wire [31:0] PCplus4F;      // the next program counter in case of normal incrementation
    wire [31:0] PCF;           // the new program counter on which operation is to be done
        
    reg [31:0] InstrF_reg;                      // declaring registers
    reg [31:0] PCF_reg, PCplus4F_reg;           // declaring tregisters

    PC_MUX ob1 (PCplus4F, PCtargetE, PCsrcE, PCF);
    PC ob2 (clk, reset, PCF, PC_F);
    IMU ob3 ( reset, PC_F, INSTRF);
    PC_ADD ob4 (PC_F, PCplus4F);

    always @(posedge clk or posedge reset) 
    begin
        if(reset == 1'b1) 
        begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCplus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= INSTRF;
            PCF_reg <= PC_F;
            PCplus4F_reg <= PCplus4F;
        end
    end

    // outputs of register
    assign  INSTRD = (reset == 1'b1) ? 32'h00000000 : InstrF_reg;
    assign  PC_D = (reset == 1'b1) ? 32'h00000000 : PCF_reg;
    assign  PCplus4D = (reset == 1'b1) ? 32'h00000000 : PCplus4F_reg;


endmodule