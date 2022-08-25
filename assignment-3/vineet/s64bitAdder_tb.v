`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:36:25 08/25/2022
// Design Name:   s64bitAdder
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/vineet/s64bitAdder_tb.v
// Project Name:  vineet
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: s64bitAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module s64bitAdder_tb;

	// Inputs
	reg [63:0] a = 64'd0;
	reg [63:0] b = 64'd0;
	reg cin = 1'b0;

	// Outputs
	wire cout;
	wire [63:0] sum;

	// Instantiate the Unit Under Test (UUT)
	s64bitAdder uut (
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

