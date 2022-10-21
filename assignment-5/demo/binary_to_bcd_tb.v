`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:13:34 09/13/2022
// Design Name:   binary_to_bcd
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-5/Verilog_Assgn_1_Grp_55/binary_to_bcd_tb.v
// Project Name:  Verilog_Assgn_1_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: binary_to_bcd
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module binary_to_bcd_tb;

	// Inputs
	reg clk=0;
	reg [3:0] in_4_bit_bin=0;

	// Outputs
	wire [3:0] ones;
	wire [3:0] tens;

	// Instantiate the Unit Under Test (UUT)
	binary_to_bcd uut (
		.clk(clk), 
		.in_4_bit_bin(in_4_bit_bin), 
		.ones(ones), 
		.tens(tens)
	);
	always #5 clk = ~clk;
	initial begin
		
		in_4_bit_bin = 0;
		# 500 in_4_bit_bin = 3;
		# 500 in_4_bit_bin = 11;
		# 500 in_4_bit_bin = 9;
		# 500 in_4_bit_bin = 15;
		# 500 in_4_bit_bin = 13;
		# 500 in_4_bit_bin = 7;
        
		// Add stimulus here

	end
      
endmodule

