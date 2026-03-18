/*
    Part of Execute stage of 5 stage pipelined RISC V
    MUX 2 to 1 is a two input one output multiplexer which provides input to the ALU
*/

`timescale 1ps / 1ps
module MUX21 (
    input [31:0] A,
    input [31:0] B, 
    input sel,
    output reg [31:0] out );
    
    always @(*)
    begin
        case (sel)
            1'b0:  out = A;
            1'b1:  out = B;
            default: out = 32'b0;
        endcase
    end
endmodule