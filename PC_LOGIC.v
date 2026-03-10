// this is the program counter logic module
// based on the type of instruction we will update the program counter values
// output of pc_logic will be sent to pc.v as pc_next
// this is a combinational block

`timescale 1ns / 1ps
module PC_LOGIC(
    input [31:0] pc_current,                // current program counter value
    input [31:0] imm,                       // immediate value for branch and jump conditions
    input [31:0] alu_result,                // alu output for jump and register condition
    input branch_taken,                     // counter which indicates that branch condition is true: If value is 1 then branch
    input jump,                             // counter which indicates that jump condition is being dealt with
    input [1:0] pc_src,                     // input from control unit
    output reg [31:0] pc_next               // next updated program counter value
);
// local variables
    localparam pc_plus4 = 2'b00;            // sequential increment: PC = PC+ 4
    localparam pc_branch = 2'b01;           // conditional branching: PC = PC + offset, else PC = PC + 4
    localparam pc_JAL = 2'b10;              // Unconditional Jump: PC + offset
    localparam pc_JALR =2'b11;              // Jump and link register (JALR): ALU result used for indirect jumps

    always @ (*)
    begin
        case (pc_src)
///////////// this is the normal condition of incrementing, PC = PC + 4 //////////////////////////////////////////////////////////////////////////////
            pc_plus4:                       
            begin
                pc_next = pc_current + 32'h4;
            end
///////////// this is the branching condition. if branch condition is satidfied then immediate value is the branch target address/////////////////////
            pc_branch:
            begin
                if (branch_taken == 1'b1)           // the branching condition is true then consider immediate value as next counter
                    pc_next = pc_current + imm;     // new pc is old pc+ immediate value
                else                                // if branching condition is false we do normal incrementation of pc
                    pc_next = pc_current + 32'h4;
            end
///////////// this is the Jump condition working. if a jump instruction is encountered we jump to the mentioned immediate address/////////////////////
            pc_JAL:
            begin
                if (jump == 1'b1)
                    pc_next = pc_current + imm;
                else
                    pc_next = pc_current + 32'h4;
            end
///////////// this is the jump and link register condition. JALR is the indirect jump to immediate value + base address. here base address is 0 //////
            pc_JALR:
            begin
                pc_next = {alu_result[31:1], 1'b0};
            end 
            default:    pc_next = pc_current + 32'h4;       
        endcase
    end
endmodule


/* points to check:
what is jump doing: where is it input from?
where is pc_scr input from?
where are the inputs taken from?
*/