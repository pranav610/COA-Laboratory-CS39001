`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:26:37 09/13/2022
// Design Name:   bcd_to_7_segment
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-5/Verilog_Assgn_1_Grp_55/bcd_to_7_segment_tb.v
// Project Name:  Verilog_Assgn_1_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bcd_to_7_segment
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bcd_to_7_segment_tb;

	// Inputs
	reg clk = 0;
	reg [7:0] switch = 0;
	reg [3:0] button = 0;

	// Outputs
	wire [3:0] anode;
	wire [7:0] cathode;

	// Instantiate the Unit Under Test (UUT)
	bcd_to_7_segment uut (
		.clk(clk), 
		.switch(switch), 
		.button(button), 
		.anode(anode), 
		.cathode(cathode)
	);
	
	always #5 clk = ~clk;

	initial begin
		#100 switch[3:0] = 4;
		#1000 switch[7:4] = 8;
		#100 button = 1;

	end
      
endmodule

