`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:36:25 08/25/2022
// Design Name:   full_adder_64_bit_tb
// Module Name:   ~/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/full_adder_64_bit_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_adder_64_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module full_adder_64_bit_tb;

	// Inputs
	reg [63:0] a = 64'd0;
	reg [63:0] b = 64'd0;
	reg cin = 1'b0;

	// Outputs
	wire cout;
	wire [63:0] sum;

	// Instantiate the Unit Under Test (UUT)
	full_adder_64_bit uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.cout(cout), 
		.sum(sum)
	);

	initial begin
		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		#5 a = 64'd345; b = 64'd473;
		#5 $finish;

	end
      
endmodule

