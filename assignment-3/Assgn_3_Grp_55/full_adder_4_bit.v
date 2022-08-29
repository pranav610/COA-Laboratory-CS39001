`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:14 08/29/2022 
// Design Name: 
// Module Name:    full_adder_4_bit 
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
module full_adder_4_bit (a, b, cin, cout, sum);
    input[3:0] a, b; 			    // two 4 bits inputs a and b
    input cin;						// single bit input cin
    output [3:0] sum;			    // 4 bit output sum
    output cout;					// single bit output cout
    wire [2:0] tempCarry;		    // 3 bits to save temporary carries

    full_adder f1 (.a(a[0]), .b(b[0]), .cin(cin), .cout(tempCarry[0]), .sum(sum[0]));	    // addition of single bits a[0] and b[0] using a full adder and saving of carry in tempCarry[0]
	 full_adder f2 (a[1], b[1], tempCarry[0], tempCarry[1], sum[1]);							// addition of single bits a[1] and b[1] using a full adder and saving of carry in tempCarry[1]
	 full_adder f3 (a[2], b[2], tempCarry[1], tempCarry[2], sum[2]);							// addition of single bits a[2] and b[2] using a full adder and saving of carry in tempCarry[2]
	 full_adder f4 (a[3], b[3], tempCarry[2], cout, sum[3]);							// addition of single bits a[3] and b[3] using a full adder and saving of carry in cout

endmodule
