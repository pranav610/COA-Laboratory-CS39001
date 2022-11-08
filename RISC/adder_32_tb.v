`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:18:52 11/08/2022
// Design Name:   adder32
// Module Name:   /home/vapippal/IIT KGP Docs/SEM 5/COA Lab/COA-Laboratory-CS39001/RISC/adder32_tb.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder32_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg c_in;

	// Outputs
	wire [31:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	adder32 uut (
		.A(A), 
		.B(B), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		c_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$monitor("A = %d, B = %d, c_in = %d, sum = %d, c_out = %b", A, B, c_in, sum, c_out);
		A = 32'd2147483648; B = 32'd1073741824; 
		#10;
		
		// Add stimulus here

	end
      
endmodule

