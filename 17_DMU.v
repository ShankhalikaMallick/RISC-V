/*
    Part of memory stage of 5 stage pipelined RISC V
    DMU is the data memory unit which stores the reults into memory
    is used for load and store instructions that is to read or write data from/to memory.
*/

`timescale 1ps/1ps
module DMU(
    input clk,                      // clock input from top module
    input reset,                    // reset input
    input mem_wr,                   // write to memory enable signal
    input [31:0] mem_add,           // memory address where read/ write operation is performed
    input [31:0] wr_data,           // data to be written into memory
    output [31:0] rd_data           // dat read from memory
);

// memory arrays is 1024 words of 32 bits
    reg [31:0] memory [0:1023];

// READ OPERATION: read from memory if read is enabled else 0
    assign rd_data = (reset == 1'b0)? memory[ mem_add [11:2]] : 32'h0;

// WRITE OPERATION: write into memory when write is enabled
    always @ (posedge clk)
    begin
        if(mem_wr == 1'b1)
            memory [mem_add[11:2]] <= wr_data;
            // address[11:2] gives word address (ignore lower 2 bits)
    end

    initial begin
        memory[0] = 32'h00000000;
        //mem[40] = 32'h00000002;
    end
endmodule