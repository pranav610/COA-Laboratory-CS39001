`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:40:07 08/30/2022 
// Design Name: 
// Module Name:    cla_16_bit_ripple 
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
// 16 bit carry look-ahead adder using ripple carry 
module cla_16bit_ripple (a, b, cin, cout, sum);
    /* 
        Input Ports:
            a - 16 bit input
            b - 16 bit input
            cin - 1-bit carry input
        Output Ports:
            cout - 1-bit carry output
            sum - 16-bit sum output        
    */
    // Input
    input [15:0] a, b;
    input cin;

    // Output
    output [15:0] sum;
    output cout;

    wire [2:0] c;

    // Instantiate the 4 cascaded 4-bit CLAs
    cla_4_bit cla1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(c[0]), .sum(sum[3:0]));
    cla_4_bit cla2(.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .cout(c[1]), .sum(sum[7:4]));
    cla_4_bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .cout(c[2]), .sum(sum[11:8]));
    cla_4_bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .cout(cout), .sum(sum[15:12]));
endmodule
