`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:32 08/25/2022 
// Design Name: 
// Module Name:    full_adder_32_bit 
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
module full_adder_32_bit (a, b, cin, cout, sum);
    input[31:0] a, b;           // two 32 bits inputs a and b
    input cin;                  // single bit input cin
    output [31:0] sum;          // 32 bit output sum
    output cout;                // single bit output coput
    wire tempCarry;             // single bit to hold temporary carry

// construction of a 32 bit adder using two 16 bit adders
    full_adder_16_bit s1(a[15:0], b[15:0], cin, tempCarry, sum[15:0]);        // addition of 16 bits a[15:0] and b[15:0] using a 16-bit adder and saving of carry in tempCarry
    full_adder_16_bit s2(a[31:16], b[31:16], tempCarry, cout, sum[31:16]);    // addition of 16 bits a[31:16] and b[31:16] using a 16-bit adder and saving of carry in tempCarry

endmodule
