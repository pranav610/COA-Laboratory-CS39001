`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:48 08/25/2022 
// Design Name: 
// Module Name:    half_adder 
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
module half_adder (a, b, sum, c); 
    input a, b; 				// two input bits a and b
    output sum, c;			    // outputs sum and c

    xor g1(sum, a, b);		    // sum = a ^ b
    and g2(c, a, b);			// c = a & b
endmodule
