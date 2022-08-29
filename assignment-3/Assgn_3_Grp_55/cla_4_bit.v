`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:34 08/29/2022 
// Design Name: 
// Module Name:    cla_4_bit 
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
module cla_4_bit(a, b, cin, cout, sum);
	input [3:0] a, b;
	input cin;
	output [3:0] sum;
	output cout;
	
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
	
	assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);
	
	assign sum = p ^ c;
	


endmodule
