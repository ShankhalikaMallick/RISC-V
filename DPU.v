//verilog code for data path unit

`include "ALU.v"
`include "RFU.v"
`include "DMU.v"

module data_path_unit (imm_address);

    arithmetic_logic_unit ob1(src1, src2, alu_control, imm_address, result, beq, bneq, bge, blt);
    data_memory_unit ob2();
endmodule