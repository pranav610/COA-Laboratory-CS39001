`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:25 10/28/2022
// Design Name:   diff
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/RISC/diff_tb.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: diff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module diff_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [5:0] diff;
	wire eq;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	diff uut (
		.A(A), 
		.B(B), 
		.diff(diff), 
		.eq(eq), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#10;
		A = 32'b11111111111111111111111111111111;
		B = 32'b11111111111111111111111011111111;
		
		#10;
		A = 32'b11111111111111110111111011111111;
		B = 32'b11111111111111111111111011111111;
        
		// Add stimulus here

	end
      
endmodule

