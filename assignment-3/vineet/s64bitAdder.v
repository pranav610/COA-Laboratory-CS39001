`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:53 08/25/2022 
// Design Name: 
// Module Name:    full_adder_64_bit 
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
module full_adder_64_bit (a, b, cin, cout, sum);
    input[63:0] a, b;               // two 64 bits inputs a and b
    input cin;                      // single bit input cin
    output [63:0] sum;              // 64 bits output sum
    output cout;                    // single bit output cout
    wire tempCarry;                 // single bit to store temporary carry

// construction of a 64 bit adder using two 32 bit adders
    full_adder_32_bit s1(a[31:0], b[31:0], cin, tempCarry, sum[31:0]);        // addition of 32 bits a[31:0] and b[31:0] using a 32-bit adder and saving of carry in tempCarry
    full_adder_32_bit s2(a[63:32], b[63:32], tempCarry, cout, sum[63:32]);    // addition of 32 bits a[63:32] and b[63:32] using a 32-bit adder and saving of carry in tempCarry
endmodule
