

`include "21_TOP.v"

module TOP_TB();
reg clk, reset;
TOP ob26(clk, reset);
initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; // Deassert reset after 10 time units
    #1000 $finish; // Run the simulation for 1000 time units
end
always #50 clk = ~clk;
initial begin
    $dumpfile("TOP.vcd");
    $dumpvars(0, TOP_TB); 
end
endmodule