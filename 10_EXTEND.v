/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    EXTEND is used to extend the immediate address into a 32 bit immediate addresses
*/

`timescale 1ns / 1ps
module EXTEND(
    input [31:0] In,                // 32 bit instruction
    input [1:0] immsrc,             // immediate value control from Main _decoder in control unit
    output [31:0] immexD            // 32 bit extended immdiate value
);

// S type 1, for B type 2, for J type 3, rest all 0
    assign immexD =  (immsrc == 2'b00) ? {{20{ In[31]}}, In[31:20]} :             // I Type
                     (immsrc == 2'b01) ? {{20{ In[31]}}, In[31:25], In[11:7]} :    // S type
                     (immsrc == 2'b10) ? {{19{ In[31]}}, In[31], In[7], In[30:25], In[11:8], 1'b0}:     // B Type
                     (immsrc == 2'b11) ? {{11{ In[31]}}, In[31], In[19:12], In[20], In[30:21], 1'b0}    // J Type
                                        : 32'h00000000; 
                                        
endmodule