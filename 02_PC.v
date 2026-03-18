/*
    Part of Instruction Fetch stage of 5 stage pipelined RISC V
    PC is the sequential ckt which is used for the program counter reset
    we reset the value of program counter based on reset button, else we update the new value
*/

`timescale 1ps / 1ps

module PC(
    input clk,                                              // clock signal
    input reset,                                            // reset signal
    input [31:0] PCF,                                       // next program counter value
    output reg [31:0]  PC_F                            // current program counter value
);
    always @ (posedge clk or posedge reset)
    begin
        if (reset!=0)
        PC_F <= PCF;
        else
        PC_F <= 32'b0;
    end
endmodule 