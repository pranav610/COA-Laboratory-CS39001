`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:13 08/25/2022 
// Design Name: 
// Module Name:    full_adder_8_bit 
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
module full_adder_8_bit (a, b, cin, cout, sum);
    input[7:0] a, b; 			    // two 8 bits inputs a and b
    input cin;						// single bit input cin
    output [7:0] sum;			    // 8 bit output sum
    output cout;					// single bit output cout
    wire [6:0] tempCarry;		    // 6 bits to save temporary carries

    full_adder f1 (.a(a[0]), .b(b[0]), .cin(cin), .cout(tempCarry[0]), .sum(sum[0]));	    // addition of single bits a[0] and b[0] using a full adder and saving of carry in tempCarry[0]
	 full_adder f2 (a[1], b[1], tempCarry[0], tempCarry[1], sum[1]);							// addition of single bits a[1] and b[1] using a full adder and saving of carry in tempCarry[1]
	 full_adder f3 (a[2], b[2], tempCarry[1], tempCarry[2], sum[2]);							// addition of single bits a[2] and b[2] using a full adder and saving of carry in tempCarry[2]
	 full_adder f4 (a[3], b[3], tempCarry[2], tempCarry[3], sum[3]);							// addition of single bits a[3] and b[3] using a full adder and saving of carry in tempCarry[3]
	 full_adder f5 (a[4], b[4], tempCarry[3], tempCarry[4], sum[4]);							// addition of single bits a[4] and b[4] using a full adder and saving of carry in tempCarry[4]
	 full_adder f6 (a[5], b[5], tempCarry[4], tempCarry[5], sum[5]);							// addition of single bits a[5] and b[5] using a full adder and saving of carry in tempCarry[5]
    full_adder f7 (a[6], b[6], tempCarry[5], tempCarry[6], sum[6]);							// addition of single bits a[6] and b[6] using a full adder and saving of carry in tempCarry[6]
	 full_adder f8 (a[7], b[7], tempCarry[6], cout, sum[7]);									// addition of single bits a[7] and b[7] using a full adder and saving of carry in tempCarry[7]

endmodule