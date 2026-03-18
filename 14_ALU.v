/*
    Part of Execute stage of 5 stage pipelined RISC V
    This is the Aritmetic & Logic unit which calculates the operations based on the Alucontrol sent from control unit
*/

`timescale 1ps / 1ps
module ALU(
    input [31:0]A,                                    // input SRCA_E from 3:1 mux
    input [31:0]B,                                    // input SRCB_E from 3:1 mux
    input [3:0] alucontrol,                     // alucontrol signal
    output reg [31:0] result,                   // result of R type operations
    output zeroE                                // for condition of jump or branch
);

    assign zeroE = &(~result);
    
    always @(*)
    begin
        result = 32'b0;
        case (alucontrol)
        4'b0001: result = A + B;
        4'b0010: result = A - B;
        4'b0011: result = A << B;
        4'b0100: result = ($signed(A)<$signed(B))?32'b1:32'b0;
        4'b0101: result = (A < B)? 32'b1:32'b0;
        4'b0110: result = A ^ B;
        4'b0111: result = A >> B;
        4'b1000: result = ($signed(A)) >>> B;
        4'b1001: result = A | B;
        4'b1010: result = A & B;
        default: result = 32'b0;
        endcase
    end
endmodule
