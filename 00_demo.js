function sleep(ms){
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function run(){

  const inst = document.getElementById("instructionSelect").value;

  // show instruction format
  showFormat(inst);

  let blocks = [];

  if(inst === "ADD")
    blocks = ["imem","control","register","alu","writeback"];

  if(inst === "LW")
    blocks = ["imem","control","register","alu","dmem","writeback"];

  if(inst === "SW")
    blocks = ["imem","control","register","alu","dmem"];

  if(inst === "BEQ")
    blocks = ["imem","control","register","alu"];

  // animation
  for(let i = 0; i < blocks.length; i++){

    const block = document.getElementById(blocks[i]);

    block.classList.add("active");

    await sleep(900);

    block.classList.remove("active");

  }

}

function showFormat(inst){

  const box = document.getElementById("formatBox");
  const bits = document.getElementById("bitLayout");

  if(inst === "ADD"){

    box.innerHTML = `
    <b>R-Type Instruction</b><br><br>
    opcode | rd | funct3 | rs1 | rs2 | funct7<br><br>

    Meaning:<br>
    x[rd] = x[rs1] + x[rs2]
    `;

    bits.innerHTML = `
    <div class="bit funct7">31-25<br>funct7</div>
    <div class="bit rs2">24-20<br>rs2</div>
    <div class="bit rs1">19-15<br>rs1</div>
    <div class="bit funct3">14-12<br>funct3</div>
    <div class="bit rd">11-7<br>rd</div>
    <div class="bit opcode">6-0<br>opcode</div>
    `;
  }

  if(inst === "LW"){

    box.innerHTML = `
    <b>I-Type Instruction</b><br><br>

    opcode | rd | funct3 | rs1 | immediate<br><br>

    Meaning:<br>
    x[rd] = Memory[x[rs1] + offset]
    `;

    bits.innerHTML = `
    <div class="bit imm">31-20<br>imm</div>
    <div class="bit rs1">19-15<br>rs1</div>
    <div class="bit funct3">14-12<br>funct3</div>
    <div class="bit rd">11-7<br>rd</div>
    <div class="bit opcode">6-0<br>opcode</div>
    `;
  }

  if(inst === "SW"){

    box.innerHTML = `
    <b>S-Type Instruction</b><br><br>

    opcode | imm | funct3 | rs1 | rs2<br><br>

    Meaning:<br>
    Memory[x[rs1] + offset] = x[rs2]
    `;

    bits.innerHTML = `
    <div class="bit imm">31-25<br>imm</div>
    <div class="bit rs2">24-20<br>rs2</div>
    <div class="bit rs1">19-15<br>rs1</div>
    <div class="bit funct3">14-12<br>funct3</div>
    <div class="bit imm">11-7<br>imm</div>
    <div class="bit opcode">6-0<br>opcode</div>
    `;
  }

  if(inst === "BEQ"){

    box.innerHTML = `
    <b>B-Type Instruction</b><br><br>

    opcode | imm | funct3 | rs1 | rs2<br><br>

    Meaning:<br>
    Branch if rs1 == rs2
    `;

    bits.innerHTML = `
    <div class="bit imm">31<br>imm</div>
    <div class="bit imm">30-25<br>imm</div>
    <div class="bit rs2">24-20<br>rs2</div>
    <div class="bit rs1">19-15<br>rs1</div>
    <div class="bit funct3">14-12<br>funct3</div>
    <div class="bit imm">11-8<br>imm</div>
    <div class="bit imm">7<br>imm</div>
    <div class="bit opcode">6-0<br>opcode</div>
    `;
  }

}

function showFormat(inst){

  const box = document.getElementById("formatBox");

  if(inst === "ADD"){

    box.innerHTML = `
    <b>R-Type Instruction (ADD)</b><br><br>

    Bit Layout:<br>
    31-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-0<br>
    funct7 | rs2 | rs1 | funct3 | rd | opcode<br><br>

    Meaning:<br>
    rd = destination register<br>
    rs1 = source register 1<br>
    rs2 = source register 2<br><br>

    Operation:<br>
    x[rd] = x[rs1] + x[rs2]
    `;
  }


  if(inst === "LW"){

    box.innerHTML = `
    <b>I-Type Instruction (LW)</b><br><br>

    Bit Layout:<br>
    31-20 | 19-15 | 14-12 | 11-7 | 6-0<br>
    imm | rs1 | funct3 | rd | opcode<br><br>

    Meaning:<br>
    rd = destination register<br>
    rs1 = base register<br>
    imm = memory offset<br><br>

    Operation:<br>
    x[rd] = Memory[x[rs1] + imm]
    `;
  }


  if(inst === "SW"){

    box.innerHTML = `
    <b>S-Type Instruction (SW)</b><br><br>

    Bit Layout:<br>
    31-25 | 24-20 | 19-15 | 14-12 | 11-7 | 6-0<br>
    imm | rs2 | rs1 | funct3 | imm | opcode<br><br>

    Meaning:<br>
    rs2 = value to store<br>
    rs1 = base address register<br>
    imm = memory offset<br><br>

    Operation:<br>
    Memory[x[rs1] + imm] = x[rs2]
    `;
  }


  if(inst === "BEQ"){

    box.innerHTML = `
    <b>B-Type Instruction (BEQ)</b><br><br>

    Bit Layout:<br>
    31 | 30-25 | 24-20 | 19-15 | 14-12 | 11-8 | 7 | 6-0<br>
    imm | imm | rs2 | rs1 | funct3 | imm | imm | opcode<br><br>

    Meaning:<br>
    rs1 and rs2 are compared<br>
    imm represents branch offset<br><br>

    Operation:<br>
    if(x[rs1] == x[rs2]) PC = PC + imm
    `;
  }


  if(inst === "JAL"){

    box.innerHTML = `
    <b>J-Type Instruction (JAL)</b><br><br>

    Bit Layout:<br>
    31 | 30-21 | 20 | 19-12 | 11-7 | 6-0<br>
    imm | imm | imm | imm | rd | opcode<br><br>

    Meaning:<br>
    rd = return address register<br>
    imm = jump offset<br><br>

    Operation:<br>
    x[rd] = PC + 4<br>
    PC = PC + imm
    `;
  }


  if(inst === "BNE"){

    box.innerHTML = `
    <b>B-Type Instruction (BNE)</b><br><br>

    Bit Layout:<br>
    31 | 30-25 | 24-20 | 19-15 | 14-12 | 11-8 | 7 | 6-0<br>
    imm | imm | rs2 | rs1 | funct3 | imm | imm | opcode<br><br>

    Meaning:<br>
    rs1 and rs2 are compared<br>
    imm represents branch offset<br><br>

    Operation:<br>
    if(x[rs1] != x[rs2]) PC = PC + imm
    `;
  }

}

  if(inst === "LW"){

    box.innerHTML = `
    <b>I-Type Instruction</b><br><br>

    opcode | rd | funct3 | rs1 | immediate<br><br>

    Meaning:<br>
    Load word from memory<br>
    Address = rs1 + offset
    `;

  }

  if(inst === "SW"){

    box.innerHTML = `
    <b>S-Type Instruction</b><br><br>

    opcode | imm | funct3 | rs1 | rs2<br><br>

    Meaning:<br>
    Store value of rs2 into memory
    `;

  }

  if(inst === "BEQ"){

    box.innerHTML = `
    <b>B-Type Instruction</b><br><br>

    opcode | imm | funct3 | rs1 | rs2<br><br>

    Meaning:<br>
    Branch if rs1 == rs2
    `;

  }

}
