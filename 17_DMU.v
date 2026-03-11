// verilog code for DATA MEMORY UNIT. 
// The Data Memory unit is used for load and store instructions that is to read or write data from/to memory.

module data_memory_unit(
    input clk,                      // clock input from top module
    input mem_rd,                   // reading from memory enable signal
    input mem_wr,                   // write to memory enable signal
    input [31:0] mem_add,           // memory address where read/ write operation is performed
    input [31:0] wr_data,           // data to be written into memory
    output [31:0] rd_data           // dat read from memory
);

// memory arrays is 1024 words of 32 bits
    reg [31:0] memory [0:1023];

// READ OPERATION: read from memory if read is enabled else 0
    assign rd_data = (mem_rd == 1'b1)? memory[ mem_add [11:2]] : 32'h0;

// WRITE OPERATION: write into memory when write is enabled
    always @ (posedge clk)
    begin
        if(mem_wr == 1'b1)
            memory [mem_add[11:2]] <= wr_data;
            // address[11:2] gives word address (ignore lower 2 bits)
    end
endmodule