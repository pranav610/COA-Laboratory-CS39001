`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:40:55 08/25/2022
// Design Name:   halfAdder
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/demo/myTest/testsuite.v
// Project Name:  myTest
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: halfAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testsuite;

	// Inputs
	reg a;
	reg b;
	reg sel;

	// Outputs
	wire f;

	// Instantiate the Unit Under Test (UUT)
	halfAdder uut (
		.f(f), 
		.a(a), 
		.b(b), 
		.sel(sel)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

