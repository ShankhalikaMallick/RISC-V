

`include "21_TOP.v"
`timescale 1ps/1ps
module TOP_TB();
reg clk, reset;
TOP ob26(clk, reset);
initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; // Deassert reset after 10 time units
    #2000 $finish; // Run the simulation for 2000 time units
end
always #50 clk = ~clk;
initial begin
    $monitor("Time=%0t PC=%h Instr=%h resultW=%h RD_W=%0d", $time, ob26.ob20.PC_F, ob26.ob20.INSTRF, ob26.resultW, ob26.RD_W);
end
initial begin
    $dumpfile("TOP.vcd");
    $dumpvars(0, TOP_TB); 
end
endmodule