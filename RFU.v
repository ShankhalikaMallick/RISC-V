// verilog code for REGISTER FILE UNIT

module register_file_unit(
    input clk,                  // clock signal from top module
    input reset,                // reset signal from top module
    input reg_wr,               // write enable signal to write into register: from control unit
    input [4:0] rs1,            // 5 bit source register 1 address for R type instructions
    input [4:0] rs2,            // 5 bit source register 2 address for R type instructions 
    input [4:0] rd,             // destination register for R type instructions
    input [31:0] wr_data,       // data written into register
    output [31:0] data1,        // data stored in rs1
    output [31:0] data2         // data stored in rs2
);
    integer i;

// 32 registers each of 32 bits
    reg [31:0] register [31:0];

/* 
READ OPERATION: 
for R type instructions obtaining data 1 and data 2 stored in rs1 and rs2
for I type instructions obtaining data 1 stored in rs1
for S type instructions obtaining data 1 and data 2 stored in rs1 and rs2
for B type instructions obtaining data 1 and data 2 stored in rs1 and rs2
for other types of instructions we hardwire data1 and data2 values as 0
*/
    assign data1 = (rs1 == 5'b0)? 32'h0 : register[rs1];
    assign data2 = (rs2 == 5'b0)? 32'h0 : register[rs2];

/*
WRITE OPERATION:
for R, I, U J type instructions we need to write the wr_data to rd location of register
*/
    always @(posedge clk or posedge reset)
    begin
        if (reset == 1'b1)
        begin
            for (i=0; i<32; i=i+1'b1)
                register[i] <=32'b0;
        end
        else if((reg_wr!=0) && (wr_data!=0))
            register[rd] <= wr_data;
    end

endmodule