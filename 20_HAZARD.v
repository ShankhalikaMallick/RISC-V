/*
    This is the Hazard unit in RISC V which prevents hazards from occuring.
    there are mainly 3 kinds of hazards:
    In RISC-V pipelining, hazards occur when instructions cannot execute in the expected clock cycle.
    1. Structural hazards occur when multiple instructions require the same hardware resource simultaneously.
    2. Data hazards occur when an instruction depends on the result of a previous instruction.
    3. Control hazards arise due to branch or jump instructions that change the program flow.
    These hazards are handled using techniques such as pipeline stalling, data forwarding, extra hardware resources, and branch prediction.

    This logic implements Forwarding (Data Bypassing). 
    Instead of stalling the pipeline, the processor takes the result directly from a later pipeline stage sends it back to the ALU inputs of the current instruction.
    Data hazard handling using forwarding (bypassing).
    If the destination register of an instruction in Memory or Writeback stage
    matches the source register of the instruction in Execute stage,
    the result is forwarded directly to the ALU inputs.
    This avoids pipeline stalls and resolves RAW hazards.

    1.  Memory Stage Forwarding:
        if (regwriteM and (RdM != 0) and (RdM == RS1E)) then ForwardAE = 10
        if (regwriteM and (RdM != 0) and (RdM == RS2E)) then ForwardBE = 10
            Meaning: Instruction in Memory stage will write to register RdM; 
            Current instruction in Execute stage needs the same register (Rs1E)
            So forward the value from Memory stage to ALU input A

    2.  Writeback Stage Forwarding
        ir (w and (RdW != 0) and (RdW == Rs1E)) then ForwardAE = 01
        ir (w and (RdW != 0) and (RdW == Rs1E)) then ForwardBE = 01
            Meaning:    If Value is available in Writeback stage
            Forward it to the Execute stage

*/
`timescale 1ps/1ps
module HAZARD(
    input reset,
    input regwriteM,
    input regwriteW,
    input [4:0] RD_M, RD_W, RS1_E, RS2_E,
    output [1:0] ForwardA_E,
    output [1:0] ForwardB_E
);
 assign ForwardAE = (reset == 1'b0) ? 2'b00 : 
                       ((regwriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS1_E)) ? 2'b10 :
                       ((regwriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1_E)) ? 2'b01 : 2'b00;
                       
    assign ForwardBE = (reset == 1'b0) ? 2'b00 : 
                       ((regwriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS2_E)) ? 2'b10 :
                       ((regwriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2_E)) ? 2'b01 : 2'b00;
endmodule