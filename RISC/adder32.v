`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:19:57 10/21/2022 
// Design Name: 
// Module Name:    adder32 
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
module adder32(
	input [31:0] A,
	input [31:0] B,
	input c_in,
	output [31:0] sum,
	output c_out
    );
	
	wire c;
	cla_16_bit cla1 (.a(A[15:0]), .b(B[15:0]), .cin(c_in), .sum(sum[15:0]), .cout(c));
	cla_16_bit cla2 (.a(A[31:16]), .b(B[31:16]), .cin(c), .sum(sum[31:16]), .cout(c_out));

endmodule
