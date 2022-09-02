`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:43 08/31/2022
// Design Name:   cla_16bit_ripple
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/cla_16_bit_ripple_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cla_16bit_ripple
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Testbench for the CLA 16bit Ripple module
module cla_16bit_ripple_tb;
    // Input
    reg [15:0] A = 16'd0;
    reg [15:0] B = 16'd0;
    reg cin = 1'b0;

    // Output
    wire [15:0] sum;
    wire cout;

    // Instantiate CLA
    cla_16bit_ripple cla(
        .a(A),
        .b(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Monitor changes
        $monitor ("A = %d, B = %d, cin = %b, sum = %d, cout = %b", A, B, cin, sum, cout);

        // Simulate
        #5 A = 16'd511; B = 16'd1023;
        #5 A = 16'd9123; B = 16'd12345;
        #5 A = 16'd32768; B = 16'd32768;
        #5 A = 16'd65535; B = 16'd65535;
        #5 $finish;
    end
endmodule

