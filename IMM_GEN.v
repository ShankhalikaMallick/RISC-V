/*
IMM_GEN (Immediate Generator) is a combinational block that takes a 32-bit instruction as input 
and produces a sign-extended immediate value (imm_val) as output.
It decodes different immediate field formats depending on the instruction type (I, S, B, U, J).
*/

module immediate_generator(
    input [31:0] instruction_code,
    output [31:0] imm_address
    );

// 7 bit opcode is generated from the instruction itself 
    wire [6:0] opcode;
    assign opcode = instruction_code[6:0];

// Based on the opcode value (ie. the type of instruction) we calculate immediate address for I,S,B,J,U type of instructions

    always @(*)
    begin
        case (opcode)
            7'b0010011:             // I- TYPE INSTRUCTION
            imm_address={{20{instruction_code[31]}},instruction_code[31:20]};

            7'b0000011:             // I- TYPE INSTRUCTION
            imm_address={{20{instruction_code[31]}},instruction_code[31:20]};

            7'b0100011:             // S- TYPE INSTRUCTION
            imm_address={{20{instruction_code[31]}},instruction_code[31:25],instruction_code[11:7]};

            7'b1100011:             // B- TYPE INSTRUCTION
            imm_address={{19{instruction_code[31]}},instruction_code[31],instruction_code[7],instruction_code[30:25],instruction_code[11:8],1'b0};

            7'b1101111:             // J- TYPE INSTRUCTION
            imm_address={{11{instruction_code[31]}},instruction_code[31],instruction_code[19:12],instruction_code[20],instruction_code[30:21],1'b0};

            7'b0110111:             // U- TYPE INSTRUCTION
            imm_address={instruction_code[31:12],12'b0};

            default:
            imm_address=32'b0;
        endcase
    end
endmodule