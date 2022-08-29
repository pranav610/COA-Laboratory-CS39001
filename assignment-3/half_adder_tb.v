`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:36:25 08/25/2022
// Design Name:   half_adder_tb
// Module Name:   ~/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/half_adder_tb.v
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

module half_adder_tb;

	// Inputs
    reg a = 1'b0, b = 1'b0;

	// Outputs
	wire c;
	wire sum;

	// Instantiate the Unit Under Test (UUT)
	half_adder uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.sum(sum)
	);

	initial begin
        // To print changes
        $monitor ("a = %d, b = %d, carry_out = %d, sum = %d", a, b, c, sum);

		// Wait 100 ns for global reset to finish
        #100;
        
		// Add stimulus here
        #5 a = 1'b0; b = 1'b0;
        #5 a = 1'b1; b = 1'b0;
        #5 a = 1'b0; b = 1'b1;
        #5 a = 1'b1; b = 1'b1;
		#5 $finish;

	end
      
endmodule

