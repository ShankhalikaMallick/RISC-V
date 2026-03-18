/*
    Part of Instruction Decode stage of 5 stage pipelined RISC V
    REG_FILE is a group of 32 registers of 32 bits
    It stored data on which operations are done and stored into
*/

`timescale 1ps / 1ps
module REG_FILE(
    input clk,                          // clock input from DECODE.v
    input reset,                        // reset input from DECODE.v
    input [4:0] A1,                     // address of source register 1 
    input [4:0] A2,                     // address of source register 2
    input [4:0] A3,                     // address of destination register
    input [31:0] WD3,                   // data to write in the destination register
    input WE3,                          // write control from execute
    output [31:0] RD1,                  // data in source register 1
    output [31:0] RD2                   // data in source register 2
);
    reg [31:0] regs [31:0];

    always @ (posedge clk)
    begin
        if ((WE3==1'b1) && (A3 != 5'b0))
            regs [A3] <= WD3;
    end

    assign RD1 = (reset==1'b1)? 32'b0: regs [A1];
    assign RD2 = (reset==1'b1)? 32'b0: regs [A2];

     initial begin
        regs[0] = 32'h00000000;
    end

endmodule