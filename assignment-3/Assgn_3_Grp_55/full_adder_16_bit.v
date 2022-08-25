`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:11 08/25/2022 
// Design Name: 
// Module Name:    full_adder_16_bit 
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
module full_adder_16_bit (a, b, cin, cout, sum);
    input[15:0] a, b;       // two 16 bits inputs a and b
    input cin;              // single bit input cin
    output [15:0] sum;      // 16 bit output sum
    output cout;            // single bit output cout
    wire tempCarry;         // single bit to hold the carry

// construction of a 16 bit adder using two 8 bit adders
    full_adder_8_bit s1(a[7:0], b[7:0], cin, tempCarry, sum[7:0]);        // addition of 8 bits a[7:0] and b[7:0] using a 8-bit adder and saving of carry in tempCarry
    full_adder_8_bit s2(a[15:8], b[15:8], tempCarry, cout, sum[15:8]);    // addition of 8 bits a[15:8] and b[15:8] using a 8-bit adder and saving of carry in cout

endmodule