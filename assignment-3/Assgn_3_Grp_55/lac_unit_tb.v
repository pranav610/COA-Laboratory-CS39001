`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:15:55 08/30/2022
// Design Name:   lac_unit
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/lac_unit_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lac_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lac_unit_tb;

	// Inputs
	reg [3:0] P;
	reg [3:0] G;
	reg cin;

	// Outputs
	wire [3:0] P_out;
	wire [3:0] G_out;
	wire [3:0] cout;

	// Instantiate the Unit Under Test (UUT)
	lac_unit uut (
		.P(P), 
		.G(G), 
		.cin(cin), 
		.P_out(P_out), 
		.G_out(G_out), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		P = 0;
		G = 0;
		cin = 0;

		// Wait 5 ns for global reset to finish
		#5;
        
		// Add stimulus here
		P = 4'b1010; G = 4'b0101;
		#5 P = 4'b1100; G = 4'b1100;
		#5 P = 4'b1110; G = 4'b0111;
		#5 P = 4'b1111; G = 4'b1111;
		#5 $finish;

	end
      
endmodule

