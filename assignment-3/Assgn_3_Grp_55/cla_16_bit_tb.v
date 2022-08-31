`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:26:37 08/30/2022
// Design Name:   cla_16_bit
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/cla_16_bit_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cla_16_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cla_16_bit_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg cin;

	// Outputs
	wire [15:0] sum;
	wire cout;
	wire [3:0] P_out;
	wire [3:0] G_out;

	// Instantiate the Unit Under Test (UUT)
	cla_16_bit uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.sum(sum), 
		.cout(cout), 
		.P_out(P_out), 
		.G_out(G_out)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		cin = 0;
		
		$monitor ("a = %d, b = %d, cin = %d, sum = %d, cout = %d, p = %d, q = %d", a, b, cin, sum, cout, P_out, G_out);

		// Wait 5 ns for global reset to finish
		#50;
		
		// Add stimulus here
		// a = 16'd705; b = 16'd511;
	   // #5 a = 16'd28341; b = 16'd12345;
	   // #5 a = 16'd65535; b = 16'd0; // 2^16 - 1 + 0
	   // #5 a = 16'd65535; b = 16'd65535; // = 2^16 - 1
		// #5 $finish;
		
		a = 16'd30037; b = 16'd30049; cin = 1'b0;
		#50 a = 16'd1024; b = 16'd2048; cin = 1'b0;
		#50 a = 16'd32768; b = 16'd65535; cin = 1'b0;
		#50 a = 16'd65535; b = 16'd65535; cin = 1'b0;
		#50 a = 16'd462; b = 16'd391; cin = 1'b0;
		#50 a = 16'd462; b = 16'd391; cin = 1'b1;
        
		

	end
      
endmodule

