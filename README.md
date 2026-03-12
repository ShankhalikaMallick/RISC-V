# RISC-V Datapath Visualizer

A simple interactive visualizer that demonstrates how different instructions move through the RISC-V datapath.

This project animates the execution stages of instructions and explains the structure of the instruction format.

---

## Live Demo

You can see the working version here:

👉 **Live Project:**  
https://yourusername.github.io/riscv-datapath-visualizer/

---

## Features

- Animated RISC-V datapath flow
- Instruction execution visualization
- Different datapath stages highlighted during execution
- Instruction format explanation
- Bit-range breakdown of instruction fields
- Support for multiple instruction types

---

## Supported Instructions

| Instruction | Type | Description |
|-------------|------|-------------|
| ADD | R-Type | Register arithmetic |
| LW | I-Type | Load word from memory |
| SW | S-Type | Store word to memory |
| BEQ | B-Type | Branch if equal |
| BNE | B-Type | Branch if not equal |
| JAL | J-Type | Jump and link |

---

## Datapath Stages

The animation highlights the following processor components:

- Instruction Memory
- Control Unit
- Register File
- ALU
- Data Memory
- Write Back

Different instructions use different subsets of these stages.

Example:
ADD → IMEM → Control → Register → ALU → Write Back
LW → IMEM → Control → Register → ALU → Memory → Write Back
SW → IMEM → Control → Register → ALU → Memory
BEQ → IMEM → Control → Register → ALU

---

## Instruction Format Example

R-Type instruction layout:
31-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-0
funct7 | rs2 | rs1 | funct3 | rd | opcode

---

## Project Structure
riscv-datapath-visualizer
│
├── index.html
├── style.css
├── README.md

---

## Technologies Used

- HTML
- CSS
- JavaScript
