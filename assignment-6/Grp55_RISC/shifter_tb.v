`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:33:59 11/08/2022
// Design Name:   shifter
// Module Name:   /home/vapippal/IIT KGP Docs/SEM 5/COA Lab/COA-Laboratory-CS39001/RISC/shifter_tb.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shifter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shifter_tb;

	// Inputs
	reg [31:0] in;
	reg [4:0] shamt;
	reg left;
	reg logical;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	shifter uut (
		.in(in), 
		.shamt(shamt), 
		.left(left), 
		.logical(logical), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 32'd2147483648;
		shamt = 5'd3;
		left = 0;
		logical = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		left = 0;
		logical = 1;
		#100;
		
		left = 1;
		logical = 1;
		#100;
		
		left = 0;
		logical = 0;
		#100;
		
		left = 1;
		logical = 0;
		#100;

	end
      
endmodule

