`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:27:33 10/21/2022 
// Design Name: 
// Module Name:    lac_unit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lac_unit(P, G, cin, cout, c);
	input [3:0] P, G;
	input cin;
	output [2:0] c;
	output cout;
	
	// using recusrsive substitution we can find values of c[i] as we know that c_i+1 = g_i OR (p_i AND c_i)
	// in recursive substitution we remove dependency of c_i+1 on c_i
	assign c[0] = G[0] | (P[0] & cin);
	assign c[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
	assign c[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
	assign cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & cin);
	
	// calculation of P = P_3 . P_2 . P_1 . P_0
	// assign P_out = P[3] & P[2] & P[1] & P[0];
	// calculation of G = G_3 + P_3 . G_2 + P_3 . P_2 . G_1 + P_3 . P_2 . P_1 . G_0
	// assign G_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
	
	

endmodule
