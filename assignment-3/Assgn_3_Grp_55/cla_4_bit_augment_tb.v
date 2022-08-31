`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:42:50 08/30/2022
// Design Name:   cla_4_bit_augment
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/cla_4_bit_augment_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cla_4_bit_augment
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cla_4_bit_augment_tb;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	// Outputs
	wire [3:0] sum;
	wire P;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	cla_4_bit_augment uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.sum(sum), 
		.P(P), 
		.G(G)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		cin = 0;

		// Wait 5 ns for global reset to finish
		#5;
        
		// add stimulus here
		a = 4'b0110; b = 4'b1001; // will give P = 1 and G = 0
		#5 a = 4'b1000; b = 4'b1011; // will give P = 0 and G = 1
		#5 a = 4'b1111; b = 4'b0000; cin = 1'b1; // will give P = 1 and G = 0
		#5 a = 4'b0111; b = 4'b0111; cin = 0; // will give P = 0  and G = 0
		#5 $finish; 

	end
      
endmodule

