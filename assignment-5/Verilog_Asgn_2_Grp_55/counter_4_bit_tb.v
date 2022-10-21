`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:23 09/14/2022
// Design Name:   counter_4_bit
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-5/Verilog_Asgn_2_Grp_55/counter_4_bit_tb.v
// Project Name:  Verilog_Asgn_2_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter_4_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_4_bit_tb;

	// Inputs
	reg clk = 0;
	reg switch = 0;
	reg rst = 0;

	// Outputs
	wire [3:0] counter;

	// Instantiate the Unit Under Test (UUT)
	counter_4_bit uut (
		.clk(clk), 
		.switch(switch), 
		.rst(rst), 
		.counter(counter)
	);
	
	always #5 clk = ~clk;

	initial begin
		#500 switch = 1;
		#500000000 rst = 1;

	end
      
endmodule

