`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:09:03 08/30/2022 
// Design Name: 
// Module Name:    cla_4_bit_augment 
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
module cla_4_bit_augment(a, b, cin, sum, P, G);
	input [3:0] a, b;
	input cin;
	output [3:0] sum;
	output P, G;
	
	// 4 bit carry look ahead 
	wire [3:0] c;
	// generate and propagate signals
	wire [3:0] g, p;
	
	assign g = a & b;			// generate signal for ith bit is given by g_i = a_i AND b_i
	assign p = a ^ b;			// propagate signal for ith bit is given by p_i = a_i XOR b_i
	
	// using recusrsive substitution we can find values of c[i] as we know that c_i+1 = g_i OR (p_i AND c_i)
	// in recursive substitution we remove dependency of c_i+1 on c_i
	assign c[0] = cin;
	assign c[1] = g[0] | (p[0] & cin);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
	
	// calculation of 4 bit output sum, 
	assign sum = p ^ c;
	
	// calculation of P = P_3 . P_2 . P_1 . P_0
	assign P = p[3] & p[2] & p[1] & p[0];
	// calculation of G = G_3 + P_3 . G_2 + P_3 . P_2 . G_1 + P_3 . P_2 . P_1 . G_0
	assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	


endmodule
