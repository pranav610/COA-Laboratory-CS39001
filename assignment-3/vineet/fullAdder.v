`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:06:58 08/25/2022 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder (a, b, cin, cout, sum);
    input a, b, cin;				// 3 input bits a, b and cin
    output cout, sum;			    // 2 output bits cout and sum
    wire w1, w2, w3;				// 3 wires to save intermediate outputs

// full_adder using two half adders
    halfAdder h1(.a(a), .b(b), .sum(w1), .c(w2)); 		    // in1 = a, in2 = b, sum = w1, cout = w2
    halfAdder h2(w1, cin, sum, w3);							// in1 = w1, in2 = cin, sum = sum, cout = w3
    or g1(cout, w2, w3);								    // cout = w2 | w3
endmodule
