`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:52:53 08/29/2022
// Design Name:   cla_4_bit
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/cla_4_bit_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cla_4_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cla_4_bit_tb;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	// Outputs
	wire cout;
	wire [3:0] sum;

	// Instantiate the Unit Under Test (UUT)
	cla_4_bit uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.cout(cout), 
		.sum(sum)
	);

	initial begin
		// Initialize Inputs
		a = 4'b0000;
		b = 4'b0000;
		cin = 1'b0;

		// Wait 5 ns for global reset to finish
		#5;
		
		// add stimulus here
		a = 4'b1010; b = 4'b1110;
		#5 a = 4'b1000; b = 4'b0011;
		#5 a = 4'b1101; b = 4'b0101;
		#5 a = 4'b0111; b = 4'b0111;
		#5 a = 4'b1111; b = 4'b1111;
		#5 $finish;
     

	end
      
endmodule

