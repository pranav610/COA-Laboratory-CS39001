`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:18:50 08/30/2022 
// Design Name: 
// Module Name:    cla_16_bit 
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
module cla_16_bit(a, b, cin, sum, cout, P_out, G_out);
	input [15:0] a, b;
	input cin;
	
	output [15:0] sum;
	output [3:0] P_out, G_out;
	output cout;
	
	wire [2:0] c;
	wire [3:0] P, G;
	
	// four 4 bits augmented cla gates
	cla_4_bit_augment g1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .P(P[0]), .G(G[0]));
	cla_4_bit_augment g2(a[7:4], b[7:4], c[0], sum[7:4], P[1], G[1]);
	cla_4_bit_augment g3(a[11:8], b[11:8], c[1], sum[11:8], P[2], G[2]);
	cla_4_bit_augment g4(a[15:12], b[15:12], c[2], sum[15:12], P[3], G[3]);
	
	// look ahead carry unit
	lac_unit g5(.P(P), .G(G), .cin(cin), .P_out(P_out), .G_out(G_out), .cout(cout), .c(c));
	
	
endmodule
