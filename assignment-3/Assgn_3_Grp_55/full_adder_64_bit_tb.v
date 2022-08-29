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
		// To print changes
		$monitor ("a = %d, b = %d, carry_in = %d, carry_out = %d, sum = %d", a, b, cin, cout, sum);

		// Wait 100 ns for global reset to finish
      // #100;

		// Add stimulus here
		#5 a = 64'd345; b = 64'd473;
		#5 a = 64'd18446744073709551615; b = 64'd18446744073709551615;
		#5 a = 64'd10000000000000000000; b = 64'd16000000000000000000;
		#5 a = 64'd104582348198348134; b = 64'd67467573419834819; // = 2^64 - 1
		#5 $finish;

	end
      
endmodule

