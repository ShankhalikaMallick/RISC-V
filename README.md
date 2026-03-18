# 🚀 RISC-V 5-Stage Pipelined Processor Implementation

[![Verilog](https://img.shields.io/badge/HDL-Verilog-orange.svg)](https://en.wikipedia.org/wiki/Verilog)
[![RISC-V](https://img.shields.io/badge/ISA-RISC--V-blue.svg)](https://riscv.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A high-performance, **5-stage pipelined RISC-V processor** implemented in Verilog. This project includes a full hardware implementation of the RV32I base integer instruction set, complete with hazard detection, forwarding, and an interactive web-based datapath visualizer.

---

## 🌟 Key Features

- **5-Stage Pipeline Architecture**: 
  - `FETCH`: Instruction fetching with PC management.
  - `DECODE`: Instruction decoding and register file access.
  - `EXECUTE`: ALU operations and branch target calculation.
  - `MEMORY`: Data memory load/store operations.
  - `WRITEBACK`: Register write-back for instruction completion.
- **Hazard Unit**: Integrated hardware logic to handle data hazards via **Forwarding** and stall mechanisms.
- **RV32I Support**: Implements core R, I, S, B, U, and J type instructions.
- **Interactive Visualizer**: A beautiful web interface to see how instructions move through the datapath in real-time.
- **Simulation Ready**: Optimized for Icarus Verilog and GTKWave for debugging.

---

## 🗺️ Datapath Visualization

You can explore the interactive datapath visualizer here:  
👉 **Live Demo:** [RISC-V Datapath Visualizer](https://codepen.io/Shankx/full/XJjNvPp)

---

## 🛠️ Hardware Architecture

### Supported Instruction Set (RV32I)

| Type | Instructions |
|------|--------------|
| **R-Type** | `ADD`, `SUB`, `SLL`, `SLT`, `XOR`, `SRL`, `OR`, `AND` |
| **I-Type** | `ADDI`, `SLLI`, `XORI`, `SLTI`, `SRLI`, `ORI`, `ANDI`, `LW`, `JALR` |
| **S-Type** | `SW` |
| **B-Type** | `BEQ`, `BNE`, `BGE`, `BLT` |
| **U-Type** | `LUI`, `AUIPC` |
| **J-Type** | `JAL` |

### Pipeline Stages Breakdown

1.  **Fetch (IF)**: Uses the Program Counter (PC) to fetch 32-bit instructions from Instruction Memory (`IMU.v`).
2.  **Decode (ID)**: Decodes instructions using a `MAIN_DECODER` and `ALU_DECODER`. Reads from the `REG_FILE`.
3.  **Execute (EX)**: Performs arithmetic/logic operations in the `ALU`. Resolves branch targets.
4.  **Memory (MEM)**: Accesses Data Memory (`DMU.v`) for load/store instructions.
5.  **Writeback (WB)**: Selects the final result (ALU output, Memory data, or PC+4) to write back to the register file.

---

## 📂 Project Structure

```bash
├── 📜 01_PC_MUX.v        # PC Source Selection Multiplexer
├── 📜 02_PC.v            # Program Counter Register
├── 📜 03_IMU.v           # Instruction Memory Unit (ROM)
├── 📜 05_FETCH.v         # IF Stage: Instruction Fetch logic
├── 📜 06_MAIN_DECODER.v  # Opcode decoding for Control Signals
├── 📜 07_ALU_DECODER.v   # Funct3/Funct7 decoding for ALU
├── 📜 08_CU.v            # Control Unit: Orchestrates datapath
├── 📜 09_REG_FILE.v      # Register File: 32 Integer Registers
├── 📜 10_EXTEND.v        # Immediate Generator/Extender
├── 📜 11_DECODE.v        # ID Stage: instruction decoding logic
├── 📜 14_ALU.v           # Arithmetic Logic Unit
├── 📜 16_EXECUTE.v       # EX Stage: Execution and Branching
├── 📜 17_DMU.v           # Data Memory Unit (RAM)
├── 📜 18_MEMORY.v        # MEM Stage: Memory access logic
├── 📜 19_WRITEBACK.v     # WB Stage: Write-back selection
├── 📜 20_HAZARD.v        # Hazard Unit: Forwarding & Stall logic
├── 📜 21_TOP.v           # Top-level SoC Integration
├── 📜 22_TOP_TB.v        # System Testbench
├── 🌐 00_demo.html       # Visualizer Web Interface
├── 🎨 00_demo.css        # Visualizer Stylesheet
├── ⚡ 00_demo.js         # Visualizer Logic & Animations
└── 📄 memfile.hex        # Hexadecimal Instruction Memory File
```

---

## 🚀 Getting Started

### Prerequisites

- [Icarus Verilog](http://iverilog.icarus.com/) (Compiler)
- [GTKWave](http://gtkwave.sourceforge.net/) (Waveform Viewer)

### Running Simulation

1. **Compile the design:**
   ```powershell
   iverilog -o riscv_sim 22_TOP_TB.v
   ```

2. **Run the simulation:**
   ```powershell
   vvp riscv_sim
   ```

3. **View Waveforms:**
   ```powershell
   gtkwave TOP.vcd
   ```

---

## 🎨 Visualizer Technical Stack

- **HTML5/CSS3**: Clean and responsive UI layout.
- **Vanilla JavaScript**: Dynamic SVG animations and datapath state management.
- **CSS Animations**: Smooth transitions for instruction flow.

---

## 🤝 Contributing

Contributions are welcome! If you find a bug or want to add support for more RISC-V extensions (like **M** or **C**), feel free to open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

Developed with ❤️ by [Shankhalika Mallick](https://github.com/ShankhalikaMallick)
