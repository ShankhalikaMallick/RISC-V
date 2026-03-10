// verilog code for instruction fetch unit

`timescale 1ns/1ps
module instruction_fetch_unit(
    input clk,                      //clock source
    input reset,                    //reset signal
    input [31:0] imm_address,       //immediate address for branch instruction
    input beq,                      //control signal for branch equals instruction
    input bneq,                     //control signal for branch not equals instruction
    input bge,                      //control signal for branch greater than equals instruction
    input blt,                      //control signal for branch less than instruction
    input jump,                     //control signal for jump instruction
    output reg [31:0] pc,           //program counter 
    output reg [31:0] curr_pc       //current program counter
    );

    //updating program counter based on type of instruction
    always @ (posedge clk)
    begin
        if(reset==1)
        pc=0;
        else if ((beq==1)||(bneq==1)||(bge==1)||(blt==1)|| (jump==1))
        pc <= pc+ imm_address;
        else
        pc <= pc+4;
    end

    //updating current program counter for storing return address
    always @ (posedge clk)
    begin
        if(reset==1)
        curr_pc <=0;
        else if ((reset==0)&&(jump==0))
        curr_pc <= pc+4;
        else 
        curr_pc <= curr_pc;
    end

endmodule