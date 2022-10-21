`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:08:52 09/13/2022
// Design Name:   counter_4_bit
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-5/Verilog_Assgn_1_Grp_55/counter_4_bit_tb.v
// Project Name:  Verilog_Assgn_1_Grp_55
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

	// Outputs
	wire [3:0] anode;
	wire [7:0] cathode;

	// Instantiate the Unit Under Test (UUT)
	counter_4_bit uut (
		.clk(clk), 
		.switch(switch), 
		.anode(anode), 
		.cathode(cathode)
	);
	
	always #5 clk = ~clk;

	initial begin
		#500 switch = 1;


	end
      
endmodule

